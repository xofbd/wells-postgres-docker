FROM postgres:13.4-buster

RUN apt-get update && apt-get install -y make python3 python3-venv wget

COPY requirements.txt /project/
COPY bin/prepare_data.py /project/bin/
COPY Makefile /project/
COPY make/data.mk /project/make/
WORKDIR project
RUN make prepare-csv

COPY bin/install.sh /docker-entrypoint-initdb.d/
COPY bin/*.sql /project/data/

RUN sed -i -e 's/all all all/all docker all/g' /usr/local/bin/docker-entrypoint.sh
