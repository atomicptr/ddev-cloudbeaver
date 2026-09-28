#!/usr/bin/env bash

#ddev-generated

set -e

TARGET="/opt/cloudbeaver/workspace/GlobalConfiguration/.dbeaver"

mkdir -p "$TARGET"

case "${DDEV_DATABASE:-mariadb}" in
postgres*)
    PROVIDER=postgresql
    DRIVER=postgres-jdbc
    PORT=5432
    URL="jdbc:postgresql://db:5432/db"
    ;;
*)
    PROVIDER=mysql
    DRIVER=mysql8
    PORT=3306
    URL="jdbc:mysql://db:3306/db"
    ;;
esac

cat >"$TARGET/data-sources.json" <<EOF
{
  "folders": {},
  "connections": {
    "ddev-db": {
      "provider": "$PROVIDER",
      "driver": "$DRIVER",
      "name": "${DDEV_SITENAME}",
      "save-password": true,
      "configuration": {
        "host": "db",
        "port": "$PORT",
        "database": "db",
        "url": "$URL",
        "configurationType": "MANUAL",
        "auth-model": "native",
        "auth-properties": {
          "user": "db",
          "password": "db"
        }
      }
    }
  }
}
EOF

exec /opt/cloudbeaver/launch-product.sh
