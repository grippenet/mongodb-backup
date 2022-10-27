#!/bin/sh
set -e

apt-get update 
apt-get install -y wget curl gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | apt-key add -
echo "deb http://repo.mongodb.org/apt/debian bullseye/mongodb-org/5.0 main" > /etc/apt/sources.list.d/mongodb-org-5.0.list
apt-get update
apt-get install -y mongodb-database-tools
apt-get update
apt-get upgrade -y
rm -r /var/lib/apt/lists /var/cache/apt/archives

echo "Installing S3CLI (https://github.com/cloudfoundry/bosh-s3cli)"
S3CLI=/usr/local/bin/s3cli
wget -O $S3CLI -q https://s3cli-artifacts.s3.amazonaws.com/s3cli-0.0.151-linux-amd64 
echo "e5eceadada910513e221e4c0a0d1dd3a33f8cfe2049229c3446690a8f722a3c1  $S3CLI" | sha256sum -c
chmod u+x $S3CLI

echo "Installing age"
AGE_BIN=/usr/local/bin/age
AGE_TGZ=age-v1.1.0-rc.1-linux-amd64.tar.gz
wget -q -O $AGE_TGZ https://github.com/FiloSottile/age/releases/download/v1.1.0-rc.1/$AGE_TGZ
tar xzvf $AGE_TGZ age/age 
echo "059e5583bd86d5388b91648a09f403e7512d129fd576b9a190f64b593cf57d03  age/age" | sha256sum -c
mv age/age $AGE_BIN
rm -Rf age/
rm $AGE_TGZ
