#
# Google Map Platform을 사용해보자

# 사용하고 있는 R 버전 확인
# 현재 3.6.1을 사용하고 있음.
# 현재시점(2019.11)에서 
# ggmap을 사용하려면 3.5.x 버전이 필요
# 3.5.3 버전을 설치하자

sessionInfo()   # 현재 3.5.3 사용

# 필요한 package 설치 및 load

install.packages("devtools")
library(devtools)

install_github('dkahle/ggmap', force=T)  # 3.5.3 에서는 force=T 추가
library(ggmap)         # API 이용 약관에 동의해야 한다.

# 생성한 Google API Key
googleAPIKey = "AIzaSyDb8Oqv9AqTVBFWUKyOZh1SkSv_9SeEtKI"

# API Key 인증을 하기 전에 Google Map Platform Console에서
# 추가 API항목에 있는 API를 사용 설정된 API로 적용시켜야 한다.
# 예) Geocoding API

# Google API Key 인증
register_google(key=googleAPIKey)

# 서울지역의 정보를 가져온다.
gg_seoul <- get_googlemap("seoul",maptype = "roadmap")

ggmap(gg_seoul)

##################################

# 위의 내용이 성공했다면 
# 특정위치를 지정해서 
library(dplyr)
library(ggplot2)

geo_code = geocode(enc2utf8("공덕역"))

geo_data = as.numeric(geo_code)  # vector로 변환

get_googlemap(center = geo_data,
              maptype = "roadmap",
              zoom = 16) %>%
  ggmap() + 
  geom_point(data=geo_code,
             aes(x=lon,
                 y=lat),
             size=5,
             color="red")

##################################

# 위치정보를 가져온다

addr <- c("공덕역","역삼역")
gc <- geocode(enc2utf8(addr))

df <- data.frame(lon=gc$lon,
                 lat=gc$lat)

cen <- c(mean(df$lon),mean(df$lat))
map <- get_googlemap(center=cen,
                     maptype="roadmap",
                     zoom=13,
                     size=c(640,640),
                     marker=gc)
ggmap(map)

# interactive graph

# 필요한 package를 설치합니다.

install.packages("plotly")
library(plotly)

# ggplot2를 이용하여 만든 그래프를 plotly의 ggplotly() 함수를
# 이용하면 인터렉티브 그래프가 생성됩니다. 

# 기존에 했던 mpg data set을 이용하여 배기량과 고속도로 연비에 대한
# 산점도를 먼저 그려보겠습니다. 

library(ggplot2)
df <- as.data.frame(mpg)

head(df)

g <- ggplot(data=df,
            aes(x=displ,
                y=hwy)) + 
  geom_point(size=2, color="red")

ggplotly(g) 

######################

# ggmap으로 처리했던 내용을 ggplotly()를 이용하여
# interactive하게 만들어보자!

addr <- c("공덕역","역삼역")
gc <- geocode(enc2utf8(addr))

df <- data.frame(lon=gc$lon,
                 lat=gc$lat)

cen <- c(mean(df$lon),mean(df$lat))
map <- get_googlemap(center=cen,
                     maptype="roadmap",
                     zoom=13,
                     size=c(640,640),
                     marker=gc)
result <- ggmap(map)

ggplotly(result)

# 시계열 그래프를 interactive하게 만들어보자

# 필요한 package를 설치합니다.

install.packages("dygraphs")
library(dygraphs)

# 사용할 데이터는 시계열 데이터가 있어야 하므로
# economics data set을 이용합니다.

head(economics)

# dygraphs를 이용하려면 데이터가 시간 순서 속성을
# 지니는 xts data type으로 되어 있어야 합니다.

# economics의 개인별 저축율을 xts type으로 변환합니다.

library(xts)

save_rate <- xts(economics$psavert,
                 order.by = economics$date)

head(save_rate)

# 시계열 그래프를 그린다.

dygraph(save_rate)

# 그래프 아래에 날짜 범위를 선택할 수 있는 selector를
# 추가할 수 있습니다.

dygraph(save_rate) %>% dyRangeSelector()

# 한번에 하나의 그래프를 그리는 것뿐 아니라
# 여러개의 그래프를 그릴 수 있습니다.

# 실업자수와 개인저축률을 시간순으로 interactive하게
# 그래프로 표현해보자!

# unemploy와 psavert를 xts type으로 변경

# 비율을 맞춰야 한다.
unemp_xts <- xts(economics$unemploy/1000,
                 order.by = economics$date)

savert_xts <- xts(economics$psavert,
                  order.by = economics$date)

# cbind()를 이용하여 가로로 병합하자

unemp_save <- cbind(unemp_xts,savert_xts)

colnames(unemp_save) <- c("실업자수","개인저축률")

head(unemp_save)

dygraph(unemp_save) %>% dyRangeSelector()