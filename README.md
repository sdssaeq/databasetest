# databasetest

UPDATE mahasiswa
SET Alamat = 'Jl. Raya No.5'
WHERE NIM = '123456';

SELECT m.NIM, m.Nama, m.Jurusan, m.Dosen_Pembimbing
FROM mahasiswa m
WHERE m.Jurusan = 'Teknik Informatika';

SELECT Nama, Umur
FROM mahasiswa
ORDER BY Umur DESC
LIMIT 5;

SELECT m.Nama, k.Mata_Kuliah, k.Nilai
FROM mahasiswa m
JOIN mata_kuliah k ON m.NIM = k.NIM
WHERE k.Nilai > 70;
