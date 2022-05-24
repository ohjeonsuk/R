# factor 생성

var1 = c("A", "O", "AB", "B", "A", "O", "A")
var1

var1_factor = factor(var1)

var1_factor                   # factor이기 때문에 
# data와 level이 같이 출력

nlevels(var1_factor)          # factor의 level개수
# 4 

levels(var1_factor)           # factor의 level 목록
# "A"  "AB"  "B"  "O"

is.factor(var1_factor)        # factor인지를 판단

ordered(var1)                 # 순서형 factor 생성

# level과 order 지정
# level에 지정이 안되면 NA로 처리
var1_factor = factor(var1, 
                     levels = c("O","A","B"), 
                     ordered = T)
var1_factor


var1_factor = factor(var1, 
                     levels = c("O","A","B","AB"), 
                     ordered = T)
var1_factor

levels(var1_factor) = c("A형","AB형","B형","O형")
levels(var1_factor)           

var1_factor                  # 결과를 꼭 확인해보자

# 남성과 여성의 데이터르 factor 생성 후 chart 그리기

gender = c("MAN", "WOMAN", "MAN", "MAN", "WOMAN")
gender

factor_gender = as.factor(gender)
factor_gender

table(factor_gender)     # 빈도수 구하기

plot(factor_gender)      # 빈도수로 막대그래프 생성

# list 

var_scalar = 100                            # scalar
var_scalar

var_vector = c(10,20,30)                    # vector
var_vector

var_matrix = matrix(1:4,nrow = 2,ncol = 2)  # matrix
var_matrix

var_array = array(1:8, dim=c(2,2,2))        # array
var_array

var_df = data.frame(id=1:3, age=c(10,15,20)) # data frame
var_df

var_factor = factor(c("A","B","C","A","B","A")) # factor
var_factor

my_list = list(var_scalar,
               var_vector,
               var_matrix,
               var_array,
               var_df,
               var_factor)
my_list

# list 생성

myList <- list("Hong","길동",20)
myList

# list 자료구조를 vector 자료구조로 변환
myVector = unlist(myList)
myVector

# key와 value형식으로 list 생성
member = list(name=c("홍길동","김길동"),
              age=c(20,30),
              address=c("서울","수원"),
              gender=c("남자","여자"))
member

# list에서 key는 $를 이용해서 표시

member$age                    # 20 30

member$age[1]                 # 20

member[[1]]                   # "홍길동" "김길동"

member[["name"]]              # "홍길동" "김길동"
member$name                   # "홍길동" "김길동"

member[2:3]