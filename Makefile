
DATAURL := https://covid19.who.int/WHO-COVID-19-global-data.csv

R = Rscript $^ $@

IDIR := ./input
ODIR := ./output

ISOS := $(shell cat ${IDIR}/isos.csv)

default: $(patsubst %,${ODIR}/%.png,${ISOS})

clean:
	rm raw_epi_data.csv epi_data.rds

${IDIR} ${ODIR}:
	mkdir $@

${IDIR}/raw_epi_data.csv: | ${IDIR}
	wget -c -O $@ ${DATAURL}

${IDIR}/epi_data.rds: gen_clean_epi_data.R ${IDIR}/raw_epi_data.csv | ${IDIR}
	${R}

${IDIR}/isos.csv: gen_isos.R ${IDIR}/epi_data.rds
	${R}

${ODIR}/africa.png: fig_case_series.R ${IDIR}/epi_data.rds | ${ODIR}
	${R}

${ODIR}/%.png: fig_country_case_series.R ${IDIR}/epi_data.rds | ${ODIR}
	${R}