#!/usr/bin/env bash

set -x

PGADMIN_BASE="${PGADMIN_BASE:-/configs}"

cd $PGADMIN_BASE || exit 1

cat <<EOF > servers.json
{
    "Servers": {
        "1": {
            "Name": "postgres",
            "Group": "Servers",
            "Host": "postgres",
            "Port": 5432,
            "MaintenanceDB": "postgres",
            "Username": "${POSTGRES_USER}",
            "SSLMode": "prefer"
        }
    }
}
EOF

cat <<EOF > .pgpass
postgres:5432:${POSTGRES_DB}:${POSTGRES_USER}:${POSTGRES_PASSWORD}
EOF

# chown pgadmin: pgpassfile
chmod 0600 .pgpass
