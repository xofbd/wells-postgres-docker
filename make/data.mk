SHELL := /bin/bash
ACTIVATE_VENV := source venv/bin/activate
WGET := wget -nc -P

raw_data := core.surface_site_county_state_materialized_view.zip
url_data := http://geothermal.smu.edu/static/DatasetsZipped8072020/$(raw_data)
csvs := data/wells.csv data/counties.csv data/states.csv

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

.PHONY: clean
clean:
	rm -rf data venv
