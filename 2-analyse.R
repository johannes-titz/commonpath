library(xtable)
library(tidyverse)
library(ggplot2)
library(extrafont) # for CM font
extrafont::loadfonts()
source("helper.R") # for science theme

# read and select data
d <- readr::read_csv("output.csv")
a <- dplyr::select(d, label, iv, dv, r_es, sum_score, jod_type, d_type)

# change data structure
a <- a %>% unite("iv_dv", c("iv", "dv"))
a <- a %>% spread(key = iv_dv, value = r_es)

# check conditions and add difference
a <- mutate(a, cond1 = f_jof > f_jod, cond2 = d_jof > d_jod)
a <- mutate(a, diff_f = f_jof - f_jod, diff_d = d_jof - d_jod)

# now add n again, this is required because Hintzman e1 has different sample
# sizes, a bit hacky
a2 <- left_join(a, dplyr::select(d, label, n))
# now remove dups and take the smaller sample size to be on the conservative
# site
a2 <- distinct(a2)
a2 <- filter(a2, n!=117 & label != "H1970 e1")

# create figure
pdf("plots/monotonicity.pdf", width = 10*0.75, height = 7*.75)
ggplot(a2, aes(x=diff_f, y=diff_d, color = as.factor(sum_score),
               shape = as.factor(sum_score))) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "gray") +
  scale_color_brewer("Attention", type = "qual",
                     labels = c("Low", "Medium", "High"),
                     palette = "Dark2") +
  scale_shape("Attention", labels = c("Low", "Medium", "High")) +
  geom_point(aes(size = n), alpha = .75) +
  scale_size(name = expression(italic(n))) +
  scale_x_continuous(expression(paste(italic(beta["Ff"]), " - ",
                                      italic(beta["Df"]))),
                     limits = c(-0.75, 0.75)) +
  scale_y_continuous(expression(paste(italic(beta["Fd"]), " - ",
                                      italic(beta["Dd"]))),
                     limits = c(-0.75, 0.75)) +
  theme_bw() +
  science_theme_without_border_without_grid +

  theme(text = element_text(family = "CM Roman"),
        legend.key = element_rect(colour = 'transparent',
                                  fill = 'transparent'),
        legend.box = "horizontal") +
  annotate("text", 0.75, 0.75, vjust = 1, hjust = 1,
    label = paste('Only 3 of 38 studies lie in the first',
                  'quadrant and are not inconsistent with',
                  'a unidimensional model.', sep = "\n"),
    family = "CM Roman")
dev.off()

# embed font in pdf
extrafont::embed_fonts("plots/monotonicity.pdf")

# CI
binom.test(table(!a$cond2))

# create table (effects that are consistent with common path hypothesis)

a2 %>%
  filter(cond1 == TRUE & cond2 == TRUE)

colnames(a2)  <- c("Study", "Attention", "D type", "d type", "$\\BDd$",
                   "$\\BFd$", "$\\BDf$", "$\\BFf$", "Condition 1",
                   "Condition 2", "difference f", "difference d", "n")

table <- a2 %>%
  filter(`Condition 1` == TRUE & `Condition 2` == TRUE) %>%
  select(-Attention, -`Condition 1`, -`Condition 2`, -`D type`, -`d type`) %>%
  xtable(caption = "Effects consistent with the unidimensional hypothesis.",
                 label = "tab:consistentEffects",
                 # align = rep("r", 9),
                 digits = 2,
                 auto = T, booktabs = TRUE)
print(table, file = "tables/tableConsistentEffects.tex",
      sanitize.text.function = function(x){x})