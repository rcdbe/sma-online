# Intall library rtweet
install.packages("rtweet")
install.packages("dplyr")

# Panggil library terlebih dulu
library("rtweet")
library("dplyr")

# Ganti dengan keword yang akan dicari
keyword <- "covid"
jumlahtweet <- 1000
type <- "recent"
bahasa <- "id"

# Bila ingin Mengambil Retweet tuliskan "TRUE", bila tidak tuliskan "FALSE"
retweet <- TRUE

#Autentifikasi
token <- create_token(
  app = "New Research Methodology",
  consumer_key = "Insert consumer key",
  consumer_secret = "Insert Consumer secret key",
  access_token = "Insert access token",
  access_secret = "Insert access secret key")

#Mencari Tweet
crawling <- search_tweets(keyword,
                          n = jumlahtweet,
                          include_rts = retweet,
                          type = type,
                          lang = bahasa,
                          retryonratelimit = FALSE)

# Mengambil data dengan kriteria tertentu (jumlah followers)
selected_followers <- filter(crawling, followers_count > 100)

# Menampilkan Data yang Telah Sesuai Kriteria
View(selected_followers)

# Membuat edge list
edgelist <- select(selected_followers, screen_name, mentions_screen_name)

# Memisahkan target jika terjadi duplikasi
edgelist <- edgelist %>% unnest(mentions_screen_name)

# Menghilangkan baris kosong
edgelist <- na.exclude(edgelist)

#Save Sebagai CSV
write_as_csv(edgelist, "data/raw/edgelist.csv", prepend_ids = TRUE, na = "",fileEncoding = "UTF-8")

