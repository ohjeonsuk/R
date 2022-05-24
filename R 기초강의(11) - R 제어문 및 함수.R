# if문

var1 = 30
var2 = 40

if(var1 > var2) {
  cat("큰 수는 :",var1)
} else {
  cat("큰 수는 :",var2)
}

var1 = 30
var2 = 40
ifelse(var1 > var2,var1,var2)

# switch

emp_name = scan(what=character())

switch(emp_name,
       "홍길동"=30,
       "김길동"=40,
       "최길동"=50)

# which

name <- c("최길동","강감찬","이순신")

which(name == "강감찬")       # 2
which(name != "강감찬")       # 1 3 
which(name == "신사임당")     # integer(0)

# for

for(n in seq(1,5)) {
  print(n)
}

# while

idx = 1
sum <- 0

while(idx <= 10) {
  sum = sum + idx  
  idx = idx + 1
}

cat("숫자의 합은 :",sum)

# 사용자 정의 함수

myFunc <- function(k) {
  cat("인자의 값은 :",k)
  return(k+100)
}

result = myFunc(100)
result