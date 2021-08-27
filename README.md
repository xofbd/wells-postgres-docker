# Dockerized PostgreSQL Database
This repo enables one to easily create a Docker container running a PostgreSQL database. The database contains several tables representing one of the compiled wells dataset from [Southern Methodist University](http://geothermal.smu.edu/gtda/).

## Getting started
If you have GNU Make, you can launch the Docker container by simply running `make all`. Once you've run `make all` once, you can simply run `make docker-run`. If you don't have GNU Make, follow the instructions below.

Before running a Docker container, you first need to prepare the CSV files that are used to create the database tables. With GNU Make you can run `make prepare-csv`. Alternatively:

1. Download the compressed [data file](http://geothermal.smu.edu/static/DatasetsZipped8072020/core.surface_site_county_state_materialized_view.zip) into a directory called `data`
1. Create and activate the virtual environment
   * `python3 -m venv venv`
   * `source venv/bin/activate` (different for Windows)
   * `pip install -r requirements.txt`
1. Run `bin/prepare_data.py core.surface_site_county_state_materialized_view.zip`

## Running the Docker container
With the data prepared, you'll need to build the image and launch a container of that image. With GNU Make you can run `make docker-run`. Alternatively:

1. `docker build -t wells .`
1. `docker run -d --rm <port>:5432 -e POSTGRES_PASSWORD=<password> wells`

Make sure to replace `<password>` with a chosen password and `<port>` with the port for the Postgres database to use. For example, you can just use the default of 5432 but you may want to use another one if that port is currently being used. You may need to kill any running Postgres database if your desired port is currently being used.

## Connecting to the database
From the local host, you can connect to the database using `psql postgresql://docker:docker@localhost:5432/wells`. Make sure to use the right port if you are not using the default.

## License
This project is distributed under the GNU General Purpose License. Please see `COPYING` for more information.
