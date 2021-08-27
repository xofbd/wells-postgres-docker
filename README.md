# Dockerized PostgreSQL Database
This repo enables one to easily create a Docker container running a PostgreSQL database. The database contains several tables representing one of the compiled wells dataset from [Southern Methodist University](http://geothermal.smu.edu/gtda/).

## Running the Docker container
If you have GNU Make, you can launch the Docker container by simply running `make all`. This will build the image and launch a container running that image. If you don't have GNU Make, just follow these instructions:

1. `docker build -t wells .`
1. `docker run -d --rm <port>:5432 -e POSTGRES_PASSWORD=<password> wells`

Make sure to replace `<password>` with a chosen password and `<port>` with the port for the Postgres database to use. For example, you can just use the default of 5432 but you may want to use another one if that port is currently being used. You may need to kill any running Postgres database if your desired port is currently being used.

## Connecting to the database
From the local host, you can connect to the database using `psql postgresql://docker:docker@localhost:5432/wells`. Make sure to use the right port if you are not using the default.

## License
This project is distributed under the GNU General Purpose License. Please see `COPYING` for more information.
