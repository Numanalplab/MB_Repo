library(ggplot2)
library(dplyr)
library(tidyr)
library(patchwork) 

data <- read.csv("results/read_metrics.csv")

p1 <- ggplot(data, aes(x = gc_content)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "#2ecc71", alpha = 0.7) +
  geom_density(color = "#27ae60", size = 1) +
  labs(title = "GC Content Distribution", x = "GC %", y = "Density") +
  theme_minimal()

p2 <- ggplot(data, aes(x = read_length)) +
  geom_histogram(aes(y = ..density..), bins = 50, fill = "#3498db", alpha = 0.7) +
  scale_x_log10() +
  labs(title = "Read Length Distribution (Log Scale)",
   x = "Length (bp - log10)",
   y = "Count") +
  theme_minimal()

p3 <- ggplot(data, aes(x = mean_quality)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "#e74c3c", alpha = 0.7) +
  geom_density(color = "#c0392b", size = 1) +
  labs(title = "Quality Score Distribution", x = "Phred Score", y = "Density") +
  theme_minimal()

combined_plot <- p1 + p2 + p3
ggsave("results/qc_plots_R.png", combined_plot, width = 15, height = 5)

summary_stats <- data %>%
  summarise(
    Mean_Length = mean(read_length),
    Median_Length = median(read_length),
    Mean_GC = mean(gc_content),
    Median_GC = median(gc_content),
    Mean_Quality = mean(mean_quality),
    Median_Quality = median(mean_quality)
  )

print("--- Statistical Summaries for Professor Kılıç ---")
print(summary_stats)