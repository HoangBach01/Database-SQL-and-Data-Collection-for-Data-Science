SELECT "Ma_sinh_vien", "Ho", "Ten", "Gioi_tinh", "Ngay_sinh", "Mail", "Di_dong", "CMND", "Hoc_bong", "Ma_khoa"
  FROM "SINH_VIEN";

--3a
SELECT "Ma_sinh_vien" AS "Mã", "Ho"||' '||"Ten" AS "Họ tên", "Gioi_tinh" AS "Giới tính", 
"Ngay_sinh" AS "Ngày sinh",  "Hoc_bong" AS "Học bổng"
FROM "SINH_VIEN"; -- literal

SELECT "Ma_sinh_vien" AS "Mã", "Ho"||' '||"Ten" AS "Họ tên", 
CASE 
	WHEN "Gioi_tinh" THEN 'Nam' 
	ELSE 'Nữ'
END AS "Giới tính", 
VARCHAR_FORMAT("Ngay_sinh", 'DD/MM/YYYY HH24:MI:SS') AS "Ngày sinh",
VARCHAR_FORMAT("Hoc_bong",'9,999,999.99') AS "Học bổng"
FROM "SINH_VIEN";

--3b
SELECT "Ma_sinh_vien", "Ho", "Ten", "Gioi_tinh", "Ngay_sinh", "Mail", "Di_dong", "CMND", "Hoc_bong", "Ma_khoa"
  FROM "SINH_VIEN"
  WHERE "Hoc_bong">1000000 
  AND "Ma_khoa"= 
(SELECT "Ma_khoa" FROM "KHOA" WHERE "Ten"='Khoa Công nghệ Thông tin');

--3c
SELECT "Ma_sinh_vien", "Ho", "Ten", "Gioi_tinh", "Ngay_sinh", "Hoc_bong"
  FROM "SINH_VIEN"
  WHERE "Hoc_bong" BETWEEN 1000000 AND 2000000;

--3d
SELECT "Ma_sinh_vien", "Ho", "Ten", "Gioi_tinh", "Ngay_sinh", "Hoc_bong"
  FROM "SINH_VIEN"
  WHERE "Hoc_bong">0 AND "Ngay_sinh" BETWEEN '1998-06-01' AND '1999-06-30';

--3e
SELECT *
  FROM "SINH_VIEN"
  WHERE "Hoc_bong">0
  FETCH FIRST 10 ROWS ONLY;
  
--4a
SELECT *
  FROM "SINH_VIEN"
  WHERE "Ho"='Hoàng Nam' AND "Ten"='Tuấn';

UPDATE "SINH_VIEN"
  SET "Ngay_sinh"='1999-07-05'
  WHERE "Ho"='Hoàng Nam' AND "Ten"='Tuấn';

--4b
UPDATE "SINH_VIEN"
  SET "Hoc_bong"="Hoc_bong"+"Hoc_bong"*5/100
  WHERE "Hoc_bong">0
  AND "Ma_khoa"= 
(SELECT "Ma_khoa" FROM "KHOA" WHERE "Ten"='Khoa Công nghệ Thông tin');

--4c
SELECT * FROM  "SINH_VIEN"
  WHERE "Hoc_bong"=0 AND NOT "Gioi_tinh"
  AND "Ma_khoa"= 
(SELECT "Ma_khoa" FROM "KHOA" WHERE "Ten"='Khoa Công nghệ Thông tin');

UPDATE "SINH_VIEN"
  SET "Hoc_bong"=500000
  WHERE "Hoc_bong"=0 AND NOT "Gioi_tinh"
  AND "Ma_khoa"= 
(SELECT "Ma_khoa" FROM "KHOA" WHERE "Ten"='Khoa Công nghệ Thông tin');

--4d
SELECT * FROM  "KET_QUA"
  WHERE "Ma_mon" = (SELECT "Ma_mon" FROM "MON_HOC" WHERE "Ten"='Trí tuệ nhân tạo' )
  AND "Ma_sinh_vien" IN (SELECT "Ma_sinh_vien" FROM "SINH_VIEN" WHERE  "Ma_khoa"= 
(SELECT "Ma_khoa" FROM "KHOA" WHERE "Ten"='Khoa Công nghệ Thông tin'))
  AND "Diem"<=9.5;

UPDATE "KET_QUA"
  SET "Diem"="Diem"+0.5
  WHERE "Ma_mon" = (SELECT "Ma_mon" FROM "MON_HOC" WHERE "Ten"='Trí tuệ nhân tạo' )
  AND "Ma_sinh_vien" IN (SELECT "Ma_sinh_vien" FROM "SINH_VIEN" WHERE  "Ma_khoa"= 
(SELECT "Ma_khoa" FROM "KHOA" WHERE "Ten"='Khoa Công nghệ Thông tin'))
  AND "Diem"<=9.5;

--4e
DELETE  "KET_QUA"
  WHERE "Ma_sinh_vien"='C0001';

--4f
DELETE  "SINH_VIEN"
  WHERE "Ma_sinh_vien"='C0001';

--4g
DELETE "SINH_VIEN"
  WHERE "Gioi_tinh"=True
  AND "Ma_khoa"= 
(SELECT "Ma_khoa" FROM "KHOA" WHERE "Ten"='Khoa Công nghệ Thông tin');

--4h
DELETE  "KET_QUA"
  WHERE "Diem"<5;