
require(data.table)

.debug <- c("input")
.args <- if (interactive()) sprintf(c(
  "%s/epi_data.rds",
  "%s/isos.csv"
), .debug[1]) else commandArgs(trailingOnly = TRUE)

ref <- readRDS(.args[1])[continent == "Africa"]

fwrite(ref[,.(iso3c=sort(unique(iso3c)))], tail(.args, 1), col.names = FALSE)