FROM python:3.8-slim AS builder

# Prepare CSVs files for database tables
RUN apt-get update && apt-get install -y make wget

COPY requirements.txt /project/
COPY bin/prepare_data.py /project/bin/
COPY Makefile /project/
COPY make/data.mk /project/make/
WORKDIR project
RUN make prepare-csv

# Setup database
FROM postgres

COPY --from=builder /project/data/*.csv /project/data/
COPY bin/install.sh /docker-entrypoint-initdb.d/
COPY sql/*.sql /project/data/
COPY .config /project/
WORKDIR project

# install.sh uses sed inplace to modify the files used to setup the database.
# However, sed will throw a permissioning error as the user is not root.
RUN chmod a+w /project/data/
RUN sed -i -e 's/all all all/all docker all/g' /usr/local/bin/docker-entrypoint.sh
