# Panggil library terlebih dulu
library(rtweet)

# Ganti dengan namaakun yang akan dicari, contoh "fahrihamzah"
namaakun <- "Nama Akun"
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
craling <- get_timelines(c(namaakun, n = jumlahtweet))
users_data(crawling)

# Save Sebagai CSV
write_as_csv(crawling, "data/raw/hasilcrawling-timeline.csv", prepend_ids = TRUE, na = "", fileEncoding = "UTF-8")