DROP DATABASE IF EXISTS QuanLySinhVien;
CREATE DATABASE QuanLySinhVien;
USE QuanLySinhVien;

CREATE TABLE Khoa (
    KhoaID CHAR(2) PRIMARY KEY NOT NULL,
    TenKhoa VARCHAR(50) NOT NULL
);

LOAD DATA LOCAL INFILE '/Users/tranhoangbach/Working Hub/Trung tam TH/4. Database and SQL/data/khoa.csv' 
INTO TABLE Khoa
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES;

SELECT * FROM Khoa;

CREATE TABLE MonHoc (
    MonHocID CHAR(2) PRIMARY KEY NOT NULL,
    TenMonHoc VARCHAR(50) NOT NULL
);

LOAD DATA LOCAL INFILE '/Users/tranhoangbach/Working Hub/Trung tam TH/4. Database and SQL/data/mon_hoc.csv' 
INTO TABLE MonHoc
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES;

SELECT * FROM MonHoc;

CREATE TABLE SinhVien (
    SinhVienID CHAR(5) PRIMARY KEY NOT NULL,
    Ho VARCHAR(50) NOT NULL,
    Ten VARCHAR(50) NOT NULL,
    GioiTinh VARCHAR(15),
    -- GioiTinh BOOLEAN,
    NgaySinh DATETIME,
    Email VARCHAR(50),
    Didong INTEGER,
    CMND INTEGER,
    HocBong INTEGER,
    KhoaID CHAR(2) NOT NULL
    -- FOREIGN KEY (KhoaID) REFERENCES Khoa (KhoaID)
);

LOAD DATA LOCAL INFILE '/Users/tranhoangbach/Working Hub/Trung tam TH/4. Database and SQL/data/sinh_vien.csv' 
INTO TABLE SinhVien
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES
-- (SinhVienID, Ho, Ten, GioiTinh, NgaySinh, Email, Didong, CMND, HocBong, KhoaID)
SET GioiTinh := GioiTinh = 'True';
ALTER TABLE SinhVien MODIFY COLUMN GioiTinh BOOLEAN;
SELECT * FROM SinhVien;

CREATE TABLE KetQua (
    SinhVienID CHAR (5),
    MonHocID CHAR (2),
    Diem REAL,
    -- FOREIGN KEY (SinhVienID) REFERENCES SinhVien (SinhVienID),
    -- FOREIGN KEY (MonHocID) REFERENCES MonHoc (MonHocID),
    CHECK (Diem >= 0)
);

LOAD DATA LOCAL INFILE '/Users/tranhoangbach/Working Hub/Trung tam TH/4. Database and SQL/data/ket_qua.csv' 
INTO TABLE KetQua
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES;

SELECT * FROM KetQua;

ALTER TABLE SinhVien ADD CONSTRAINT FK_SinhVien_Khoa FOREIGN KEY (KhoaID) REFERENCES Khoa (KhoaID);
ALTER TABLE KetQua ADD CONSTRAINT FK_KetQua_SinhVien FOREIGN KEY (SinhVienID) REFERENCES SinhVien (SinhVienID);
ALTER TABLE KetQua ADD CONSTRAINT FK_KetQua_MonHoc FOREIGN KEY (MonHocID) REFERENCES MonHoc (MonHocID);

