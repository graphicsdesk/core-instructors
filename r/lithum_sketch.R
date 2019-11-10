library(tidyverse)
library(jsonlite)

students <- fromJSON("../data/students-110119.json")
lithum_courses <- fromJSON("../data/literature_humanities.json")

lithum_courses %>%
  rename(uni = instructors_uni, course_title = title) %>%
  merge(students, by "uni") %>%
  ggplot(aes(department)) +
  geom_bar()+
  coord_flip()

