#25-0114 tue 09:25

#
library(tidyverse)
#install.packages("tidymodels")
library(tidymodels)

#
rep_sample_n(mpg)
rep(rep_sample_n)
example("rep_sample_n")
args('rep_sample_n')
rep_sample_n(mpg, 10)
sample_n(mpg, 10)


# duplicated ----
# 중복되는 벡터 확인
c(1,3,3,4) |> duplicated() |> any()

# any() ----
 #TRUE 가 1개라도 있으면 TRUE
c(1,2,3,4) |> duplicated() |> any()

# set.seed() ----
set.seed(1234)
tibble(날짜 = 1:365) |> 
  rep_sample_n(28, replace = T) |> 
  duplicated() |> any()
  

# tibble() ----
set.seed(1234)
tibble(날짜 = 1:365) |> 
  rep_sample_n(reps = 100,
               size = 30, 
               replace = T) |> 
  reframe(중복 = 날짜 |> duplicated() |> any()) |> 
  #print(n = Inf)
  group_by(중복) |> 
  reframe(중복여부 = sum(중복))


# 50% 넘어가는 시점 ----
tibble(
  사람 = 2:365
)

#








