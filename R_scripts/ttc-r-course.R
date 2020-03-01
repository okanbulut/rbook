##########################################################
##                                                      ##
##   Statistical Analysis and Visualizations Using R    ##
##                                                      ##
##########################################################

## PART I: INTRODUCTION ----

install.packages("ggplot2")
library("ggplot2")

# To get details regarding contents of a package
help(package = "ggplot2")

# To list vignettes available for a specific package
vignette(package = "ggplot2")

# To view specific vignette
vignette("ggplot2-specs")


#######################################
#               EXERCISE 1            #
#######################################

# Set the working directory
setwd("Put your folder path here")

# Check if you changed it properly
getwd()

# Install and activate the lattice package
install.packages("lattice")
library("lattice")

#--------------------------------------#

# Creating variables in R
x <- 25
x

weight <- c(60, 72, 80, 84, 56)
weight

height <- c(1.7, 1.75, 1.8, 1.9, 1.6)
height

weight2 <- weight * 2.20462
weight2

# It overwrites the existing weight variable
weight <- weight * 2.20462

reading <- c(80, 75, 50, 44, 65)
math <- c(90, 65, 60, 38, 70)
total <- reading + math
total

cities <- c("Edmonton", "Calgary", "Red Deer", "Spruce Grove")
cities

gender <- c("1", "2", "2", "1", "2")
gender


# You will see error messages for each one.
# Just remove the hashtag and run them

#Cities
#CITIES
#4cities <- c("Edmonton", "Calgary", "Red Deer", "Spruce Grove")
#my cities <- c("Edmonton", "Calgary", "Red Deer", "Spruce Grove")


#######################################
#               EXERCISE 2            #
#######################################

# Type the values of 21, 24, 32, 45, 52 inside c()
age <- c()

# Type the values of 4500, 3500, 4100, 4700, 6000 inside c()
salary <- c()

# Correlate the two variables using the cor function
cor(age, salary)

#--------------------------------------#

## PART II: DATA WRANGLING ----

# Binding columns
age <- c(21, 24, 32, 45, 52)
salary <- c(4500, 3500, 4100, 4700, 6000)
mydata <- cbind(age, salary)
mydata

# Binding rows
person1 <- c(21, 4500)
person2 <- c(24, 3500)
person3 <- c(32, 4100)
person4 <- c(45, 4700)
person5 <- c(52, 6000)

mydata <- rbind(person1, person2, person3, person4, person5)
mydata

# Data frame
mydata <- data.frame(age = c(21, 24, 32, 45, 52),
                     salary = c(4500, 3500, 4100, 4700, 6000))
mydata

# To print the first six rows of a data frame
head(mydata)

# To see the entire data in the view window
View(mydata)

# Read in EXCEL files
install.packages("xlsx")
library("xlsx")

# DON'T RUN THE CODE AS THIS IS AN EXAMPLE
my_excel_file <- read.xlsx("path to the file/filename.xlsx", sheetName = "sheetname")


# Read in SPSS files
install.packages("foreign")
library("foreign")

# DON'T RUN THE CODE AS THIS IS AN EXAMPLE
my_spss_file <- read.spss("path to the file/filename.sav", to.data.frame = TRUE)


# Read in text files
# DON'T RUN THE CODE AS THIS IS AN EXAMPLE
my_csv_file <- read.csv("path to the file/filename.csv", header = TRUE)

# DON'T RUN THE CODE AS THIS IS AN EXAMPLE
my_txt_file <- read.table("path to the file/filename.txt", header = TRUE, sep = "\t")


#######################################
#               EXERCISE 3            #
#######################################

# Make sure that you set your working directory
# to where this file is located
medical <- read.csv("medical.csv", header = TRUE)

# Preview the data
head(medical)

#--------------------------------------#

nrow(medical)
ncol(medical)
dim(medical)

names(medical)
str(medical)

# Indexing
medical[5, 2]
medical[1:5, 1:3]
medical[c(1, 2, 3, 4, 5), c(1, 2, 3)]
medical[c(1, 2, 3, 4, 5), c("id", "age", "sex")]

medical$age
head(medical$age)
medical$age[10:15]
medical$age[c(10, 11, 12, 13, 14, 15)]

# Subsetting using "subset"
medical_female <- subset(medical, sex == "female")
head(medical_female)

medical_f40 <- subset(medical, sex == "female" & age >= 40,
                      select = c("id", "age", "sex", "substance"))

head(medical_f40)

# Subsetting using "dplyr"
install.packages("dplyr")
library("dplyr")

medical_female <- filter(medical, sex == "female")
head(medical_female)


medical_f40 <- filter(medical, sex == "female", age >= 40)
medical_f40 <- select(medical_f40, id, age, sex, substance)
head(medical_f40)

# or

medical_f40 <- medical %>% # Send the medical data to filter
  filter(sex == "female", age >= 40) %>% # Filter the data and send it to select
  select(id, age, sex, substance) # Finally select the data

head(medical_f40)


# Reorder the data by age
medical_f40 <- arrange(medical_f40, age)
head(medical_f40)

# Reorder the data by age in descending order
medical_f40 <- arrange(medical_f40, desc(age))
head(medical_f40)

# Create a new variable based on age
medical_f40 <- medical_f40 %>%
  mutate(age2 = ifelse(age < 45, "Younger than 45", "45 or older"))

head(medical_f40)

#######################################
#               EXERCISE 4            #
#######################################

# Filter the data based on age, gender, and homeless
# Type the following inside filter()
# age > 30, sex == "female", homeless != "homeless"
medical_example <- medical %>%
  filter()

dim(medical_example)

# Order the data
# Type the following inside arrange
# medical_example, desc(age)
medical_example <- arrange()

# Preview the data
head(medical_example)

#-------------------------------------#

## PART III: DESCRIPTIVE STATISTICS ----

# Summary function
summary(medical)
summary(medical$age)
summary(medical[,c("age", "avg_drinks", "max_drinks")])

# Frequency tables for homeless status and sex
table(medical$homeless)
table(medical$sex)

# Frequency table for age
table(medical$age)

age_table <- as.data.frame(table(medical$age))
head(age_table)

colnames(age_table) <- c("Age", "Frequency")
head(age_table)

# Proportions
prop.table(table(medical$sex))

# Percentages
prop.table(table(medical$sex))*100

# Percentages rounded (no decimal points)
round(prop.table(table(medical$sex))*100, 0)

# 2 by 2 Frequencies
table(medical$homeless, medical$sex)

# 2 by 2 Proportions
prop.table(table(medical$homeless, medical$sex))

# 2 by 2 Percentages
prop.table(table(medical$homeless, medical$sex))*100

# 2 by 2 Percentages rounded to the 2nd decimal point
round(prop.table(table(medical$homeless, medical$sex))*100, 2)

#######################################
#               EXERCISE 5            #
#######################################

# Type the following inside table()
# medical$race, medical$substance
prop.table(table())*100


#-------------------------------------#

# Mean
mean(medical$age, na.rm = TRUE)

# Median
median(medical$age, na.rm = TRUE)

# Standard deviation
sd(medical$age, na.rm = TRUE)

# Variance
var(medical$age, na.rm = TRUE)

# Quantile
quantile(medical$age, na.rm = TRUE)

# A particular Quantile - for example, 95th percentile
quantile(medical$age, 0.95)

# Range
range(medical$age, na.rm = TRUE)

# Interquartile range (IQR)
IQR(medical$age, na.rm = TRUE)

# Min and max values
min(medical$age, na.rm = TRUE)
max(medical$age, na.rm = TRUE)

# Mean and median by group
tapply(medical$age, medical$sex, mean)
tapply(medical$age, medical$sex, median)


medical %>%
  summarise(mean_age = mean(age, na.rm = TRUE),
            median_age = median(age, na.rm = TRUE),
            sd_age = sd(age, na.rm = TRUE),
            var_age = var(age, na.rm = TRUE))

medical %>%
  group_by(sex) %>%
  summarise(n = n(), # Count by sex
            mean_age = mean(age, na.rm = TRUE), # Mean
            median_age = median(age, na.rm = TRUE), # Median
            sd_age = sd(age, na.rm = TRUE), # Standard deviation
            var_age = var(age, na.rm = TRUE)) # Variance


# Let's install and activate the package
install.packages("skimr")
library("skimr")

# Summary for the entire data
skim(medical)

# Summary for some variables
skim(medical, mental1, mental2, avg_drinks, max_drinks)

# Summary by grouping variables
medical %>%
  group_by(sex) %>%
  select(sex, mental1, mental2, avg_drinks, max_drinks) %>%
  skim()

#######################################
#               EXERCISE 6            #
#######################################

# Type race inside group_by()
# Type depression1, na.rm = TRUE inside
# mean(), sd(), min(), and max()
medical %>%
  group_by() %>%
  summarise(n = n(),
            mean_depression = mean(),
            sd_depression = sd(),
            min_depression = min(),
            max_depression = max())

#-------------------------------------#

## PART IV: DATA VISUALIZATIONS ----

# Boxplots
boxplot(medical$depression1,
        main = "Depression Scores",
        sub = "The measurement was completed at the baseline")


boxplot(formula = depression1 ~ sex,
        data = medical,
        main = "Depression Scores by Sex",
        ylab = "Depression at the baseline",
        names = c("Female", "Male"))


# Histograms
hist(medical$depression1,
     main = "Depression Scores at the Baseline",
     xlab = "Depression")

hist(medical$depression1,
     main = "Depression Scores at the Baseline",
     xlab = "Depression",
     font.main = 1,
     cex.main = 1,
     font.axis = 2,
     col.lab = "gray50")


# Bar Graphs
medical$race <- as.factor(medical$race)
plot(medical$race,
     main = "Race Groups in the medical Dataset",
     xlab = "Race",
     ylab = "Count")


# Scatterplots
plot(medical$depression1, medical$depression2,
     xlab = "Depression at the baseline",
     ylab = "Depression after 6 months",
     main = "Scatterplot of Depression Scores")


# Scatterplots + Boxplots
install.packages("car")
library("car")

scatterplot(depression1 ~ depression2,
            data = medical,
            smooth = FALSE)


# Scatterplot matrix
pairs(formula = ~ depression1 + mental1 + physical1,
      data = medical,
      main = "Scatterplot Matrix with Three Scores")


# Saving plots
jpeg("myplot.jpg", width = 8, height = 4, units = "in", res = 300)
plot(medical$depression1, medical$depression2)
dev.off()

#######################################
#               EXERCISE 7            #
#######################################

# Type mental1 ~ substance after formula =
boxplot(formula = ,
        data = medical,
        main = "Mental Status by Substance",
        ylab = "Mental Status at the baseline",
        names = c("Alcohol", "Cocaine", "Heroin"))

# Delete ... and type medical$depression1, medical$mental1
plot(...,
     xlab = "Depression at the baseline",
     ylab = "Mental Status at the baseline",
     main = "Scatterplot of Depression and Mental Scores")

#-------------------------------------#

# Visualizations with ggplot2
library("ggplot2")

ggplot(data = medical,
       mapping = aes(depression1, depression2)) +
  geom_point(size = 3) +
  labs(x = "Depression (Baseline)",
       y = "Depression (6 months)") +
  theme_bw() # for black & white theme


ggplot(data = medical,
       mapping = aes(depression1, depression2, colour = sex)) +
  geom_point(size = 3) +
  geom_smooth(method = lm, color = "red", se = TRUE) +
  labs(colour = "Sex",
       x = "Depression (Baseline)",
       y = "Depression (6 months)") +
  theme_bw() # for black & white theme


ggplot(data = medical,
       mapping = aes(x = sex, y = depression1, fill = race)) +
  labs(x = "Sex",
       y = "Depression at the baseline",
       fill = "Race") +
  geom_boxplot() +
  theme_bw()


ggplot(data = medical,
       mapping = aes(x = depression1)) +
  labs(x = "Depression at the baseline",
       y = "Frequency",
       title = "Depression Scores at the the Baseline") +
  geom_histogram(color = "white", # color of bar lines
                 fill = "steelblue", # filling color
                 bins = 40) + # number of bins
  theme_bw()


ggplot(data = medical,
       mapping = aes(x = race)) +
  labs(x = "Race",
       y = "Frequency") +
  geom_bar(color = "white",
           fill = "orange") +
  theme_bw()


ggplot(data = medical,
       mapping = aes(x = race, fill = sex)) +
  labs(x = "Race",
       y = "Frequency") +
  geom_bar() +
  theme_bw()


ggplot(data = medical,
       mapping = aes(x = race, fill = sex)) +
  labs(x = "Race",
       y = "Frequency") +
  geom_bar(position = "dodge") +
  theme_bw()


ggplot(data = medical,
       mapping = aes(x = race, fill = sex)) +
  labs(x = "Race",
       y = "Frequency") +
  geom_bar(position = "dodge") +
  facet_wrap(. ~ sex) +
  theme_bw()


#######################################
#               EXERCISE 8            #
#######################################

# Type medical for data
# Type depression1, mental1, colour = sex inside aes()
ggplot(data = ,
       mapping = aes()) +
  geom_point(size = 3) +
  labs(colour = "Sex",
       x = "Depression (Baseline)",
       y = "Mental (Baseline)") +
  theme_bw() +
  facet_wrap(. ~ substance)

#-------------------------------------#

## PART V: HYPOTHESIS TESTING ----

# Let's see the mean for mental1 in the data
mean(medical$mental1) # it is 31.68

# One-sample t test
t.test(medical$mental1, mu = 35, conf.level = 0.95, alternative = "two.sided")

# Install the activate the package
install.packages("lsr")
library("lsr")

oneSampleTTest(x=medical$mental1, mu=35, conf.level=0.95, one.sided=FALSE)

# Independent-samples t test
boxplot(formula = depression1 ~ sex,
        data = medical,
        main = "Depression Scores by Sex",
        ylab = "Depression at the baseline",
        names = c("Female", "Male"))

male <- subset(medical, sex == "male", select = "depression1")
female <- subset(medical, sex == "female", select = "depression1")
t.test(male, female, conf.level = 0.95, alternative = "two.sided")


medical$sex <- as.factor(medical$sex)

independentSamplesTTest(formula = depression1 ~ sex,
                        conf.level = 0.95,
                        one.sided = FALSE,
                        data = medical)

# Paired t test
mean(medical$depression1)
mean(medical$depression2)

t.test(medical$depression1, medical$depression2,
       paired = TRUE, alternative = "two.sided",
       conf.level = 0.95)

pairedSamplesTTest(formula = ~ depression1 + depression2,
                   conf.level = 0.95,
                   one.sided = FALSE,
                   data = medical)

# ANOVA
boxplot(formula = depression1 ~ substance,
        data = medical,
        main = "Depression Scores by Substance Type",
        ylab = "Depression at the baseline")


# Compute the analysis of variance
aov_model1 <- aov(depression1 ~ substance, data = medical)

# Summary of the analysis
summary(aov_model1)

# Post hoc comparison
TukeyHSD(aov_model1)

# Substance + Sex
aov_model2 <- aov(depression1 ~ substance + sex, data = medical)
summary(aov_model2)

# Substance + Sex + Substance x Sex
aov_model3 <- aov(depression1 ~ substance*sex, data = medical)
summary(aov_model3)


#######################################
#               EXERCISE 9            #
#######################################

# Save the suicide status as a factor
medical$suicidal <- as.factor(medical$suicidal)

# Type depression1 ~ suicidal after formula =
independentSamplesTTest(formula = ,
                        conf.level = 0.95,
                        one.sided = FALSE,
                        data = medical)

# Type ~ mental1 + mental2 after formula =
pairedSamplesTTest(formula = ,
                   conf.level = 0.95,
                   one.sided = FALSE,
                   data = medical)


# Type physical1 ~ race, data = medical inside aov()
aov_model4 <- aov()
summary(aov_model4)

#-------------------------------------#

## PART VI: REGRESSION AND CORRELATION ----

cor(medical$depression1, medical$mental1)

cor(medical[, c("depression1", "mental1", "physical1")])

# Activate the package
library("lsr")

correlate(medical[, c("depression1", "mental1", "physical1")],
          test = TRUE, corr.method="pearson")

# Install and activate the package
install.packages("corrplot")
library("corrplot")

# First, we need to save the correlation matrix
cor_scores <- cor(medical[, c("depression1", "mental1", "physical1",
                              "depression2", "mental2", "physical2")])

# Plot 1 with circles
corrplot(cor_scores, method="circle")

# Plot 2 with colors
corrplot(cor_scores, method="color")

# Plot 3 with numbers
corrplot(cor_scores, method="number")

# Plot 4 with circles + lower triangular
corrplot(cor_scores, method="circle", type="lower")

# Plot 5 with circles + lower triangular + ordered correlations
corrplot(cor_scores, method="circle", type="lower", order="hclust")

cor(medical$depression1, medical$mental1)

# Activate the ggplot2 first
library("ggplot2")

ggplot(data = medical,
       mapping = aes(x = depression1, y = mental1)) +
  geom_point(size = 2, color = "grey25") +
  geom_smooth(method = lm, color = "blue", se = TRUE) +
  labs(x = "Depression scores",
       y = "Mental scores",
       title = "Scatterplot of depression and mental scores at the baseline") +
  theme_bw()

# Set up the model and save it as model1
model1 <- lm(mental1 ~ depression1, data = medical)

# Print basic model output
print(model1)

# Print detailed summary of the model
summary(model1)

# Install and activate the package
install.packages("jtools")
library("jtools")

# Print more organized output
summ(model1)

# Add physical1 into the previous model
model2 <- lm(mental1 ~ depression1 + physical1, data = medical)

# Print detailed summary of the model
summ(model2)

# Add sex into the previous model
model3 <- lm(mental1 ~ depression1 + physical1 + sex, data = medical)

# Print detailed summary of the model
summ(model3)

# Model comparison
anova(model1, model2, model3)
plot_summs(model1, model2, model3, scale = TRUE)


#######################################
#              EXERCISE 10            #
#######################################

# Type the following inside lm()
# depression2 ~ depression1 + treat1 + sex, data = medical

model4 <- lm()

# See the results
summary(model4)
summ(model4)

#-------------------------------------#
