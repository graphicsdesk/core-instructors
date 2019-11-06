library(tidyverse)
library(jsonlite)

students <- fromJSON("../data/students-110119.json")
coci_courses <- fromJSON("../data/contemporary_civilization_courses.json")

students %>% 
  mutate(instructor_uni = uni) %>% 
  merge(coci_courses, by = "instructor_uni") %>% 
  View()
