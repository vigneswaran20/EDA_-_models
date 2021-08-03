


library(dplyr)             #Load dplyr package

#Create Example data
data <- data.frame(x1 = 1:6,
                   x2 = c(1,2,2,3,1,2),
                   x3 = c("F","B","C","E","A","D"))

arrange(data,x3)           #Apply arrange function


filter(data, x2==2)        #Apply filter function 


mutate(data, x4 = x1 + x2) #Apply mutate function 

pull(data, x2)             #Apply pull function

rename(data, new_name = x3) #Apply rename function

set.seed(765)             #set seed for reproducibility
sample_n(data, 3)         #Apply sample_n function   


select(data, c(x2,x3))   #Apply select function



data1 <- data.frame(ID = 1:2,
                    x1 = c("a1","a2"),
                    stringsAsFactors = FALSE)  #Create first example data frame

data2 <- data.frame(ID = 2:3,
                    x1 = c("b1","b2"),
                    stringsAsFactors = FALSE) #Create second example data frame


inner_join(data1, data2, by = "ID")  #Apply inner_join dplyr function
left_join(data1, data2, by = "ID")   #Apply left_join dplyr function
right_join(data1, data2, by = "ID")  #Apply right_join dplyr function 
full_join(data1, data2, by = "ID")   #Apply full_join dplyr function
semi_join(data1, data2, by="ID")     #Apply semi_join dplyr function
anti_join(data1, data2, by="ID")     #Apply anti_join dplyr function


data1 <- data.frame(x1 = 1:5, x2 = letters[1:5]) #Create three data frames
data2 <- data.frame(x1 = 0, x3 = 5:9)
data3 <- data.frame(x3 = 5:9, x4 = letters[5:9])

bind_rows(data1, data2)           #Apply bind_rows function
bind_cols(data1, data3)           #Apply bind_cols function

#### Example data
data <- data.frame(x1 = 1:5,
                   x2 = c(1,2,2,1,2),
                   x3 = c("B","C","E","A","D"))
data

arrange(data, x2)           #Arrange data by one column
arrange(data, x2, x3)       #Arrange data by multiple columns






#Lead and Lag R functions of dplyr

x <- 1:10                 #Example Vector

lead(x)                  #Basic application of Lead
                         #Vector shifted one position to the right

lag(x)                  #Basic application of Lag
                        #Vector shifted one position to the left

lead(x, 3)             #Apply lead function with larger n
lag(x,3)               #Apply lag function with larger n








#Extract rows of tibble or data frame
data <- data.frame(x1 = 1:5, x2 = letters[1:5], group = c("gr1","gr2","gr1","gr3","gr2"))
filter(data, group == "gr2")


#mutate & transmute R functions of dplyr Package
data <- data.frame(x1 = 1:5,
                   x2 = 5:9)   #Create example data

mutate(data, x3 = x1 + x2)     #Apply mutate function
transmute(data, x3 = x1 + x2)  #Apply transmute function

#Extract column of tibble in R
data <- data.frame(x1 = 1:5,
                   x2 = letters[1:5],
                   x3 = 1)

data <- as_tibble(data)
data                        #Print example from tibble

x1 <- data %>% pull(x1)     #Extract column from tibble
x1                          #Print column to console

#Subset Data Frame Rows by Logical Condition in R 
data <- data.frame(x1 = c(3,7,1,8,5),x2 = letters[1:5],group = c("g1","g2","g1","g3","g1"))
data

data[data$group == "g1", ]        #subset rows with ==

data[data$group != "g1", ]        #subset rows with !=

data[data$group %in% c("g1", "g3"), ] #subset rows with %in%

subset(data, group == "g1")           #Apply subset function

filter(data, group == "g1")          #Apply filter function  

#if_else function 

x <- -3:3                                #Example vector

if_else(x < 0, "neg", "pos")            #Basic application of if_else

x_NA <- c(-3:3, NA)                     #Example vector with NA
x_NA

if_else(x_NA < 0, "neg", "pos","xxx")   #Apply if_else with NA function


#sample_n & sample_frac R function

data <- data.frame(x1 = c(1,2,1,3,2,3), x2 = c("A","A","C","A","B","C")) #Create Example data
data

set.seed(15151)             # Set seed

sample_n(data, 3)           # Apply sample_n

sample_frac(data, 0.33)       # Apply sample_frac


#Convert Data Frame to Tibble & Test

my_data <- data.frame(x1 = 1:5, x2 = LETTERS[1:5], x3 = 5)

my_data       #Print


my_tbl <-  tibble::as_tibble(my_data) #convert data_frame to tibble
my_tbl


tibble::is_tibble(my_tbl)      #check whether data is tibble
tibble::is_tibble(my_data)

data <- data.frame(x1 = 1:5, x2 = LETTERS[1:5]) #Create example data
data

pull(data, x1)          #Apply pull function 

pull(data, 1)           #Pull function with index


data <- data.frame(x1 = 1:3, x2 = LETTERS[1:3], x3 = 5) #Print example data

data

select(data, c(x1, x3))                     #Apply select function

rename(data, x1_new = x1)                   #Apply rename function 

data <- data.frame(x=1:10, group = c(rep("g1",3), rep("g2",5), rep("g3",2)))  #Create example data
data
data1 <- data
data1$numbering <- ave(data1$x, data1$group, FUN = seq_along) #Create numbering variable
data1                   #Print updated data

#Using dplyr

data2 <- data
data2 <- data2 %>% group_by(group) %>% mutate(numbering = row_number())
data2


#Proportions with dplyr Package
set.seed(9876)
data <- data.frame(x = sample(1:5, 100, replace = TRUE),
                   y = sample(LETTERS[1:3], 100, replace = TRUE))

data %>% group_by(x,y) %>% summarise(n=n()) %>% mutate(freq = n/sum(n))

#Apply Function to Every Row of Data Using dplyr Package in R 
data <- tibble::as_tibble(data.frame(x1 = 1:5, x2 = 2:6, x3 = 3:7))
data

data %>% rowwise() %>% mutate(row_sum = sum(x1, x2, x3))

#Convert Row Names into Data Frame Column in R 
data <- data.frame(x1 = LETTERS[1:5], x2 = letters[5:1])


data1 <- data
data1$row_names <- row.names(data1)


#With dplyr

data2 <- data
data2 <- tibble::rownames_to_column(data2, "row_names")



library(data.table)
data3 <- data
data3 <- setDT(data3, keep.rownames = TRUE)[]

#Select Row with Maximum or Minimum Value in Each Group in R
data <- data.frame(x = 1:10, group = c(rep("A", 2), rep("B", 3), rep("C", 5)))
data
data %>% group_by(group) %>% top_n(1,x) #Maximum value of each group


setDT(data)[ , .SD[which.max(x)], by = group] #Apply data.table function
setDT(data)[ , .SD[which.min(x)], by = group] 

#Count Number of Rows by Group Using dplyr Package in R
data <- data.frame(x1 = 1:10,    # Example data
                   x2 = letters[1:10],
                   group = c("A", "A", "A",
                             "B", "B", "B", "B",
                             "C", "C", 
                             "D"))



data %＞%                         # Count rows by group
  group_by(group) %＞% 
  summarise(n = n())


data <- data.frame(x1 = 1:5,    # Create data
                   x2 = letters[1:5],
                   x3 = 5,
                   x4 = c(3, 1, 6, 3, 7))



col_remove <- c("x1", "x3")     # Define columns that should be dropped

data_new <- data %＞%            # Apply select & one_of functions
  select(- one_of(col_remove))
##----------------------------------------

data <- data.frame(x1 = 1:10,       # Create example data
                   x2 = letters[1:10])
data                                # Return example data

vec <- c(1, 7, 10)                  # Create example vector
vec                                 # Return example vector

data[data$x1 %in% vec, ]            # Applying %in%-operator

data[is.element(data$x1, vec), ]    # Applying is.element function



filter(data, x1 %in% vec)           # Applying filter function
          

setDT(data, key = "x1")[J(vec)]     # Applying setDT function

##---------------------------------

data <- data.frame(x1 = c(4, 1, NA, 7, 8, 1),    # Create example data
                   x2 = c("A", NA, NA, "XX", "YO", "YA"),
                   x3 = c(1, 0, NA, 1, 1, NA))

data1 <- na.omit(data)                           # Apply na.omit function

data1

data2 <- data[complete.cases(data), ]     # Apply complete.cases function

data2

data3 <- data[rowSums(is.na(data)) == 0, ]       # Apply rowSums & is.na

data3



data4 <- data %＞% na.omit()                     # Apply drop_na function
data4


data5 <- data[!is.na(data$x1), ]                 # Apply is.na function
data5                                 # Load dplyr package

data6 <- filter(data, !is.na(data$x1))           # Apply filter function
data6

#Extract Unique Values in R

x <- rep(letters[1:3], each = 3)    # Create example vector
x                                   # Print example vector

unique(x)                           # Using unique function

x[!duplicated(x)]                   # Using duplicated function



distinct(data.frame(x))             # Using distinct function




data <- data.frame(value = 1:9,    # Create example data
                   group = letters[1:3])

         # Install & load plyr

data %>%  # Code does not lead to error
  group_by(group) %>% 
  dplyr::summarize(count = n())


