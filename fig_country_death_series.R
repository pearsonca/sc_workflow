
require(data.table)
require(ggplot2)

.debug <- c(".")
.args <- if (interactive()) sprintf(c(
  "%s/input/epi_data.rds",
  "%s/input/plot_elements.rda",
  "%s/output/ZAF.png"
), .debug[1]) else commandArgs(trailingOnly = TRUE)

target <- tail(.args, 1)
tariso <- gsub("\\.\\w+$", "", basename(target))

epidata <- readRDS(.args[1])[iso3c == tariso, .(deaths = sum(deaths)), by=date]

load(.args[2])

pl <- ggplot(epidata) +
  aes(date, deaths) +
  geom_line() +
  theme_minimal() +
  scale_y_incidence(itype="Deaths") +
  scale_x_quarters()

ggsave(tail(.args, 1), pl, width = 15, height = 7)