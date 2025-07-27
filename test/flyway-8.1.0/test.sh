#!/bin/bash

set -e

source dev-container-features-test-lib

check "execute command" bash -c "flyway --version | grep '8.1.0'"

reportResults