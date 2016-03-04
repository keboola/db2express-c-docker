#!/usr/bin/env bash

# Creates the instance according to the response file.
${DB2_DIR}/instance/db2isetup -r ${DB2_CONF}/${DB2_RESP_FILE}

su -c "db2start" - db2inst1

# Create sample DB
su -c "/home/db2inst1/sqllib/bin/db2sampl" - db2inst1

# Changes to the instance user.
su db2inst1

tail -f /home/db2inst1/sqllib/db2dump/db2diag.log
