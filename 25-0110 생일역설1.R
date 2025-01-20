#25-0110 fri 09:54

#
library(tidyverse)


# pbirthday ----
pbirthday(6)
pbirthday(10)
pbirthday(20)
pbirthday(30)
pbirthday(40)
pbirthday(50)
pbirthday(60)

#
sample_n(mpg, 10, replace = T)

# duplicated() ----
set.seed(1234)
c(1:20) |> 
  sample(10) |> 
  duplicated() |> 
  any()

# any() ----


# choose() ----
# 조합함수 
choose(10, 3)
choose(4,2)
choose(3,2)

# 이항분포 확률 계산 예: 동전을 10번 던져 3번 앞면이 나올 확률
p <- 0.5
n <- 10
k <- 3
prob <- choose(n, k) * (p^k) * ((1 - p)^(n - k))
print(prob)
# 결과: 0.1171875

# factorial ----
# 특정 숫자에서 1일 될때까지 하나씩 줄여가며 곱하기 
factorial(3)
factorial(5)
6*5*4*3*2*1
factorial(6)

