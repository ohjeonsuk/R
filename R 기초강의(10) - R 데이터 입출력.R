# scan() 함수

myNum = scan()    # console창의 prompt를 이용하여 숫자 데이터 입력
myNum

myStr = scan(what=character())  # 문자열 데이터 입력
myStr

# data frame에 edit()를 이용해 데이터 입력

df = data.frame();

my_df = edit(df)    # 데이터 편집기 실행

# read.table() 함수 이용
# header가 있는 경우 "header=TRUE"를 이용

getwd()
setwd(str_c(getwd(),"/data"))

# text 파일 데이터 최 하단에 개행이 1줄 있어야 한다.
student_midterm = read.table(file="student_midterm.txt", sep=",")
student_midterm  

# 한글이 있는 경우 encoding 설정이 필요
# header가 있는 경우 header=T 필요
student_midterm = read.table(file="student_midterm.txt", 
                             sep=",",
                             fileEncoding = "UTF-8",
                             header = T)
student_midterm 

names(student_midterm) = c("학번","반","국어","영어")
student_midterm      

# 만약 탐색기를 실행해서 파일을 선택하려면 file.choose() 사용

student_midterm = read.table(file.choose(), sep=",")
student_midterm

# 파일의 특정 문자열을 NA로 처리하여 파일을 불러올 수 있다.
student_midterm = read.table(file="student_midterm_na.txt", sep=",", na.strings="-")
student_midterm

# read.csv() 함수 이용

getwd()
setwd(str_c(getwd(),"/data"))

student_midterm = read.csv(file="student_midterm.csv", sep=",")
student_midterm

# read.xlsx() 함수 이용

install.packages("xlsx")
Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jre1.8.0_221")

library(xlsx)
student_midterm = read.xlsx(file.choose(), sheetIndex=1, encoding="UTF-8")

student_midterm

# # write.table() 함수 이용 - data frame 저장
getwd()
setwd(str_c(getwd(),"/data"))

student_midterm = read.table(file="student_midterm.txt", sep=",")
student_midterm      

names(student_midterm) = c("학번","반","국어","영어")
student_midterm    

write.table(student_midterm, file="student_write_table.txt")
write.table(student_midterm, file="student_write_table.txt", row.names=FALSE, quote=FALSE)

# cat() 함수 이용
cat("계산된 결과값은 :",
    "\n","\n",
    file="c:/R_workspace/R_Lecture/data/final_result.txt",
    append=TRUE)

# data frame을 출력 
write.table(student_midterm, 
            file="c:/R_workspace/R_Lecture/data/final_result.txt", 
            row.names=FALSE, 
            quote=FALSE, 
            append = T)

# data frame의 summary를 파일에 출력
capture.output(summary(student_midterm),
               file="c:/R_workspace/R_Lecture/data/final_result.txt",
               append=TRUE)

# write.xlsx() 함수 이용 - 데이터 저장

libray(xlsx)
getwd()
setwd(str_c(getwd(),"/data"))

df = data.frame(x=c(1:5),
                y=seq(2,10,2),
                z=c("a","b","c","d","e"))

write.xlsx(df,"df_write.xlsx")

# JSON 처리

# jsonlite package의 fromJSON() 함수를 사용
install.packages("jsonlite")
library(jsonlite)

# install.packages("httr")
# library(httr)

library(stringr)

url <- "http://localhost:8080/bookSearch/search"

keyword <- "keyword="

request_url = str_c(url,"?",keyword,scan(what=character()))
request_url

df = fromJSON(request_url) # 키워드가 영문일경우

df = fromJSON(URLencode(request_url)) # 키워드가 한글일 경우 encoding처리 필요

str(df)
names(df)
View(df)

# 찾은 도서 제목 출력
for(i in 1:nrow(df)) {
  print(df$title[i])
}

# data frame을 CSV 파일로 저장
write.csv(df,
          file="C:/R_workspace/R_Lecture/data/df.csv",
          quote=FALSE,
          row.names=FALSE)

# data frame을 JSON 파일로 저장
help(toJSON)
df_json <- toJSON(df)
df_json

library(stringr)
getwd()
setwd(str_c(getwd(),"/data"));

write(df_json,file = "df_json.json");
write(prettify(df_json),
      file = "df_json_prettify.json");

url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"

key = "key=bb9595efebb93c44b9f1271e52bcdf74"

date = "targetDt=20191010"

library(stringr)

request_url = str_c(url,"?",key,"&",date)

df = fromJSON(request_url)

View(df)

class(df[[1]])
class(df[[1]][["dailyBoxOfficeList"]])
class(df[[1]][["dailyBoxOfficeList"]]$movieNm)

for(i in 1:10) {
  print(df[[1]][["dailyBoxOfficeList"]]$movieNm[i])