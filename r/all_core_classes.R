library(tidyverse)
library(jsonlite)
library(magrittr)
library(dplyr)

#Read in people from the directory 
students <- fromJSON("../data/students-110119.json")
facultyanddstaff <- fromJSON("../data/facultyandstaff-110119.json")
people <- union(facultyanddstaff, students)

#Read in all courses (uw, cc, and lithum)
all_courses <- fromJSON("../data/all_courses.json")


# Counting and graphing

all_courses %>% 
  rename(uni = instructor_uni, course_title = title) %>% 
  merge(people, by = "uni") %>% View()
  mutate(
    instructor_type = case_when(
      grepl("Lecturer", title) ~ "Nontenured",
      grepl("Student", title) ~ "Student",
      uni %in% c("rcp6", "tsl2119","hck2110") ~ "Student",
      grepl("Assistant Professor", title) ~ "Tenure-track",
      grepl("Professor", title) ~ "Tenured",
      grepl("Dean", title) ~ "Administrative",
      TRUE ~ "UNCAUGHT"
    )
  ) %>% 
  count(instructor_type) %>% 
  # filter(instructor_type == "UNCAUGHT") %>%
  # View()
  # count(instructor_type, subject) %>%
  mutate(
    pct = n / sum(n)
  ) %>% 
  ggplot(aes(instructor_type, pct)) +
  geom_col() +
  coord_flip()

