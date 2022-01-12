SELECT "Ma_sinh_vien", "Ho", "Ten", "Gioi_tinh", "Ngay_sinh", "Mail", "Di_dong", "CMND", "Hoc_bong", "Ma_khoa"
  FROM "SINH_VIEN";

--1a
SELECT "Ma_sinh_vien" AS "Mã", "Ho"||' '||"Ten" AS "Họ tên", "Gioi_tinh" AS "Giới tính", 
"Ngay_sinh" AS "Ngày sinh",  "Hoc_bong" AS "Học bổng"
FROM "SINH_VIEN";

SELECT "Ma_sinh_vien" AS "Mã", "Ho"||' '||"Ten" AS "Họ tên", 
CASE 
	WHEN "Gioi_tinh" THEN 'Nam' 
	ELSE 'Nữ'
END AS "Giới tính", 
VARCHAR_FORMAT("Ngay_sinh", 'DD/MM/YYYY HH24:MI:SS') AS "Ngày sinh",
VARCHAR_FORMAT("Hoc_bong",'9,999,999.99') AS "Học bổng"
FROM "SINH_VIEN"
ORDER BY Hoc_bong;

--1b
SELECT "Ma_sinh_vien", "Ho", "Ten", "Hoc_bong", "Ma_khoa"
  FROM "SINH_VIEN"
  ORDER BY "Hoc_bong" DESC
  FETCH FIRST 10 ROWS ONLY;

--2a
SELECT s."Ma_sinh_vien", s."Ho", s."Ten", s."Ma_khoa", k."Ten" AS "Ten_khoa"
  FROM "SINH_VIEN" s INNER JOIN "KHOA" k
  ON s."Ma_khoa"=k."Ma_khoa";

--2b
SELECT s."Ma_sinh_vien", s."Ho"||' '||s."Ten" AS "Họ tên", k."Ma_mon", k."Diem"
  FROM "SINH_VIEN" s INNER JOIN "KET_QUA" k ON s."Ma_sinh_vien"=k."Ma_sinh_vien";

--2c
SELECT "Ma_sinh_vien", "Ho"||' '||"Ten" AS "Họ tên", "Ngay_sinh"
FROM "SINH_VIEN"
WHERE "Ma_sinh_vien" IN (
SELECT k."Ma_sinh_vien" FROM "KET_QUA" k JOIN "MON_HOC" m ON k."Ma_mon"=m."Ma_mon"
WHERE m."Ten" LIKE 'Cơ sở dữ liệu%');

--2d
SELECT "Ma_sinh_vien", "Ho"||' '||"Ten" AS "Họ tên", "Ngay_sinh"
FROM "SINH_VIEN"
WHERE "Ma_sinh_vien" IN (SELECT "Ma_sinh_vien" FROM "KET_QUA" WHERE "Diem"=10);

--2e
SELECT "Ma_sinh_vien", "Ho"||' '||"Ten" AS "Họ tên", "Ngay_sinh"
FROM "SINH_VIEN"
WHERE "Ma_sinh_vien" IN (
SELECT k."Ma_sinh_vien" FROM "KET_QUA" k JOIN "MON_HOC" m ON k."Ma_mon"=m."Ma_mon"
WHERE m."Ten" LIKE 'Toán cao cấp%' AND k."Diem"<5);

--2f
SELECT *
FROM "MON_HOC"
WHERE "Ma_mon" NOT IN (SELECT "Ma_mon" FROM "KET_QUA");

--2g
SELECT "Ma_sinh_vien", "Ho"||' '||"Ten" AS "Họ tên", "Ngay_sinh"
FROM "SINH_VIEN"
WHERE "Ma_sinh_vien" NOT IN (SELECT "Ma_sinh_vien" FROM "KET_QUA");

--3a
SELECT "Ma_khoa" AS "Mã khoa", COUNT(*) AS "Tổng số sinh viên"
FROM "SINH_VIEN"
GROUP BY "Ma_khoa"
ORDER BY COUNT(*);

--3b
SELECT s."Ma_khoa", k."Ten", SUM(s."Hoc_bong")
FROM "SINH_VIEN" s JOIN "KHOA" k ON s."Ma_khoa"=k."Ma_khoa"
GROUP BY s."Ma_khoa", k."Ten"
HAVING SUM(s."Hoc_bong")>=150000000;

--3c
SELECT s."Ma_sinh_vien", s."Ho"||' '||s."Ten" AS "Họ tên", AVG(k."Diem")
  FROM "SINH_VIEN" s INNER JOIN "KET_QUA" k ON s."Ma_sinh_vien"=k."Ma_sinh_vien"
GROUP BY s."Ma_sinh_vien", s."Ho"||' '||s."Ten";

--3d
SELECT s."Ma_khoa", k."Ten", AVG(kq."Diem")
FROM "SINH_VIEN" s JOIN "KHOA" k ON s."Ma_khoa"=k."Ma_khoa"
	INNER JOIN "KET_QUA" kq ON s."Ma_sinh_vien"=kq."Ma_sinh_vien"
GROUP BY s."Ma_khoa", k."Ten";

--3e
SELECT s."Ma_sinh_vien", s."Ho"||' '||s."Ten" AS "Họ tên", AVG(k."Diem") AS "điểm trung bình",
  CASE 
	WHEN AVG(k."Diem")<5 THEN 'Yếu'
	WHEN AVG(k."Diem")<6.5 THEN 'Trung bình'
	WHEN AVG(k."Diem")<8 THEN 'Khá'
	ELSE 'Giỏi'
  END AS "xếp loại"
  FROM "SINH_VIEN" s INNER JOIN "KET_QUA" k ON s."Ma_sinh_vien"=k."Ma_sinh_vien"
GROUP BY s."Ma_sinh_vien", s."Ho"||' '||s."Ten";

--3f
SELECT m."Ma_mon", m."Ten", MAX(k."Diem")
  FROM "MON_HOC" m INNER JOIN "KET_QUA" k ON m."Ma_mon"=k."Ma_mon"
GROUP BY m."Ma_mon", m."Ten";

--3g
SELECT m."Ma_mon", m."Ten", COUNT(k."Ma_sinh_vien")
  FROM "MON_HOC" m INNER JOIN "KET_QUA" k ON m."Ma_mon"=k."Ma_mon"
GROUP BY m."Ma_mon", m."Ten";

--3h
SELECT m."Ma_mon", m."Ten", COUNT(k."Ma_sinh_vien")
  FROM "MON_HOC" m INNER JOIN "KET_QUA" k ON m."Ma_mon"=k."Ma_mon"
GROUP BY m."Ma_mon", m."Ten"
ORDER BY COUNT(k."Ma_sinh_vien") DESC
FETCH FIRST 1 ROWS ONLY;

--3i
SELECT m."Ma_mon", m."Ten",
	SUM(CASE WHEN k."Diem">=5 THEN 1 ELSE 0 END) AS "đậu",
	SUM(CASE WHEN k."Diem"<5 THEN 1 ELSE 0 END) AS "rớt"
  FROM "MON_HOC" m INNER JOIN "KET_QUA" k ON m."Ma_mon"=k."Ma_mon"
GROUP BY m."Ma_mon", m."Ten";
