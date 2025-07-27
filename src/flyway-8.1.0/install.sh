#!/bin/sh
set -e

echo "Activating feature 'flyway-8.1.0'"

if [ -d "/flyway" ]; then
  echo "Flyway is already installed"
  exit 0
fi

apt update
apt install -y openjdk-11-jre curl

FLYWAY_VERSION=8.1.0

mkdir /flyway
cd /flyway
curl -L https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz -o flyway-commandline-${FLYWAY_VERSION}.tar.gz
tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz --strip-components=1
rm flyway-commandline-${FLYWAY_VERSION}.tar.gz
chmod 755 /flyway/flyway
