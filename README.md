# Dasar-Algoritma-Pemrograman-Final-Project

Pencatatan Log Photocopy 
 
FIF bekerja sama dengan Kopcit menyediakan layanan photocopy untuk mempermudah pekerjaan pegawainya. Mekanismenya adalah pegawai cukup menuliskan NIP dan jumlah lembar photocopy, kemudian tagihan biayanya akan dibayar oleh pihak FIF, dimana biaya per lembarnya adalah 200. Agar tercatat dengan baik, maka akan dibuat sebuah sistem pencatatan log photocopy dengan spesifikasi sebagai berikut: 

1. Pencatatan Log Photocopy 
   a. Input NIP dan jumlah lembar photocopy. NIP dan jumlah lembar photocopy tidak boleh kosong. 
      i. Jika pada tanggal tersebut pegawai belum pernah mem-photocopy maka akan disimpan data log baru berupa ID, NIP, tanggal photocopy, dan jumlah lembar photocopy. 
      ii. Jika sudah pernah, maka jumlah lembar photocopy untuk pegawai dan tanggal tersebut akan ditambah dengan jumlah lembar photocopy yang baru. 
   b. NIP valid jika berupa 8 digit angka dan diawali angka 2. 
   c. Jumlah lembar photocopy harus positif, maksimum 1000 lembar per hari.  
   d. ID sebagai primary key, digenerate secara otomatis dengan format FC-[nomor bulan saat ini dalam 2 digit][2 digit terakhir dari tahun saat ini]-[nomor urut pengambilan dalam 3 digit sesuai bulan], contoh: FC-0618-010 (artinya log photocopy ke-10 pada bulan Juni 2018). 
   e. Tanggal photocopy diambil otomatis dari tanggal sistem saat ini. 

2. Login Asumsi hanya ada satu akun untuk login admin FIF 
   a. Menampilkan data photocopy untuk satu pegawai tertentu 
   b. Menampilkan total lembar dan biaya photocopy per-bulan tertentu (misal: Juni 2018) 
   c. Menampilkan data photocopy per-bulan tertentu secara terurut berdasarkan NIP 
   d. Menampilkan data photocopy per-bulan tertentu secara terurut berdasarkan jumlah lembar photocopy 
   e. Menampilkan total lembar dan biaya semua photocopy  
   f. Menampilkan semua data photocopy secara terurut berdasarkan NIP 
   g. Menampilkan semua data photocopy secara terurut berdasarkan jumlah lembar photocopy 
