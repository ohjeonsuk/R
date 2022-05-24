# 결측치가 포함된 데이터 생성

df <- data.frame(id=c(1,2,NA,4,NA,6),
                 score=c(20,30,NA,50,67,NA))
df

# is.na() 함수 이용

is.na(df)  # 결과는 logical type의 data frame 

# table() 함수는 빈도를 계산하는 함수

table(is.na(df))      # data frame 전체에 대한 빈도
table(is.na(df$id))   # 특정 column에 대한 빈도
table(is.na(df$score))   # 특정 column에 대한 빈도

# 결측치가 있는 행 제거
library(dplyr)

result_df <- df %>% filter(!is.na(df$id)) # id 결측치 제거
result_df

result_df <- df %>% filter(!is.na(df$score)) # score 결측치 제거
result_df

mean(df$score)            # NA
mean(result_df$score)

# 모든 column에 존재하는 결측치 제거
result_df <- df %>% filter(!is.na(df$score),
                           !is.na(df$id))
result_df

# 결측치가 하나라도 있으면 해당 행 제거
result_df <- na.omit(df)  # 간편하지만 좋은 방식은 아님.
result_df

# 함수의 결측치 제외 기능

df <- data.frame(id=c(1,2,NA,4,NA,6),
                 score=c(20,30,NA,50,67,NA))
df

mean(df$score, na.rm=TRUE)   # 결측치를 제외하고 연산수행
sum(df$score, na.rm=TRUE)   # 결측치를 제외하고 연산수행

# 결측치를 평균 값으로 대체

df$score <- ifelse(is.na(df$score), 
                   mean(df$score, na.rm=T),
                   df$score)
df

# 이상치 정제

# 성별에 존재할 수 없는 값이 있을 경우
# table() 함수를 이용하여 빈도수를 알아보면 확인할 수 있다

df <- data.frame(id=c(1,2,NA,4,NA,6),
                 score=c(20,30,NA,50,67,NA),
                 gender=c("^^","F","M","F","M","M"),
                 stringsAsFactors = F)
df
str(df)
table(df$gender)

# 이상치를 결측치로 변환

df$gender = ifelse(df$gender %in% c("M","F"),
                   df$gender,
                   NA)
table(df$gender)
df

# 극단치를 확인하기 위한 sample code
data = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,22.1)
summary(data)
# IQR(데이터 중간 위쪽의 mid point - 중간 아래쪽의 mid point)
median_value = summary(data)[3]; median_value
lower_data = c(1,2,3,4,5,6,7,8)
upper_data = c(8,9,10,11,12,13,14,22.1)
mid_lower = median(lower_data); mid_lower
mid_upper = median(upper_data); mid_upper

IQR_value = mid_upper - mid_lower; IQR_value
# 기준치 => IQR * 1.5
deter_value = IQR_value * 1.5
# 3사분위 값 + 기준치 => summary(data)[5] + deter_value
outlier_value = summary(data)[5] + deter_value; 
outlier_value
boxplot(data)


# mpg data를 이용한 극단치 처리

library(ggplot2)
mpg
class(mpg)

mpg <- as.data.frame(mpg)
class(mpg)

boxplot(mpg$hwy)

# 상자그림의 통계치 추출

boxplot(mpg$hwy)$stats

# 통계치의 결과는 위에서 아래 순으로
# 아래쪽 극단치 경계, 1산분위수, 중앙값, 3사분위수
# 위쪽 극단치 경계를 의미
# 즉, 12~37을 벗어나면 극단치로 분류된다

# 해당 범위를 벗어난 값을 결측치 처리한다.

mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37,
                  NA,
                  mpg$hwy)
table(is.na(mpg$hwy))

result <- mpg %>%
  group_by(drv) %>%
  summarise(hwy_mean=mean(hwy, na.rm=T))
result

####################################
# 연습문제!!
####################################

# data : excel 파일(exec1105.xlsx)

# 만약 결측값이 존재하면 결측값은 결측값을 제외한 
# 해당 과목의 평균을 이용합니다.

# 만약 극단치가 존재하면 하위 극단치는 극단치값을 제외한
# 해당 과목의 1사분위 값을 이용하고 상위 극단치는
# 해당 과목의 3사분위 값을 이용합니다.

# 1. 전체 평균이 가장 높은 사람은 누구이며 평균값은 얼마인가요?

# 2. 남자와 여자의 전체 평균은 각각 얼마인가요?

# 3. 수학성적이 전체 수학 성적 평균보다 높은 남성은 누구이며
#    수학성적은 얼마인가요?

library(xlsx)
library(stringr)
library(dplyr)
library(reshape2)

file_name = "C:/R_workspace/R_Lecture/data/exec1105.xlsx"

score_df <- read.xlsx(file=file_name,
                      header = F,
                      sheetIndex = 1,
                      encoding = "UTF-8",
                      stringsAsFactors=F)

names(score_df) <- c("s_num","subject","score")
score_df
str(score_df)

student_df <- read.xlsx(file=file_name,
                        header = F,
                        sheetIndex = 2,
                        encoding = "UTF-8",
                        stringsAsFactors=F)
names(student_df) <- c("s_num","s_name","s_gender")
student_df
str(student_df)

join_df <- inner_join(student_df,
                      score_df,
                      by="s_num")
join_df

df <- dcast(join_df,
            formula = s_num + s_name + s_gender ~ subject,
            value.var = "score")
df

## 결측치 처리

for(i in 1:length(df)) {
  col_value = df[[i]]
  if(sum(is.na(col_value)) > 0) {
    df[[i]] = ifelse(is.na(col_value),
                     mean(col_value, na.rm=T),
                     col_value)
  }
}

df

## 극단치 처리

for(i in 1:length(df)) {
  if(!(names(df[i]) %in% c("s_num","s_name","s_gender"))) {
    min_val = boxplot(df[[i]])$stats[1,1]
    max_val = boxplot(df[[i]])$stats[5,1]
    
    
    
    first_4 = summary(df[[i]], na.rm=T)[2]  # NA 해결 필요
    third_4 = summary(df[[i]], na.rm=T)[5]
    
    df[[i]] = ifelse(df[[i]] > max_val,
                     third_4,
                     df[[i]])
    
    df[[i]] = ifelse(df[[i]] < min_val,
                     first_4,
                     df[[i]])
  }
}

df


# 1. 전체 평균이 가장 높은 사람은 누구이며 평균값은 얼마인가요?
answer_1 <- df %>% mutate(avg=(eng+kor+math)/3) %>%
  arrange(desc(avg)) %>%
  head(1)

answer_1
# 김연아 81.11111


# 2. 남자와 여자의 전체 평균은 각각 얼마인가요?
answer_2 <- df %>% 
  mutate(avg=(eng+kor+math)/3) %>%
  group_by(s_gender) %>%
  summarise(total_avg = mean(avg))

answer_2

# 남자 : 40.7
# 여자 : 54.6

# 3. 수학성적이 전체 수학 성적 평균보다 높은 남성은 누구이며
#    수학성적은 얼마인가요?
answer_3 <- df %>% 
  filter(s_gender == "남자",
         math > mean(df$math))

answer_3

# 이순신 : 68
# 강감찬 : 78.66667