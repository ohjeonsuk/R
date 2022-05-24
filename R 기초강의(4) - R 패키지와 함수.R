# ggplot2 package를 설치하고 사용해보자
install.packages("ggplot2")
library(ggplot2)

# 문자로 구성된 vector 생성
x <- c("a","b","c","a","b","a")

# qplot()을 이용하여 빈도 막대 그래프를 그려보자
qplot(x)

# R의 도움말 기능을 이용해보자

help(mean)

# 기본 함수의 파라미터를 확인해보자

args(max)

# 기본 함수의 사용예제

example(mean)

# qplot 함수의 사용예제

example(qplot)