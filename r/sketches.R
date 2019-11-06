library(tidyverse)
library(jsonlite)

students <- fromJSON("../data/students-110119.json")
coci_courses <- fromJSON("../data/contemporary_civilization_courses.json")

coci_courses %>% 
  rename(uni = instructor_uni, course_title = title) %>% 
  merge(students, by = "uni") %>% 
  ggplot(aes(department)) +
  geom_bar() +
  coord_flip()
