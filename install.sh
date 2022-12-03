#!/bin/sh
set -e

apt-get update
apt-get install -y wget curl gnupg postgresql-client-13
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | apt-key add -
echo "deb http://repo.mongodb.org/apt/debian bullseye/mongodb-org/5.0 main" > /etc/apt/sources.list.d/mongodb-org-5.0.list
apt-get update
apt-get install -y mongodb-database-tools
apt-get update
apt-get upgrade -y
rm -r /var/lib/apt/lists /var/cache/apt/archives
rm -r /usr/share/postgresql/13/ /usr/share/doc/postgresql-client-13 /usr/share/man/*
echo "Installing MC"
MC_CLI=/usr/local/bin/mc
wget -O $MC_CLI -q https://dl.minio.io/client/mc/release/linux-amd64/mc 
chmod u+x $MC_CLI

echo "Installing age"
AGE_BIN=/usr/local/bin/age
AGE_TGZ=age-v1.1.0-rc.1-linux-amd64.tar.gz
wget -q -O $AGE_TGZ https://github.com/FiloSottile/age/releases/download/v1.1.0-rc.1/$AGE_TGZ
tar xzvf $AGE_TGZ age/age 
echo "059e5583bd86d5388b91648a09f403e7512d129fd576b9a190f64b593cf57d03  age/age" | sha256sum -c
mv age/age $AGE_BIN
rm -Rf age/
rm $AGE_TGZ
