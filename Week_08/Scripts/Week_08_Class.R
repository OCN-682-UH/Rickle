### SZR
### 14/10/25
### Week 8 Class
### Working with words

##############################################################################

## load libraries
library(here)
library(tidyverse)
library(tidytext)
library(wordcloud2)
library(janeaustenr)
library(stringr)

## Working with words practice
headstrings <- c("550-153-7578",
             "banana",
             "435.114.67586,
             home: 672-442-6739") 

  str_replace_all(strings,"\\.", "-") %>% ## replacing . with -
    str_replace_all("[a-z]|\\:","") %>% ## removing letters and replacing with nothing
    str(trim) ## removed white spaces

## Jane Austen Data
original_books <- austen_books() %>%
  group_by(book) %>%
  mutate(line = row_number(),
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",
                                                 ignore_case = TRUE)))) %>%
  ungroup()
  
tidy_books <- original_books %>%
  unnest_tokens(output = word, input = text)

cleaned_books <- tidy_books %>% ## removing common stopwords
  anti_join(get_stopwords())

cleaned_books %>% ## most common word in books
  count(word, sort = TRUE)

sent_word_counts <- tidy_books %>%
  inner_join(get_sentiments()) %>% # only keep pos or negative words
  count(word, sentiment, sort = TRUE) # count them
