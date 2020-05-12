# Intall library rtweet
install.packages("rtweet")

# Panggil library terlebih dulu
library("rtweet")

# Ganti dengan keword yang akan dicari
keyword <- "Keyword"
jumlahtweet <- 1000

# Bila ingin Mengambil Retweet tuliskan "TRUE", bila tidak tuliskan "FALSE"
retweet <- TRUE

#Autentifikasi
token <- create_token(
  app = "New Research Methodology",
  consumer_key = "Masukkan Consumer Key",
  consumer_secret = "Masukkan Consumer Secret",
  access_token = "Masukkan Access Token",
  access_secret = "Masukkan Access Secret")

#Mencari Tweet
crawling <- search_tweets(keyword, n = jumlahtweet, include_rts = retweet)

#Save Sebagai CSV
write_as_csv(crawling, "data/raw/hasilcrawling-keyword.csv", prepend_ids = TRUE, na = "",fileEncoding = "UTF-8")

