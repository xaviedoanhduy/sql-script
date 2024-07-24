CREATE DATABASE QLBH

USE QLBH
GO

CREATE TABLE CHINHANH
(
	MACN CHAR(10) PRIMARY KEY,
	TENCN NVARCHAR(100),
	DIACHI NVARCHAR(100),
	SODT VARCHAR(15)
	
	--KHOÁ CHÍNH: MACN
)

CREATE TABLE KHACHHANG
(
	MAKH CHAR(10),
	HOTEN NVARCHAR(50),
	DIACHI NVARCHAR(50),
	SODT VARCHAR(15),
	NGAYSINH SMALLDATETIME,
	NGAYDK SMALLDATETIME,
	DOANHSO MONEY,
	DIEMTICHLUY INT,

	PRIMARY KEY(MAKH),
	CHECK(DOANHSO>=0),
	CHECK(DIEMTICHLUY>=0)
)

CREATE TABLE NHANVIEN
(
	MANV CHAR(10),
	HOTEN NVARCHAR(50),
	DIACHI NVARCHAR(50),
	SODT VARCHAR(15),
	NGAYSINH SMALLDATETIME,
	NGAYVL SMALLDATETIME,
	LUONG MONEY,
	MACN CHAR(10)

	PRIMARY KEY(MANV),
	CHECK(LUONG>=5000000),
	FOREIGN KEY(MACN) REFERENCES CHINHANH(MACN)
)

CREATE TABLE SANPHAM
(
	MASP CHAR(4),
	TENSP NVARCHAR(40),
	DVT NVARCHAR(20),
	NUOCSX NVARCHAR(40),
	GIABAN MONEY

	PRIMARY KEY (MASP),
	CHECK(GIABAN>0)
)

CREATE TABLE KHO
(	
	MAKHO CHAR(4),
	DIACHI NVARCHAR(100),
	MACN CHAR(10),
	PRIMARY KEY(MAKHO),
	FOREIGN KEY(MACN) REFERENCES CHINHANH(MACN)
)

CREATE TABLE KHO_SP
(
	MAKHO CHAR(4),
	MASP CHAR(4),
	SOLUONGTON INT,

	PRIMARY KEY(MAKHO, MASP),
	FOREIGN KEY(MAKHO) REFERENCES KHO(MAKHO),
	FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP),
	CHECK(SOLUONGTON>0)
)

CREATE TABLE HOADON
(
	SOHD INT,
	NGHD SMALLDATETIME DEFAULT(GETDATE()),
	MAKH CHAR(10),
	MANV CHAR(10),
	TONGTRIGIA MONEY,
	MACN CHAR(10),

	PRIMARY KEY(SOHD),
	FOREIGN KEY(MAKH) REFERENCES KHACHHANG(MAKH),
	FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV),
	FOREIGN KEY(MACN) REFERENCES CHINHANH(MACN),
	CHECK(TONGTRIGIA>0)
)

CREATE TABLE CTHD
(
	SOHD INT,
	MASP CHAR(4),
	DONGIA MONEY,
	SOLUONG INT,

	PRIMARY KEY(SOHD, MASP),
	FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP),
	FOREIGN KEY(SOHD) REFERENCES HOADON(SOHD),
	CHECK (SOLUONG>0)
)

CREATE TABLE NHACC
(
	MANCC CHAR(8),
	TENNCC NVARCHAR(100),
	DIACHI NVARCHAR(100),
	DIENTHOAI VARCHAR(15),
	QUOCGIA NVARCHAR(50),
	
	PRIMARY KEY(MANCC)
)

CREATE TABLE PHIEUNHAP
(
	MAPN INT,
	NGAYNHAP DATE DEFAULT(GETDATE()),
	MANCC CHAR(8),
	MANV CHAR(10),
	MAKHO CHAR(4),

	PRIMARY KEY(MAPN),
	FOREIGN KEY(MANCC) REFERENCES NHACC(MANCC),
	FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV),
	FOREIGN KEY(MAKHO) REFERENCES KHO(MAKHO)
)


CREATE TABLE CTPN
(
	MAPN INT,
	MASP CHAR(4),
	SOLUONG INT,
	DONGIANHAP MONEY,
	
	PRIMARY KEY(MAPN, MASP),
	FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP),
	FOREIGN KEY(MAPN) REFERENCES PHIEUNHAP(MAPN),
	CHECK (SOLUONG>0),
	CHECK(DONGIANHAP>0)
)

--CHINHANH
insert into CHINHANH values('CN1',N'TPHCM',N'123 Sư Vạn Hạnh, Q10, TPHCM','0283456789')
insert into CHINHANH values('CN2',N'Hà Nội',N'567 Nguyễn Trãi, Thanh Kê, Hà Nội','0283456789')

-- KHACHHANG

insert into khachhang values('KH01',N'Nguyễn Văn An',N'731 Trần Hưng Đạo, Q5, TpHCM','8823451','1960/10/22','2019/07/22',13060000, 1300)
insert into khachhang values('KH02',N'Trần Ngọc Hân',N'23/5 Nguyễn Trãi, Q5, Hà Nội','908256478','1974/03/04','2019/07/30',280000,280)
insert into khachhang values('KH03',N'Trần Ngọc Linh',N'45 Nguyễn Cảnh Chân, Q1, TpHCM','938776266','1980/06/12','2019/05/08',3860000,380)
insert into khachhang values('KH04',N'Trần Minh Long',N'50/34 Lê Đại Hành, Q10, Hà Nội','917325476','1965/09/03','2019/02/10',250000,25)
insert into khachhang values('KH05',N'Lê Nhật Minh',N'34 Trương Định, Q3, TpHCM','8246108','1950/03/10','2019/10/28',21000,2)
insert into khachhang values('KH06',N'Lê Hoài Thương',N'227 Nguyễn Văn Cừ, Q5, Hà Nội','8631738','1981/12/31','2019/11/24',915000,91)
insert into khachhang values('KH07',N'Nguyễn Văn Tâm',N'32/3 Trần Bình Trọng, Q5, TpHCM','916783565','1971/06/04','2019/01/12',12500,1)
insert into khachhang values('KH08',N'Phan Thị Thanh',N'45/2 An Dương Vương, Q1, Hà Nội','938435756','1971/10/01','2019/12/13',365000,36)
insert into khachhang values('KH09',N'Lê Hà Vinh',N'873 Lê Hồng Phong, Q5, TpHCM','8654763','1979/03/09','2020/01/14',70000,7)
insert into khachhang values('KH10',N'Hà Duy Lập',N'34/34B Nguyễn Trãi, Q1, Hà Nội','8768904','1983/02/05','2020/01/16',67500,6)
insert into khachhang values('KH11',N'Nguyễn Văn Hùng',N'75/2 Kinh Dương Vương, Q5, TpHCM','12345678','1979/10/22','2020/07/22',14060000, 1400)
insert into khachhang values('KH12',N'Trần Thị Lan',N'65 Trần Hưng Đạo, Hà Nội','908277478','1975/03/04','2020/07/30',300000,300)
insert into khachhang values('KH13',N'Trần Hoàng Anh',N'45 Nguyễn Cảnh Chân, Q1, TpHCM','938666266','1981/06/12','2020/05/08',5860000,580)
insert into khachhang values('KH14',N'Trần Minh Quý',N'50 Lê Đại Hành, Q10, Hà Nội','917888476','1966/09/03','2020/02/10',450000,45)
insert into khachhang values('KH15',N'Lê Nhật Anh',N'34/8/7/9 Trương Định, Q3, TpHCM','84258108','1951/03/10','2020/10/28',31000,3)
insert into khachhang values('KH16',N'Lê Hoài ',N'227/45 Nguyễn Văn Cừ, Q5, Hà Nội','8678938','1982/12/31','2020/11/24',1015000,101)
insert into khachhang values('KH17',N'Nguyễn Văn Bình',N'33Trần Bình Trọng, Q5, TpHCM','916333565','1975/06/04','2020/01/12',45500,4)
insert into khachhang values('KH18',N'Phan Thị Thúy',N'45/9 An Dương Vương, Q1, Hà Nội','938444756','1975/10/01','2020/12/13',550000,55)
insert into khachhang values('KH19',N'Lê Hà Nam',N'85/9 Lê Hồng Phong, Q5, TpHCM','84589763','1980/03/09','2021/01/14',80000,8)
insert into khachhang values('KH20',N'Hà Duy KHoa',N'34/8 Nguyễn Trãi, Q1, Hà Nội','83254904','1985/02/05','2021/01/16',675000,67)
 
-------------------------------
-- NHANVIEN

insert into nhanvien values('NV01',N'Nguyễn Minh Nhựt','123 Sư Vạn Hạnh, Q1','927345678','1970/3/4','2019/04/13',5000000,'CN1')
insert into nhanvien values('NV02',N'Lê Thị Yến','55/27 Nguyễn TRãi, Q5','987567390','1980/5/6','2019/04/21',6000000,'CN2')
insert into nhanvien values('NV03',N'Nguyễn Văn Bình','67/2 Trần Nhân Tông','997047382','1990/7/8','2019/04/8',5400000,'CN1')
insert into nhanvien values('NV04',N'Ngô Thanh Tuấn','77 Nguyễn Văn Cừ','913758498','2000/9/5','2019/06/20',10000000,'CN2')
insert into nhanvien values('NV05',N'Nguyễn Thị Trúc','68/5 Trần Hưng Đạo','918590387','2000/9/9','2019/07/20',6000000,'CN1')
 
-------------------------------
-- SANPHAM
insert into sanpham values('BC01',N'Bút chì',N'cây','Singapore',3000)
insert into sanpham values('BC02',N'Bút chì',N'cây','Singapore',5000)
insert into sanpham values('BC03',N'Bút chì',N'cây',N'Việt Nam',3500)
insert into sanpham values('BC04',N'Bút chì',N'hộp',N'Việt Nam',30000)
insert into sanpham values('BB01',N'Bút bi',N'cây',N'Việt Nam',5000)
insert into sanpham values('BB02',N'Bút bi',N'cây',N'Hàn Quốc',7000)
insert into sanpham values('BB03',N'Bút bi',N'hộp',N'Thái Lan',100000)
insert into sanpham values('TV01',N'Tập 100 giấy mỏng',N'quyển',N'Hàn Quốc',2500)
insert into sanpham values('TV02',N'Tập 200 giấy mỏng',N'quyển',N'Hàn Quốc',4500)
insert into sanpham values('TV03',N'Tập 100 giấy tốt',N'quyển',N'Việt Nam',3000)
insert into sanpham values('TV04',N'Tập 200 giấy tốt',N'quyển',N'Việt Nam',5500)
insert into sanpham values('TV05',N'Tập 100 trang','chuc',N'Việt Nam',23000)
insert into sanpham values('TV06',N'Tập 200 trang','chuc',N'Việt Nam',53000)
insert into sanpham values('TV07',N'Tập 100 trang','chuc',N'Hàn Quốc',34000)
insert into sanpham values('ST01',N'Sổ tay 500 trang',N'quyển',N'Hàn Quốc',40000)
insert into sanpham values('ST02',N'Sổ tay loai 1',N'quyển',N'Việt Nam',55000)
insert into sanpham values('ST03',N'Sổ tay loai 2',N'quyển',N'Việt Nam',51000)
insert into sanpham values('ST04',N'Sổ tay',N'quyển',N'Thái Lan',55000)
insert into sanpham values('ST05',N'Sổ tay mong',N'quyển',N'Thái Lan',20000)
insert into sanpham values('ST06',N'Phấn viết bảng',N'hộp',N'Việt Nam',5000)
insert into sanpham values('ST07',N'Phấn không bụi',N'hộp',N'Việt Nam',7000)
insert into sanpham values('ST08',N'Lau bảng',N'cái',N'Việt Nam',1000)
insert into sanpham values('ST09',N'Bút lông',N'cây',N'Việt Nam',5000)
insert into sanpham values('ST10',N'Bút lông',N'cây',N'Hàn Quốc',7000)

------------KHO------------------------
insert into KHO values('K1',N'123 Sư Vạn Hạnh, Q10','CN1')
insert into KHO values('K2',N'43 Nguyễn Văn Cừ, Q5','CN1')
insert into KHO values('K3',N'65 Hai Bà Trưng, Q.Hoàn Kiếm','CN2')
insert into KHO values('K4',N'81 Thanh Xuân, Q5','CN2')


----------KHO-SP-----------------------------
INSERT INTO KHO_SP VALUES ('K1','BC01',100)
INSERT INTO KHO_SP VALUES ('K1','BC02',100)
INSERT INTO KHO_SP VALUES ('K1','BC03',100)
INSERT INTO KHO_SP VALUES ('K1','BC04',100)
INSERT INTO KHO_SP VALUES ('K1','BB01',100)
INSERT INTO KHO_SP VALUES ('K1','BB02',100)
INSERT INTO KHO_SP VALUES ('K1','BB03',100)
INSERT INTO KHO_SP VALUES ('K1','TV01',100)
INSERT INTO KHO_SP VALUES ('K1','TV02',100)
INSERT INTO KHO_SP VALUES ('K1','TV03',100)
INSERT INTO KHO_SP VALUES ('K1','TV04',100)
INSERT INTO KHO_SP VALUES ('K1','TV05',100)
INSERT INTO KHO_SP VALUES ('K1','TV06',100)
INSERT INTO KHO_SP VALUES ('K1','TV07',100)

insert into KHO_SP values('K2','ST01',200)
insert into KHO_SP values('K2','ST02',200)
insert into KHO_SP values('K2','ST03',200)
insert into KHO_SP values('K2','ST04',200)
insert into KHO_SP values('K2','ST05',200)
insert into KHO_SP values('K2','ST06',200)
insert into KHO_SP values('K2','ST07',200)
insert into KHO_SP values('K2','ST08',200)
insert into KHO_SP values('K2','ST09',200)
insert into KHO_SP values('K2','ST10',200)

INSERT INTO KHO_SP VALUES ('K4','BC01',100)
INSERT INTO KHO_SP VALUES ('K4','BC02',100)
INSERT INTO KHO_SP VALUES ('K4','BC03',100)
INSERT INTO KHO_SP VALUES ('K4','BC04',100)
INSERT INTO KHO_SP VALUES ('K4','BB01',100)
INSERT INTO KHO_SP VALUES ('K4','BB02',100)
INSERT INTO KHO_SP VALUES ('K4','BB03',100)
INSERT INTO KHO_SP VALUES ('K4','TV01',100)
INSERT INTO KHO_SP VALUES ('K4','TV02',100)
INSERT INTO KHO_SP VALUES ('K4','TV03',100)
INSERT INTO KHO_SP VALUES ('K4','TV04',100)
INSERT INTO KHO_SP VALUES ('K4','TV05',100)
INSERT INTO KHO_SP VALUES ('K4','TV06',100)
INSERT INTO KHO_SP VALUES ('K4','TV07',100)

insert into KHO_SP values('K3','ST01',200)
insert into KHO_SP values('K3','ST02',200)
insert into KHO_SP values('K3','ST03',200)
insert into KHO_SP values('K3','ST04',200)
insert into KHO_SP values('K3','ST05',200)
insert into KHO_SP values('K3','ST06',200)
insert into KHO_SP values('K3','ST07',200)
insert into KHO_SP values('K3','ST08',200)
insert into KHO_SP values('K3','ST09',200)
insert into KHO_SP values('K3','ST10',200)

-------------------------------
-- HOADON
insert into HOADON values(1001,'2019/07/23','KH01','NV01',320000, 'CN1')
insert into HOADON values(1002,'2019/12/08','KH01','NV02',840000,'CN1')
insert into HOADON values(1003,'2019/3/08','KH02','NV01',100000,'CN1')
insert into HOADON values(1004,'2019/01/09','KH02','NV01',180000,'CN1')
insert into HOADON values(1005,'2019/2/10','KH01','NV02',3800000,'CN1')
insert into HOADON values(1006,'2019/10/16','KH01','NV03',2430000,'CN1')
insert into HOADON values(1007,'2019/10/28','KH03','NV03',510000,'CN1')
insert into HOADON values(1008,'2019/10/28','KH01','NV03',440000,'CN1')
insert into HOADON values(1009,'2019/10/28','KH03','NV04',200000,'CN1')
insert into HOADON values(1010,'2019/11/01','KH01','NV01',5200000,'CN1')
insert into HOADON values(1011,'2019/11/04','KH04','NV03',250000,'CN1')
insert into HOADON values(1012,'2019/11/30','KH05','NV03',21000,'CN2')
insert into HOADON values(1013,'2019/12/12','KH06','NV01',5000,'CN2')
insert into HOADON values(1014,'2019/12/31','KH03','NV02',3150000,'CN2')
insert into HOADON values(1015,'2020/01/01','KH06','NV01',910000,'CN2')
insert into HOADON values(1016,'2020/01/01','KH07','NV02',12500,'CN2')
insert into HOADON values(1017,'2020/01/02','KH08','NV03',35000,'CN2')
insert into HOADON values(1018,'2020/01/13','KH08','NV03',330000,'CN2')
insert into HOADON values(1019,'2020/01/13','KH01','NV03',30000,'CN2')
insert into HOADON values(1020,'2020/4/1','KH09','NV04',70000,'CN2')
insert into HOADON values(1021,'2020/4/16','KH10','NV03',67500,'CN2')
insert into HOADON values(1022,'2020/4/15',Null,'NV03',7000,'CN2')
insert into HOADON values(1023,'2020/4/18',Null,'NV01',330000,'CN2')
insert into HOADON values(1024,'2020/4/20','KH10','NV02',67500,'CN2')
insert into HOADON values(1025,'2020/5/8','KH02','NV02',70500,'CN2')

insert into HOADON values(1026,'2019/07/23','KH11','NV01',320000, 'CN1')
insert into HOADON values(1027,'2019/12/08','KH12','NV02',840000,'CN1')
insert into HOADON values(1028,'2019/3/08','KH13','NV01',100000,'CN1')
insert into HOADON values(1029,'2019/01/09','KH14','NV01',180000,'CN1')
insert into HOADON values(1030,'2019/2/10','KH15','NV02',3800000,'CN1')
insert into HOADON values(1031,'2019/10/16','KH16','NV03',2430000,'CN1')
insert into HOADON values(1032,'2019/10/28','KH17','NV03',510000,'CN1')
insert into HOADON values(1033,'2019/10/28','KH18','NV03',440000,'CN1')
insert into HOADON values(1034,'2019/10/28','KH19','NV04',200000,'CN1')
insert into HOADON values(1035,'2019/11/01','KH20','NV01',5200000,'CN1')
insert into HOADON values(1036,'2019/11/04','KH11','NV03',250000,'CN1')
insert into HOADON values(1037,'2019/11/30','KH12','NV03',21000,'CN2')
insert into HOADON values(1038,'2019/12/12','KH13','NV01',5000,'CN2')
insert into HOADON values(1039,'2019/12/31','KH14','NV02',3150000,'CN2')
insert into HOADON values(1040,'2020/01/01','KH15','NV01',910000,'CN2')
insert into HOADON values(1041,'2020/01/01','KH16','NV02',12500,'CN2')
insert into HOADON values(1042,'2020/01/02','KH17','NV03',35000,'CN2')
insert into HOADON values(1043,'2020/01/13','KH18','NV03',330000,'CN2')
insert into HOADON values(1044,'2020/01/13','KH19','NV03',30000,'CN2')
insert into HOADON values(1045,'2020/4/1','KH20','NV04',70000,'CN2')
insert into HOADON values(1046,'2020/4/16','KH20','NV03',67500,'CN2')
insert into HOADON values(1047,'2020/4/15',Null,'NV03',7000,'CN2')
insert into HOADON values(1048,'2020/4/18',Null,'NV01',330000,'CN2')
insert into HOADON values(1049,'2020/4/20','KH15','NV02',67500,'CN2')
insert into HOADON values(1050,'2020/5/8','KH12','NV02',70500,'CN2')


-------------------------------
-- CTHD
insert into cthd values(1001,'TV02',4500,10)
insert into cthd values(1001,'ST01',40000,5)
insert into cthd values(1001,'BC01',3000,5)
insert into cthd values(1001,'BC02',5000,10)
insert into cthd values(1001,'ST08',1000,10)
insert into cthd values(1002,'BC04',30000,20)
insert into cthd values(1002,'BB01',5000,20)
insert into cthd values(1002,'BB02',7000,20)
insert into cthd values(1003,'BB03',100000,10)
insert into cthd values(1004,'TV01',2500,20)
insert into cthd values(1004,'TV02',4500,10)
insert into cthd values(1004,'TV03',3000,10)
insert into cthd values(1004,'TV04',5500,10)
insert into cthd values(1005,'TV05',23000,50)
insert into cthd values(1005,'TV06',53000,50)
insert into cthd values(1006,'TV07',34000,20)
insert into cthd values(1006,'ST01',40000,30)
insert into cthd values(1006,'ST02',55000,10)
insert into cthd values(1007,'ST03',51000,10)
insert into cthd values(1008,'ST04',55000,8)
insert into cthd values(1009,'ST05',20000,10)
insert into cthd values(1010,'TV07',34000,50)
insert into cthd values(1010,'ST07',7000,50)
insert into cthd values(1010,'ST08',1000,100)
insert into cthd values(1010,'ST04',55000,50)
insert into cthd values(1010,'TV03',3000,100)
insert into cthd values(1011,'ST06',5000,50)
insert into cthd values(1012,'ST07',7000,3)
insert into cthd values(1013,'ST08',1000,5)
insert into cthd values(1014,'BC02',5000,80)
insert into cthd values(1014,'BB02',7000,100)
insert into cthd values(1014,'BC04',30000,60)
insert into cthd values(1014,'BB01',5000,50)
insert into cthd values(1015,'BB02',7000,30)
insert into cthd values(1015,'BB03',100000,7)
insert into cthd values(1016,'TV01',2500,5)
insert into cthd values(1017,'TV02',4500,1)
insert into cthd values(1017,'TV03',3000,1)
insert into cthd values(1017,'TV04',5500,5)
insert into cthd values(1018,'ST04',55000,6)
insert into cthd values(1019,'ST05',20000,1)
insert into cthd values(1019,'ST06',5000,2)
insert into cthd values(1020,'ST07',7000,10)
insert into cthd values(1021,'ST08',1000,5)
insert into cthd values(1021,'TV01',2500,7)
insert into cthd values(1021,'TV02',4500,10)
insert into cthd values(1022,'ST07',7000,1)
insert into cthd values(1023,'ST04',55000,6)
insert into cthd values(1023,'ST05',20000,6)
insert into cthd values(1024,'ST05',20000,7)
insert into cthd values(1024,'ST07',7000,8)
insert into cthd values(1024,'ST08',1000,9)
insert into cthd values(1025,'ST03',51000,3)
insert into cthd values(1025,'ST04',55000,2)
insert into cthd values(1025,'ST08',1000,4)
insert into cthd values(1025,'TV02',4500,8)

insert into cthd values(1026,'TV02',4500,10)
insert into cthd values(1026,'ST01',40000,5)
insert into cthd values(1026,'BC01',3000,5)
insert into cthd values(1026,'BC02',5000,10)
insert into cthd values(1026,'ST08',1000,10)
insert into cthd values(1027,'BC04',30000,20)
insert into cthd values(1027,'BB01',5000,20)
insert into cthd values(1027,'BB02',7000,20)
insert into cthd values(1028,'BB03',100000,10)
insert into cthd values(1029,'TV01',2500,20)
insert into cthd values(1029,'TV02',4500,10)
insert into cthd values(1029,'TV03',3000,10)
insert into cthd values(1029,'TV04',5500,10)
insert into cthd values(1030,'TV05',23000,50)
insert into cthd values(1030,'TV06',53000,50)
insert into cthd values(1031,'TV07',34000,20)
insert into cthd values(1031,'ST01',40000,30)
insert into cthd values(1031,'ST02',55000,10)
insert into cthd values(1032,'ST03',51000,10)
insert into cthd values(1033,'ST04',55000,8)
insert into cthd values(1034,'ST05',20000,10)
insert into cthd values(1035,'TV07',34000,50)
insert into cthd values(1035,'ST07',7000,50)
insert into cthd values(1035,'ST08',1000,100)
insert into cthd values(1035,'ST04',55000,50)
insert into cthd values(1035,'TV03',3000,100)
insert into cthd values(1036,'ST06',5000,50)
insert into cthd values(1037,'ST07',7000,3)
insert into cthd values(1038,'ST08',1000,5)
insert into cthd values(1039,'BC02',5000,80)
insert into cthd values(1039,'BB02',7000,100)
insert into cthd values(1039,'BC04',30000,60)
insert into cthd values(1039,'BB01',5000,50)
insert into cthd values(1040,'BB02',7000,30)
insert into cthd values(1040,'BB03',100000,7)
insert into cthd values(1041,'TV01',2500,5)
insert into cthd values(1042,'TV02',4500,1)
insert into cthd values(1042,'TV03',3000,1)
insert into cthd values(1042,'TV04',5500,5)
insert into cthd values(1043,'ST04',55000,6)
insert into cthd values(1044,'ST05',20000,1)
insert into cthd values(1044,'ST06',5000,2)
insert into cthd values(1045,'ST07',7000,10)
insert into cthd values(1046,'ST08',1000,5)
insert into cthd values(1046,'TV01',2500,7)
insert into cthd values(1046,'TV02',4500,10)
insert into cthd values(1047,'ST07',7000,1)
insert into cthd values(1048,'ST04',55000,6)
insert into cthd values(1048,'ST05',20000,6)
insert into cthd values(1049,'ST05',20000,7)
insert into cthd values(1049,'ST07',7000,8)
insert into cthd values(1049,'ST08',1000,9)
insert into cthd values(1050,'ST03',51000,3)
insert into cthd values(1050,'ST04',55000,2)
insert into cthd values(1050,'ST08',1000,4)
insert into cthd values(1050,'TV02',4500,8)
----------------------------------------------------------

INSERT INTO NHACC VALUES('BOF', 'Blue Office',N'123 Nguyễn Văn Linh, Q7', '028457195', N'Việt Nam')
INSERT INTO NHACC VALUES('ABC', 'ABC Company',N'567 Quốc lộ 12, Hóc Môn', '028741295', N'Việt Nam')
INSERT INTO NHACC VALUES('HH', N'Hồng Hà',N'456 Đường số 4, Long An', '028895695', N'Việt Nam')
INSERT INTO NHACC VALUES('BN', N'Bến Nghé',N'789 Nguyễn Văn Linh, Thủ Đức', '028231195', N'Việt Nam')
INSERT INTO NHACC VALUES('MT', N'Minh Tâm',N'55/2 Nguyễn Trãi, Bình Chánh', '028457854', N'Việt Nam')
INSERT INTO NHACC VALUES('KHPN', N'KHPN',N'52 Nguyễn Trãi, Bình Chánh', '023589746', N'Việt Nam')

-- PHIEUNHAP
set dateformat dmy

insert into PHIEUNHAP values(1,'23/07/2019','BOF','NV01', 'K1')
insert into PHIEUNHAP values(2,'12/08/2019','BOF','NV02','K4')
insert into PHIEUNHAP values(3,'23/08/2019','ABC','NV01','K1')
insert into PHIEUNHAP values(4,'01/09/2019','ABC','NV01','K3')
insert into PHIEUNHAP values(5,'20/10/2019','BOF','NV02','K2')
insert into PHIEUNHAP values(6,'16/10/2019','BOF','NV03','K2')
insert into PHIEUNHAP values(7,'28/10/2019',N'HH','NV03','K2')
insert into PHIEUNHAP values(8,'28/10/2019','BOF','NV03','K3')
insert into PHIEUNHAP values(9,'28/10/2019',N'HH','NV04','K3')
insert into PHIEUNHAP values(10,'01/11/2019','BOF','NV01','K3')
insert into PHIEUNHAP values(11,'04/11/2019',N'HH','NV03','K3')
insert into PHIEUNHAP values(12,'30/11/2019',N'BN','NV03','K1')
insert into PHIEUNHAP values(13,'12/12/2019',N'BN','NV01','K2')
insert into PHIEUNHAP values(14,'31/12/2019',N'HH','NV02','K4')
insert into PHIEUNHAP values(15,'01/01/2020',N'BN','NV01','K2')
insert into PHIEUNHAP values(16,'01/01/2020',N'BN','NV02','K4')
insert into PHIEUNHAP values(17,'02/01/2020',N'MT','NV03','K3')
insert into PHIEUNHAP values(18,'13/01/2020',N'MT','NV03','K2')
insert into PHIEUNHAP values(19,'13/01/2020','BOF','NV03','K1')
insert into PHIEUNHAP values(20,'14/01/2020',N'MT','NV04','K2')
insert into PHIEUNHAP values(21,'16/01/2020','KHPN','NV03','K1')
insert into PHIEUNHAP values(22,'16/01/2020',Null,'NV03','K3')
insert into PHIEUNHAP values(23,'17/01/2020',Null,'NV01','K2')
insert into PHIEUNHAP values(24,'16/01/2020','KHPN','NV02','K3')
insert into PHIEUNHAP values(25,'15/01/2020','ABC','NV02','K4')

--CTPN
insert into CTPN values(1,'TV02',10,5000)
insert into CTPN values(1,'ST01',5,5000)
insert into CTPN values(1,'BC01',5,10000)
insert into CTPN values(1,'BC02',10,15000)
insert into CTPN values(1,'ST08',10,15000)
insert into CTPN values(2,'BC04',20,20000)
insert into CTPN values(2,'BB01',20,30000)
insert into CTPN values(2,'BB02',20,50000)
insert into CTPN values(3,'BB03',10,60000)
insert into CTPN values(4,'TV01',20,35000)
insert into CTPN values(4,'TV02',10,15000)
insert into CTPN values(4,'TV03',10,15000)
insert into CTPN values(4,'TV04',10,30000)
insert into CTPN values(5,'TV05',50,60000)
insert into CTPN values(5,'TV06',50,100000)
insert into CTPN values(6,'TV07',20,200000)
insert into CTPN values(6,'ST01',30,30000)
insert into CTPN values(6,'ST02',10,45000)
insert into CTPN values(7,'ST03',10,75000)
insert into CTPN values(8,'ST04',8,90000)
insert into CTPN values(9,'ST05',10,100000)
insert into CTPN values(10,'TV07',50,60000)
insert into CTPN values(10,'ST07',50,25000)
insert into CTPN values(10,'ST08',100,40000)
insert into CTPN values(10,'ST04',50,45000)
insert into CTPN values(10,'TV03',100,55000)
insert into CTPN values(11,'ST06',50,100000)
insert into CTPN values(12,'ST07',3,40000)
insert into CTPN values(13,'ST08',5,30000)
insert into CTPN values(14,'BC02',80,23000)
insert into CTPN values(14,'BB02',100,36000)
insert into CTPN values(14,'BC04',60,20000)
insert into CTPN values(14,'BB01',50,60000)
insert into CTPN values(15,'BB02',30,50000)
insert into CTPN values(15,'BB03',7,70000)
insert into CTPN values(16,'TV01',5,80000)
insert into CTPN values(17,'TV02',1,55000)
insert into CTPN values(17,'TV03',1,12000)
insert into CTPN values(17,'TV04',5,55000)
insert into CTPN values(18,'ST04',6,100000)
insert into CTPN values(19,'ST05',1,110000)
insert into CTPN values(19,'ST06',2,210000)
insert into CTPN values(20,'ST07',10,60000)
insert into CTPN values(21,'ST08',5,70000)
insert into CTPN values(21,'TV01',7,80000)
insert into CTPN values(21,'TV02',10,90000)
insert into CTPN values(22,'ST07',1,70000)
insert into CTPN values(23,'ST04',6,12000)
insert into CTPN values(23,'ST05',6,25000)
insert into CTPN values(24,'ST05',7,35000)
insert into CTPN values(24,'ST07',8,50000)
insert into CTPN values(24,'ST08',9,70000)
insert into CTPN values(25,'ST03',3,80000)
insert into CTPN values(25,'ST04',2,90000)
insert into CTPN values(25,'ST08',4,30000)
insert into CTPN values(25,'TV02',8,25000)







