
require(data.table)

.args <- if (interactive()) c(
  "raw_epi_data.csv",
  "epi_data.rds"
) else commandArgs(trailingOnly = TRUE)

res <- fread(.args[1])[, .(who = WHO_region, iso2 = Country_code, date = Date_reported, cases = New_cases, deaths = New_deaths)]

setkey(res, who, iso2, date)

saveRDS(res, tail(.args, 1))