USE QuanLySinhVien;

SELECT
	SinhVienID,
    CONCAT(Ho, ' ', Ten) AS HoTen,
    DATE_FORMAT(NgaySinh, '%d/%m/%Y') as NgaySinh,
    GioiTinh,
    HocBong
FROM SinhVien;

-- 

SELECT
	SinhVienID,
    CONCAT(Ho, ' ', Ten) AS HoTen,
    DATE_FORMAT(NgaySinh, '%d/%m/%Y') as NgaySinh,
    GioiTinh,
    HocBong
FROM SinhVien
WHERE KhoaID = 'CN' AND HocBong > 300000;

-- 

SELECT
	SinhVienID,
    CONCAT(Ho, ' ', Ten) AS HoTen,
    DATE_FORMAT(NgaySinh, '%d/%m/%Y') as NgaySinh,
    GioiTinh,
    HocBong
FROM SinhVien
WHERE HocBong > 0 AND NgaySinh BETWEEN '1999-06-01' AND '1999-06-30';

-- 

UPDATE SinhVien SET NgaySinh = '1998-07-05' WHERE Ho = 'Khương Thảo' AND Ten = 'Loan';
SELECT * 
FROM SinhVien
WHERE Ho = 'Khương Thảo' AND Ten = 'Loan';

--

SELECT
	SinhVienID,
    CONCAT(Ho, ' ', Ten) AS HoTen,
    DATE_FORMAT(NgaySinh, '%d/%m/%Y') as NgaySinh,
    GioiTinh,
    HocBong,
    HocBong * 1.05 AS HocBong_tang5_phan_100,
    KhoaID
FROM SinhVien
WHERE HocBong > 0 AND KhoaID = 'CN';

-- 

UPDATE SinhVien SET HocBong = 50000 WHERE GioiTinh = FALSE AND HocBong = 0;
SELECT *
FROM SinhVien
WHERE GioiTinh = FALSE;

-- 

UPDATE KetQua SET Diem = 10 WHERE Diem + 5 > 10 AND MonHocID = 'TT';
UPDATE KetQua SET Diem = Diem + 5 WHERE Diem + 5 <= 10 AND MonHocID = 'TT';
SELECT * FROM KetQua WHERE MonHocID = 'TT';

--

DELETE FROM KetQua WHERE SinhVienID = 'C0001';

SELECT *
FROM KetQua;
-- 

DELETE 
FROM KetQua
WHERE SinhVienID IN ( SELECT * FROM (
						SELECT SinhVienID
						FROM KetQua
						WHERE Diem < 5) q
);

SELECT *
FROM KetQua;
