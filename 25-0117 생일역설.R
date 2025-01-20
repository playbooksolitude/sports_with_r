#25-0117 fri 09:13

#
library(tidyverse)
library(tidymodels)

# duplicated() ----
duplicated(c(1,2,3))
duplicated(c(1,2,3,3,4))

# any() ----
any(duplicated(c(1,2,3)))
any(duplicated(c(1,2,3,3,4)))

# with() ----
tibble(날짜 = 2:365) |> 
  rep_sample_n(size = 28, replace = T, reps = 50) |> 
  reframe(중복 = duplicated(날짜) |> any()) |> 
  with(중복) |> sum()

  ## reframe() ----
tibble(날짜 = 2:365) |> 
  rep_sample_n(size = 28, replace = T, reps = 50) |> 
  reframe(중복 = duplicated(날짜) |> any()) |> 
  reframe(결과 = sum(중복))

# 몇명인지? 
tibble(
  사람 = 2:365
) |> 
  mutate(
      rep_sample_n(size = 사람, replace = T, reps = 100))
      reframe(중복 = duplicated(날짜) |> any()) |> 
      reframe(결과 = sum(중복))
  )
