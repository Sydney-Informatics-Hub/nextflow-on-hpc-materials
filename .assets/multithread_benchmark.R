library(tidyverse)
library(ggplot2)

df <- read_tsv("bwa_fqc_times.tsv")
colnames(df) <- c("Tool", "Threads", "CPU_Time", "Walltime")

# Calculate summary statistics
summary_data <- df %>%
  pivot_longer(cols = c(CPU_Time, Walltime), 
               names_to = "Metric", 
               values_to = "Time") %>%
  group_by(Tool, Threads, Metric) %>%
  summarise(
    mean_time = mean(Time),
    sd_time = sd(Time),
    .groups = "drop"
  ) %>%
  mutate(
    Category = paste(Tool, Threads, "threads"),
    Metric = recode(Metric, 
                    CPU_Time = "CPU Time", 
                    Walltime = "Walltime")
  )

# Create the plot
p <- ggplot(summary_data, aes(x = Category, y = mean_time, fill = Metric)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +
  geom_errorbar(aes(ymin = mean_time - sd_time, ymax = mean_time + sd_time),
                position = position_dodge(width = 0.8),
                width = 0.25) +
  labs(
    title = "Performance Comparison: bwa vs fastqc",
    x = "Tool and Thread Count",
    y = "Time (seconds)",
    fill = "Metric"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(hjust = 0.5, face = "bold")
  ) +
  scale_fill_manual(values = c("CPU Time" = "#3498db", "Walltime" = "#e74c3c"))

ggsave("bwa_fqc_times.png", p, scale = 0.75)
