# vector 생성 - c()

var1 = c(10,30,77,100)
var1

var2 = c(89,56,33)
var2

var3 = c(TRUE,FALSE,FALSE,TRUE)
var3

var4 = c("홍길동", "강감찬", "유관순")
var4

var5 = c("홍길동", 100, TRUE, 3.141592)
var5

var6 = c(var1, var2)
var6

var7 = c(var1, var4)
var7

# vector 생성 - :

var1 = 1:5
var1

var2 = 5:0
var2

var3 = 3.3:10
var3

# vector 생성 - seq()

var1 = seq(from=1, to=5, by=1)
var1

var2 = seq(from=0.5, to=10, by=1.5)
var2

var3 = seq(from=10, to=5, by=-2)
var3

# vector 생성 - rep()    # replicate 함수

var1 = rep(1:3, times=3) # times 생략 가능
var1                     # 1 2 3 1 2 3 1 2 3 

var2 = rep(1:3, each=3)  # each는 각 원소가 반복할 횟수 지정
var2                     # 1 1 1 2 2 2 3 3 3

# vector의 Data Type

var1 = c(10,20,50,100)
var1
mode(var1)              # numeric
is.character(var1)      # FALSE
is.numeric(var1)        # TRUE
is.integer(var1)        # FALSE 
is.double(var1)         # TRUE

# vector의 개수 확인 - length()

var1 = seq(1,100,2)
var1

var2 = c(10,20,30)
var2

length(var1)    # var1의 개수 - 50
length(var2)    # var1의 개수 - 3

var3 = seq(1,100, length = 4)  # length을 이용한 vector 생성
var3

# vector 데이터 추출

var1 = c(67,90,80,50,100)
var1

var1[1]                   # 67
var1[length(var1)]        # 100
var1[2:4]                 # 90 80 50
var1[c(1,2,5)]            # 67 90 100
var1[seq(2,4)]            # 90 80 50
var1[6]                   # NA
var1[-1]                  # 1번째를 제외한 나머지
# 90 80 50 100
var1[-(2:5)]              # 67
var1[-c(1,2,4,5)]         # 80

# vector의 원소 이름
var1 = c(10,20,30)
var1

names(var1)    # NULL

names(var1) = c("국어", "영어", "수학")

names(var1)    # "국어" "영어" "수학"

var1           # 이름과 데이터 함께 출력

var1[1]        # index를 이용한 vector 원소 접근

var1["국어"]   # name을 이용한 vector 원소 접근

# vector간의 연산

var1 = 1:3
var2 = 4:6

var1                      # 1 2 3
var2                      # 4 5 6 

var1 * 2                  # 2 4 6
var1 + 10                 # 11 12 13

var1 + var2               # 5 7 9

var3 = 1:6
var3

var1 + var3               # var1 : 1 2 3 1 2 3 (recycling rule)
# var3 : 1 2 3 4 5 6
# 2 4 6 5 7 9

var4 = 1:5
var4

var1 + var4               # var1 : 1 2 3 1 2 (recycling rule)
# var4 : 1 2 3 4 5
# 연산은 되지만 warning 발생
# 2 4 6 5 7

# vector의 집합연산

var1 = c(1,2,3,4,5)
var2 = seq(3,7)

union(var1,var2)       # 합집합 : 1 2 3 4 5 6 7

intersect(var1,var2)   # 교집합 : 3 4 5

setdiff(var1, var2)    # 차집합 : 1 2 

# vector간의 비교연산

var1 = c("홍길동","김길동","최길동")
var2 = c("HONG","KIM","CHOI")
var3 = c("김길동","홍길동","김길동","최길동")

identical(var1,var3)    # FALSE

setequal(var1,var3)     # TRUE

var1 = 1:3
var2 = c(1:3)
var3 = c(1,2,3)

class(var1); class(var2); class(var3)

# data type이 다르다.
identical(var1,var2)  # TRUE   
identical(var1,var3)  # FALSE  

# 요소가 없는 vector 생성
# 항목을 저장할 공간을 생성할 때 사용

var1 = vector(mode="numeric", length=10)

var1