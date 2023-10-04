output "ec2_role" {
  value = {
    instance_profile_name = aws_iam_instance_profile.ec2_access_to_s3.name
    role_arn              = aws_iam_role.ec2_access_to_s3.arn
  }
}

output "ec2_linux_mountpoint_userdata" {
  value = <<EOT
#!/bin/sh
wget https://s3.amazonaws.com/mountpoint-s3-release/latest/x86_64/mount-s3.rpm
sudo yum install -y ./mount-s3.rpm
mkdir -p ${var.local_mount_path}
mount-s3 ${aws_s3_bucket.mount.bucket} ${var.local_mount_path} --allow-delete --allow-other
EOT
}

output "ec2_linux_goofys_userdata" {
  value = <<EOT
#!/bin/sh
wget https://go.dev/dl/go1.21.1.linux-amd64.tar.gz
tar -zxf go1.21.1.linux-amd64.tar.gz
export PATH=$PATH:$(pwd)/go/bin
go version
export GOPATH=$(pwd)/go
wget -P $GOPATH/bin/ https://github.com/kahing/goofys/releases/latest/download/goofys
chmod +x $GOPATH/bin/goofys
goofys -v
echo "" >> $HOME/.bash_profile
echo "# Go Configure" >> $HOME/.bash_profile
echo "export PATH=\$PATH:$(pwd)/go/bin" >> $HOME/.bash_profile
echo "export GOPATH=$(pwd)/go" >> $HOME/.bash_profile
mkdir -p ${var.local_mount_path}
$GOPATH/bin/goofys ${aws_s3_bucket.mount.bucket}:${var.s3_prefix} ${var.local_mount_path}
echo "$GOPATH/bin/goofys#${aws_s3_bucket.mount.bucket}:${var.s3_prefix}   ${var.local_mount_path}        fuse     _netdev,allow_other,--file-mode=0666,--dir-mode=0777    0       0" >> /etc/fstab
EOT
}