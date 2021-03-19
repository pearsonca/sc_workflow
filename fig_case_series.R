
require(data.table)
require(ggplot2)

.debug <- c(".")
.args <- if (interactive()) sprintf(c(
  "%s/input/epi_data.rds",
  "%s/output/africa.png"
), .debug[1]) else commandArgs(trailingOnly = TRUE)

epidata <- readRDS(.args[1])[continent == "Africa"][,.(cases = sum(cases)),by=date]

pl <- ggplot(epidata) +
  aes(date, cases) +
  geom_line() +
  theme_minimal() +
  scale_y_continuous("Cases (per day)") +
  scale_x_date(NULL, date_breaks = "months", date_labels = "%b")

ggsave(tail(.args, 1), pl, width = 15, height = 7)