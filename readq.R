# Must load librarys' before executing code

Needed <- c("tm", "SnowballCC", "RColorBrewer", "ggplot2", "wordcloud", "biclust", 
            "cluster", "igraph", "fpc")
install.packages(Needed, dependencies = TRUE)

install.packages("Rcampdf", repos = "http://datacube.wu.ac.at/", type = "source")

file.choose()

getwd()

cname <- file.path("C:/Users/livin/OneDrive/Documents/R projects/a2econ", "texts")   

cname   

dir(cname) 

# Other import method
library(readr)
mystring <- read_file("C:/Users/livin/OneDrive/Documents/R projects/a2econ/texts/texts.txt")
dir(mystring)


#install devtools if you have not installed, need slam for tm
install.packages('devtools')
library(devtools)
slam_url <- "https://cran.r-project.org/src/contrib/Archive/slam/slam_0.1-37.tar.gz"
install_url(slam_url)


library(tm)

# Make a volatile corpus
docs <- VCorpus(DirSource(cname))   

docs

str(docs)

docs$content

# Some preprocessing functions:
# tolower(): Make all characters lowercase
# removePunctuation(): Remove all punctuation marks
# removeNumbers(): Remove numbers
# stripWhitespace(): Remove excess whitespace
# The qdap package offers other text cleaning functions. Each is useful in its own way and is particularly powerful when combined with the others.
# bracketX(): Remove all text within brackets (e.g. “It’s (so) cool” becomes “It’s cool”)
# replace_number(): Replace numbers with their word equivalents (e.g. “2” becomes “two”)
# replace_abbreviation(): Replace abbreviations with their full text equivalents (e.g. “Sr” becomes “Senior”)
# replace_contraction(): Convert contractions back to their base words (e.g. “shouldn’t” becomes “should not”)
# replace_symbol() Replace common symbols with their word equivalents (e.g. “$” becomes “dollar”)
# stopwords, stemming
stopwords("en")

# Function for preprocessing using tm_map
clean_corpus <- function(corpus){
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, content_transformer(tolower))
  return(corpus)
}

# matching -----------------------------------------------------------

cleancorp <- clean_corpus(docs)

text <- cleancorp[[1]]$content

# List words
library(tokenizers)
# tokenize_words includes removal of punctuation and lowercase

words <- tokenize_words(docs[[1]]$content)

words

# manual enter text-----------------------------------
text <- c(" ")


library(qdap)

frequent_terms <- freq_terms(text)

plot(frequent_terms)

library(googlesheets)

gs_ls()

a2 <- gs_title("a2 econ data")

# list worksheets
gs_ws_ls(a2)

commandtbl <- gs_read(ss=a2, ws = "Command", skip=0)

str(commandsheet)

commandq <- merge(x = frequent_terms, y = commandtbl, by.x = "WORD", by.y = "command", all = F)

text
modaltbl <- data.frame(modal = c("will", "would", "shall", "should", "can", "could", "may", "might", "must"))

modalv <- merge(x = frequent_terms, y = modaltbl, by.x = "WORD", by.y = "modal", all = F)
# verb attached to modal verb?


# match similar to index of textbook ------------

# test using igcse book, http://www.newocr.com/

# using ropensi tesseract

install.packages("tesseract")

library(tesseract)
