FROM postgres:13.4-buster

RUN apt-get update && apt-get install -y make python3 python3-venv wget

# Prepare CSVs files for database tables
COPY requirements.txt /project/
COPY bin/prepare_data.py /project/bin/
COPY Makefile /project/
COPY make/data.mk /project/make/
WORKDIR project
RUN make prepare-csv

# Setup database
COPY bin/install.sh /docker-entrypoint-initdb.d/
COPY sql/*.sql /project/data/
COPY .config .

# install.sh uses sed inplace to modify the files used to setup the database.
# However, sed will throw a permissioning error as the user is not root.
# Granting write access also lets install.sh delete the CSVs once they've been
# used.
RUN chmod -R a+w /project/data/
RUN sed -i -e 's/all all all/all docker all/g' /usr/local/bin/docker-entrypoint.sh
