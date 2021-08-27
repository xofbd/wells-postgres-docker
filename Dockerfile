FROM postgres

RUN mkdir data
COPY bin/*.sql data/
COPY data/*.csv data/
COPY bin/install.sh /docker-entrypoint-initdb.d/

RUN sed -i -e 's/all all all/all docker all/g' /usr/local/bin/docker-entrypoint.sh
