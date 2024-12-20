local luasql = require "luasql.mysql"
local env = luasql.mysql()
local conn, err = env:connect('your_database', 'your_user', 'your_password', 'localhost', 3306)

if not conn then
    print("Connection failed: " .. err)
    return
end

local create_mahasiswa_table = [[
    CREATE TABLE IF NOT EXISTS mahasiswa (
        NIM VARCHAR(10) PRIMARY KEY,
        Nama VARCHAR(50),
        Alamat VARCHAR(100),
        Jurusan VARCHAR(50),
        Umur INT
    );
]]

local res, err = conn:execute(create_mahasiswa_table)
if not res then
    print("Error creating mahasiswa table: " .. err)
else
    print("Tabel Mahasiswa created successfully!")
end

-- Insert data into Tabel Mahasiswa
local insert_mahasiswa_data = [[
    INSERT INTO mahasiswa (NIM, Nama, Alamat, Jurusan, Umur) VALUES
    ('123456', 'John', 'Jl. Merdeka No. 1', 'Teknik Informatika', 21),
    ('234567', 'Alice', 'Jl. Gatot Subroto', 'Sistem Informasi', 23),
    ('345678', 'Bob', 'Jl. Sudirman No. 5', 'Teknik Informatika', 20),
    ('456789', 'Cindy', 'Jl. Pahlawan No. 2', 'Manajemen', 22),
    ('567890', 'David', 'Jl. Diponegoro No. 3', 'Teknik Elektro', 25),
    ('678901', 'Emily', 'Jl. Cendrawasih No. 4', 'Manajemen', 24),
    ('789012', 'Frank', 'Jl. Ahmad Yani No. 6', 'Teknik Informatika', 19);
]]

res, err = conn:execute(insert_mahasiswa_data)
if not res then
    print("Error inserting data into mahasiswa table: " .. err)
else
    print("Data inserted into Tabel Mahasiswa successfully!")
end

-- Create Tabel Mata Kuliah
local create_mata_kuliah_table = [[
    CREATE TABLE IF NOT EXISTS mata_kuliah (
        ID INT PRIMARY KEY,
        Mata_Kuliah VARCHAR(50),
        NIM VARCHAR(10),
        Nilai INT,
        Dosen_Pengajar VARCHAR(50),
        FOREIGN KEY (NIM) REFERENCES mahasiswa(NIM)
    );
]]

-- Execute the create table query for Mata Kuliah
res, err = conn:execute(create_mata_kuliah_table)
if not res then
    print("Error creating mata kuliah table: " .. err)
else
    print("Tabel Mata Kuliah created successfully!")
end

-- Insert data into Tabel Mata Kuliah
local insert_mata_kuliah_data = [[
    INSERT INTO mata_kuliah (ID, Mata_Kuliah, NIM, Nilai, Dosen_Pengajar) VALUES
    (1, 'Pemrograman Web', '123456', 85, 'Pak Budi'),
    (2, 'Basis Data', '234567', 70, 'Ibu Ani'),
    (3, 'Jaringan Komputer', '345678', 75, 'Pak Dodi'),
    (4, 'Sistem Operasi', '123456', 90, 'Pak Budi'),
    (5, 'Manajemen Proyek', '456789', 80, 'Ibu Desi'),
    (6, 'Bahasa Inggris', '567890', 85, 'Ibu Eka'),
    (7, 'Statistika', '678901', 75, 'Pak Farhan'),
    (8, 'Algoritma', '789012', 65, 'Pak Galih'),
    (9, 'Pemrograman Java', '123456', 95, 'Pak Budi');
]]

-- Execute insert data query for Mata Kuliah
res, err = conn:execute(insert_mata_kuliah_data)
if not res then
    print("Error inserting data into mata kuliah table: " .. err)
else
    print("Data inserted into Tabel Mata Kuliah successfully!")
end

conn:close()
env:close()

print("Tables and data created successfully!")
