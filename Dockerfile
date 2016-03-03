FROM angoca/db2-instance

ADD init.sh /tmp/db2_conf/

# db2start
RUN ${DB2_DIR}/instance/db2isetup -r ${DB2_CONF}/${DB2_RESP_FILE}

# spawn a DB2 listener
EXPOSE 50000

RUN chmod a+x init.sh

# we just have to keep some process running to keep the container alive (since `db2start` daemonizes)
ENTRYPOINT ./init.sh
