FROM centos7

RUN apt-get update

RUN wget https://s3.amazonaws.com/syrup-shared/v10.5_linuxx64_expc.tar.gz
ADD db2-expc-gen.rsp db2-expc-gen.rsp
RUN v10.5fp1_linuxx64_expc.tar.gz/expc/db2setup -r db2-expc-gen.rsp || true

# spawn a DB2 listener
EXPOSE 50000
# we just have to keep some process running to keep the container alive (since `db2start` daemonizes)
ENTRYPOINT /home/db2inst1/sqllib/adm/db2start && tail -f /home/db2inst1/sqllib/db2dump/db2diag.log
