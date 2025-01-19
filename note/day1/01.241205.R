#24-1205 11:50

#
library(tidyverse)

#1 한글 파일 오류 ----
read.csv("./rawdata/kbo_batting_qualified.csv") #아예 안열림 

## 해결책 ---- 
read.csv("./rawdata/kbo_batting_qualified.csv", fileEncoding = 'CP949')
read_csv("./rawdata/kbo_batting_qualified.csv", 
         locale = locale(encoding = 'cp949'))
read_csv("./rawdata/kbo_batting_qualified.csv", 
         locale = locale('ko', encoding = 'euc-kr'))

### error ----
read.csv("./rawdata/kbo_batting_qualified.csv", fileEncoding = 'UTF-8') #error
read_csv("./rawdata/kbo_batting_qualified.csv", locale = locale(encoding = 'UTF-8')) #error

## 다른 해결책 ----
### file.choose() ----
file.choose()
read.csv(file.choose(),fileEncoding = 'cp949')
read_csv(file.choose(), locale = locale(encoding = 'cp949'))

#2 변수 저장 ----
read.csv("./rawdata/kbo_batting_qualified.csv", 
         fileEncoding = 'CP949') -> batting
batting

#3 구조 파악 ----
class(batting)
str(batting)

## 함수 이름 출력 ----
ls('package:dplyr')
ls(batting)
batting |> head()

# R한사전 ----
#'?'


## args() ----
args(ls)
args(geom_point)
args(rm)

args(after_stat)
example("after_stat")

# 사투리 ----
mtcars
sample_n(mtcars,5)
mtcars[1,5]
sample(mtcars[1,10],10)
#MASS::Animals
#detach('package:MASS', unload = T)

## |> ----
mtcars[sample(10,2),1:5]
mtcars |> 
  sample_n(2) |> 
  dplyr::select(mpg, cyl)

#
view(mtcars)


#
mtcars |> 
  sample_n(10)

#
# geom_histogram() ----
batting |> tibble() -> batting
(batting |> tibble() -> batting)
batting |> sample_n(10) |> gt::gt()
batting |> 
  ggplot(aes(x = avg)) +
  geom_histogram()

# geom_histogram() ----
batting |> tibble() -> batting
batting |> sample_n(10) |> gt::gt()
batting |> 
  ggplot(aes(x = avg)) +
  geom_histogram(binwidth = .001) +
  coord_cartesian(xlim = c(0.25,0.35))

# binwidth ----
batting |> 
  ggplot(aes(x = avg)) +
  #geom_histogram(binwidth = .001) # .001 넓이로 구분하기
  geom_histogram(bins = 10)  #10개 구간으로 나누기

# table ----
batting$throw_bat |> 
  table()
  
# geom_bar ----  
batting$throw_bat |> 
  table() |> 
  data.frame() |> 
  ggplot(aes(x = Var1, 
             y = Freq)) +
  geom_bar(stat = 'identity')

# 한글 ----
#install.packages('showtext')
library(showtext)
showtext_auto()

#
batting$throw_bat |> 
  table() |> 
  data.frame() |> 
  ggplot(aes(x = Var1, 
             y = Freq)) +
  geom_bar(stat = 'identity')

# factor ----
batting$throw_bat |> 
  table() |> 
  data.frame() |> 
  ggplot(aes(x = factor(Var1, levels = c('좌좌', '우좌', '우우', '우양')), 
             y = Freq)) +
  geom_bar(stat = 'identity')

## 다른 방식 ----
batting$throw_bat |> 
  table() |> 
  data.frame() |> 
  ggplot(aes(x = factor(Var1) |> fct_relevel('좌좌', '우좌', '우우', '우양'), 
             y = Freq)) +
  geom_bar(stat = 'identity')

args(fct_relevel)

# 많은 순서 ----
batting$throw_bat |> 
  table() |> 
  data.frame() |> 
  ggplot(aes(x = factor(Var1) |> fct_reorder(Freq), 
             y = Freq)) +
  geom_bar(stat = 'identity')

# 적은 순서 ----
batting$throw_bat |> 
  table() |> 
  data.frame() |> 
  ggplot(aes(x = factor(Var1) |> fct_reorder(desc(Freq)), 
             y = Freq)) +
  geom_bar(stat = 'identity')


# geom_point ----
read_csv("./rawdata/2020_ryu.csv") -> ryu
ryu |> 
  group_by(pitch_type) |> 
  reframe(mean = mean(release_speed)) -> ryu2

# mean () ----
ryu |> 
  ggplot(aes(x = pitch_type, y = release_speed)) +
  geom_point() +
  geom_point(data = ryu2, aes(y = mean), color = 'red', size = 4)

# jitter ----
ryu |> 
  ggplot(aes(x = pitch_type, y = release_speed)) +
  geom_point(position = position_jitter(.1), alpha = .5) +
  geom_point(data = ryu2, aes(y = mean), color = 'red', size = 4)

# violin ----
ryu |> 
  ggplot(aes(x = pitch_type, y = release_speed)) +
  geom_violin() +
  geom_point(position = position_jitter(.3), alpha = .5) +
  geom_point(data = ryu2, aes(y = mean), color = 'red', size = 4)

# violin ----
ryu |> 
  ggplot(aes(x = pitch_type, y = release_speed)) +
  geom_boxplot() +
  #geom_point(position = position_jitter(.3), alpha = .5) +
  geom_point(data = ryu2, aes(y = mean), color = 'red', size = 4)

# plate_x
ryu |> 
  ggplot(aes(x = plate_x, y = plate_z)) +
  geom_point()

# coord_fixed() ----
ryu |> 
  ggplot(aes(x = plate_x, y = plate_z)) +
  geom_point() +
  #facet_wrap(.~pitch_name) +
  facet_grid(.~pitch_name) +
  coord_fixed()

# geom_density2d_filled ----
ryu |> 
  ggplot(aes(x = plate_x, y= plate_z)) +
  geom_density2d_filled() +
  facet_grid(stand ~ pitch_name) +
  coord_fixed() +
  guides(fill = F)

ryu |> 
  ggplot(aes(x = plate_x, y= plate_z, )) +
  geom_density2d_filled(show.legend = F) +
  facet_grid(stand ~ pitch_name) +
  coord_fixed()

#
ryu$pitch_name
ryu |> 
  filter(pitch_name %in% c('4-Seam Fastball', 'Cutter')) |> 
  ggplot(aes(x = plate_x, y= plate_z)) +
  geom_point() +
  geom_density2d_filled(show.legend = F) +
  facet_grid(stand ~ pitch_name) +
  annotate(geom = 'rect', 
           xmin = -1, 
           xmax = 1,
           ymin = 1,
           ymax = 3, 
           alpha = .5, 
           color = 'snow', 
           linetype = 'dashed') +
  coord_fixed()


# 1210
ryu |> 
  ggplot(aes(x = pitch_type, y = after_stat(count))) +
  geom_bar() +
  geom_text(aes(label = after_stat(count)), stat = 'count')

#
read_csv("./rawdata/kbo_team_batting.csv", locale = locale(encoding = 'cp949')) |> 
  as_tibble() -> team_batting

# relocate
team_batting |> 
  filter(year %in% c(1982)) |> 
  relocate(c(year, g), .before = 1)

team_batting |> 
  filter(year %in% c(1983)) |> 
  #select(9:last_col())
  select(last_col(),last_col(2))

team_batting |> 
  group_by(year) |> 
  reframe(n = n()) |> #tail()
  slice(1,c(n()-1:n()))

mpg |> 
  count(class, drv, fl) |>
  slice(1,c(n()-3:n()))
  
team_batting |> 
  count(year) |> 
  slice(1,c(n()-5:n()))

# .keep = 'used'
team_batting |> 
  filter(year > 2000) |> 
  group_by(year) |> 
  reframe(hr_mean = mean(hr), n = n()) |> 
  mutate(hr_mean / n, .keep = 'used')

# group = drop
team_batting |> 
  group_by(year) |> 
  reframe(avg = sum(h)/sum(ab))

Animals
MASS::Animals
data(package = "MASS", Animals)
Animals
 data()

data()

# 팀 배팅 2번 ---
team_batting |> 
  tibble() |> 
  mutate(
  #transmute(
    avg = h / ab, 
         obp = (h + bb + hbp) / (ab+bb+hbp+sf), 
         slg = (h + `2b` + 2 * `3b` + 3 * hr) / ab, 
         ops = obp + slg, 
         .before = g) |> 
  filter(ops >= 0.7, hr < 70) |> 
  #reframe(n = n())
  tally()
  
?tally()

# 
team_batting |> 
  tibble() |> 
  mutate(
    #transmute(
    avg = h / ab, 
    obp = (h + bb + hbp) / (ab+bb+hbp+sf), 
    slg = (h + `2b` + 2 * `3b` + 3 * hr) / ab, 
    ops = obp + slg, 
    .before = g) |> 
  filter(ops >= 0.7, hr < 70) |> 
  filter(year >= 1991, year < 2001) |> 
  transmute(year, team, rg = r / g, sb = sb / g)
  
  
  
  
  
  
  
  
  
  
  
  

















