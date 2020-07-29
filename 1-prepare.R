library(tidyverse)

# read data
d2 <- readr::read_csv("winkler2009.csv")
d3 <- readr::read_csv("betsch2010.csv")
d3 <- filter(d3, jod_type == "total") # for betsch we only look at total duration
d4 <- readr::read_csv("hintzman.csv")

d <- bind_rows(d2, d3, d4)

# sum_score for attention
d <- mutate(d, sum_score = stim_type_num + att_type_num)

# new cis
d <- d %>% rowwise() %>%
  mutate(ci_low = psychometric::CIr(r_es, n)[1],
         ci_up = psychometric::CIr(r_es, n)[2])

# proper labels
d <- mutate(d, condition = ifelse(is.na(condition), "0", condition))
d <- mutate(d, exp = paste(abbreviate(paper, 5),
                           ifelse(nchar(study_number) == 1, "   e", " e"),
                           study_number,
                           sep = ""))

d <- d %>% group_by(exp) %>%
  mutate(cond = as.numeric(as.factor(condition)),
         max_cond = max(cond)) %>%
  ungroup()

d <- d %>% mutate(cond = paste(" c", as.character(cond), sep = ""))

d <- d %>% mutate(label = paste(exp, cond, sep = ""))

# arrange
d <- arrange(d, paper, manuscript, study_number, condition, iv, dv)

# write file
readr::write_csv(d, "output.csv")

# number of studies and experiments
table <- d %>% group_by(paper) %>% summarize(n = n(), n_exp = length(unique(study_number)))
sum(table$n)
sum(table$n_exp)

# effects per iv-dv combination
d %>% group_by(iv, dv) %>% summarize(n = n())
