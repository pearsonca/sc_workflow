
default: epi_data.rds

clean:
	rm raw_epi_data.csv epi_data.rds

DATAURL := https://covid19.who.int/WHO-COVID-19-global-data.csv

R = Rscript $^ $@

raw_epi_data.csv:
	wget -c -O $@ ${DATAURL}

epi_data.rds: gen_clean_epi_data.R raw_epi_data.csv
	${R}

