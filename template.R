
require(data.table)

.args <- if (interactive()) c(
  ""
) else commandArgs(trailingOnly = TRUE)

saveRDS(thing, tail(.args, 1))