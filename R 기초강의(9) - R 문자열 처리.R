# 패캐지 설치와 로드

install.packages('stringr')
library("stringr")

# 문자열 길이와 위치

myStr <- "Hongkd1051Leess1002YOU25홍길동2005"

str_length(myStr)       # 31

str_locate(myStr,"홍길동")

# 부분문자열 

str_sub(myStr,1,str_length(myStr)-7)

# 대소문자 변경

str_to_upper(myStr)

str_to_lower(myStr)

# 문자열 교체, 결합, 분리

myStr <- "Hongkd1051,Leess1002,YOU25,홍길동2005"
str_replace(myStr,"Hong","KIM")

str_c(myStr,",이순신2019")

str_split(myStr,",")

str1 <- c("홍길동","김길동","이순신","강감찬")
paste(str1,collapse=",")

myStr <- "Hongkd1051,Leess1002,YOU25,홍길동2005"

str_extract_all(myStr,"[a-z]{3}")  # 영문소문자 연속 3문자 추출
str_extract_all(myStr,"[a-z]{3,}") # 영문소문자 연속 3문자 이상 추출
str_extract_all(myStr,"[a-z]{3,5}") # 영문소문자 연속 3~5문자 추출

str_extract_all(myStr,"Hong")  # 해당 문자열 추출

str_extract_all(myStr,"[가-힣]{3}") # 연속된 3개의 한글 문자 추출
str_extract_all(myStr,"[0-9]{4}") # 연속된 4개의 숫자문자 추출

str_extract_all(myStr,"[^a-z]") # 영문 소문자 제외한 나머지 추출
str_extract_all(myStr,"[^가-힣]{5}") # 한글을 제외한 나머지 연속된 5개 추출
str_extract_all(myStr,"[^0-9]{3}") # 숫자를 제외한 나머지 연속된 3개 추출

myId <- "901010-1000432"

str_extract_all(myId,"[0-9]{6}-[1234][0-9]{6}") #주민번호 검사
str_extract_all(myId,"\\d{6}-[1234]\\d{6}")

myStr <- "Hongkd1051,Leess1002,YOU25,홍길동2005"

str_extract_all(myStr,"\\w{6}") # w는 한글,영문자,숫자문자를 포함하지만 특수문자는 제외