var1 = 100
var2 = 100L
var3 = "HEllo"
var4 = TRUE
var5 = 4 - 3i
var6 = NULL
var7 = sqrt(-3)      # warning : NaNs produced

mode(var1)           # "numeric" 
mode(var2)           # "numeric" 
mode(var3)           # "character"
mode(var4)           # "logical" 
mode(var5)           # "complex"
mode(var6)           # "NULL"
mode(var7)           # "numeric"

is.numeric(var1)     # TRUE
is.numeric(var2)     # TRUE

is.double(var1)      # TRUE
is.integer(var1)     # FALSE
is.integer(var2)     # TRUE

is.character(var3)   # TRUE
is.logical(var1)     # FALSE
is.null(var6)        # TRUE   
is.na(var7)          # TRUE

# Data Type의 우선순위

var1 <- c(100,TRUE,3.1415)     # numeric
var1

var2 <- c(100,TRUE,3.1415,"Hello")  # character
var2

var3 <- c(100,FALSE,3-4i)  # complex
var3

var4 <- c(100,FALSE,3-4i,"안녕!!")  # character
var4

# Data Type 변환

var1 <- 3.1415
var2 <- 0
var3 <- "3.141592"
var4 <- "Hello"

as.character(var1)      # "3.1415"
as.double(var1)         # 3.1415  
as.integer(var1)        # 3 
as.numeric(var1)        # 3.1415

as.logical(var1)        # TRUE
as.logical(var2)        # FALSE

as.double(var3)         # 3.141592
as.integer(var3)        # 3
as.double(var4)         # NA