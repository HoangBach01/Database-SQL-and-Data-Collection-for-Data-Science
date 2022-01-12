USE QuanLySinhVien;
-- Cau 1a, b
SELECT
	SinhVienID,
    CONCAT(Ho, ' ', Ten) AS HoTen,
    DATE_FORMAT(NgaySinh, '%Y-%m-%d') as NgaySinh,
    (CASE WHEN GioiTinh = True THEN 'Nam' ELSE 'Nu' END) AS GioiTinh,
    HocBong
FROM SinhVien
ORDER BY HocBong DESC;

-- Cau 2a,b
SELECT 
	s.SinhVienID,
    CONCAT(Ho, ' ', Ten) AS HoTen,
    k.MonHocID,
    k.Diem
FROM SinhVien s
JOIN KetQua k 
	ON s.SinhVienID = k.SinhVienID;

-- Cau 2c
SELECT *
FROM SinhVien
WHERE SinhVienID IN(
	SELECT DISTINCT SinhVienID
	FROM KetQua
	WHERE MonHocID = 'CS'
);

-- Cau 2d
SELECT *
FROM SinhVien
WHERE SinhVienID IN (
	SELECT DISTINCT SinhVienID
	FROM KetQua
	WHERE Diem = 10
);

-- Cau 2f
SELECT *
FROM MonHoc
WHERE MonHocID NOT IN (
	SELECT DISTINCT MonHocID
	FROM KetQua
);

-- Cau 2g
SELECT *
FROM SinhVien
WHERE SinhVienID NOT IN (
	SELECT DISTINCT SinhVienID
	FROM KetQua
);

-- Cau 3a
SELECT 
	KhoaID,
    COUNT(*) as TongSV
FROM SinhVien
GROUP BY KhoaID
ORDER BY TongSV;

-- Cau 3b
SELECT 
	s.KhoaID,
    k.TenKhoa,
    SUM(HocBong) as TongHocBong
FROM SinhVien s
JOIN Khoa k USING (KhoaID)
GROUP BY KhoaID
HAVING TongHocBong > 3000000
ORDER BY TongHocBong DESC;

-- Cau 3c
SELECT 
	s.SinhVienID,
    CONCAT(Ho, ' ', Ten) as HoTen,
    AVG(Diem) as DiemTrungBinh
FROM SinhVien s
JOIN KetQua k
	ON s.SinhVienID = k.SinhVienID
GROUP BY SinhVienID, HoTen;

-- Cau 3d
SELECT 
	s.KhoaID, 
    kh.TenKhoa,
	AVG(Diem) as DTB_Khoa
FROM SinhVien s
JOIN KetQua k
	ON s.SinhVienID = k.SinhVienID
JOIN Khoa kh
	ON s.KhoaID = kh.KhoaID
GROUP BY KhoaID, TenKhoa;

-- Cau 3e
SELECT 
	s.SinhVienID,
    CONCAT(Ho, ' ', Ten) as HoTen,
    AVG(Diem) as DTB,
    (CASE 
		WHEN AVG(Diem) < 5 THEN 'Yeu'
        WHEN AVG(Diem) >= 5 AND AVG(Diem) < 6.5 THEN 'Trung Binh'
        WHEN AVG(Diem) >= 6.5 AND AVG(Diem) < 8 THEN 'Kha'
        ELSE 'Gioi'
	END) AS Xeploai
FROM SinhVien s
JOIN KetQua k
	ON s.SinhVienID = k.SinhVienID
GROUP BY SinhVienID, HoTen;

-- Cau 3f
SELECT 
	k.MonHocID,
    m.TenMonHoc,
    Max(Diem) as DiemCaoNhat
FROM SinhVien s
JOIN KetQua k
	ON s.SinhVienID = k.SinhVienID
JOIN MonHoc m
	ON k.MonHocID = m.MonHocID
GROUP BY k.MonHocID;

-- Cau 3g
SELECT 
	k.MonHocID,
    m.TenMonHoc,
    COUNT(*) as DangKy
FROM KetQua k
JOIN MonHoc m
	ON m.MonHocID = k.MonHocID
GROUP BY MonHocID, TenMonHoc;

-- Cau 3i
SELECT 
	q.MonHocID,
    m.TenMonHoc,
    SUM(KetQua = 'Pass') AS Count_Pass,
    SUM(KetQua = 'Fail') AS Count_Fail
FROM ( 
	SELECT 
		SinhVienID,
		MonHocID,
		Max(Diem) as Diem,
		(CASE WHEN Max(Diem) < 5 THEN 'Fail' ELSE 'Pass' END) AS KetQua
	FROM KetQua
	GROUP BY SinhVienID, MonHocID
	
) q
JOIN MonHoc m 
	ON q.MonHocID = m.MonHocID
GROUP BY MonHocID, TenMonHoc;