FROM mysql as mysqldb
COPY ./*.sql /docker-entrypoint-initdb.d/
COPY ./*py /scripts/