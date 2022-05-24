# 정형 데이터 처리

# MySQL Database 처리

# 기존의 MySQL DBMS server를 기동하자
# mysqld

# R에서 MySQL DBMS에 연동하기 위해서는 몇가지 package가 필요

install.packages("rJava")  # Java 기능을 이용
install.packages("DBI")    # R Database Interface
install.packages("RJDBC")  # JDBC 기능을 위한 package

library(rJava)
library(DBI)
library(RJDBC)

# JRE 경로 설정
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jre1.8.0_221")

# 드라이버 설정

drv = JDBC(driverClass = "com.mysql.jdbc.Driver",
           classPath = "C:/R_workspace/R_Lecture/mysql-connector-java-5.1.7-bin.jar")

# Database 연결

conn <- dbConnect(drv,
                  "jdbc:mysql://localhost:3306/library",
                  "data",
                  "data")

# Query 실행
sql = "select btitle from book"
bookTitle <- dbGetQuery(conn, sql)
head(bookTitle)

sql = "select btitle,bprice from book"
books <- dbGetQuery(conn, sql)
head(books)

sql = "select btitle,bprice from book where bprice > 30000"
books <- dbGetQuery(conn, sql)
head(books)

library(stringr)

sql = str_c("select btitle,bprice ",
            "from book ",
            "where bprice > 30000 ",
            "order by bprice desc")
books <- dbGetQuery(conn, sql)
head(books)

# 데이터베이스 연결 종료
dbDisconnect(conn)