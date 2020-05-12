# Panggil library terlebih dulu
library(rtweet)

# Ganti dengan keword yang akan dicari
akun <- "username"
jumlahtweet <- 1000

# Autentifikasi
token <- create_token(
  app = "Nama Aplikasi",
  consumer_key = "Masukan Twitter Consumer Key",
  consumer_secret = "Masukan Twitter Consumer Secret",
  access_token = "Masukan Twitter Access Token",
  access_secret = "Masukan Twitter Access Secred"
)

# Mencari Tweet
crawling <- get_favorites(akun, jumlahtweet)

# Save Sebagai CSV
write_as_csv(crawling, "data/raw/hasilcrawling-like.csv", prepend_ids = TRUE, na = "", fileEncoding = "UTF-8")