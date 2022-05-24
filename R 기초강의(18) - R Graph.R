# mpg data set을 이용하여 그래프를 생성합니다
# ggplot2를 이용한 그래프 생성

install.packages("ggplot2")
library(ggplot2)

df <- as.data.frame(mpg)

# 1. 배경 설정
# data 속성 : 그래프를 그리는데 사용할 데이터 
# aes 속성 : x축과 ㅛ축에 사용할 변수를 지정

# mpg data set의 displ(배기량)을 x축에 hwy(고속도로 연비)를 
# y축으로 지정

ggplot(data=df,
       aes(x=displ, y=hwy))    # 배경 생성

# 2. 그래프 추가
# 배경을 생성했으니 그 위에 그래프를 그린다
# + 기호를 이용하여 그래프 유형을 지정하는 함수를 추가
# 산점도를 그리는 함수는 geom_point()
# dplyr에서 연결기호는 %>%, ggplot2의 연결기호는 +

ggplot(data=df,
       aes(x=displ, y=hwy)) +
  geom_point()      # 산점도 추가

# 그래프를 보면 배기량이 클수록 연비가 떨어지는 것을 확인할 수 있다.

# 3. 설정 추가
# 축 범위를 조절하는 설정을 추가할 수 있다
# 기본적으로 축은 최소값에서 최대값을 표현할 수 있도록 기본 설정
# 일부 데이터만 표현하고 싶을 때 축 범위 조절

# 축 범위 조절 함수 : xlim(), ylim()

ggplot(data=df,
       aes(x=displ, y=hwy)) +
  geom_point() +
  xlim(3,6) +
  ylim(10,30)

# plots 창의 export menu를 이용하면 해당 그래프를 이미지나 PDF로
# 저장할 수 있다.

# 그래프를 그릴때 그래프의 option을 줄 수 있습니다.

ggplot(data=df,
       aes(x=displ, y=hwy)) +
  geom_point(size=3, color="red")      # 산점도 추가


plot.new()   # 작성한 그래프를 지울 때 사용

# mpg data set을 이용한 drv별 평균 hwy 막대 그래프 그리기

# 1. 집단별 평균표로 구성된 data frame 생성

library(ggplot2)
library(dplyr)
df <- as.data.frame(mpg)

head(df)

result <- df %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

result     # 구동방식별 고속도로 평균 연비


# 2. 그래프 생성

ggplot(data=result,
       aes(x=drv, y=mean_hwy)) +
  geom_col(width=0.3)

# 3. 크기순으로 정렬
# 기본적으로 알파벳 오름차순으로 범주가 정렬
# reorder를 이용하면 막대를 값의 크기순으로 정렬할 수 있다
# reorder()의 기본 정렬은 오름차순, - 기호를 이용하면 내림차순

ggplot(data=result,
       aes(x=reorder(drv, -mean_hwy), y=mean_hwy)) +
  geom_col()

################################

# 빈도 막대 그래프 - geom_col() 대신 geom_bar()를 이용
# 빈도 막대 그래프는 별도의 data frame을 만들지 않고 
# raw data frame을 이용하여 바로 생성

# drv 항목의 빈도 그래프를 그려보자

ggplot(data = df,
       aes(x=drv)) +
  geom_bar(width=0.5)

# 빈도 막대 그래프에 추가해서 누적 막대 그래프를 표현해보자
# 이전 그래프는 구동방식(drv)에 따른 빈도는 알 수 있으나
# 각 구동방식내에서 cyl(실린더의 개수)의 빈도까지 파악 할 수는
# 없습니다.
# geom_bar() 함수내에 aes()를 이용하여 누적할 열을 지정합니다.

ggplot(data = df,
       aes(x=drv)) +
  geom_bar(aes(fill=factor(cyl)),width=0.5)

# 도수분포를 막대 모양 그래프(히스토그램)로 표현할 수 있습니다.

# 아래의 예시는 오류입니다. 연속형 변수를 이용해야 하는데 drv는
# 범주로 구분되는 discret변수를 사용해서 그렇습니다.

ggplot(data = df,
       aes(x=drv)) +
  geom_histogram()

# 연속형 변수를 이용해서 히스토그램을 그려보겠습니다.
ggplot(data = df,
       aes(x=hwy)) +
  geom_histogram()
# 히스토그램의 bin의 값을 설정하지 않아서 30으로 설정
# 만약 bin값을 다시 설정하려면 다음과 같이 설정(비율지정)

ggplot(data = df,
       aes(x=hwy)) +
  geom_histogram(binwidth = 1)

# 시계열 데이터를 이용하여 선 그래프를 그려보자!

# 사용 data set
economics
economics_long

# 컬럼설명
# date : 날짜(년도별 월)
# psavert : personal savings rate(개인 저축률)
# pce : personal consumption expenditures(개인소비지출)
#       경기선행지수로 사용된다. in billions of dollars(십억달러)
# unemploy : number of unemployed in thousands( 실업자 수 - 천단위)
# uempmed : median duration of unemployment, in weeks
#           비고용기간의 중앙값 (주단위)
# pop : total population, in thousands (전체인구 - 천단위)

help(economics)

# 시간에 따른 실업자수 추이를 생성해보자

ggplot(data=economics,
       aes(x=date, y=unemploy)) +
  geom_line()

# 5년을 주기로 등락을 거듭하고 있다.
# 2008년 리먼 브라더스 사태로 실업률 대량 증가

# scatter를 이용한 산점도를 그린 후 그 위에 선 그래프를
# 추가해서 그래프에 그래프를 추가해 보자

ggplot(data=economics,
       aes(x=date, y=unemploy)) +
  geom_point(color = "red") + 
  geom_line()

# mpg data set을 이용하여 drv(구동방식)별 hwy(고속도로 연비)를 
# 상자 그림으로 표현

ggplot(data=df,
       aes(x=drv, y=hwy)) +
  geom_boxplot()

# 그래프를 보고 파악할 수 있는 점

# 4륜 구동은 hwy가 약 17~22사이에 자동차가 모여있다.
# 전륜 구동은 연비가 극단적인 형태의 자동차가 많다.
# 후륜 구동은 대부분의 자동차가 사분위 범위에 해당한다.

# ggplot2 그래프에 객체 추가

# 사용할 data set은 ecomonics

df <- economics
head(df)

# 날짜별 개인 저축률에 대한 선 그래프를 그려보자

ggplot(data=df,
       aes(x=date, y=psavert)) +
  geom_line()

# 직선을 추가해보자

ggplot(data=df,
       aes(x=date, y=psavert)) +
  geom_line() +
  geom_abline(intercept=12.1, slope=-0.0003444)

# 여기서 잠깐!!
# 만약 데이터를 가장 잘 표현하는 직선을 우리가 찾을 수
# 있다면 해당 그래프를 이용해서 미래의 값을 예측할 수 있다.
# 이 직선을 얻기 위해서는 기울기와 절편의 값을 구해야 하는데
# 이 값은 회귀분석을 통해서 얻을 수 있다.

# 평행선을 추가해보자

# geom_hline()을 이용해서 평행선을 그릴 수 있다.
# 기존 시간에 따른 개인저축률 그래프에 개인 저축률의 
# 평균값을 이용하여 평행선을 그려보자

ggplot(data=df,
       aes(x=date, y=psavert)) +
  geom_line() +
  geom_hline(yintercept=mean(df$psavert))

# geom_vline()을 이용하여 수직선을 그릴 수 있다.
# 개인 저축률이 가장 낮은 시기를 바로 알 수 있도록 수직선을
# 그려보자
# 먼저 개인 저축률이 가장 낮은 날짜를 알아야 한다.

tmp <- 
  df %>% filter(psavert == min(psavert)) %>%
  select(date)

tmp <- as.data.frame(tmp)$date

ggplot(data=df,
       aes(x=date, y=psavert)) +
  geom_line() + 
  geom_vline(xintercept = tmp)

## 만약 날짜를 직접입력하려면??
ggplot(data=df,
       aes(x=date, y=psavert)) +
  geom_line() + 
  geom_vline(xintercept = as.Date("2009-10-01"))


# 그래프에 텍스트를 추가하려면??

# geom_text()를 이용하면 그래프에 텍스트를 입력할 수 있습니다.
# 그래프의 범례나 제목과는 다르게 그래프 위에 직접 표현

# geom_text(aes(label="라벨명", vjust=세로위치, hjust=가로위치))

ggplot(data=df,
       aes(x=date, y=psavert)) +
  geom_point() + 
  xlim(as.Date("1990-01-01"),
       as.Date("1992-12-01")) +
  ylim(7,10) +
  geom_text(aes(label=psavert, vjust=0, hjust=-0.5))
#geom_text(aes(label=psavert, vjust=0, hjust=0))
# 숫자의 의미 : + 아래, 왼쪽 , - 위 , 오른쪽을 의미  


# 도형 및 화살표를 추가하는 annotate() 함수

# annotate()함수는 그래프 위에 사각형이나 화살표 등으로
# 특정 영역을 강조할 때 많이 사용됩니다.

# annotate("모양",
#          xmin=x축시작,
#          xmax=x축 끝,
#          ymin=y축 시작,
#          ymax=y축 끝)
ggplot(data=df,
       aes(x=date, y=psavert)) +
  geom_point() + 
  xlim(as.Date("1990-01-01"),
       as.Date("1992-12-01")) +
  ylim(7,10) + 
  annotate("rect",
           xmin=as.Date("1991-01-01"),
           xmax=as.Date("1991-12-31"),
           ymin=8,
           ymax=9,
           alpha=0.3,
           fill="red")

# 여기에 추가적으로 화살표를 표시할 수 있습니다.
# 화살표 역시 annotate()를 이용하여 표현합니다.

ggplot(data=df,
       aes(x=date, y=psavert)) +
  geom_point() + 
  xlim(as.Date("1990-01-01"),
       as.Date("1992-12-01")) +
  ylim(7,10) + 
  annotate("rect",
           xmin=as.Date("1991-01-01"),
           xmax=as.Date("1991-12-31"),
           ymin=8,
           ymax=9,
           alpha=0.3,
           fill="red") +
  annotate("segment",
           x = as.Date("1990-05-01"),
           xend=as.Date("1991-05-01"),
           y = 7.5,
           yend=8.5,
           color="blue",
           arrow=arrow()) +
  annotate("text",
           x=as.Date("1991-05-01"),
           y=8.5,
           label="글자도 쓸수 있어요!!")

# 마지막으로 그래프의 제목과 각 축의 이름, 배경색등을 설정해보자
# 테마는 총 8가지를 기본으로 제공하며 기본 테마는 theme_gray()

# labs(x=x축 이름, y=y축 이름, title=그래프 제목)
ggplot(data=df,
       aes(x=date, y=psavert)) +
  geom_point() + 
  xlim(as.Date("1990-01-01"),
       as.Date("1992-12-01")) +
  ylim(7,10) + 
  labs(x="연도", y="개인저축률", title="날짜별 개인 저축률") + 
  theme_classic()