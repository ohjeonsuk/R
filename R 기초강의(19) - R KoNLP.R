# 한글 형태소 분석

install.packages("KoNLP")
library(KoNLP)

#useSystemDic() # 시스템 사전 설정
#useSejongDic() # 세종 사전 설정
useNIADic() # NIADic 사전 설정   # 이놈을 사용하자

library(dplyr)

# JRE 경로를 설정해야 한다.
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jre1.8.0_221/")

# 분석할 Text data를 준비하자
# 해당 파일은 제공
# 가요가사!!(봄날, 에라 모르겠다, etc)

txt <- readLines("C:/R_workspace/R_Lecture/data/hiphop.txt",
                 encoding = "UTF-8")
head(txt)

# 특수문자 제거
library(stringr)

# \\W은 특수문자를 의미하는 정규식
txt <- str_replace_all(txt,"\\W"," ")
head(txt)

# 명사 추출 연습
tmp <- "이것은 소리없는 아우성"
extractNoun(tmp)

nouns <- extractNoun(txt)
head(nouns)

# 결과가 list로 추출되는데 이를 vector형태로 변환
words <- unlist(nouns)
head(words)

# 빈도를 조사해보자
wordcount <- table(words)
head(wordcount)

# 빈도를 가지고 있는 데이터를 data frame으로 변환
df <- as.data.frame(wordcount,
                    stringsAsFactors = F)
head(df)

# 한글자로 된 단어는 의미가 없으므로 두 글자 이상으로 된 단어만
# 추출한 후 빈도로 내림차순 정렬한 후 상위 20개만 추출

word_df <- df %>%
  filter(nchar(words) >= 2) %>%
  arrange(desc(Freq)) %>%
  head(20)

word_df

install.packages("wordcloud")     # 워드 클라우드 패키지

library(wordcloud)

# 단어 색상 목록 생성
pal <- brewer.pal(8,"Dark2")   # Dark2 색상 목록에서 8개의 색상 추출

# 난수 seed 설정
# 워드 클라우드는 생성 시 난수를 이용하여 매번 다른 모양의
# 그래프를 생성. 항상 동일한 그래프가 생성되도록(재현성)
# 난수의 seed를 지정
set.seed(1)

wordcloud(words=word_df$words,    # 단어
          freq=word_df$Freq,      # 빈도
          min.freq = 2,           # 최소 빈도
          max.words = 200,        # 최대 단어 
          random.order = F,       # 고빈도 단어 중앙 배치
          rot.per = .1,           # 단어 회전 비율
          scale = c(4,0.3),       # 단어 크기 범위
          colors = pal)           # 색상 목록

## 네이버 영화 댓글을 이용한 워드 클라우드 생성

## Crawling & Scraping 작업
library(stringr)
library(rvest)

url <- "https://movie.naver.com/movie/point/af/list.nhn?target=after&st=mcode"

movie_code = "88426"  # 건축학개론 영화 code
sword <- "sword="
page <- "page="

result <- vector(mode="character")

for(p in 1:100) {
  request_url <- str_c(url,"&",
                       sword,movie_code,
                       "&",
                       page,p)
  
  page_html <- read_html(request_url,  encoding="CP949")
  page_html;
  
  movie_review = vector(mode="character", length=10)
  
  for(i in 1:10) {
    myPath = str_c('//*[@id="old_content"]/table/tbody/tr[',
                   i,
                   ']/td[2]/text()')
    nodes <- html_nodes(page_html, xpath=myPath)
    comment <- html_text(nodes, trim=TRUE);
    movie_review[i] = comment[3]
  }
  result = c(result,movie_review)
}

result  # 문자열 vector

library(KoNLP)

#useSystemDic() # 시스템 사전 설정
#useSejongDic() # 세종 사전 설정
useNIADic() # NIADic 사전 설정   # 이놈을 사용하자

# 특수문자 제거
library(stringr)
library(dplyr)

# JRE 경로를 설정해야 한다.
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jre1.8.0_221/")

txt <- result
head(txt)

# \\W은 특수문자를 의미하는 정규식
txt <- str_replace_all(txt,"\\W"," ")
head(txt)

nouns <- extractNoun(txt)
head(nouns)

# 결과가 list로 추출되는데 이를 vector형태로 변환
words <- unlist(nouns)
head(words)

# 빈도를 조사해보자
wordcount <- table(words)
head(wordcount)

# 빈도를 가지고 있는 데이터를 data frame으로 변환
df <- as.data.frame(wordcount,
                    stringsAsFactors = F)
head(df)

# 한글자로 된 단어는 의미가 없으므로 두 글자 이상으로 된 단어만
# 추출한 후 빈도로 내림차순 정렬한 후 상위 20개만 추출

word_df <- df %>%
  #  filter(nchar(words) >= 2) %>%  # CP949로 인한 인코딩 오류
  arrange(desc(Freq)) %>%
  head(100)

word_df

# wordcloud를 이용한 그래프 출력

library(wordcloud)

# 단어 색상 목록 생성
pal <- brewer.pal(8,"Dark2")   # Dark2 색상 목록에서 8개의 색상 추출

# 난수 seed 설정
# 워드 클라우드는 생성 시 난수를 이용하여 매번 다른 모양의
# 그래프를 생성. 항상 동일한 그래프가 생성되도록(재현성)
# 난수의 seed를 지정
set.seed(1)

wordcloud(words=word_df$words,    # 단어
          freq=word_df$Freq,      # 빈도
          min.freq = 2,           # 최소 빈도
          max.words = 50,        # 최대 단어 
          random.order = F,       # 고빈도 단어 중앙 배치
          rot.per = .1,           # 단어 회전 비율
          scale = c(4,0.3),       # 단어 크기 범위
          colors = pal)           # 색상 목록