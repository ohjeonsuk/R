# 변수선언 및 사칙연산

# scalar : R의 vector 자료구조의 한 유형으로 한 개의 값만 갖는 vector를 의미

myVar <- 100
result <- myVar + 200
result

# 1개의 데이터 출력(출력 후 개행)
print(result)

var1 = 3.141592
result = var1 * 2

# 여러개의 데이터 출력
# cat()은 출력후 개행이 일어나지 않음. "\n"으로 개행 출력
cat("계산된 결과값은 :", result)

# cat() 함수는 console이 아닌 파일에 출력을 할 수 있습니다.
cat("계산된 결과값은 :",
    result,"\n",
    file="c:/R_workspace/R_Lecture/data/cat_result.txt",
    append=TRUE)

# Environment에 있는 모든 객체 삭제.
# Console을 clear.

rm(list=ls())  # Environment 객체 삭제
cat("\014")    # console clear
