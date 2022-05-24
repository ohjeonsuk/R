# ggplot2 설치
install.packages("ggplot2")
library(ggplot2)

# mpg data set 이용
mpg
mpg = as.data.frame(mpg)   # mpg data frame

class(mpg)
ls(mpg)
# 주요컬럼
# 컬럼의 명세 : R Document(https://www.rdocumentation.org/)

# manufacturer : 제조회사
# displ : 배기량(Displacement)
# cyl : 실린더 개수
# drv : 구동 방식( f: 전륜구동, r : 후륜구동, 4 : 4륜구동)
# hwy : 고속도로 연비 (miles per gallon) 
#                     1gal : 3.8리터, 1mile : 1609.34m
# class : 자동차 종류
# model : 자동차 모델명
# year : 생산연도
# trans : 변속기 종류
# cty : 도시 연비
# fl : 연료 종류
head(mpg)
tail(mpg)
View(mpg)
dim(mpg)         # 234행, 11 column
nrow(mpg)
ncol(mpg)
str(mpg)
ls(mpg)
length(mpg)      # data frame인 경우 column의 개수
summary(mpg)
rev(head(mpg))   # vector인 경우 원소의 순서를 역순으로
# data frame인 경우 column을 역순으로

# 여기서 잠깐!! 4분위에 대해서 실습하고 넘어가자
# 사분위수 : 측정값을 오름차순으로 정렬한 후 4등분했을 때
# 각 등위에 해당하는 값을 의미.
# 중앙값(중위수)는 2사분위값에 해당.

# 총 13개의 데이터
data = c(1, 3, 5, 7, 9, 10, 11, 13, 14, 17, 20, 23, 25)
summary(data)
# 1사분위 => 1 + (0.25 * 12) = 4(번째 값) => 7
# 3사분위 => 1 + (0.75 * 12) = 10(번째 값) => 17

#########################################################
# hflights package설치
# 주요컬럼
# Year(년), Month(일), DayofMonth(일), DayofWeek(요일)
# AirTime(비행시간), DepTime(출발시간), ArrTime(도착시간)
# TailNum(항공기 일련번호), DepDelay(출발지연시간)
# ArrDelay(도착지연시간), Distance(비행거리)
# 다른컬럼의 의미는 reference 참조

install.packages("hflights")
library(hflights)

class(hflights)   # data frame
head(hflights)    # 상위 6행 출력
tail(hflights)    # 하위 6행 출력
View(hflights)    # View 창으로 출력
dim(hflights)     # 행,열 (227496,21)     
str(hflights)     # 변수의 속성확인
summary(hflights) # 요약 통계
# mean : 평균
# median : 중앙값
# 평균은 편향된 데이터와 이상치 때문에 그릇된 정보를
# 제공하는 경우가 있음. 이런 경우 값을 작은수에서
# 큰 수로 정렬한 후 중앙에 있는 값을 계산해서 사용
ls(hflights)      # column명을 vector로 출력
nrow(hflights)    # 행의 개수
ncol(hflights)    # 열의 개수
length(hflights)  # 열의 개수
# matrix에 length()를 적용하면 열의 개수가 아니라
# 모든 원소의 개수를 리턴한다.
rev()             # vector인 경우 원소의 순서를 역순으로
# data frame인 경우 column을 역순으로

######################################################
# iris dataset
# 통계학자인 피셔(Fisher) 가 소개한 데이터.
# 붓꽃(iris)의 3가지 종(setosa, versicolor, virginica)에 대해 
# 꽃받침(sepal)과 꽃잎(petal)의 길이를 정리한 데이터

# R에 기본으로 내장
# Species : 붓꽃의 종. setosa, versicolor, virginica (Factor)
# Sepal.Width : 꽃받침의 너비 (numeric)
# Sepal.Length : 꽃받침의 길이 (numeric)
# Petal.Width : 꽃잎의 너비 (numeric)
# Petal.Length : 꽃잎의 길이 (numeric)

head(iris)
rev(head(iris))
View(iris)
str(iris)
summary(iris)
rev(iris)


# 2016년 2017년 ATM 이용건수와 이용금액
# 제공된 2016_2017_이용건수_및_이용금액.xlsx 파일 이용

install.packages("xlsx")
library(xlsx)

df <- read.xlsx(file.choose(),
                sheetIndex = 1,
                encoding = "UTF-8")
head(df)
View(df)
str(df)
summary(df)
rev(ls(df))

# plyr package

# 1. data frame 병합

install.packages("plyr")
library(plyr)

x <- data.frame(id=c(1,2,3,4,6),
                height=c(160,175,180,177,194))
y <- data.frame(id=c(5,4,1,3,2),
                weight=c(55,73,80,94,77))

# join() : key값을 기준으로 두 개의 data frame을 하나로 병합
# left join이 default

inner_df = join(x,y, by="id", type="inner")  # inner join
inner_df

left_df = join(x,y, by="id", type="left") # left join
left_df

right_df = join(x,y, by="id", type="right") # right join
right_df

full_df = join(x,y, by="id", type="full") # full join
full_df


x <- data.frame(id=c(1,2,3,4,6),
                gender=c("M","F","M","F","M"),
                height=c(160,175,180,177,194))
y <- data.frame(id=c(5,4,1,3,2),
                gender=c("M","F","M","F","M"),
                weight=c(55,73,80,94,77))

df <- join(x,y, by=c("id","gender"), type="inner")
df

# 2. 그룹별 기술 통계량 구하기
# tapply() : 집단별 통계치를 구해주며 한번에 1개의 통계치만 구할 수 있다.

str(iris)
unique(iris$Species)
result = tapply(iris$Sepal.Length, iris$Species, FUN=mean)
result
result = tapply(iris$Sepal.Length, iris$Species, FUN=sd)
result

# ddply() : 한번에 여러개의 통계치를 구할 수 있다.

result = ddply(iris, 
               .(Species), 
               summarise,
               avg=round(mean(Sepal.Length),2),
               sd=round(sd(Sepal.Length),2),
               max=max(Sepal.Length))
result
View(result)    # data frame

# dplyr package

install.packages("dplyr")
library(dplyr)
library(xlsx)

excel_data <- read.xlsx(file.choose(),
                        sheetIndex = 1,
                        encoding = "UTF-8")
excel_data

# 1. tbl_df()
df <- tbl_df(excel_data)
df    # 현재 R의 console 크기에서 볼 수 있는 만큼 결과 출력

View(df)


# 2. rename(data frame, newVar = var, ...)
df <- rename(excel_data, 
             Y17_AMT = AMT17,
             Y16_AMT = AMT16)
df    # column명 변경


# 3. filter(data frame, 조건1, 조건2, ... )
df <- filter(excel_data, 
             AREA == "서울" & AMT17 >500000)
df

df <- filter(excel_data, 
             AREA == "서울", 
             SEX == "M",
             AMT16 > 350000)
df

df <- filter(excel_data, 
             AREA %in% c("서울","경기"), 
             SEX == "M",
             AMT16 > 350000)
df



# 4. arrange(data frame, column1, desc(column2), ...)
df <- filter(excel_data, 
             SEX != "M") %>%
  arrange(AREA, 
          desc(AMT17))
df


# 5. select(data frame, column1, column2, ...)
df <- filter(excel_data, 
             SEX == "M") %>%
  arrange(AREA, 
          desc(AMT17)) %>%
  select(ID,AREA:Y17_CNT)
df

df <- filter(excel_data, 
             SEX == "M") %>%
  arrange(AREA, 
          desc(AMT17)) %>%
  select(-SEX)
df



# 6. 새로운 column 생성
df <- filter(excel_data, 
             SEX == "M") 

df$AMT15 = df$AMT16 + 10000
df

df$VIP = ifelse(df$AMT15 > 500000, TRUE, FALSE)
df


# 7. mutate(data fame, column명1=수식1, column명2=수식2)
df <- filter(excel_data, 
             SEX == "M") %>%
  mutate(AMT15=AMT16 + 10000, 
         AMT14=AMT15+10000,
         VIP=ifelse(AMT15 > 500000, TRUE, FALSE))
df


# 8. summaries(data frame, 추가할column명1=함수(column명))
df <- filter(excel_data, 
             SEX == "M") %>%
  mutate(AMT15=AMT16 + 10000, 
         AMT14=AMT15+10000) %>%
  summarise(sum=sum(AMT14, na.rm=T), cnt=n())
df


# 9. group_by(data frame, 범주형 column)
df <- filter(excel_data, 
             AMT17 > 300000) %>%
  group_by(SEX) %>%
  summarise(sum=sum(AMT17, na.rm=T), cnt=n()) 
df

# 10. bind_rows(), bind_cols()
df1 <- data.frame(x=c(1,2,3))
df1
df2 <- data.frame(y=c(4,5,6))
df2

bind_rows(df1,df2)
df2 = rename(df2, x = y)
bind_rows(df1,df2)

bind_cols(df1,df2)

install.packages("reshape2")
library(reshape2)

df = airquality
class(df)
str(df)     # 153행 6열
df

View(df)

# melt()의 기본은 기준이 될 열을 지정하지 않으면 
# numeric data type의 모든 열을 행으로 변환
melt(df)       
melt(df, na.rm = T)         # value값이 NA인 것은 제외

nrow(melt(df))              # 생성된 총 row수 : 153 * 6 = 918

# month를 기준으로 데이터를 행으로 변환
melt(df,id.vars="Month")    
nrow(melt(df,id.vars="Month"))  # 생성된 총 row수 : 153 * 5 = 765

# month와 day를 기준으로 데이터를 행으로 변환
melt(df,id.vars=c("Month","Day"))
nrow(melt(df,id.vars=c("Month","Day"))) 
# 생성된 총 row수 : 153 * 4 = 612

# month와 day를 기준으로 ozone데이터만 행으로 변환
melt(df,
     id.vars=c("Month","Day"),
     measure.vars="Ozone")


# smiths data set을 이용하여 melt를 실습해보자

smiths

melt_smiths <- melt(smiths,
                    id.vars=c("subject"))
melt_smiths   # 8행


melt_smiths <- melt(smiths,
                    id.vars=c("subject","time"))
melt_smiths   # 6행

melt_smiths <- melt(smiths,
                    id.vars=c("subject","time","age"))
melt_smiths   # 4행

melt_smiths <- melt(smiths,
                    id.vars=c("subject","time","age"),
                    na.rm = T)
melt_smiths   # 3행


# 다른 데이터 셋으로 실습
install.packages("ggplot2")

library(ggplot2)
library(reshape2)
library(dplyr)
mpg

df <- as.data.frame(mpg)
melt(df)

melt(df, id.vars="model")

melt(df, id.vars=c("manufacturer","model"),
     measure.vars="cty")

df = airquality; df

melt_df <- melt(df,id.vars=c("Month","Day")); head(melt_df)


# Month를 기준으로 각 값들의 mean
dcast_df <- dcast(melt_df,
                  formula=Month ~ variable,
                  fun=mean,
                  na.rm=T)
dcast_df


# 모든 column 원상 복구
dcast_df <- dcast(melt_df,
                  formula=Month + Day ~ ...)
dcast_df

#############################

df <- as.data.frame(mpg)

melt_df <- melt(df, id.vars=c("manufacturer","model"),
                measure.vars="cty")
melt_df;

dcast_df <- dcast(melt_df,
                  formula=manufacturer ~ variable,
                  fun=mean)
dcast_df

## cf. 각 제조사별 cty의 평균

df <- as.data.frame(mpg)

df %>% group_by(manufacturer) %>%
  summarise(avg_cty=mean(cty))

## 입력받은 데이터파일을 정상적인 data frame으로 변환

melt_sample_mpg

result <- dcast(melt_audi_df,
                manufacturer + model + year + 
                  cyl + trans + drv + fl + class ~ d_name,
                value.var = "d_value")

result