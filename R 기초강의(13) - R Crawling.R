# 네이버 영화 사이트 댓글정보 스크래핑

# 필요한 package 설치 및 loading
install.packages("rvest"); 
library(rvest)

# 네이버 영화 검색 후 평점,리뷰 부분

url <- "http://movie.naver.com/movie/point/af/list.nhn"
page <- "page="

request_url <- str_c(url,"?",page,"1")

page_html <- read_html(request_url,  encoding="CP949")
page_html;

# 영화제목 추출
nodes <- html_nodes(page_html, "td.title > a.movie")
nodes

movie_title <- html_text(nodes)
movie_title

# 기존에는 영화 평점도 있었지만 지금은 공개하지 않음.

# 영화리뷰 추출
# CSS를 이용(완전하지 않음-영화제목이 포함됨)
# nodes <- html_nodes(page_html, "td.title")
# movie_review <- html_text(nodes, trim=TRUE);
# movie_review
# 문자열 처리필요(데이터 정제)
# movie_review <- str_remove_all(movie_review,"\t")
# movie_review <- str_remove_all(movie_review,"\n")
# movie_review <- str_remove_all(movie_review,"신고")
# movie_review


# XPATH를 이용
movie_review = vector(mode="character", length=10)
for(i in 1:10) {
  myPath = str_c('//*[@id="old_content"]/table/tbody/tr[',
                 i,
                 ']/td[2]/text()')
  nodes <- html_nodes(page_html, xpath=myPath)
  comment <- html_text(nodes, trim=TRUE);
  movie_review[i] = comment[3]
}
movie_review

result_page <- cbind(movie_title, movie_review)

write.csv(result_page, 
          file="C:/R_workspace/R_Lecture/data/movie_reviews.csv",
          row.names = FALSE,
          quote = FALSE,
          fileEncoding = "CP949")

extract_comment <- function(idx) {
  url <- "http://movie.naver.com/movie/point/af/list.nhn"
  page <- "page="
  
  request_url <- str_c(url,"?",page,idx)
  
  page_html <- read_html(request_url,  encoding="CP949")
  
  # 영화제목 추출
  nodes <- html_nodes(page_html, "td.title > a.movie")
  movie_title <- html_text(nodes)
  
  # 영화리뷰 추출
  movie_review = vector(mode="character", length=10)
  for(i in 1:10) {
    myPath = str_c('//*[@id="old_content"]/table/tbody/tr[',
                   i,
                   ']/td[2]/text()')
    nodes <- html_nodes(page_html, xpath=myPath)
    comment <- html_text(nodes, trim=TRUE);
    movie_review[i] = comment[3]
  }
  
  result_page <- cbind(movie_title, movie_review)
  return(result_page)
}

result_df = data.frame();

for(i in 1:10) {
  result_df = rbind(result_df,extract_comment(i))
}

View(result_df)