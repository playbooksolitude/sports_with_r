rm(list=ls())

pacman::p_load(tidyverse)

tribble(
  ~����, ~�̸�, ~Ȩ��, ~��,
  2003, '�̽¿�', 56, '�Ｚ',
  1999, '�̽¿�', 54, '�Ｚ',
  2003, '������', 53, '����',
  2015, '�ں�ȣ', 53, '�ؼ�',
  2014, '�ں�ȣ', 52, '�ؼ�',
  2015, '���ٷ�', 48, '�Ｚ',
  2002, '�̽¿�', 47, '�Ｚ',
  2015, '������', 47, 'NC',
  2020, '���Ͻ�', 47, 'KT',
  2002, '������', 46, '����',
) -> Ȩ��

tribble(
  ~��, ~��Ī,
  '�ؼ�', '�������',
  '�λ�', '���',
  '�Ե�', '���̾���',
  '�Ｚ', '���̿���',
  '��ȭ', '�̱۽�',
  'KIA', 'Ÿ�̰���',
  'KT', '����',
  'LG', 'Ʈ����',
  'NC', '���̳뽺',
  'SK', '���̹���'
) -> ��

Ȩ�� %>% inner_join(��)

Ȩ�� %>% left_join(��)

Ȩ�� %>% right_join(��)

Ȩ�� %>% full_join(��)

Ȩ�� %>% semi_join(��)

Ȩ�� %>% anti_join(��)

tribble(
  ~����, ~��Ī,
  '�ؼ�', '�������',
  '�λ�', '���',
  '�Ե�', '���̾���',
  '�Ｚ', '���̿���',
  '��ȭ', '�̱۽�',
  'KIA', 'Ÿ�̰���',
  'KT', '����',
  'LG', 'Ʈ����',
  'NC', '���̳뽺',
  'SK', '���̹���'
) -> ��

Ȩ�� %>% left_join(��)

Ȩ�� %>% left_join(��, by = c('��' = '����'))

'international_soccer_matches_results.csv' %>% 
  read.csv() %>% 
  as_tibble() -> results

results %>% 
  glimpse()  

results %>%
  select(
    date,
    team = away_team,
    opponent = home_team,
    team_score = away_score,
    opponent_score = home_score,
    tournament:last_col()
  ) -> results_away

tribble(
  ~a, ~b, ~c,
  1, 2, 3,
) -> tbl1

tribble(
  ~a, ~b, ~c,
  4, 5, 6
) -> tbl2

tbl1 %>% 
  bind_rows(tbl2)

results %>%
  rename(
    team = home_team,
    opponent = away_team,
    team_score = home_score,
    opponent_score = away_score
  ) %>%
  bind_rows(results_away) -> results

results

results %>%
  mutate(
    win = ifelse(team_score > opponent_score, 1, 0),
    draw = ifelse(team_score == opponent_score, 1, 0),
    lose = ifelse(team_score < opponent_score, 1, 0)
  ) %>%
  group_by(team) %>%
  summarise(
    wins = sum(win),
    draws = sum(draw),
    loses = sum(lose),
    matches = wins + draws + loses,
    win_percent = wins / matches,
    .groups = 'drop'
  ) %>%
  arrange(-wins)

results %>%
  mutate(
    win = ifelse(team_score > opponent_score, 1, 0),
    draw = ifelse(team_score == opponent_score, 1, 0),
    lose = ifelse(team_score < opponent_score, 1, 0)
  ) %>%
  group_by(team) %>%
  summarise(
    wins = sum(win),
    draws = sum(draw),
    loses = sum(lose),
    matches = wins + draws + loses,
    win_percent = wins / matches,
    .groups = 'drop'
  ) %>%
  arrange(-win_percent)

results %>%
  mutate(
    win = ifelse(team_score > opponent_score, 1, 0),
    draw = ifelse(team_score == opponent_score, 1, 0),
    lose = ifelse(team_score < opponent_score, 1, 0)
  ) %>%
  group_by(team, opponent) %>%
  summarise(
    wins = sum(win),
    draws = sum(draw),
    loses = sum(lose),
    matches = wins + draws + loses,
    win_percent = wins / matches,
    .groups = 'drop'
  ) %>%
  arrange(-wins)

results %>%
  mutate(
    win = ifelse(team_score > opponent_score, 1, 0),
    draw = ifelse(team_score == opponent_score, 1, 0),
    lose = ifelse(team_score < opponent_score, 1, 0)
  ) %>%
  group_by(team, opponent) %>%
  summarise(
    wins = sum(win),
    draws = sum(draw),
    loses = sum(lose),
    matches = wins + draws + loses,
    win_percent = wins / matches,
    .groups = 'drop'
  ) %>%
  filter(team == 'South Korea') %>%
  arrange(-wins)

'fifa_ranking.csv' %>% 
  read.csv() %>% 
  as_tibble() -> fifa_ranking

fifa_ranking %>% 
  glimpse()

fifa_ranking %>% 
  filter(country_full == 'South Korea')

fifa_ranking %>% 
  filter(country_full == 'Korea Republic')

results %>%
  filter(date >= '1993-08-08') %>%
  select(team) %>%
  distinct() -> results_countries

results_countries

fifa_ranking %>%
  select(country_full, country_abrv) %>%
  distinct() -> fifa_ranking_countries

fifa_ranking_countries

results_countries %>%
  left_join(fifa_ranking_countries,
            by = c('team' = 'country_full')) %>%
  filter(is.na(country_abrv) == TRUE) -> countries_to_match

countries_to_match

pacman::p_load(countrycode)

c('South Korea', 'Korea Republic') %>%
  countrycode(origin = 'country.name',
              destination = 'iso3c')

tribble(
  ~x, ~y, ~z,
  8, 1, 6,
  3, 5, 7,
  4, 9, 2,
) %>% 
  mutate(sum = sum(x, y, z))

tribble(
  ~x, ~y, ~z,
  8, 1, 6,
  3, 5, 7,
  4, 9, 2,
) %>% 
  rowwise() %>%
  mutate(sum = sum(x, y, z))

countries_to_match %>%
  rowwise() %>%
  mutate(country_abrv =
           countrycode(team,
                       origin = 'country.name',
                       destination = 'iso3c')) -> country_codes_result

results_countries %>%
  left_join(fifa_ranking_countries,
            by = c('team' = 'country_full')) %>% 
  bind_rows(country_codes_result) %>% 
  drop_na() -> country_code_result

country_code_result

results %>% 
  filter(date >= '1993-08-08') %>%
  left_join(country_code_result) %>% 
  left_join(fifa_ranking,
            by = c('country_abrv', 'date' = 'rank_date')) %>% 
  select(id:last_col())

results %>% 
  filter(date >= '1993-08-08') %>%
  left_join(country_code_result) %>% 
  left_join(fifa_ranking,
            by = c('country_abrv', 'date' = 'rank_date')) %>% 
  drop_na()

results %>%
  filter(date >= '1993-08-08') %>%
  left_join(country_code_result) %>%
  rename(team_abrv = country_abrv) %>%
  left_join(country_code_result,
            by = c('opponent' = 'team')) %>%
  rename(opponent_abrv = country_abrv)

results %>%
  filter(date > '1993-08-08') %>%
  left_join(country_code_result) %>%
  rename(team_abrv = country_abrv) %>%
  left_join(country_code_result,
            by = c('opponent' = 'team')) %>%
  rename(opponent_abrv = country_abrv) %>%
  drop_na() %>%
  write.csv('soccer_matches_results_in_progress.csv')