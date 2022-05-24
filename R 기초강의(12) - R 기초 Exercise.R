# 다음의 데이터를 사용해 문제를 해결하세요!!

# 사용할 데이터 : 2 3 5 6 7 10

# 1. 데이터 벡터 x를 만드시오
x <- c(2,3,5,6,7,10); x

# 2. 각 데이터의 제곱으로 구성된 벡터 x2를 만드시오
x2 <- c(2,3,5,6,7,10)^2; x2

# 3. 각 데이터의 제곱의 합을 구하시오
sum(c(2,3,5,6,7,10)^2)

# 4. 각 데이터에서 2를 뺀 값을 구하시오
var1 <- c(2,3,5,6,7,10)-2; var1

# 5. 최대값과 최소값을 구하시오
maxValue = max(c(2,3,5,6,7,10))
minValue = min(c(2,3,5,6,7,10))
cat("최대 :",maxValue,", 최소 :",minValue)

# 6. 5보다 큰 값들로만 구성된 데이터 벡터 x_up을 만드시오
var1 = c(2,3,5,6,7,10); var1
var2 = c(2,3,5,6,7,10) > 5; var2

var1[var2]              # fancy indexing

# 7. 벡터 x의 길이를 구하시오
length(x)

# UsingR 패키지를 인스톨한 후 내장되어 있는 데이터셋 primes를 이용하여 답하시오. 
# primes는 1부터 2003 까지의 소수(prime number)들의 집합이다.

install.packages("UsingR")
library(UsingR)

data("primes")  # primes 데이터 셋을 불러옵니다.
head(primes)    # 처음 6개만 출력

# 8. 1부터 2003까지 몇 개의 소수가 있는가?
length(primes)  # 304

# 9. 1부터 200까지 몇 개의 소수가 있는가?
sum(primes <= 200)   # 46

# 10. 평균은 얼마인가?
mean(primes)         # 917.9375

# 11. 1000 이상의 소수는 몇 개인가?
sum(primes >= 1000)  # 136

# 12. 500 부터 1000 사이의 소수만을 포함한 벡터 pp를 만드시오
pp = primes[primes > 500 & primes<1000]; pp

# 13. 벡터를 입력을 받아 그 원소들의 값을 모두 더해서 결과를 반환하는 
# mysum 함수를 작성하시오.

mysum <- function(var) {
  result = sum(var)
  return(result)
}

var1 = c(1:10)
mysum(var1)

# 다음과 같은 형태의 데이터를 이용하여 다음의 문제를 해결하세요
# x =
# [ 1, 5, 9,
#   2, 6, 10,
#   3, 7, 11,
#   4, 8, 12 ]

# 14. 행렬(matrix) x를 만드시오.
var1 = c(1,5,9,2,6,10,3,7,11,4,8,12)
x = matrix(data=var1,
           nrow=4,
           byrow=T)
x

# 15. x의 전치행렬 xt를 만드시오.
xt = t(x); xt


# 16. x의 첫번째 행(row)만 뽑아낸 xr1을 만드시오
xr1 = x[1,]; xr1

# 17. x의 세번째 열(col)만 뽑아낸 xc3을 만드시오
xc3 = x[,3]; xc3

# 18. x에서 6,7,10,11을 원소로 가지는 부분행렬 xs를 만드시오
xs = x[2:3,2:3]; xs

# 19. x의 두번째 열(col)의 원소가 홀수인 행(row)들만 뽑아서 부분행렬 xs2를 만드시오
xs2 = x[x[,2] %% 2 == 1,]; xs2

# 20. 20. matrix x의 각 행(row)의 평균을 구하시오
apply(X=x, MARGIN = 1, FUN=mean)

# 21. 20. matrix x의 각 열(col)의 평균을 구하시오
apply(X=x, MARGIN = 2, FUN=mean)

# DMwR라는 패키지를 설치후, 패키지에 포함된 데이터셋인 algae를 로딩하시오. 
# algae의 속성 중 NH4 의 값들에 대해,

# 22. NA(결측치)가 몇개인지 구하시오
install.packages("DMwR")
library(DMwR)

data(algae)
head(algae)
var1 = algae[,"NH4"]
var1
sum(is.na(var1))   # 2

# 23. 결측치를 제거하고 평균을 구하시오.
mean(var1[!is.na(var1)])    # 501.2958