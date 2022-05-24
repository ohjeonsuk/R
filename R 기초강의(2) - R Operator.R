var1 <- 100
var2 <- 3                

result <- var1 / var2    # 기본 나누기
result                   # 33.33333
options(digits = 5)     # 숫자를 몇 자리까지 출력할 것인가 설정( default값은 7 )
result
sprintf("%0.7f",var1 / var2)   # format을 설정해서 출력

result <- var1 %/% var2  # 몫 구하기 
result                   # 33  

result <- var1 %% var2   # 나머지 구하기 
result                   # 1

var1 <- 100
var2 <- 200

var1 == var2     # FALSE  
var1 != var2     # TRUE

var1 > var2      # FALSE
var1 >= var2     # FALSE

!(var1 <= var2)  # FALSE

# 조건에 있는 값이 scalar면 &와 &&가 동일처리
TRUE & FALSE      # FALSE
TRUE && FALSE     # FALSE

# 조건에 있는 값이 scalar면 |와 ||가 동일처리
TRUE | FALSE      # TRUE
TRUE || FALSE     # TRUE

# 조건에 있는 값이 vector이면 
# &는 vector의 모든 조건에 대한 연산을 수행한 후 
# 결과를 vector로 return
# &&는 vector의 첫번째 조건에 대한 연산을 수행한 후
# 결과를 scalr로 return

c(TRUE,FALSE) & c(TRUE,TRUE)   # TRUE FALSE
c(TRUE,FALSE) && c(TRUE,TRUE)  # TRUE
c(TRUE,FALSE) & c(TRUE,TRUE,FALSE)  # Error

!c(TRUE,FALSE,TRUE)            # FALSE TRUE FALSE

