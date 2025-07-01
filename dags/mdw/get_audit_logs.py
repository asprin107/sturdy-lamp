import os
import json
from datetime import datetime, timedelta
import requests

from airflow.decorators import dag, task

# DAG 기본 설정
default_args = {
    'owner': 'airflow',
    'retries': 1,
    'retry_delay': timedelta(minutes=60),
}

TENANT_ID = os.environ.get("TENANT_ID")
CLIENT_ID = os.environ.get("CLIENT_ID")
CLIENT_SECRET = os.environ.get("CLIENT_SECRET")
RESOURCE = os.environ.get("RESOURCE", "https://manage.office.com")
OUTPUT_PATH = os.environ.get("OUTPUT_PATH", "/tmp/audit_log_data.json")

@dag(
    dag_id="m365_audit_log_collector",
    catchup=False,
    default_args=default_args,
    tags=['m365', 'audit', 'log']
)
def m365_audit_log_collector():

    @task
    def get_access_token():
        url = f"https://login.microsoftonline.com/{TENANT_ID}/oauth2/token"
        payload = {
            'grant_type': 'client_credentials',
            'client_id': CLIENT_ID,
            'client_secret': CLIENT_SECRET,
            'resource': RESOURCE
        }
        res = requests.post(url, data=payload)
        res.raise_for_status()
        return res.json()['access_token']

    @task
    def ensure_subscription(token: str, content_type: str = "Audit.General"):
        url = f"https://manage.office.com/api/v1.0/{TENANT_ID}/activity/feed/subscriptions/list"
        headers = {"Authorization": f"Bearer {token}"}
        res = requests.get(url, headers=headers)
        res.raise_for_status()
        for sub in res.json():
            if sub['contentType'] == content_type and sub['status'] == 'enabled':
                return "already_exists"

        # create new subscription if not exists
        url = f"https://manage.office.com/api/v1.0/{TENANT_ID}/activity/feed/subscriptions/start?contentType={content_type}"
        res = requests.post(url, headers=headers)
        if res.status_code not in (200, 201, 202, 204):
            raise Exception(f"Subscription failed: {res.status_code}, {res.text}")
        return "created"

    @task
    def get_content_uris(token: str):
        end_time = datetime.utcnow()
        start_time = end_time - timedelta(hours=1)

        headers = {'Authorization': f'Bearer {token}'}
        url = (
            f"https://manage.office.com/api/v1.0/{TENANT_ID}/activity/feed/subscriptions/content"
            f"?contentType=Audit.General"
            f"&startTime={start_time.replace(microsecond=0).isoformat()}Z"
            f"&endTime={end_time.replace(microsecond=0).isoformat()}Z"
        )
        res = requests.get(url, headers=headers)
        res.raise_for_status()
        return [item['contentUri'] for item in res.json()]

    @task
    def fetch_log_from_uri(uri: str, token: str):
        headers = {'Authorization': f'Bearer {token}'}
        res = requests.get(uri, headers=headers)
        res.raise_for_status()
        return res.json()

    @task
    def save_logs(all_logs: list):
        with open(OUTPUT_PATH, mode='a', encoding='utf-8') as f:
            json.dump(all_logs, f, ensure_ascii=False, indent=2)
            f.write("\n")
        print(f"✅ {len(all_logs)} records saved to {OUTPUT_PATH}")

    # DAG 실행 순서 정의
    token = get_access_token()
    _ = ensure_subscription(token)
    uris = get_content_uris(token)
    raw_logs = fetch_log_from_uri.expand(uri=uris, token=token)  # dynamic task mapping
    save_logs(raw_logs)

# DAG 객체 생성
m365_audit_log_collector_dag = m365_audit_log_collector()
