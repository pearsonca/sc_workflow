
require(data.table)

.debug <- c("input")
.args <- if (interactive()) sprintf(c(
  "%s/thing.rds",
  "%s/newthing.rds"
), .debug[1]) else commandArgs(trailingOnly = TRUE)

saveRDS(thing, tail(.args, 1))