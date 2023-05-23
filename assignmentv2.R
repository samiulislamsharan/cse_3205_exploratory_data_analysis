install.packages("sandwich")

remove.packages("Zelig")

install.packages("https://cran.r-project.org/src/contrib/Archive/Zelig/Zelig_4.2-1.tar.gz", 
                 repos=NULL, 
                 type="source")

library(dplyr)
## Warning: package 'dplyr' was built under R version 3.4.4
library(Zelig)
library(ZeligChoice)
library(faraway)
library(survival)
data(transplant)
tibble::glimpse(transplant)

str(transplant)

summary(transplant)

transplant$evcode[transplant$event=="death"] <- "2"
transplant$evcode[transplant$event=="ltx"] <- "1"
transplant$evcode[transplant$event=="withdraw"] <- "1"
transplant$evcode[transplant$event=="censored"] <- "1"
transplant$evcode <- factor(transplant$evcode)
head(transplant)

str(transplant)

head(transplant)

transplant <- transplant %>%
  mutate(futime = as.integer(futime+1)) %>% 
  mutate(evcode = as.integer(sjmisc::rec(evcode, rec = "2=0; 1=1"))) %>% 
  select(futime, evcode, everything())


z.exp <- zelig(Surv(futime, evcode) ~ age + sex + abo,
               model = "exp", data = transplant, cite = F)
summary(z.exp)

x.low <- setx(z.exp, abo = "AB")
x.high <- setx(z.exp, abo = "O")
s.out <- sim(z.exp, x = x.low, x1 = x.high)
summary(s.out)

s.out$graph()