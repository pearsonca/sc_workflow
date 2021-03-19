
require(ggplot2)

.debug <- c(".")
.args <- if (interactive()) sprintf(c(
  "%s/input/plot_elements.rda",
), .debug[1]) else commandArgs(trailingOnly = TRUE)

scale_y_incidence <- function(
  itype = "Cases", name = sprintf("%s (per day)", itype), ...
) scale_y_continuous(name = name, ...)

scale_y_logincidence <- function(
  itype = "Cases", name = sprintf("%s (per day)", itype), ...
) scale_y_log10(name = name, ...)

scale_x_quarters <- function(
  name = NULL, date_breaks = "3 months", date_minor_breaks = "months",
  date_labels = "%b %Y", ...
) scale_x_date(
  name = name, date_breaks = date_breaks, date_minor_breaks = date_minor_breaks,
  date_labels = date_labels, ...
)

save(list = ls(), file = tail(.args, 1))