##########################################################
##                                                      ##
##   Statistical Analysis and Visualizations Using R    ##
##                                                      ##
##########################################################

## INTRODUCTION ----

install.packages("ggplot2")
library("ggplot2")

# To get details regarding contents of a package
help(package = "ggplot2")

# To list vignettes available for a specific package
vignette(package = "ggplot2")

# To view specific vignette
vignette("ggplot2-specs")

install.packages("lattice")
library("lattice")

# Calculations in R
20 + (30 * 3)
(144/12) - (20/5)
10^2
sqrt(81)
log(5)
exp(1.5)


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


# You will see error messages once you uncomment and run them

#Cities
#CITIES
#4cities <- c("Edmonton", "Calgary", "Red Deer", "Spruce Grove")
#my cities <- c("Edmonton", "Calgary", "Red Deer", "Spruce Grove")

# Solution to Exercise

age <- c(21, 24, 32, 45, 52)
salary <- c(4500, 3500, 4100, 4700, 6000)
cor(age, salary)


#---------------------------------------------------------------------------#

## R AND RSTUDIO ----

# binding columns
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


# Read the medical dataset in
# Make sure that you set your working directory to where this file is located
medical <- read.csv("medical_CSV.csv", header = TRUE)

head(medical)

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

# Subsetting
medical_female <- medical[medical$sex == "female", ]
head(medical_female)
medical_female_40 <- medical[medical$sex == "female" & medical$age > 40, ]

medical_female <- subset(medical, sex == "female")
head(medical_female)

# Install and activate the package first
install.packages("dplyr")
library("dplyr")

medical_female <- filter(medical, sex == "female")

head(medical_female)

# Selecting
medical_f40 <- subset(medical, sex == "female" & age >= 40,
                      select = c("id", "age", "sex", "substance"))

head(medical_f40)

medical_f40 <- medical %>%
  filter(sex == "female", age >= 40) %>%
  select(id, age, sex, substance)

head(medical_f40)

# Reorder the data by age
medical_f40 <- arrange(medical_f40, age)

# Let's see if the ordering worked
head(medical_f40)

# Reorder the data by age in descending order
medical_f40 <- arrange(medical_f40, desc(age))

# Let's see if the ordering worked
head(medical_f40)

# Create a new variable based on age
medical_f40 <- medical_f40 %>%
  mutate(age2 = ifelse(age < 45, "Younger than 45", "45 or older"))

# Let's see if the ordering worked
head(medical_f40)

# Solution to Exercise
medical_example <- medical %>%
  filter(age > 30, sex == "female", homeless != "homeless")

dim(medical_example)

medical_example <- arrange(medical_example, desc(age))

head(medical_example)

#---------------------------------------------------------------------------#

## DESCRIPTIVE STATISTICS ----


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
skim(medical[,c("mental1", "mental2", "avg_drinks", "max_drinks")])

# Summary by grouping variables
medical %>%
  group_by(sex) %>%
  select(sex, mental1, mental2, avg_drinks, max_drinks) %>%
  skim()

# Solution to Exercise
medical %>%
  group_by(race) %>%
  summarise(n = n(),
            mean_depression = mean(depression1, na.rm = TRUE),
            sd_depression = sd(depression1, na.rm = TRUE),
            min_depression = min(depression1, na.rm = TRUE),
            max_depression = max(depression1, na.rm = TRUE))

#---------------------------------------------------------------------------#

## DATA VISUALIZATIONS ----

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


tp <-c("p","o","h","l","b","s")
par(mfrow=c(2,3), mar=c(1,1,2,1), mai=c(0.2,0.1,0.3,0.1))
Fibonacci <- c( 1,1,2,3,5,8,13 )
for(i in tp){
  plot(Fibonacci,
       type = i, col=1, lwd=2,
       main = paste0("type = '",i,"'"),
       axes = FALSE,
       frame.plot = TRUE,
       xlab = "",
       ylab="")
}
par(mfrow=c(1,1))


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
  facet_wrap(~ sex, ncol = 1) +
  theme_bw()


# Solution to Exercise
ggplot(data = medical,
       mapping = aes(depression1, mental1, colour = sex)) +
  geom_point(size = 3) +
  labs(colour = "Sex",
       x = "Depression (Baseline)",
       y = "Mental (Baseline)") +
  theme_bw() +
  facet_wrap(~ substance, ncol = 1)


#---------------------------------------------------------------------------#

## HYPOTHESIS TESTING ----

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

# Solution to Exercise
medical$suicidal <- as.factor(medical$suicidal)

independentSamplesTTest(formula = depression1 ~ suicidal,
                        conf.level = 0.95,
                        one.sided = FALSE,
                        data = medical)

pairedSamplesTTest(formula = ~ mental1 + mental2,
                   conf.level = 0.95,
                   one.sided = FALSE,
                   data = medical)


aov_model4 <- aov(physical1 ~ race, data = medical)
summary(aov_model4)


#---------------------------------------------------------------------------#

## REGRESSION AND CORRELATION ----

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


# Solution to Exercise
model4 <- lm(depression2 ~ depression1 + treat1 + sex, data = medical)
summ(model4)
































