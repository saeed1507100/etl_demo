FROM postgres:alpine as postgres_db
COPY ./*.sql /docker-entrypoint-initdb.d/
RUN apk add --update python3 py3-pip gcc python3-dev openjdk11

RUN apk update \
 && apk add alpine-sdk linux-headers \
            py3-libxml2 libxml2-dev libxslt-dev libffi-dev

RUN mkdir airflow && export AIRFLOW_HOME=/airflow/
RUN pip install apache-airflow && airflow db init
RUN airflow users create \
    --username saeed \
    --password password \
    --firstname SAEED \
    --lastname KHAN \
    --role Admin \
    --email  saeedkhan.kuet.cse@gmail.com


RUN mkdir scripts/
COPY ./*py /scripts/

RUN pip install pyspark && pip install findspark