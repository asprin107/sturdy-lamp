#!/bin/sh

apk add tzdata # Set timezone as KST (Asia/Seoul)
gem install fluent-plugin-s3 --no-document

#source vars if file exists
DEFAULT=/etc/default/fluentd

if [ -r $DEFAULT ]; then
    set -o allexport
    . $DEFAULT
    set +o allexport
fi

# If the user has supplied only arguments append them to `fluentd` command
if [ "${1#-}" != "$1" ]; then
    set -- fluentd "$@"
fi

# If user does not supply config file or plugins, use the default
if [ "$1" = "fluentd" ]; then
    if ! echo $@ | grep -e ' \-c' -e ' \-\-config' ; then
       set -- "$@" --config /fluentd/etc/${FLUENTD_CONF}
    fi

    if ! echo $@ | grep -e ' \-p' -e ' \-\-plugin' ; then
       set -- "$@" --plugin /fluentd/plugins
    fi
fi

exec "$@"
