SHELL := /bin/bash
ACTIVATE_VENV := source venv/bin/activate
WGET := wget -nc -P
PORT ?= 5432
POSTGRES_PASSWORD ?= postgres

raw_data := core.surface_site_county_state_materialized_view.zip
url_data := http://geothermal.smu.edu/static/DatasetsZipped8072020/$(raw_data)
csvs := data/wells.csv data/counties.csv data/states.csv
docker_image := wells

.PHONY: all
all: clean $(csvs) docker-run

venv: requirements.txt
	test -d $@ || python3 -m venv $@
	$(ACTIVATE_VENV) && pip install -r $^
	touch $@

data:
	mkdir -p $@

.INTERMEDIATE: data/$(raw_data)
data/$(raw_data): | data
	$(WGET) $| $(url_data)
	touch $@

$(csvs) &: data/$(raw_data) | venv
	$(ACTIVATE_VENV) && bin/prepare_data.py $^	

.PHONY: prepare-csv
prepare-csv: $(csvs)

.PHONY: docker-build
docker-build:
	docker build -t $(docker_image) .

.PHONY: docker-run
docker-run: docker-build
	docker run -d -p $(PORT):5432 --rm -e POSTGRES_PASSWORD=$(POSTGRES_PASSWORD) $(docker_image)

.PHONY: clean
clean:
	rm -rf data venv
