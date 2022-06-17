# 6/24/19
# Catarina Pien
# Figure out which species are already in benthic census
# Kisters database transfer
rm(list=ls(all=TRUE))
library(stringr)
library(plyr)
library(dplyr)


setwd("C:/Users/cpien/OneDrive - California Department of Water Resources/Work/Database/R_code/")
#setwd("C:/Users/Catarina/Dropbox/DWR/Database/")
benthic <- read.csv("Data/kieco_benthic_2.csv")
zoop <- read.csv("Data/kieco_zoop_2.csv")
drift <- read.csv("Data/kieco_drift_2.csv")

benthic$db <- "benthic"
zoop$db <- "zoop"
drift$db <- "drift"
yolo <- rbind(zoop, drift)

yolo_unique <- yolo %>%
  distinct()

match_phylum <- match_df(yolo, benthic, on = "Phylum")
match_order <- match_df(yolo,benthic, on = "Order") %>%
  distinct()
match_class <- match_df(yolo,benthic, on = "Class")
match_family <- match_df(yolo,benthic, on = "Family") %>%
    distinct()
match_genus <- match_df(yolo, benthic, on = "Genus") %>%
  filter(Genus != "NA")
match_species <- match_df(yolo, benthic, on = "Species")

match_most <- match_df(yolo, benthic, on = c("Phylum", "Order", "Class", "Family", "Genus"))

match_some <- inner_join(yolo, benthic, by = c("Phylum", "Order", "Class", "Family"))
match_more <- inner_join(yolo, benthic, by = c("Order", "Family", "Genus"))

missing_phylum <- anti_join(yolo, benthic, by = "Phylum") %>%
  distinct()
missing_class <- anti_join(yolo, benthic, by = "Class") %>%
  distinct()
missing_order <- anti_join(yolo, benthic, by = "Order")%>%
  distinct()
missing_family <- anti_join(yolo, benthic, by = "Family")%>%
  distinct()
missing_genus <- anti_join(yolo, benthic, by = "Genus")%>%
  distinct()
missing_species <- anti_join(yolo, benthic, by = "Species")%>%
  distinct()

missing_all <- anti_join(yolo_unique, benthic, by = c("Phylum", "Class", "Order", "Family", "Genus", "Species"))
missing_most <- anti_join(yolo_unique, benthic, by = c("Phylum", "Class", "Order", "Family", "Genus"))

m1 <- rbind(missing_phylum, missing_class)
m2 <- rbind(m1, missing_order)
m3 <- rbind(m2, missing_family)
m4 <- rbind(m3, missing_genus)
m5 <- rbind(m4, missing_species)

add <- m5 %>%
  distinct()

add_phylum <- anti_join(yolo, benthic, by = "Phylum") %>%
  select(Phylum) %>%
  distinct()
add_class <- anti_join(yolo, benthic, by = "Class")%>%
  select(Class) %>%
  distinct()
add_order <- anti_join(yolo, benthic, by = "Order")%>%
  select(Order) %>%
  distinct()
add_family <- anti_join(yolo, benthic, by = "Family")%>%
  select(Family) %>%
  distinct()
add_genus <- anti_join(yolo, benthic, by = "Genus")%>%
  select(Genus) %>%
  distinct()
add_species <- anti_join(yolo, benthic, by = "Species")%>%
  select(Species) %>%
  distinct()





write.csv(yolo, "yolo_merged.csv")
write.csv(missing, "missing_rvers_postcage.csv")
write.csv(missing2, "missing_rvers_precage.csv")
