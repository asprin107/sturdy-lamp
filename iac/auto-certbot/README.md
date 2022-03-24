# EC2 Access Key Creation Guide

## 1. Creation
Create asymmetric key with ssh-keygen
```
ssh-keygen -t rsa -b 4096 -C "mail_address@sample.com" 
```
Write your passphrase. Example is just enter without passphrase. 
```
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/gim-yongseon/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again: 
Your identification has been saved in /Users/gim-yongseon/.ssh/id_rsa
Your public key has been saved in /Users/gim-yongseon/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:4/SD+YxuqoySB18klOjkcWT10cXbKbyvrjpnr2szezI tortoise@lguplus.co.kr
The key's randomart image is:
+---[RSA 4096]----+
| ..+.. .. o.     |
|.o+.  . .. .     |
|+.o    .  . o .  |
| o. .      + o   |
|   o    S   o    |
|.   .  o = .     |
| + .    + o .    |
|o oo   ..E o .   |
| o. o..=O=/+.    |
+----[SHA256]-----+
```

After above, the key will located at `~/.ssh`. You can find the keys each name of `id_rsa` and `id_rsa.pub`.
`id_rsa` is private key and `id_rsa.pub` is public key. The key name is not important. Changing the name of the key is allowed.

## 2. Validation
If you run below,
```
ssh-keygen -y -e -f <private key>
ssh-keygen -y -e -f <public key>
```
those result would be same. If not, those keys are not asymmetric key.