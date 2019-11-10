library(tidyverse)
library(jsonlite)
library(magrittr)
library(dplyr)

# Read in people from directory

students <- fromJSON("../data/students-110119.json")
facultyanddstaff <- fromJSON("../data/facultyandstaff-110119.json")
people <- union(facultyanddstaff, students)

# Read in courses and combine them; we will do this in Python

lithum_courses <- fromJSON("../data/literature_humanities.json") %>% 
  mutate(subject = "Literature Humanities")
cc_courses <- fromJSON("../data/contemporary_civilization_courses.json") %>% 
  mutate(subject = "Contemporary Civilization")
all_courses <- union(lithum_courses, cc_courses)

# Counting and graphing

all_courses %>% 
  rename(uni = instructor_uni, course_title = title) %>% 
  merge(people, by = "uni") %>% 
  mutate(
    instructor_type = case_when(
      grepl("Lecturer", title) ~ "Nontenured",
      grepl("Student", title) ~ "Student",
      uni %in% c("rcp6", "tsl2119") ~ "Student",
      grepl("Assistant Professor", title) ~ "Tenure-track",
      grepl("Professor", title) ~ "Tenured",
      grepl("Dean", title) ~ "Administrative",
      TRUE ~ "UNCAUGHT"
    )
  ) %>% 
  count(instructor_type, subject) %>% 
  group_by(subject) %>% 
  mutate(
    pct = n / sum(n)
  ) %>% 
  ggplot(aes(instructor_type, pct)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ subject)
