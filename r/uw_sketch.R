library(tidyverse)
library(jsonlite)
library(magrittr)
library(dplyr)

students <- fromJSON("../data/students-110119.json")
uw_courses <- fromJSON("../data/university_writing.json")

uw_courses %>%
  rename(uni = instructor_uni, course_title = title) %>% 
  merge(students, by = "uni") %>% 
  ggplot(aes(department)) +
  geom_bar() +
  coord_flip()


