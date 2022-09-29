#!/bin/bash

cd /work && rails db:migrate
rm -rf /work/tmp/pids/server.pid
php -S 0.0.0.0:9000 -t /work/client_site >/dev/null 2>&1 &
php -S 0.0.0.0:9999 -t /work/client_site >/dev/null 2>&1 &
/work/bin/rails s -b 0.0.0.0