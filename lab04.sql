--1. Tạo cơ sở dữ liệu là tên của mình
CREATE DATABASE ANHDUY
USE ANHDUY
GO
--2. Tạo 2 table như trên trong cơ sở dữ liệu vừa tạo với đây đủ ràng buộc về 
--khóa chính và khóa ngoại
create table LOP
(
	MaLop int primary key,
	TenLop varchar(5),
	SiSo int

)

create table SINHVIEN
(
	MaSV int primary key,
	HoTen varchar(50),
	NoiSInh varchar(50),
	MaLop int FOREIGN KEY (MaLop) REFERENCES LOP(MaLop)
)
--3. Thêm 3 dòng dữ liệu vào LOP và SINHVIEN như sau: Thêm 3 dòng dữ 
--liệu vào LOP
INSERT INTO LOP (MaLop,TenLop, SiSo)
VALUES(1,'TH1',1)

INSERT INTO LOP (MaLop,TenLop, SiSo)
VALUES(2,'TH2',1)

INSERT INTO LOP (MaLop,TenLop, SiSo)
VALUES(3,'TH3',1)

insert into SINHVIEN(MaSV, HoTen,NoiSInh,MaLop)
VALUES(1,'A','X',1)

insert into SINHVIEN(MaSV, HoTen,NoiSInh,MaLop)
VALUES(2,'B','X',2)

insert into SINHVIEN(MaSV, HoTen,NoiSInh,MaLop)
VALUES(3,'A','X',3)
--4. Dùng lệnh Begin tran và Commit tran để thêm 2 dòng dữ liệu sau:
Begin tran
	insert into LOP (MaLop,TenLop, SiSo)
	values (4, 'TH4', 4)

	insert into SINHVIEN (MaSV, HoTen,NoiSInh,MaLop)
	values (4, 'A', 'X', 4)
	commit tran

select * from SINHVIEN
select * from LOP
--5. Dùng lệnh Begin tran và Commit tran để thêm 2 dòng dữ liệu sau
BEGIN TRAN
	INSERT INTO LOP (MaLop,TenLop, SiSo)
	values (5, 'TH5', 1)

	insert into SINHVIEN (MaSV, HoTen,NoiSInh,MaLop)
	values (4, 'A', 'X', 5)
	commit tran
--6. Đặt SET XACT_ABORT ON trước khi dùng lệnh Begin tran và Commit 
--tran thực hiện thêm 2 dòng dữ liệu sau 
SET XACT_ABORT ON
BEGIN TRAN
	insert into LOP (MaLop,TenLop, SiSo)
	values (6, 'TH5', 1)

	insert into SINHVIEN (MaSV, HoTen,NoiSInh,MaLop)
	values (4, 'A', 'X', 4)
	commit tran

--7. Dùng lệnh Begin tran và Commit tran để insert và update hai dòng dữ liệu 
--sau: Insert: SINHVIEN(5,D, Z, 4) 
--Update: SiSo của lớp 4 tăng thêm 1 
BEGIN TRAN
	insert into SINHVIEN (MaSV, HoTen,NoiSInh,MaLop)
	values (5, 'D', 'Z', 4)

	UPDATE LOP
	SET SiSo = SiSo +1 
	COMMIT TRAN

select * from SINHVIEN
select * from LOP
--8. Đặt SET XACT_ABORT ON cho câu 7 
SET XACT_ABORT ON
BEGIN TRAN
	BEGIN TRY
		insert into SINHVIEN (MaSV, HoTen,NoiSInh,MaLop)
		values (5, 'D', 'Z', 4)

		UPDATE LOP
		SET SiSo = SiSo +1 
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		DECLARE @ErrorMessage varchar(2000) = 'Loi: ' + ERROR_MESSAGE()
		RAISERROR (@ErrorMessage, 16, 1)
	END CATCH

--II. XỬ LÝ ĐỒNG THỜI
--Câu 1. Xác định chiến lược sử dụng Lock và Isolation Level. Một số gợi ý sau:
CREATE TABLE Item (id INT, NAME VARCHAR(50))
INSERT INTO Item VALUES(1,'a')
INSERT INTO Item VALUES(2,'b')
INSERT INTO Item VALUES(3,'c')

BEGIN TRAN
	UPDATE Item
	SET name = 'x'
	WHERE id>2
	WAITFOR DELAY '00:00:10' --wait for 10 seconds
	ROLLBACK

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT * FROM Item WITH (NOLOCK)

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SELECT * FROM Item WHERE id>2

BEGIN TRAN
	UPDATE Item
	SET name = 'x'
	WHERE id>2
	WAITFOR DELAY '00:00:10'
	COMMIT

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
INSERT INTO Item SELECT 5,'e'

SELECT * FROM Item
WHERE id>2

BEGIN TRAN
	SELECT * FROM Item
	WAITFOR DELAY '00:00:10'
	SELECT * FROM Item
	COMMIT

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
UPDATE Item
SET name = 'x'
WHERE id>2
SELECT * FROM item

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRAN
	SELECT * FROM Item
	WAITFOR DELAY '00:00:10'

	SELECT * FROM Item
	COMMIT

INSERT INTO Item SELECT 4,'d'


--1. Viết SP thêm 1 hoá đơn và chi tiết hoá đơn vào trong DB với tham số truyền vào 
--tương ứng, sau khi thêm thành công hoá đơn và CTHD thì cập nhật lại số lượng sản 
--phẩm trong kho. (có transaction và xử lý đồng thời
use QLBH
GO

ALTER PROC sp_ThemHoaDon @makh char(10), @manv char(10), @macn char(10)
AS
BEGIN	
	SET XACT_ABORT ON
	BEGIN TRAN
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	SELECT SOHD FROM HOADON WITH (UPDLOCK) ORDER BY SOHD
	BEGIN TRY
		DECLARE @sohd INT = (SELECT TOP 1 SOHD FROM HOADON ORDER BY SOHD DESC)

		WAITFOR DELAY '00:00:10'
		SET @sohd = @sohd + 1

		INSERT INTO HOADON
		VALUES (@sohd, GETDATE(), @makh, @manv, 0, @macn)

	COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		DECLARE @ErrorMessage varchar(2000) = 'Loi: ' + ERROR_MESSAGE()
		RAISERROR (@ErrorMessage, 16, 1)
	END CATCH
END

EXEC sp_ThemHoaDon 'KH12', 'NV03', 'CN2'

ALTER PROC sp_ThemCTHD @sohd char(10), @masp char(10), @soluong int
AS
BEGIN
	SET XACT_ABORT ON
	BEGIN TRAN
	BEGIN TRY
		--lay don gia tu bang san phamr
		DECLARE @dongia money
		select @dongia = GIABAN from SANPHAM where MASP = @masp

		--them 1 cthd moi
		INSERT INTO CTHD
		VALUES (@sohd, @masp, @dongia, @soluong)

		--cap nhat tong tri gia cua HOADON
		UPDATE HOADON
		SET TONGTRIGIA = TONGTRIGIA + (@soluong * @dongia)
		WHERE SOHD = @sohd

		--cap nhat lai soluong sp trong kho
		--lay ra cac kho co chua san pham
		DECLARE @makho char(4)
		SET @makho = (SELECT TOP 1 MAKHO FROM KHO_SP
						WHERE MASP = @masp AND SOLUONGTON >= @soluong)
		UPDATE KHO_SP
		SET SOLUONGTON = SOLUONGTON - @soluong
		WHERE MAKHO = @makho AND MASP = @masp

	COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		DECLARE @ErrorMessage varchar(2000) = 'Lỗi' + ERROR_MESSAGE()
		RAISERROR(@ErrorMessage, 16, 1)
	END CATCH
END
drop TRIGGER [dbo].[tr_DatHang]
EXEC sp_ThemCTHD 1050, 'BC01', 10

--2. Viết SP thêm 1 Phiếu nhập và chi tiết phiếu nhập vào trong DB với tham số truyền 
--vào tương ứng, sau khi thêm thành công phiếu nhập và CTPN thì cập nhật lại số 
--lượng sản phẩm trong kho. (có transaction và xử lý đồng thời)
CREATE PROC sp_ThemPhieuNhap @mancc char(8), @manv char(10), @makho char(4)
AS
BEGIN
	SET XACT_ABORT ON
	BEGIN TRAN
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	SELECT MAPN FROM PHIEUNHAP WITH (UPDLOCK) ORDER BY MAPN
	BEGIN TRY
		DECLARE @mapn int = (select top 1 MAPN from PHIEUNHAP order by MAPN desc)
		SET @mapn = @mapn + 1
		INSERT INTO PHIEUNHAP SELECT @mapn, GETDATE(), @mancc, @manv, @makho
	COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		DECLARE @ErrorMessage varchar(2000) = 'Loi: ' + ERROR_MESSAGE()
		RAISERROR (@ErrorMessage, 16, 1)
	END CATCH
END

-------------------
EXEC sp_ThemPhieuNhap 'MT', 'NV04', 'K2'

ALTER PROC sp_ThemCTPN @mapn int, @masp char(10), @soluong int
AS
BEGIN
	SET XACT_ABORT ON
	BEGIN TRAN
	BEGIN TRY
		--lay don gia tu bang san phamr
		DECLARE @dongia money
		select @dongia = GIABAN from SANPHAM where MASP = @masp

		DECLARE @dongianhap money = @dongia * @soluong
		INSERT INTO CTPN VALUES(@mapn, @masp, @soluong, @dongianhap)

		DECLARE @makho char(4)
		SET @makho = (SELECT TOP 1 MAKHO FROM KHO_SP
						WHERE MASP = @masp ORDER BY SOLUONGTON ASC)
		UPDATE KHO_SP
		SET SOLUONGTON = SOLUONGTON + @soluong
		WHERE MAKHO = @makho AND MASP = @masp
	COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		DECLARE @ErrorMessage varchar(2000) = 'Loi: ' + ERROR_MESSAGE()
		RAISERROR (@ErrorMessage, 16, 1)
	END CATCH
END

EXEC sp_ThemCTPN 30, 'ST02', 10
EXEC sp_ThemCTPN 29, 'ST02', 20

--3. Viết SP xoá 1 hoá đơn và chi tiết hoá đơn vào trong DB với tham số truyền vào 
--tương ứng, sau khi thêm thành công hoá đơn và CTHD thì cập nhật lại số lượng sản 
--phẩm trong kho. (có transaction và xử lý đồng thời
ALTER PROC sp_XoaHoaDon @sohd int
AS
BEGIN
	SET XACT_ABORT ON
	BEGIN TRAN
	BEGIN TRY
		DELETE FROM HOADON WHERE SOHD = @sohd
	COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		DECLARE @ErrorMessage varchar(2000) = 'Loi: ' + ERROR_MESSAGE()
		RAISERROR (@ErrorMessage, 16, 1)
	END CATCH
END

exec sp_XoaHoaDon 1
----------------------------
ALTER PROC sp_XoaCTHD @sohd int, @masp char(10)
AS
BEGIN
	SET XACT_ABORT ON
	BEGIN TRAN
	BEGIN TRY
		DECLARE @soluong int = (select SOLUONG from CTHD where SOHD = @sohd and MASP = @masp)
		declare @dongia money = (select DONGIA from CTHD where SOHD = @sohd and MASP = @masp)
		update HOADON
		set TONGTRIGIA = TONGTRIGIA - (@soluong * @dongia)
		WHERE SOHD = @sohd

		DECLARE @makho char(4)
		SET @makho = (SELECT TOP 1 MAKHO FROM KHO_SP
						WHERE MASP = @masp)
		UPDATE KHO_SP
		SET SOLUONGTON = SOLUONGTON + @soluong
		WHERE MAKHO = @makho AND MASP = @masp
		DELETE FROM CTHD WHERE SOHD = @sohd and MASP = @masp
	COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		DECLARE @ErrorMessage varchar(2000) = N'Lỗi: ' + ERROR_MESSAGE()
		RAISERROR (@ErrorMessage, 16, 1)
	END CATCH
END
select* from KHO_SP where MASP = 'ST01'
exec sp_XoaCTHD 1001, 'ST01'

--4. Viết SP xoá 1 Phiếu nhập và chi tiết phiếu nhập vào trong DB với tham số truyền 
--vào tương ứng, sau khi thêm thành công phiếu nhập và CTPN thì cập nhật lại số 
--lượng sản phẩm trong kho. (có transaction và xử lý đồng thời)
CREATE PROC sp_XoaPhieuNhap @mapn int
AS
BEGIN
	BEGIN TRAN
	BEGIN TRY
		DELETE FROM PHIEUNHAP WHERE MAPN = @mapn
	COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		DECLARE @ErrorMessage varchar(2000) = N'Lỗi: ' + ERROR_MESSAGE()
		RAISERROR (@ErrorMessage, 16, 1)
	END CATCH
END

EXEC sp_XoaPhieuNhap 30

CREATE PROC sp_XoaCTPN @mapn int, @masp char(10)
AS
BEGIN
	BEGIN TRAN
	BEGIN TRY
		DECLARE @soluong int = (select SOLUONG FROM CTPN WHERE MAPN = @mapn AND MASP = @masp )
		DECLARE @makho char(4)
		SET @makho = (SELECT TOP 1 MAKHO FROM KHO_SP
						WHERE MASP = @masp ORDER BY SOLUONGTON ASC)
		UPDATE KHO_SP
		SET SOLUONGTON = SOLUONGTON - @soluong
		WHERE MAKHO = @makho AND MASP = @masp
		DELETE FROM CTPN WHERE MAPN = @mapn AND MASP = @masp
	COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		DECLARE @ErrorMessage varchar(2000) = 'Lỗi: ' + ERROR_MESSAGE()
		RAISERROR (@ErrorMessage, 16, 1)
	END CATCH
END
exec sp_XoaCTPN 30, 'ST02'
select* from KHO_SP where MASP = 'ST02'

--5. Viết SP cập nhật 1 hoá đơn và chi tiết hoá đơn vào trong DB với tham số truyền vào 
--tương ứng, sau khi thêm thành công hoá đơn và CTHD thì cập nhật lại số lượng sản 
--phẩm trong kho. (có transaction và xử lý đồng thời
CREATE PROC sp_CapNhatHoaDon @sohd int, @ngay date, @makh char(10), @manv char(10), @macn char(4)
AS
BEGIN
	SET XACT_ABORT ON
	BEGIN TRAN
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	SELECT SOHD FROM HOADON WITH (UPDLOCK) ORDER BY SOHD
	BEGIN TRY
		UPDATE HOADON
		SET NGHD = @ngay, MAKH = @makh, MANV = @manv, MACN = @macn
		WHERE SOHD = @sohd
	COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		DECLARE @ErrorMessage varchar(2000) = 'Lỗi: ' + ERROR_MESSAGE()
		RAISERROR (@ErrorMessage, 16, 1)
	END CATCH
END
--------------------
EXEC sp_CapNhatHoaDon 2, '3/12/2023', 'KH01', 'NV01', 'CN2'
------------------------------
CREATE PROC sp_CapNhatCTHD @sohd int, @masp char(10), @soluongmoi int
AS
BEGIN
	BEGIN TRAN
	BEGIN TRY
		DECLARE @soluongcu int = (select SOLUONG from CTHD where SOHD = @sohd and MASP = @masp)
		update CTHD
		set SOLUONG = @soluongmoi

		DECLARE @makho char(4)
		SET @makho = (SELECT TOP 1 MAKHO FROM KHO_SP
						WHERE MASP = @masp)		
		UPDATE KHO_SP
		SET SOLUONGTON = SOLUONGTON + @soluongcu - @soluongmoi
		WHERE MAKHO = @makho AND MASP = @masp
	COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		DECLARE @ErrorMessage varchar(2000) = 'Lỗi: ' + ERROR_MESSAGE()
		RAISERROR (@ErrorMessage, 16, 1)
	END CATCH
END
--6. Viết SP cập nhật 1 Phiếu nhập và chi tiết phiếu nhập vào trong DB với tham số 
--truyền vào tương ứng, sau khi thêm thành công phiếu nhập và CTPN thì cập nhật lại 
--số lượng sản phẩm trong kho. (có transaction và xử lý đồng thời
CREATE PROC sp_CapNhatPhieuNhap @mapn int, @ngay date, @mancc char(10), @manv char(10), @makho char(4)
AS
BEGIN
	SET XACT_ABORT ON
	BEGIN TRAN
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	SELECT MAPN FROM PHIEUNHAP WITH (UPDLOCK) ORDER BY MAPN
	BEGIN TRY
		UPDATE PHIEUNHAP
		SET NGAYNHAP = @ngay, MANCC = @mancc, MANV = @manv, MAKHO = @makho
		WHERE MAPN = @mapn
	COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		DECLARE @ErrorMessage varchar(2000) = 'Lỗi: ' + ERROR_MESSAGE()
		RAISERROR (@ErrorMessage, 16, 1)
	END CATCH
END

-----------------
CREATE PROC sp_CapNhatCTPN @mapn int, @masp char(10), @soluongmoi int
AS
BEGIN
	SET XACT_ABORT ON
	BEGIN TRAN
	BEGIN TRY
		UPDATE CTPN
		SET SOLUONG = @soluongmoi
		WHERE MAPN = @mapn AND MASP = @masp

		DECLARE @soluongcu int
		SET @soluongcu = (SELECT SOLUONG FROM CTPN WHERE MAPN = @mapn AND MASP = @masp)
		
		DECLARE @makho char(4)
		SET @makho = (SELECT TOP 1 MAKHO FROM KHO_SP
						WHERE MASP = @masp)		
		UPDATE KHO_SP
		SET SOLUONGTON = SOLUONGTON + @soluongcu - @soluongmoi
		WHERE MAKHO = @makho AND MASP = @masp
	COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		DECLARE @ErrorMessage varchar(2000) = 'Lỗi: ' + ERROR_MESSAGE()
		RAISERROR (@ErrorMessage, 16, 1)
	END CATCH
END