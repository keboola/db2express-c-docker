FROM angoca/db2-instance

# db2start
RUN ./createInstance

# create sample DB
RUN su -c "/home/db2inst1/sqllib/bin/db2sampl" - db2inst1

# spawn a DB2 listener
EXPOSE 50000

# we just have to keep some process running to keep the container alive (since `db2start` daemonizes)
ENTRYPOINT tail -f /home/db2inst1/sqllib/db2dump/db2diag.log
