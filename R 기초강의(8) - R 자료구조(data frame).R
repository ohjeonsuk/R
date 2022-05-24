# data frame 생성

# vector를 이용한 data frame 생성
no = c(1,2,3)
name = c("홍길동","최길동","김길동")
pay = c(250,150,300)

df = data.frame(NO=no,Name=name,Pay=pay)

df

# matrix를 이용한 data frame 생성
mat1 = matrix(data = c(1,"홍길동",150,
                       2,"최길동",150,
                       3,"김길동",300),
              nrow = 3,
              by=T)           # 행 우선

mat1

memp = data.frame(mat1)
memp

# 3개의 vector를 이용하여 data frame 생성
df = data.frame(x=c(1:5),
                y=seq(2,10,2),
                z=c("a","b","c","d","e"))
df

# data frame의 column을 참조하기 위해서는 $ 이용

df$x           # 1 2 3 4 5

# str() 함수의 사용

df = data.frame(x=c(1:5),
                y=seq(2,10,2),
                z=c("a","b","c","d","e"))

str(df)

# 'data.frame':	5 obs. of  3 variables:
# $ x: int  1 2 3 4 5
# $ y: num  2 4 6 8 10
# $ z: Factor w/ 5 levels "a","b","c","d",..: 1 2 3 4 5

df = data.frame(x=c(1:5),
                y=seq(2,10,2),
                z=c("a","b","c","d","e"),
                stringsAsFactors = F)
df
str(df)    # factor가 아닌 문자열 형태로 사용

# summary() 함수의 사용

summary(df)

# apply() 함수의 사용
df = data.frame(x=c(1:5),
                y=seq(2,10,2),
                z=c("a","b","c","d","e"))

apply(df[,c(1,2)],2,sum)

# subset() 함수의 사용

df = data.frame(x=c(1:5),
                y=seq(2,10,2),
                z=c("a","b","c","d","e"))

sub1 <- subset(df, x>=3)   # x가 3이상인 행 추출
sub1

sub2 <- subset(df, x>=3 & y<=8)
sub2

# 연습문제
# 1. 4,6,5,7,10,9,4,15를 R의 숫자형 벡터 x로 만드세요.
x <- c(4,6,5,7,10,9,4,15)
x

# 2. 아래의 두 벡터의 계산 결과는?
x1 = c(3,5,6,8)
x2 = c(3,3,3)

x1+x2                 # 6 8 9 11

# 3. Data Frame과 subset을 이용하여 다음의 결과를 도출하세요
Age <- c(22, 25, 18, 20)
Name <- c("James", "Mathew", "Olivia", "Stella")
Gender <- c("M", "M", "F", "F")

##   Age   Name Gender
## 1  22  James      M
## 2  25 Mathew      M

df = data.frame(Age=Age,
                Name=Name,
                Gender=Gender)
df
df_subset = subset(df,Gender != "F")
df_subset

# 4. 다음의 계산 결과는?
의미없는 문제 삭제

# 5. 아래의 R코드를 실행한 결과는?
x <- c(2, 4, 6, 8)
y <- c(TRUE, TRUE, FALSE, TRUE)
sum(x[y])           # 14

# 6. 아래의 계산결과는?
x <- c(1,2,3,4)
(x+2)[(!is.na(x)) & x > 2] -> k
k         # 5 6


# 7. 아래의 벡터에서 결측치의 수를 구하는 R코드를 작성하세요
x <- c(34, 56, 55, 87, NA, 4, 77, NA, 21, NA, 39)
is.na(x)
sum(is.na(x))

# 8. 아래 두 벡터를 결합하는 코드이다. 결과는?
a=c(1,2,4,5,6)
b=c(3,2,4,1,9)
cbind(a,b)

# 9. 아래 두 벡터를 결합하는 코드이다. 결과는?
a=c(10,2,4,15)
b=c(3,12,4,11)
rbind(a,b)

# 10. 아래 R 코드의 결과는?
x=c(1:12)
length(x)

# 11. 아래 R 코드의 결과는?
x=c('blue',10,'green',20)
is.character(x)          # TRUE

# 12. 아래의 세개의 벡터를 이용하여 아래의 결과가 나오도록 리스트(Date)를 만들어라.
year=c(2005:2016)
month=c(1:12)
day=c(1:31)

# Date
# $year
#  [1] 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016
# $month
#  [1] 1 2 3 4 5 6 7 8 9 10 11 12
# $day
#  [1] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Date = list(year=year,
            month=month,
            day=day)
Date

# 13. 아래의 행렬계산 결과는?
M=matrix(c(1:9),3,3,byrow=T)
N=matrix(c(1:9),3,3)

M%*%N


# 14. 아래의 데이터를 데이터프레임(Department)으로 만들어라.
#DepartmentID	DepartmentName
#31	          영업부
#33	          기술부
#34	          사무부
#35	          마케팅