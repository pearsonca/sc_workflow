
DATAURL := https://covid19.who.int/WHO-COVID-19-global-data.csv

R = Rscript $^ $@

IDIR := ./input
ODIR := ./output

ISOS := $(shell cat ${IDIR}/isos.csv)

default: figures

figures: $(patsubst %,${ODIR}/figures/cases/%.png,${ISOS}) $(patsubst %,${ODIR}/figures/deaths/%.png,${ISOS}) $(patsubst %,${ODIR}/figures/both/%.png,${ISOS})

clean:
	rm raw_epi_data.csv epi_data.rds

${IDIR} ${ODIR} ${ODIR}/figures/cases ${ODIR}/figures/deaths ${ODIR}/figures/both:
	mkdir -p $@

${IDIR}/raw_epi_data.csv: | ${IDIR}
	wget -c -O $@ ${DATAURL}

${IDIR}/epi_data.rds: gen_clean_epi_data.R ${IDIR}/raw_epi_data.csv | ${IDIR}
	${R}

${IDIR}/isos.csv: gen_isos.R ${IDIR}/epi_data.rds
	${R}

${IDIR}/plot_elements.rda: gen_plot_elements.R
	${R}

${ODIR}/africa.png: fig_case_series.R ${IDIR}/epi_data.rds | ${ODIR}
	${R}

${ODIR}/figures/cases/%.png: fig_country_case_series.R ${IDIR}/epi_data.rds ${IDIR}/plot_elements.rda | ${ODIR}/figures/cases
	${R}

${ODIR}/figures/deaths/%.png: fig_country_death_series.R ${IDIR}/epi_data.rds ${IDIR}/plot_elements.rda | ${ODIR}/figures/deaths
	${R}

${ODIR}/figures/both/%.png: fig_country_both_series.R ${IDIR}/epi_data.rds ${IDIR}/plot_elements.rda | ${ODIR}/figures/both
	${R}