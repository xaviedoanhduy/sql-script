select*
from NHANVIEN
select*
from CHINHANH

ALTER PROC sp_TimThongTinNV @manv CHAR(10)
AS
	IF EXISTS (SELECT* FROM NHANVIEN WHERE MANV = @manv)
		SELECT*
		FROM NHANVIEN
		WHERE MANV = @manv
	ELSE 
		PRINT 'KHONG TON TAI MA NHAN VIEN'

EXEC sp_TimThongTinNV 'NV06'


--1. Vi?t 1 Stored Procedure tìm thông tin nhân viên trên 2 chi nhánh d?a vào @manv ???c 
--truy?n vào 
CREATE PROC sp_TimThongTinNV @manv CHAR(10)
AS
	IF EXISTS (SELECT* FROM NHANVIEN WHERE MANV = @manv)
		SELECT*
		FROM NHANVIEN
		WHERE MANV = @manv
	ELSE 
		PRINT 'KHONG TON TAI MA NHAN VIEN'

EXEC sp_TimThongTinNV 'NV06'
EXEC sp_TimThongTinNV 'NV02'
--2. Vi?t 1 Stored Procedure ?? in ra các hoá ??n do nhân viên có mã s? @manv ?ã l?p trong 
--ngày @ngay. K?t xu?t: 
-- S? phi?u Ngay HotenNV Tr?Gia 

ALTER PROC sp_InRaHDDonDoNV @manv CHAR(10), @ngay datetime
AS
	BEGIN
		IF EXISTS (SELECT* FROM HOADON WHERE MANV = @manv)
			SELECT HD.NGHD, NV.HOTEN, HD.TONGTRIGIA
			FROM HOADON HD, NHANVIEN NV
			WHERE NV.MANV = HD.MANV AND HD.MANV = @manv
			AND HD.NGHD = @ngay
		ELSE
			PRINT'KHONG TON TAI MA NHAN VIEN'
	END

EXEC sp_InRaHDDonDoNV 'NV01', '2019-07-23 00:00:00'
--3. Vi?t 1 Stored Procedure ?? xóa các phi?u nh?p do nhân viên có mã s? @manv ?ã l?p 
--trong ngày @ngay.

alter proc sp_XoaPN @manv CHAR(10), @ngay datetime
as
	begin
		if exists (select* from PHIEUNHAP where MANV = @manv)
			if exists (select* from PHIEUNHAP where NGAYNHAP = @ngay)
				delete
				from PHIEUNHAP
				where MANV = @manv and NGAYNHAP = @ngay
			else
				print 'ngay nhap khong ton tai'
		else
			print 'Khong ton tai ma nhan vien'
	end

exec sp_XoaPN 'NV05', '2023-12-12'
exec sp_XoaPN 'NV02', '2019-08-12'
insert into PHIEUNHAP values(26, '2023-12-12', 'ABC' ,'NV05', 'K1')
SELECT* FROM PHIEUNHAP 
SELECT* FROM CTPN
select* from NHANVIEN
--4. Viết 1 Stored Procedure tên ThongTin_Phieu để liệt kê các sản phẩm thuộc 1 phiếu nhập 
--có số phiếu là @SoPhieu. Kết xuất gồm các cột: 
--Tên SP - Số lượng - Đơn giá - Ngày - Mã phiếu - Họ tên NV 
select* from PHIEUNHAP
select* from CTPN
alter PROC sp_ThongTin_Phieu @sophieu int
as
	begin
		if exists (select* from  PHIEUNHAP where MAPN = @sophieu)
			begin
				select sp.TENSP, ct.SOLUONG, ct.DONGIANHAP, pn.NGAYNHAP, pn.MAPN, nv.HOTEN
				from (select * from CTPN) ct join (select NGAYNHAP, MANV, MAPN from PHIEUNHAP) pn
					on ct.MAPN = pn.MAPN join (select MASP, TENSP from SANPHAM) sp on sp.MASP = ct.MASP
					join (select* from NHANVIEN) nv on nv.MANV = pn.MANV
				where pn.MAPN = @sophieu
			end
		else
			print 'Khong ton tai phieu nhap'
	end

exec sp_ThongTin_Phieu 1
exec sp_ThongTin_Phieu 100
--5. Viết 1 SP update họ tên nhân viên dựa vào @manv 
create proc sp_UpdateNhanVien @manv varchar(4), @hoten nvarchar(20)
as
	begin
		update NHANVIEN
		set HOTEN = @hoten
		where MANV = @manv
	end

--------------------
select*
from NHANVIEN
exec sp_UpdateNhanVien 'NV01', N'Đỗ Anh Duy'
--6. Viết SP tính doanh thu (trị giá của hoá đơn) theo từng tháng của 2 chi nhánh. Kết xuất: 
--(Tên CN Tháng Năm DoanhThu) 
create proc sp_DoanhThu 
as
	begin
		select cn.TENCN, month(hd.NGHD) as thang,YEAR(hd.NGHD) as nam, sum(hd.tongtrigia) as doanhthu
		from CHINHANH cn, HOADON hd
		where cn.MACN = hd.MACN
		group by month(hd.NGHD), YEAR(hd.NGHD), hd.MACN, cn.TENCN
	end
--------------------
select* from HOADON
exec sp_DoanhThu  
--7. Viết SP thêm 1 hoá đơn và chi tiết hoá đơn vào trong DB với tham số truyền vào tương 
--ứng, sau khi thêm thành công hoá đơn và CTHD thì cập nhật lại số lượng sản phẩm trong 
--kho. 
alter proc sp_UpdateWareHouse @nghd date, @makh varchar(10),
@manv varchar(10), @macn varchar(5), @masp varchar(10), @soluong int
as
	begin
		declare @sohd int
		set @sohd = 1
		while exists (select* from HOADON where SOHD = @sohd)
			set @sohd = @sohd + 1

		declare @tongtrigia money
		select @tongtrigia = @soluong*GIABAN
		from SANPHAM
		where MASP = @masp

		insert into HOADON (SOHD, NGHD, MAKH, MANV, TONGTRIGIA, MACN) 
		values (@sohd, @nghd, @makh, @manv, @tongtrigia, @macn)

		declare @dongia money
		select @dongia = GIABAN
		from SANPHAM
		where MASP = @masp
		insert into CTHD (SOHD, MASP, DONGIA, SOLUONG)
		values (@sohd, @masp, @dongia, @soluong)
		
		update KHO_SP
		set SOLUONGTON = SOLUONGTON - @soluong
		where MASP = @masp
	end
--------------------
exec sp_UpdateWareHouse '11/22/2023', 'KH08', 'NV01', 'CN2', 'BB02', 10
select* from SANPHAM
select* from HOADON
select* from CTHD
select* from KHO_SP
--8. Viết SP thêm 1 Phiếu nhập và chi tiết phiếu nhập vào trong DB với tham số truyền vào 
--tương ứng, sau khi thêm thành công phiếu nhập và CTPN thì cập nhật lại số lượng sản 
--phẩm trong kho. 

create proc sp_ThemPNVaCTPN @ngay date, @mancc char(10), @manv char(10), 
@makho char(10), @masp char(10), @soluong int , @dongianhap money
as
	begin
		declare @mapn int
		set @mapn = 1
		while exists (select* from PHIEUNHAP where MAPN = @mapn)
			set @mapn = @mapn + 1
		insert into PHIEUNHAP values (@mapn, @ngay, @mancc, @manv, @makho)
		insert into CTPN values (@mapn, @masp, @soluong, @dongianhap)
		update KHO_SP
		set SOLUONGTON = SOLUONGTON + @soluong
		where MASP = @masp and MAKHO = @makho
	end

exec sp_ThemPNVaCTPN '2022-1-11', 'ABC', 'NV01', 'K3', 'ST01', '20', 50000
select* from PHIEUNHAP
select* from CTPN
select* from KHO_SP
select* from KHO
--9. Viết SP xoá 1 hoá đơn và chi tiết hoá đơn vào trong DB với tham số truyền vào tương 
--ứng, sau khi thêm thành công hoá đơn và CTHD thì cập nhật lại số lượng sản phẩm trong 
--kho. 
select* from HOADON
select* from CTHD
Create proc sp_XoaHDVaCTHD @sohd char(10)
as
	begin
		--tim kho tuong ung chi nhanh trong hoadon
		declare @kho char(10)
		select @kho = kho.MAKHO from KHO kho, CHINHANH cn where cn.MACN = kho.MACN
		--tim ma san pham trong hoadon va kho
		declare @masp char(10)
		select @masp from KHO_SP kh, CTHD ct where ct.MASP = kh.MASP
		--------
		delete from CTHD where SOHD = @sohd
		delete from HOADON where SOHD = @sohd
		declare @sl int
		select @sl = SOLUONG
		from CTHD where  SOHD = @sohd
		update KHO_SP
		set SOLUONGTON = SOLUONGTON - @sl
		where MAKHO = @kho and MASP = @masp
	end

------ 
exec sp_XoaHDVaCTHD 5
select* from KHO_SP where MASP = 'BB02'
select* from HOADON where SOHD= 5
select* from CTHD where SOHD= 5
--10.Viết SP xoá 1 Phiếu nhập và chi tiết phiếu nhập vào trong DB với tham số truyền vào 
--tương ứng, sau khi thêm thành công phiếu nhập và CTPN thì cập nhật lại số lượng sản 
--phẩm trong kho. 
--11.Viết SP cập nhật 1 hoá đơn và chi tiết hoá đơn vào trong DB với tham số truyền vào 
--tương ứng, sau khi thêm thành công hoá đơn và CTHD thì cập nhật lại số lượng sản phẩm 
--trong kho. 
--12.Viết SP cập nhật 1 Phiếu nhập và chi tiết phiếu nhập vào trong DB với tham số truyền 
--vào tương ứng, sau khi thêm thành công phiếu nhập và CTPN thì cập nhật lại số lượng 
--sản phẩm trong kho.