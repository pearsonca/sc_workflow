
require(data.table)
require(ggplot2)

.debug <- c(".")
.args <- if (interactive()) sprintf(c(
  "%s/input/epi_data.rds",
  "%s/input/plot_elements.rda",
  "%s/output/figures/both/ZAF.png"
), .debug[1]) else commandArgs(trailingOnly = TRUE)

target <- tail(.args, 1)
tariso <- gsub("\\.\\w+$", "", basename(target))

epidata <- melt(readRDS(.args[1])[
  iso3c == tariso, .(
    deaths = sum(deaths),
    cases = sum(cases)
  ),
  by=date
], id.vars = "date")

load(.args[2])

pl <- ggplot(epidata) +
  facet_grid(variable ~ ., switch = "y") +
  aes(date, value) +
  geom_line() +
  theme_minimal() + theme(strip.placement = "outside") +
  scale_y_logincidence(itype="Incidence") +
  scale_x_quarters()

ggsave(tail(.args, 1), pl, width = 15, height = 7)