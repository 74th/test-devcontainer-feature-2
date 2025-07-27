#!/bin/bash
set -xe

flyway -user=dev -password=dev -url=jdbc:mysql://mysql:3306/dev -locations=db/migration migrate