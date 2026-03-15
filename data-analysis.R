library(tidyverse)

df <- read_tsv("results/substitution_type.tsv", 
               col_names = c("REF", "ALT", "TYPE"),
               show_col_types = FALSE)

p1 <- df %>%
  count(TYPE) %>%
  mutate(prop = n / sum(n)) %>%
  ggplot(aes(x = TYPE, y = prop, fill = TYPE)) +
  geom_col() +
  scale_y_continuous(labels = scales::percent) +
  labs(title = "Total Proportion of Transitions and Transversions",
       y = "Proportion (%)", 
       x = "Mutation Type") +
  theme_minimal()

p2 <- df %>%
  count(REF, TYPE) %>%
  group_by(REF) %>%
  mutate(prop = n / sum(n)) %>%
  ggplot(aes(x = REF, y = prop, fill = TYPE)) +
  geom_col(position = "stack") +
  scale_y_continuous(labels = scales::percent) +
  labs(title = "Proportion of Ti/Tv by Reference Nucleotide",
       y = "Proportion (%)", 
       x = "Original Nucleotide (REF)") +
  theme_minimal()

ggsave("results/plot_total.jpeg", p1, width = 8, height = 6)
ggsave("results/plot_by_nucleotide.jpeg", p2, width = 8, height = 6)
