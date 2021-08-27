CREATE TABLE wells (
          id text,
          latitude double precision,
          longitude double precision,
          state_id int,
          county_id int,
          bht double precision,
          max_temperature double precision,
          depth double precision,
          datasource text,
          thermal_conductivity double precision,
          heat_flow double precision,
          gradient double precision
);

CREATE TABLE states (
          state_id int,
          state_code text,
	  state text
);

CREATE TABLE counties (
          county_id int,
          county text
);

CREATE INDEX ix_depth ON wells(depth);
CREATE INDEX ix_gradient ON wells(gradient);

COPY wells(id, latitude, longitude, state_id, county_id, bht, max_temperature, depth, datasource, thermal_conductivity, heat_flow, gradient)
FROM '/data/wells.csv'
DELIMITER ','
CSV HEADER;

COPY states(state_id, state_code, state)
FROM '/data/states.csv'
DELIMITER ','
CSV HEADER;

COPY counties(county_id, county)
FROM '/data/counties.csv'
DELIMITER ','
CSV HEADER;
