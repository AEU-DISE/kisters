library(dplyr)
library(tidyverse)


setwd("C:/Users/cpien/OneDrive - California Department of Water Resources/Work/Database/R_code/")

Taxa <- read.csv("Data/YB_Taxonomy_Taxa_Codes.csv")
NewTaxa <- read.csv("Data/ZOOP_kieco_taxonomy.csv")

NewTaxa_f <- NewTaxa %>%
  select(c(1:15,21,22))

TaxaAll <- left_join(Taxa, NewTaxa_f, by = "TaxonName") %>%
  arrange(OrganismID) %>%
  filter(!(OrganismID ==64 & CommonName == "Other Calanoid")) %>%
  filter(!(OrganismID == 124 & CommonName == "Other Calanoid")) %>%
  filter(!(OrganismID ==68 & CommonName == "Calanoid")) 

write.csv(TaxaAll, "Data/YB_TaxonomyTable.csv")
