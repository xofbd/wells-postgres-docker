# Dockerized PostgreSQL Database
This repo enables one to easily create a Docker container running a PostgreSQL database. The database contains several tables representing one of the compiled wells dataset from [Southern Methodist University](http://geothermal.smu.edu/gtda/).

## Configuration
You will setup a few configuration values before getting things going. They are:

* `DB_USER`: username to access the database
* `DB_PASSWORD`: password of the user
* `PORT`: The port used by the database
* `POSTGRES_PASSWORD`: password for admin account (not important as it's not used but can't be empty)

You need to create a file called `.config` in the project's root directory. An example of `.config` is shown in `.config.template`. It contains a set of defaults and you can just copy over `.config.template` to `.config`.

## Running the Docker container
If you have GNU Make, you can launch the Docker container by simply running `make all`. This will build the image and launch a container running that image. If you don't have GNU Make, just follow these instructions:

1. Run `docker build -t wells .`
1. Run `docker run -d --rm <PORT>:5432 -e POSTGRES_PASSWORD=<POSTGRES_PASSWORD> wells`

Make sure to replace `<POSTGRES_PASSWORD>` with a chosen password and `<PORT>` with the port for the Postgres database to use. Note, building the image and running a contianer outside of Make will not use the port and `POSTGRES_PASSWORD` values set in `.config`. With regards to the port, you can just use the default of 5432 but you may want to use another one if that port is currently being used. You may need to kill any running Postgres databases or other services if your desired port is occupied.

## Connecting to the database
From the localhost, you can connect to the database using:

`psql $(bin/construct-url)`

as running `bin/construct-url` returns the database URL by using the values set in `.config`. In general the database URL is `postgresql://<DB_USER>:<DB_PASSWORD>@localhost:<PORT>/wells`.

## Testing
You can test that the database is running and that all the tables are accessible by running either `make test` or `test/test-db`.

## License
This project is distributed under the GNU General Purpose License. Please see `COPYING` for more information.
