한국복지패널데이터를 이용한 데이터 분석 연습

# 1. 데이터 준비

# 제공된 데이터를 이용합니다. 
# Koweps_hpc10_2015_beta1.sav (128M)
# 상용 통계분석 소프트웨어인 SPSS 전용파일로 제공

# 해당 데이터 파일은 SPSS 전용파일이기 때문에 R에서 사용하기 
# 위해서 foreign package를 이용해야 합니다. 

install.packages("foreign")
library(foreign)

# 사용할 package load
library(dplyr)
library(stringr)
library(ggplot2)
library(xlsx)

# 데이터 불러오기

# raw data 불러오기
data_file = "C:/R_workspace/R_Lecture/data/한국복지패널데이터/Koweps_hpc10_2015_beta1.sav"
raw_welfare <- read.spss(file=data_file,
                         to.data.frame = TRUE)

head(raw_welfare)

welfare <- raw_welfare   # 원본 데이터 보존

# 데이터 특성 확인

str(welfare)   # 16664 row, 957 column 

# 코드북을 이용해 분석에 필요한 column의 이름을 변경합니다.

welfare <- rename(welfare,
                  gender = h10_g3,         # 성별
                  birth = h10_g4,          # 태어난 연도
                  marriage = h10_g10,      # 혼인 상태 
                  religion = h10_g11,      # 종교
                  income = p1002_8aq1,     # 월급
                  code_job = h10_eco9,     # 직업 코드
                  code_region = h10_reg7)  # 지역 코드

# 해당 내용을 이용하여 데이터 분석을 진행해보자

#################################################

# 1. 성별에 따른 월급 차이
# 과거에 비해 여성의 사회 진출이 활발하지만 직장에서의
# 위상에서는 여전히 차별이 존재하고 있는것이 사실.
# 실제로 그러한지 월급의 차이를 이용하여 사실을 확인해보자
table(welfare$gender)  # 남자 1, 여자 2
# 1은 male, 2는 female로 변환
welfare$gender <- ifelse(welfare$gender == 1,"male","female")

table(welfare$gender)  # 남자 male, 여자 female

class(welfare$income)  # numeric

summary(welfare$income) # 월평균임금. 만원단위
# 전체적으로 122만원과 316만원 사이에 위치.
# 중간값이 평균보다 작기 때문에 전체적으로 낮은 값 쪽으로 치우쳐 있다.

# 그래프로 확인해보자( 확인할 때는 qplot이용 )
qplot(welfare$income) + xlim(0,1000)
# 0~250만원 사이에 가장 많은 사람이 분포하고 있다.

# 결측치가 12030 존재 => 월급을 받지 않은 응답자.
# 결측치부터 제거해야 한다.
# 또한 값이 0 이거나 무응답에 해당하는 9999는 이상치 처리
welfare$income <- ifelse(welfare$income %in% c(0,9999), NA,
                         welfare$income)

table(is.na(welfare$income)) # NA값이 12044개

gender_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(gender) %>%
  summarise(mean_income = mean(income))

gender_income <- as.data.frame(gender_income)

gender_income

# 그래프 그리기
ggplot(data=gender_income,
       aes(x=gender, y=mean_income)) +
  geom_col(width=0.5) + 
  labs(x="성별", 
       y="평균 월급", 
       title="성별에 따른 월급차이",
       subtitle = "남성이 여성보다 평균 월급이 150만원 많다",
       caption="(Example 1)")

# 결과
# 남성 평균 월급 : 312.2932
# 여성 평균 월급 : 163.2471
# 남성이 여성보다 월급이 약 150만원 많다.
# 해당 결과를 ggplot2를 이용하여 그래프로 표현하자

##########################################

# 2. 나이와 월급의 관계
# 몇 살 때 월급을 가장 많이 받을까? 또 그때의 월급은 얼마인가?
# 월급을 가장 많이 받는 나이는 : 53살 월급 : 318.6777

# 나이에 따른월급을 선 그래프로 표현하자
class(welfare$birth)
head(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)  # 빈도를 알아보자
# 코드북에 따르면 출생연도는 1900~2014이며 무응답은 9999
# 먼저 결측치가 존재하는지 확인
table(is.na(welfare$birth))  # 결측치는 존재하지 않는다

# 이상치를 확인한다.
welfare$birth <- ifelse(welfare$birth == 9999,
                        NA,
                        welfare$birth)

table(is.na(welfare$birth))  # 이상치도 존재하지 않는다.

# 나이를 구해야 하니 파생변수 age를 생성
welfare <- welfare %>%
  mutate(age = 2015 - birth + 1)
summary(welfare$age)  # 나이 확인
qplot(welfare$age)    # 나이 빈도 확인

# 전처리가 끝났으니 이제 나이에 따른 월급의 관계를 분석
# 나이별 평균월급을 구하자
age_income <- welfare %>%
  filter(!is.na(income)) %>%   # 월급이 있는 사람만 filtering
  group_by(age) %>%
  summarise(mean_income = mean(income))

head(age_income)
age_income <- as.data.frame(age_income)

# 가장 월급을 많이 받는 나이는?
age_income %>% arrange(desc(mean_income)) %>%
  head(1)

# 결과에 대한 선 그래프를 그려보자
ggplot(data=age_income,
       aes(x=age,
           y=mean_income)) + 
  geom_line() +
  geom_hline(yintercept = mean(age_income$mean_income))

# 20초반에는 100만원가량
# 40대부터 50대 중반까지 300만원 으로 가장많은 월급
# 60대 이후로는 급격히 감소하는 추세
# 평균 이상의 월급을 받는 나이는 20대 말에서 60대 초반까지


#################################


# 3. 연령대에 따른 월급 차이
# 30세 미만을 초년(young), 
# 30~59세 : 중년(middle), 
# 60세 이상 : 노년(old)
# 위의 범주로 연령대에 따른 월급의 차이를 알아보자

# 연령대(age_group) column을 조건에 맞게 추가하자
welfare <- welfare %>%
  mutate(age_group = ifelse(age < 30,"young",
                            ifelse(age <60,"middle","old")))

table(welfare$age_group)
qplot(welfare$age_group)

# 연령대별 평균 월급을 구해보자
age_group_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age_group) %>%
  summarise(mean_income = mean(income))

age_group_income <- as.data.frame(age_group_income)
age_group_income

# 초년(young) : 163.5953
# 중년(middle) : 281.8871
# 노년(old) : 125.3295

# 해당 결과를 그래프로 표현하자
ggplot(data=age_group_income,
       aes(x=age_group,
           y=mean_income)) +
  geom_col(width=0.5)
# ggplot은 기본적으로 막대변수를 알파벳 순으로 오름차순
# 정렬. 막대가 young, middle, old 순으로 정렬해보자
# scale_x_discrete(limits=c("young","middle","old")) 이용
ggplot(data=age_group_income,
       aes(x=age_group,
           y=mean_income)) +
  geom_col(width=0.5) +
  scale_x_discrete(limits=c("young","middle","old"))


############################################


# 4. 연령대 및 성별 월급 차이
# 성별 월급 차이는 연령대에 따라 다른 양상을 보일 수 있습니다.
# 성별 월급 차이가 연령대에 따라 다른지 분석해보자

# 기존에는 3그룹(초년,중년,노년)이었지만 이젠 6그룹으로
# 그룹핑을 해야 한다.(초년남성,초년여성,..)
gender_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age_group,gender) %>%
  summarise(mean_income = mean(income))

gender_income <- as.data.frame(gender_income)
gender_income

# 초년 남성 : 170.81737
# 초년 여성 : 159.50518
# 중년 남성 : 353.07574
# 중년 여성 : 187.97552
# 노년 남성 : 173.85558
# 노년 여성 : 81.52917

# 그래프로 표현해 보자
ggplot(data=gender_income,
       aes(x=age_group,
           y=mean_income,
           fill=gender)) +    # 누적 그래프
  geom_col() + 
  scale_x_discrete(limits=c("young","middle","old"))

# 다르게 표현하면 다음과 같이 표현해도 된다.
plot.new()
ggplot(data=gender_income,
       aes(x=age_group,
           y=mean_income)) +    
  geom_col(aes(fill=gender)) + 
  scale_x_discrete(limits=c("young","middle","old"))

# 누적 그래프는 우리가 원하는 정보를 얻기가 힘들다

# 누적시키지 않고 옆으로 따로 막대를 분리
# position = "dodge" 이용
ggplot(data=gender_income,
       aes(x=age_group,
           y=mean_income)) +    
  geom_col(aes(fill=gender), position="dodge") + 
  scale_x_discrete(limits=c("young","middle","old"))

# 사회초년생일때는 남녀의 월급이 큰 차이가 없지만
# 중년으로 들어서면 월급의 차이가 크게 벌어진다.
# 남성의 경우 초년과 노년의 월급차이가 크지 않다는 것을
# 파악할 수 있다.

##############################################

# 5. 나이 및 성별 월급 차이 분석
# 연령대를 구분하지 않고 나이 및 성별 월급 평균표를 만들어서
# 그래프로 표현해 보자
# 선 그래프로 표현하고 월급 평균 선이 성별에 따라 다른 색으로
# 표현되도록 한다.

gender_age <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age,gender) %>%
  summarise(mean_income=mean(income))

gender_age <- as.data.frame(gender_age)
gender_age

ggplot(data=gender_age,
       aes(x=age,
           y=mean_income,
           col=gender)) +
  geom_line(size=1)
# 30살 이후가 되면 여성과 남성의 월급차가 급격히 벌어진다.
# 남성의 경우 60세 이후가 되면 월급이 급격히 감소하는 현상


###############################################


# 6. 직업별 월급 차이
# 어떤 직업이 월급을 가장 많이 받을까?
# 직업별 월급을 분석해 보자
# 직업코드는 제공된 PDF에서 직업분류코드(제6차 개정)에 명시되어
# 있습니다.
# 하지만 조금 편하게 코드작업을 하기 위해서 
# 제공된 Koweps_Codebook.xlsx을 이용하면 편하게 코드값을 이용
# 할 수 있습니다.

class(welfare$job_code)
table(welfare$job_code)

code_job_file = "C:/R_workspace/R_Lecture/data/한국복지패널데이터/Koweps_Codebook.xlsx"
# 직업 code값이 들어 있는 excel파일 불러오기
raw_code_job <- read.xlsx(file=code_job_file, sheetIndex=2,
                          encoding="UTF-8")

code_job <- raw_code_job

head(code_job)

# 두 data frame을 join해서 welface에 결합

welfare <- left_join(welfare,code_job,
                     by="code_job")

# 정상적으로 결합되었는지 확인해보자
welfare %>%
  filter(!is.na(code_job)) %>%
  select(code_job,job) %>%
  head(10)

# 직업별 월급 평균을 구하자
# 직업이 없거나 월급이 없는 사람은 제외
job_income <- welfare %>%
  filter(!is.na(job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income=mean(income))

job_income = as.data.frame(job_income)
head(job_income)

top10 <- job_income %>%
  arrange(desc(mean_income)) %>%
  head(10)

top10
# 작성된 내용을 그래프로 표현해보자
# 직업이름이 길기 때문에 일반 막대그래프로는
# 표현이 힘들다. 가로로 90도 회전시켜서 표현
# 월급이 많은 순으로 reorder시켜서 표현

ggplot(data=top10,
       aes(x=reorder(job,mean_income),
           y=mean_income)) +
  geom_col() + 
  coord_flip()

# 추가로 월급이 적은 하위 10개의 직업도 추출해보자
bottom10 <- job_income %>%
  arrange(desc(mean_income)) %>%
  tail(10)

bottom10

ggplot(data=bottom10,
       aes(x=reorder(job,-mean_income),
           y=mean_income)) +
  geom_col() + 
  coord_flip()


###########################################


# 7. 성별 직업 빈도
# 성별로 어떤 직업이 가장 많을까?
# 원자료를 이용한 빈도는 geom_bar()를 이용하고
# 요약표를 이용한 빈도는 geom_col()를 이용합니다.

table(is.na(welfare$code_job))

#남성 직업 빈도를 구해보자
job_male <- welfare %>%
  filter(!is.na(job),
         gender=="male") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

job_male

job_female <- welfare %>%
  filter(!is.na(job),
         gender=="female") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

job_female

ggplot(data=job_male,
       aes(x=reorder(job,n),
           y=n)) +
  geom_col() +
  coord_flip()


# 8. 종교 유무에 따른 이혼율
# 종교가 있는 사람들이 이혼을 덜 할까??

class(welfare$religion)
table(welfare$religion)  # 1 : 종교있음. 2: 종교없음
# 3 : 무응답
# 이상치와 결측치가 없다

welfare$religion <- ifelse(welfare$religion == 1,
                           "yes","no")
qplot(welfare$religion)

# 결혼여부를 알아보자
table(welfare$marriage)
# 0 : 비해당(18세 미만), 1: 유배우, 2: 사별
# 3 : 이혼, 4 : 별거, 5: 미혼(18세이상, 미혼모포함)
# 6 : 기타

# 이혼율의 정의는 모든 결혼한 사람들중에 이혼한 사람 비율
# 이혼여부를 나타내는 column을 만들어 처리하자

welfare <- welfare %>%
  mutate(group_marriage = ifelse(marriage %in% c(1,2,4), "marriage",
                                 ifelse(marriage == 3,"divorce", NA)))

table(welfare$group_marriage)

qplot(welfare$group_marriage)

# 종교유무에 따른 이혼율 표를 만들자
religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(religion, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(total_group = sum(n)) %>%
  mutate(pct = round(n/total_group*100,1))

religion_marriage

# 이혼 추출
divorce <- religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(religion,pct)

divorce = as.data.frame(divorce)
divorce

ggplot(data=divorce,
       aes(x=religion,
           y=pct)) +
  geom_col(width=0.5)

# 이전에는 전체를 대상으로 종교 유무에 따른 이혼율을
# 분석했지만 이번에는 종교 유무에 따른 이혼율이 연령대별로
# 다른지 알아보자!

# 9. 지역별 연령대 비율
# 노년층이 많은 지역은 어디일까?

# 이 이외의 변수들을 이용하여 어떠한 데이터를 추출할 수 있는지
# 개인적으로 한번 생각해보자!