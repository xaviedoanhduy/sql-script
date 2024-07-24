--Cau 1: tao bang
CREATE TABLE [dbo].[HOADON_Aditing]
(
	[SOHD] [int],
	[NGHD] [smalldatetime],
	[MAKH] [char](10),
	[MANV] [char](10),
	[TONGTRIGIA] [money],
	[MACN] [char](10),
	AUDIT_TYPE char(1),
	DATE_TIME_STAMP datetime
)

CREATE TABLE [dbo].[CTHD_Auditing]
(
	[SOHD] [int],
	[MASP] [char](4),
	[DONGIA] [money],
	[SOLUONG] [int],
	AUDIT_TYPE char(1),
	DATE_TIME_STAMP datetime
)

CREATE TABLE [dbo].[SANPHAM_Auditing](
	[MASP] [char](4),
	[TENSP] [nvarchar](40),
	[DVT] [nvarchar](20),
	[NUOCSX] [nvarchar](40),
	[GIABAN] [money],
	AUDIT_TYPE char(1),
	DATE_TIME_STAMP datetime
)

SELECT* FROM HOADON

--Cau 2:Viết các Trigger lưu lại việc thêm, xóa, sửa dữ liệu của HOADON, CTHD và SANPHAM
--TRIGGER INSERT TABLE HOADON----------
CREATE TRIGGER trg_Audit_HoaDon_Insert
ON HOADON
AFTER INSERT
AS
	BEGIN
		DECLARE @sohd int, @nghd datetime, @makh char(10), @manv char(10), @tongtg money, @macn char(10)
		select @sohd = SOHD, @nghd = NGHD, @makh = MAKH, @manv = MANV, @tongtg = TONGTRIGIA, @macn = MACN 
		from inserted

		INSERT INTO HOADON_Aditing
		VALUES (@sohd, @nghd, @makh, @manv, @tongtg, @macn, 'I', GETDATE())
	END

----------------------------------------------------------------
insert into HOADON values(1051,'2020/5/8','KH12','NV02',1000,'CN2')
----------------------------------------------------------------
--TRIGGER DELETE TABLE HOADON----------
CREATE TRIGGER trg_Audit_HoaDon_Delete
ON HOADON
AFTER DELETE
AS
	BEGIN
		DECLARE @sohd int, @nghd datetime, @makh char(10), @manv char(10), @tongtg money, @macn char(10)
		select @sohd = SOHD, @nghd = NGHD, @makh = MAKH, @manv = MANV, @tongtg = TONGTRIGIA, @macn = MACN 
		from deleted

		INSERT INTO HOADON_Aditing
		VALUES (@sohd, @nghd, @makh, @manv, @tongtg, @macn, 'D', GETDATE())
	END

--------------------------------------------------------
DELETE FROM HOADON
WHERE SOHD = 1051
----------------------------------------------------------
--TRIGGER UPDATE TABLE HOADON----------
CREATE TRIGGER trg_Audit_HoaDon_Update
ON HOADON
AFTER UPDATE
AS
	BEGIN
		DECLARE @sohd int, @nghd datetime, @makh char(10), @manv char(10), @tongtg money, @macn char(10)
		select @sohd = SOHD, @nghd = NGHD, @makh = MAKH, @manv = MANV, @tongtg = TONGTRIGIA, @macn = MACN 
		from deleted

		INSERT INTO HOADON_Aditing
		VALUES (@sohd, @nghd, @makh, @manv, @tongtg, @macn, 'U', GETDATE())
	END

--------------------------------------------------------
UPDATE HOADON
SET TONGTRIGIA = 200000
WHERE SOHD = 1051
------------------------------------------------------------
----------------------------------------------------------
---TRIGGER UPDATE TABLE CTHD---
CREATE TRIGGER trg_Audit_CTHD_Update
ON CTHD
AFTER UPDATE
AS
	BEGIN
		DECLARE @sohd int, @masp char(10), @dongia money, @soluong int
		SELECT @sohd = SOHD, @masp = MASP, @dongia = DONGIA, @soluong = SOLUONG 
		FROM deleted

		INSERT INTO CTHD_Auditing
		VALUES (@sohd, @masp, @dongia, @soluong, 'U', GETDATE())
	END
-------------------------------------------------------------------
UPDATE CTHD
SET DONGIA = 2000
WHERE SOHD = 2 AND MASP = 'BB01'
-------------------------------------------------------------------
---TRIGGER DELETE TABLE CTHD---
ALTER TRIGGER trg_Audit_CTHD_Delete
ON CTHD
AFTER DELETE
AS
	BEGIN
		DECLARE @sohd int, @masp char(10), @dongia money, @soluong int
		SELECT @sohd = SOHD, @masp = MASP, @dongia = DONGIA, @soluong = SOLUONG 
		FROM deleted

		INSERT INTO CTHD_Auditing
		VALUES (@sohd, @masp, @dongia, @soluong, 'D', GETDATE())
	END
-------------------------------------------------------------------
DELETE
FROM CTHD
WHERE SOHD = 4 AND MASP = 'BB01'
-------------------------------------------------------------------
---TRIGGER INSERT TABLE CTHD---
CREATE TRIGGER trg_Audit_CTHD_Insert
ON CTHD
AFTER INSERT
AS
	BEGIN
		DECLARE @sohd int, @masp char(10), @dongia money, @soluong int
		SELECT @sohd = SOHD, @masp = MASP, @dongia = DONGIA, @soluong = SOLUONG 
		FROM inserted

		INSERT INTO CTHD_Auditing
		VALUES (@sohd, @masp, @dongia, @soluong, 'I', GETDATE())
	END
-------------------------------------------------------------------
INSERT INTO CTHD
VALUES(2, 'BB01', 2000, 10)
-------------------------------------------------------------------
----------------------------------------------------------
---TRIGGER INSERT TABLE SANPHAM---
CREATE TRIGGER trg_Audit_SanPham_Insert
ON SANPHAM
AFTER INSERT
AS
	BEGIN
		DECLARE @masp char(4), @tensp nvarchar(40), @dvt nvarchar(20),
				@nuocsx nvarchar(40), @giaban money

		SELECT @masp = MASP, @tensp = TENSP, @dvt = DVT, @nuocsx = NUOCSX, @giaban = GIABAN
		FROM inserted
		
		INSERT INTO SANPHAM_Auditing
		VALUES(@masp, @tensp, @dvt, @nuocsx, @giaban, 'I', GETDATE())
	END
----------------------------------------------------------
INSERT INTO SANPHAM
VALUES ('AD02', 'Thuoc ke', 'cây', 'USA', '3000')
----------------------------------------------------------
---TRIGGER UPDATE TABLE SANPHAM---
CREATE TRIGGER trg_Audit_SanPham_Update
ON SANPHAM
AFTER UPDATE
AS
	BEGIN
		DECLARE @masp char(4), @tensp nvarchar(40), @dvt nvarchar(20),
				@nuocsx nvarchar(40), @giaban money

		SELECT @masp = MASP, @tensp = TENSP, @dvt = DVT, @nuocsx = NUOCSX, @giaban = GIABAN
		FROM deleted
		
		INSERT INTO SANPHAM_Auditing
		VALUES(@masp, @tensp, @dvt, @nuocsx, @giaban, 'U', GETDATE())
	END
----------------------------------------------------------
UPDATE SANPHAM
SET TENSP = 'But may'
where MASP = 'AD01'
----------------------------------------------------------
---TRIGGER DELETE TABLE SANPHAM---
CREATE TRIGGER trg_Audit_SanPham_Delete
ON SANPHAM
AFTER DELETE
AS
	BEGIN
		DECLARE @masp char(4), @tensp nvarchar(40), @dvt nvarchar(20),
				@nuocsx nvarchar(40), @giaban money

		SELECT @masp = MASP, @tensp = TENSP, @dvt = DVT, @nuocsx = NUOCSX, @giaban = GIABAN
		FROM deleted
		
		INSERT INTO SANPHAM_Auditing
		VALUES(@masp, @tensp, @dvt, @nuocsx, @giaban, 'D', GETDATE())
	END
----------------------------------------------------------
DELETE
FROM SANPHAM
WHERE MASP = 'AD02'
----------------------------------------------------------

--Cau 3: Viết Trigger để khi người dùng đặt hàng hãy tự động cập nhật số lượng tồn trong 
--bảng Sản phẩm
CREATE TRIGGER tr_DatHang
ON CTHD
AFTER INSERT
AS
	BEGIN
		DECLARE @soluongdat int = (select SOLUONG from inserted)

		UPDATE KHO_SP
		SET SOLUONGTON = SOLUONGTON - @soluongdat
		WHERE KHO_SP.MASP = (SELECT MASP FROM inserted)
	END
--------------------------------------------------
INSERT INTO CTHD
VALUES (3, 'ST01', 1000, 15)
--------------------------------------------------
CREATE TRIGGER trg_XoaHang
ON CTHD
AFTER DELETE 
AS
	BEGIN
		DECLARE @soluongdat int = (select SOLUONG from deleted)
		UPDATE KHO_SP
		SET SOLUONGTON = SOLUONGTON + @soluongdat
		WHERE KHO_SP.MASP = (SELECT MASP FROM deleted)
	END
--------------------------------------------------
DELETE
FROM CTHD
WHERE SOHD = 3 AND MASP ='BB02'
--------------------------------------------------
CREATE TRIGGER trg_SuaHang
ON CTHD
AFTER UPDATE 
AS
	BEGIN
		DECLARE @soluongdat_old int = (select SOLUONG from deleted)
		DECLARE @soluongdat_new int = (select SOLUONG from inserted)

		UPDATE KHO_SP
		SET SOLUONGTON = SOLUONGTON + @soluongdat_old - @soluongdat_new
		WHERE KHO_SP.MASP = (SELECT MASP FROM deleted)
	END
--------------------------------------------------
UPDATE CTHD
SET SOLUONG = 11
WHERE SOHD = 3 AND MASP ='BB02'
--------------------------------------------------

--Cau 4: Tương tự câu 3, viết Trigger để khi nhập hàng thì tự động cập nhật số lượng tồn trong bảng sản phẩm
CREATE TRIGGER tr_NhapHang
ON CTPN
AFTER INSERT
AS
	BEGIN
		DECLARE @soluongnhap int = (select SOLUONG from inserted)

		UPDATE KHO_SP
		SET SOLUONGTON = SOLUONGTON + @soluongnhap
		WHERE KHO_SP.MASP = (SELECT MASP FROM inserted)
	END
--------------------------------------------------
INSERT INTO CTPN
VALUES (28, 'ST03', 50, 20000)
--------------------------------------------------
--5. Viết trigger kiểm tra, ngày đăng ký phải luôn > ngày sinh ít nhất 20 năm
ALTER TRIGGER tr_KiemTraNgay
ON KHACHHANG
AFTER INSERT, UPDATE
AS
	BEGIN
		DECLARE @nam int
		set @nam = (select year(NGAYDK) - year(NGAYSINH) from inserted)
		if @nam < 20
			begin
				print 'ngày đăng ký phải luôn > ngày sinh ít nhất 20 năm'
				rollback transaction
			end
		else
			print 'Them thanh cong'
	END
-------------------------------------
SELECT* FROM KHACHHANG where MAKH = 'KH21'

INSERT INTO KHACHHANG
VALUES ('KH21', 'Do Anh Duy', '58 Phan Chu Trinh, CuJut, Dak Nong', '0123123122','2001/11/14', '2022/12/10',120000, 1333)

update KHACHHANG
set NGAYDK = '2023/12/10'
where MAKH = 'KH21'

delete from KHACHHANG
where MAKH = 'KH21'
