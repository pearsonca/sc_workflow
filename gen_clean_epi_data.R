
require(data.table)
require(countrycode)

.debug <- c("input")
.args <- if (interactive()) sprintf(c(
  "%s/raw_epi_data.csv",
  "%s/epi_data.rds"
), .debug[1]) else commandArgs(trailingOnly = TRUE)

res <- fread(.args[1])[, .(
  who = WHO_region, iso2 = Country_code, date = Date_reported,
  cases = New_cases, deaths = New_deaths
)]

res[, continent := countrycode(iso2, "iso2c", "continent")]
res[, iso3c := countrycode(iso2, "iso2c", "iso3c")]

setkey(res, who, continent, iso2, iso3c, date)

saveRDS(res, tail(.args, 1))
