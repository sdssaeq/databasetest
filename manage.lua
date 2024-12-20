local luasql = require "luasql.mysql"
local env = luasql.mysql()
local conn, err = env:connect('your_database', 'your_user', 'your_password', 'localhost', 3306)

if not conn then
    print("Connection failed: " .. err)
    return
end

-- 1. Update the address for the student with NIM '123456'
local update_address = [[
    UPDATE mahasiswa
    SET Alamat = 'Jl. Raya No.5'
    WHERE NIM = '123456';
]]

-- Execute the update query
local res, err = conn:execute(update_address)
if not res then
    print("Error updating address: " .. err)
else
    print("Alamat mahasiswa with NIM '123456' updated successfully!")
end

-- 2. Display NIM, name, and department for students with the department 'Teknik Informatika',
--    and also display the name of their advisor (assuming there is a field in the `mahasiswa` table for this).
local query_2 = [[
    SELECT m.NIM, m.Nama, m.Jurusan, m.Dosen_Pembimbing
    FROM mahasiswa m
    WHERE m.Jurusan = 'Teknik Informatika';
]]

-- Execute query 2
local cur, err = conn:execute(query_2)
if not cur then
    print("Error executing query 2: " .. err)
else
    print("NIM, Nama, Jurusan, and Dosen Pembimbing for Teknik Informatika:")
    local row = cur:fetch({}, "a")
    while row do
        print(string.format("NIM: %s, Nama: %s, Jurusan: %s, Dosen Pembimbing: %s", 
                            row.NIM, row.Nama, row.Jurusan, row.Dosen_Pembimbing))
        row = cur:fetch(row, "a")
    end
end

-- 3. Display the 5 oldest students (top 5 by age)
local query_3 = [[
    SELECT Nama, Umur
    FROM mahasiswa
    ORDER BY Umur DESC
    LIMIT 5;
]]

-- Execute query 3
cur, err = conn:execute(query_3)
if not cur then
    print("Error executing query 3: " .. err)
else
    print("Top 5 oldest students:")
    local row = cur:fetch({}, "a")
    while row do
        print(string.format("Nama: %s, Umur: %d", row.Nama, row.Umur))
        row = cur:fetch(row, "a")
    end
end

-- 4. Display student name, course taken, and grade for students who have grades above 70
local query_4 = [[
    SELECT m.Nama, k.Mata_Kuliah, k.Nilai
    FROM mahasiswa m
    JOIN mata_kuliah k ON m.NIM = k.NIM
    WHERE k.Nilai > 70;
]]

-- Execute query 4
cur, err = conn:execute(query_4)
if not cur then
    print("Error executing query 4: " .. err)
else
    print("Nama mahasiswa, Mata Kuliah, and Nilai (for students with grade > 70):")
    local row = cur:fetch({}, "a")
    while row do
        print(string.format("Nama: %s, Mata Kuliah: %s, Nilai: %d", 
                            row.Nama, row.Mata_Kuliah, row.Nilai))
        row = cur:fetch(row, "a")
    end
end

conn:close()

env:close()

print("All queries executed successfully!")
