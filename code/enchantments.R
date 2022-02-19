library(tidyverse)
library(readxl)

df <- readxl::read_excel("data/enchantments_raw_data.xlsx") %>%
  mutate_at(c('Preferred Entry Date 1', 'Preferred Entry Date 2', 'Preferred Entry Date 3'), ~as.Date(.)) 

pref_date1 <- df %>% 
  group_by(`Preferred Entry Date 1`, `Results Status`) %>% 
  summarise(n=n())

acc_gg <- pref_date1 %>% 
  ggplot() + 
  geom_line(aes(x=`Preferred Entry Date 1`, y=n,color = `Results Status`))
acc_gg

pref_date_zone <- df %>% 
  group_by(`Preferred Entry Date 1`, `Results Status`, `Preferred Division 1`) %>% 
  summarise(n=n())

acc_gg <- pref_date_zone %>% 
  filter(`Results Status` %in% c("Accepted", "Unsuccessful")) %>%
  ggplot() + 
  geom_line(aes(x=`Preferred Entry Date 1`, y=n,color = `Results Status`)) + 
  facet_wrap(vars(`Preferred Division 1`))
acc_gg



