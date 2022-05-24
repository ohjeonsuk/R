library(xlsx)

df <- read.xlsx(file="C:/R_workspace/R_Lecture/data/sample_data.xlsx",
                sheetIndex = 1,
                encoding = "UTF-8")
df

# 기본 통계량
summary(df$Y16_CNT)

# 기본 통계 함수
mean(df$Y16_CNT)
median(df$Y16_CNT)
max(df$Y16_CNT)
min(df$Y16_CNT)      
range(df$Y16_CNT)    # 최소값 최대값
quantile(df$Y16_CNT) # 사분위
var(df$Y16_CNT)      # 분산  
sd(df$Y16_CNT)       # 표준편차
skew(df$Y16_CNT)     # 왜도
kurtosi(df$Y16_CNT)  # 첨도


install.packages("psych")  # psychometrics(심리측정학)
library(psych)
describe(df)

# Package for Analysis of Space-Time Ecological Series
install.packages("pastecs") 
library(pastecs)
stat.desc(df)


# 빈도를 구하기 위한 함수

install.packages("descr")
library(descr)

freq(df$SEX, plot = T)
freq(df$AREA, plot = T)