FROM angoca/db2-instance

# db2start
RUN ${DB2_DIR}/instance/db2isetup -r ${DB2_CONF}/${DB2_RESP_FILE}
USER db2inst1
RUN /home/db2inst1/sqllib/adm/db2start

#RUN ./createInstance

# create sample DB
#RUN /home/db2inst1/sqllib/bin/db2sampl

# spawn a DB2 listener
EXPOSE 50000

# we just have to keep some process running to keep the container alive (since `db2start` daemonizes)
ENTRYPOINT tail -f /home/db2inst1/sqllib/db2dump/db2diag.log
