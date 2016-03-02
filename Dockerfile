FROM centos:7

RUN rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm && \
	rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
	yum -y --enablerepo=epel,remi,remi-php70 upgrade && \
	yum -y --enablerepo=epel,remi,remi-php70 install wget

RUN wget https://s3.amazonaws.com/syrup-shared/v10.5_linuxx64_expc.tar.gz
ADD db2-expc-gen.rsp db2-expc-gen.rsp
RUN v10.5fp1_linuxx64_expc.tar.gz/expc/db2setup -r db2-expc-gen.rsp || true
RUN source /home/db2inst1/sqllib/db2profile

# spawn a DB2 listener
EXPOSE 50000
# we just have to keep some process running to keep the container alive (since `db2start` daemonizes)
ENTRYPOINT /home/db2inst1/sqllib/adm/db2start && tail -f /home/db2inst1/sqllib/db2dump/db2diag.log
