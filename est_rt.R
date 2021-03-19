
require(data.table)
require(EpiNow2)

.debug <- c("~/Dropbox/sc_workflow", "ZAF")
.args <- if (interactive()) sprintf(c(
  "%s/input/epi_data.rds",
  "%s/output/rt/%s.rds"
), .debug[1], .debug[2]) else commandArgs(trailingOnly = TRUE)

target <- tail(.args, 1)
tariso <- gsub("\\.\\w+$","",basename(target))

epidata <- readRDS(.args[1])[
  iso3c == tariso, .(cases = sum(cases)), by=date
][(which.max(cases > 0)-1):.N][1:120, .(date, confirm = cases)]

lastdate <- epidata[90, date]

generation_time <- as.list(EpiNow2::generation_times[
  disease == "SARS-CoV-2",
  .(mean, mean_sd, sd, sd_sd, max=30)
])

incubation_period <- as.list(EpiNow2::incubation_periods[
  disease == "SARS-CoV-2",
  .(mean, mean_sd, sd, sd_sd, max=15)
])

res <- estimate_infections(
  reported_cases = epidata,
  generation_time = generation_time,
  delays = delay_opts(incubation_period),
  rt = NULL,
  verbose = TRUE,
  horizon = 0
)$samples[variable == "R" & date <= lastdate, .(sample, date, value)]

saveRDS(res, tail(.args, 1))