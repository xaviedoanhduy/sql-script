--Câu 2:
INSERT INTO KHACHHANG
VALUES ('KH01', N'Nguy?n Th? Bé', N'Tân Bình', '38457895', 'bnt@yahoo.com');
INSERT INTO KHACHHANG
VALUES ('KH02', N'Lê Hoàng Nam', N'Bình Chánh', '39878987', 'namlehoang@gmail.com');
INSERT INTO KHACHHANG
VALUES ('KH03', N'Tr?n Th? Chiêu', N'Tân Bình', '38457895', NULL);
INSERT INTO KHACHHANG
VALUES ('KH04', N'Mai Th? Qu? Anh', N'Bình Chánh', NULL, NULL);
INSERT INTO KHACHHANG
VALUES ('KH05', N'Lê V?n Sáng', N'Qu?n 10', NULL , 'sanglv@hcm.vnn.vn');
INSERT INTO KHACHHANG
VALUES ('KH06', N'Tr?n Hoàng', N'Tân Bình', '38457897', NULL);
------------------------------------------------------------------------------------
INSERT INTO VATTU
VALUES ('VT01', N'Xi m?ng', 'Bao', 50000, 5000);
INSERT INTO VATTU
VALUES ('VT02', N'Cát', N'Kh?i', 45000, 5000);
INSERT INTO VATTU
VALUES ('VT03', N'G?ch ?ng ', N'Viên', 120, 800000);
INSERT INTO VATTU
VALUES ('VT04', N'G?ch th? ', N'Viên', 110, 800000);
INSERT INTO VATTU
VALUES ('VT05', N'?á l?n', N'Viên', 25000, 100000);
INSERT INTO VATTU
VALUES ('VT06', N'?á nh?  ', N'Kh?i', 33000, 100000);
INSERT INTO VATTU
VALUES ('VT07', N'Lam gió', N'Cái', 15000, 50000);
------------------------------------------------------------------------------------
INSERT INTO HOADON
VALUES ('HD001', to_date('12/05/2016', 'DD-MM-YYYY'), 'KH01', NULL);
INSERT INTO HOADON
VALUES ('HD002', to_date('25/05/2016', 'DD-MM-YYYY'), 'KH02', NULL);
INSERT INTO HOADON
VALUES ('HD003', to_date('25/05/2016', 'DD-MM-YYYY'), 'KH01', NULL);
INSERT INTO HOADON
VALUES ('HD004', to_date('25/05/2016', 'DD-MM-YYYY'), 'KH04', NULL);
INSERT INTO HOADON
VALUES ('HD005', to_date('26/05/2016', 'DD-MM-YYYY'), 'KH04', NULL);
INSERT INTO HOADON
VALUES ('HD006', to_date('02/06/2016', 'DD-MM-YYYY'), 'KH03', NULL);
INSERT INTO HOADON
VALUES ('HD007', to_date('22/06/2016', 'DD-MM-YYYY'), 'KH04', NULL);
INSERT INTO HOADON
VALUES ('HD008', to_date('25/06/2016', 'DD-MM-YYYY'), 'KH03', NULL);
INSERT INTO HOADON
VALUES ('HD009', to_date('15/08/2016', 'DD-MM-YYYY'), 'KH04', NULL);
INSERT INTO HOADON
VALUES ('HD010', to_date('30/09/2016', 'DD-MM-YYYY'), 'KH01', NULL);
select* from hoadon;
------------------------------------------------------------------------------------
CREATE TABLE CTHD
(
    MAHD VARCHAR2(10),
    MAVT varchar2(5),
    SL NUMBER CHECK (SL > 0),
    KHUYENMAI number (10,2),
    GIABAN number (10,2),
    PRIMARY KEY(MAHD, MAVT),
    FOREIGN KEY(MAHD) REFERENCES HOADON(MAHD),
	FOREIGN KEY(MAVT) REFERENCES VATTU(MAVT)
)

INSERT INTO CTHD VALUES ('HD001', 'VT01', 5, null, 52000);

INSERT INTO CTHD VALUES ('HD001', 'VT05', 10, null, 30000);
INSERT INTO CTHD VALUES ('HD002', 'VT03', 10000, null, 150);
INSERT INTO CTHD VALUES ('HD003', 'VT02', 20, null, 55000);
INSERT INTO CTHD VALUES ('HD004', 'VT03', 50000, null, 150);
INSERT INTO CTHD VALUES ('HD004', 'VT04', 20000, null, 30000);
INSERT INTO CTHD VALUES ('HD005', 'VT05', 10, null, 30000);
INSERT INTO CTHD VALUES ('HD005', 'VT06', 15, null, 35000);
INSERT INTO CTHD VALUES ('HD005', 'VT07', 20, null, 17000);
INSERT INTO CTHD VALUES ('HD006', 'VT04', 10000, null, 120);
INSERT INTO CTHD VALUES ('HD007', 'VT04', 20000, null, 125);
INSERT INTO CTHD VALUES ('HD008', 'VT01', 100, null, 55000);
INSERT INTO CTHD VALUES ('HD008', 'VT02', 20, null, 47000);
INSERT INTO CTHD VALUES ('HD009', 'VT02', 25, null, 48000);
INSERT INTO CTHD VALUES ('HD010', 'VT01', 25, null, 57000);
select* from cthd;

--Câu 3: T?o các view sau:
--1. Hi?n th? danh sách các khách hàng có ??a ch? là “Tân Bình” g?m mã khách hàng, tên 
--khách hàng, ??a ch?, ?i?n tho?i, và ??a ch? E-mail.
CREATE OR REPLACE VIEW cau_1
AS
    SELECT *
    FROM KHACHHANG
    WHERE DIACHI = N'Tân Bình';
    
SELECT * FROM cau_1;
--2. Hi?n th? danh sách các khách hàng g?m các thông tin mã khách hàng, tên khách hàng, 
--??a ch? và ??a ch? E-mail c?a nh?ng khách hàng ch?a có s? ?i?n tho?i.
CREATE OR REPLACE VIEW cau_2
AS
    SELECT *
    FROM KHACHHANG
    WHERE DT IS NULL;
    
SELECT * FROM cau_2;
--3. Hi?n th? danh sách các khách hàng ch?a có s? ?i?n tho?i và c?ng ch?a có ??a ch? Email 
--g?m mã khách hàng, tên khách hàng, ??a ch?.
CREATE OR REPLACE VIEW cau_3
AS
    SELECT MAKH, TENKH, DIACHI
    FROM KHACHHANG
    WHERE DT IS NULL AND EMAIL IS NULL;
    
SELECT * FROM cau_3;
--4. Hi?n th? danh sách các khách hàng ?ã có s? ?i?n tho?i và ??a ch? E-mail g?m mã khách 
--hàng, tên khách hàng, ??a ch?, ?i?n tho?i, và ??a ch? E-mail.
CREATE OR REPLACE VIEW cau_4
AS
    SELECT *
    FROM KHACHHANG
    WHERE DT IS NOT NULL AND EMAIL IS NOT NULL;
    
SELECT * FROM cau_4;
--5. Hi?n th? danh sách các v?t t? có ??n v? tính là “Cái” g?m mã v?t t?, tên v?t t? và giá 
--mua.
CREATE OR REPLACE VIEW cau_5
AS
    SELECT MAVT, TENVT, GIAMUA
    FROM VATTU
    WHERE DTV = N'Cái';
    
SELECT * FROM cau_5;
--6. Hi?n th? danh sách các v?t t? g?m mã v?t t?, tên v?t t?, ??n v? tính và giá mua mà có giá 
--mua trên 25000.
CREATE OR REPLACE VIEW cau_6
AS
    SELECT MAVT, TENVT, DTV, GIAMUA
    FROM VATTU
    WHERE GIAMUA > 25000;
    
SELECT * FROM cau_6;
--7. Hi?n th? danh sách các v?t t? là “G?ch” (bao g?m các lo?i g?ch) g?m mã v?t t?, tên v?t 
--t?, ??n v? tính và giá mua. 
CREATE OR REPLACE VIEW cau_7
AS
    SELECT MAVT, TENVT, DTV, GIAMUA
    FROM VATTU
    WHERE TENVT LIKE N'G?ch%';
    
SELECT * FROM cau_7;
--8. Hi?n th? danh sách các v?t t? g?m mã v?t t?, tên v?t t?, ??n v? tính và giá mua mà có giá 
--mua n?m trong kho?ng t? 20000 ??n 40000.
CREATE OR REPLACE VIEW cau_8
AS
    SELECT MAVT, TENVT, DTV, GIAMUA
    FROM VATTU
    WHERE GIAMUA BETWEEN 20000 and 40000;
    
SELECT * FROM cau_8;
--9. L?y ra các thông tin g?m Mã hóa ??n, ngày l?p hóa ??n, tên khách hàng, ??a ch? khách 
--hàng và s? ?i?n tho?i
CREATE OR REPLACE VIEW cau_9
AS
    SELECT hd.MAHD, hd.NGAY, kh.TENKH, kh.DIACHI, kh.DT
    FROM HOADON hd JOIN KHACHHANG kh ON hd.MAKH = kh.MAKH;
    
SELECT * FROM cau_9;

--10.L?y ra các thông tin g?m Mã hóa ??n, tên khách hàng, ??a ch? khách hàng và s? ?i?n 
--tho?i c?a ngày 25/5/2016.
CREATE OR REPLACE VIEW cau_10
AS
    SELECT hd.MAHD, hd.NGAY, kh.TENKH, kh.DIACHI, kh.DT
    FROM HOADON hd JOIN KHACHHANG kh ON hd.MAKH = kh.MAKH
    WHERE hd.NGAY = to_date('25/5/2016', 'DD-MM-yyyy');
    
SELECT * FROM cau_10;
--11.L?y ra các thông tin g?m Mã hóa ??n, ngày l?p hóa ??n, tên khách hàng, ??a ch? khách 
--hàng và s? ?i?n tho?i c?a nh?ng hóa ??n trong tháng 6/2016.
CREATE OR REPLACE VIEW cau_11
AS
    SELECT hd.MAHD, hd.NGAY, kh.TENKH, kh.DIACHI, kh.DT
    FROM HOADON hd JOIN KHACHHANG kh ON hd.MAKH = kh.MAKH
    WHERE hd.NGAY BETWEEN to_date('1/6/2016', 'DD-MM-yyyy') AND to_date('30/6/2016', 'DD-MM-yyyy');
    
SELECT * FROM cau_11;
--12.L?y ra danh sách nh?ng khách hàng (tên khách hàng, ??a ch?, s? ?i?n tho?i) ?ã mua hàng 
--trong tháng 6/2016.
CREATE OR REPLACE VIEW cau_12
AS
    SELECT kh.TENKH, kh.DIACHI, kh.DT
    FROM KHACHHANG kh
    WHERE kh.MAKH IN (SELECT HOADON.MAKH FROM HOADON WHERE HOADON.MAKH = kh.MAKH 
                    AND (HOADON.NGAY BETWEEN to_date('1/6/2016', 'DD-MM-yyyy') AND to_date('30/6/2016', 'DD-MM-yyyy')));
    
SELECT * FROM cau_12;
--13.L?y ra danh sách nh?ng khách hàng không mua hàng trong tháng 6/2016 g?m các thông 
--tin tên khách hàng, ??a ch?, s? ?i?n tho?i.
CREATE OR REPLACE VIEW cau_13
AS
    SELECT kh.TENKH, kh.DIACHI, kh.DT
    FROM KHACHHANG kh
    WHERE kh.MAKH NOT IN (SELECT HOADON.MAKH FROM HOADON WHERE HOADON.MAKH = kh.MAKH 
                    AND (HOADON.NGAY BETWEEN to_date('1/6/2016', 'DD-MM-yyyy') AND to_date('30/6/2016', 'DD-MM-yyyy')));
    
SELECT * FROM cau_13;
--14.L?y ra các chi ti?t hóa ??n g?m các thông tin mã hóa ??n, mã v?t t?, tên v?t t?, ??n v? 
--tính, giá bán, giá mua, s? l??ng, tr? giá mua (giá mua * s? l??ng), tr? giá bán (giá bán * 
--s? l??ng).
CREATE OR REPLACE VIEW cau_14
AS
    SELECT CT.MAHD, CT.MAVT, VT.TENVT, VT.DTV, CT.GIABAN, VT.GIAMUA, CT.SL, 
            VT.GIAMUA * CT.SL AS "Tr? giá mua", CT.GIABAN * CT.SL AS "Tr? giá bán"
    FROM CTHD CT JOIN VATTU VT ON CT.MAVT = VT.MAVT;
    
SELECT * FROM cau_14;
--15.L?y ra các chi ti?t hóa ??n g?m các thông tin mã hóa ??n, mã v?t t?, tên v?t t?, ??n v? 
--tính, giá bán, giá mua, s? l??ng, tr? giá mua (giá mua * s? l??ng), tr? giá bán (giá bán * 
--s? l??ng) mà có giá bán l?n h?n ho?c b?ng giá mua.
CREATE OR REPLACE VIEW cau_15
AS
    SELECT CT.MAHD, CT.MAVT, VT.TENVT, VT.DTV, CT.GIABAN, VT.GIAMUA, CT.SL, 
            VT.GIAMUA * CT.SL AS "Tr? giá mua", CT.GIABAN * CT.SL AS "Tr? giá bán"
    FROM CTHD CT JOIN VATTU VT ON CT.MAVT = VT.MAVT
    WHERE CT.GIABAN >= VT.GIAMUA;
    
SELECT * FROM cau_15;
--16.L?y ra các thông tin g?m mã hóa ??n, mã v?t t?, tên v?t t?, ??n v? tính, giá bán, giá mua, 
--s? l??ng, tr? giá mua (giá mua * s? l??ng), tr? giá bán (giá bán * s? l??ng) và c?t khuy?n 
--mãi v?i khuy?n mãi 10% cho nh?ng m?t hàng bán trong m?t hóa ??n l?n h?n 100.
CREATE OR REPLACE VIEW cau_16
AS
    SELECT CT.MAHD, CT.MAVT, VT.TENVT, VT.DTV, CT.GIABAN, VT.GIAMUA, CT.SL, 
            VT.GIAMUA * CT.SL AS "Tr? giá mua", CT.GIABAN * CT.SL AS "Tr? giá bán", (CT.GIABAN * CT.SL * 0.1) AS "Khuy?n mãi"
    FROM CTHD CT JOIN VATTU VT ON CT.MAVT = VT.MAVT
    WHERE CT.SL > 100;
    
SELECT * FROM cau_16;
--17.Tìm ra nh?ng m?t hàng ch?a bán ???c.
CREATE OR REPLACE VIEW cau_17
AS
    SELECT VT.*
    FROM VATTU VT
    WHERE VT.MAVT NOT IN (SELECT CT.MAVT FROM CTHD CT WHERE CT.MAVT = VT.MAVT);
    
SELECT * FROM cau_17;
--18.T?o b?ng t?ng h?p g?m các thông tin: mã hóa ??n, ngày hóa ??n, tên khách hàng, ??a 
--ch?, s? ?i?n tho?i, tên v?t t?, ??n v? tính, giá mua, giá bán, s? l??ng, tr? giá mua, tr? giá 
--bán. 
CREATE OR REPLACE VIEW cau_18
AS
    SELECT CT.MAHD, HD.NGAY, KH.TENKH, KH.DIACHI, KH.DT, VT.TENVT, VT.DTV, CT.GIABAN, VT.GIAMUA, CT.SL, 
            VT.GIAMUA * CT.SL AS "Tr? giá mua", CT.GIABAN * CT.SL AS "Tr? giá bán"
    FROM CTHD CT JOIN VATTU VT ON CT.MAVT = VT.MAVT 
    JOIN HOADON HD ON HD.MAHD = CT.MAHD
    JOIN KHACHHANG KH ON KH.MAKH = HD.MAKH;
    
SELECT * FROM cau_18;
--19.T?o b?ng t?ng h?p tháng 5/2016 g?m các thông tin: mã hóa ??n, ngày hóa ??n, tên 
--khách hàng, ??a ch?, s? ?i?n tho?i, tên v?t t?, ??n v? tính, giá mua, giá bán, s? l??ng, tr? 
--giá mua, tr? giá bán. 
CREATE OR REPLACE VIEW cau_19
AS
    SELECT CT.MAHD, HD.NGAY, KH.TENKH, KH.DIACHI, KH.DT, VT.TENVT, VT.DTV, CT.GIABAN, VT.GIAMUA, CT.SL, 
            VT.GIAMUA * CT.SL AS "Tr? giá mua", CT.GIABAN * CT.SL AS "Tr? giá bán"
    FROM CTHD CT JOIN VATTU VT ON CT.MAVT = VT.MAVT 
    JOIN HOADON HD ON HD.MAHD = CT.MAHD
    JOIN KHACHHANG KH ON KH.MAKH = HD.MAKH
    WHERE HD.NGAY BETWEEN to_date('1/5/2016', 'DD-MM-yyyy') AND to_date('31/5/2016', 'DD-MM-yyyy');
    
SELECT * FROM cau_19;
--20.T?o b?ng t?ng h?p quý 1 – 2016 g?m các thông tin: mã hóa ??n, ngày hóa ??n, tên 
--khách hàng, ??a ch?, s? ?i?n tho?i, tên v?t t?, ??n v? tính, giá mua, giá bán, s? l??ng, tr? 
--giá mua, tr? giá bán. 
CREATE OR REPLACE VIEW cau_20
AS
    SELECT CT.MAHD, HD.NGAY, KH.TENKH, KH.DIACHI, KH.DT, VT.TENVT, VT.DTV, CT.GIABAN, VT.GIAMUA, CT.SL, 
            VT.GIAMUA * CT.SL AS "Tr? giá mua", CT.GIABAN * CT.SL AS "Tr? giá bán"
    FROM CTHD CT JOIN VATTU VT ON CT.MAVT = VT.MAVT 
    JOIN HOADON HD ON HD.MAHD = CT.MAHD
    JOIN KHACHHANG KH ON KH.MAKH = HD.MAKH
    WHERE HD.NGAY BETWEEN to_date('1/1/2016', 'DD-MM-yyyy') AND to_date('31/3/2016', 'DD-MM-yyyy');
    
SELECT * FROM cau_20;
--21.L?y ra danh sách các hóa ??n g?m các thông tin: S? hóa ??n, ngày, tên khách hàng, ??a 
--ch? khách hàng, t?ng tr? giá c?a hóa ??n.
CREATE OR REPLACE VIEW cau_21
AS
    SELECT HD.MAHD, HD.NGAY, KH.TENKH, KH.DIACHI, HD.TONGTG
    FROM HOADON HD JOIN KHACHHANG KH ON KH.MAKH = HD.MAKH;
    
SELECT * FROM cau_21;
--22.L?y ra hóa ??n có t?ng tr? giá l?n nh?t g?m các thông tin: S? hóa ??n, ngày, tên khách 
--hàng, ??a ch? khách hàng, t?ng tr? giá c?a hóa ??n.
CREATE OR REPLACE VIEW cau_22
AS
    SELECT *
    FROM (SELECT h.MAHD, h.NGAY, kh.TENKH, kh.DIACHI, SUM(ct.GIABAN * ct.SL) as TONGTRIGIA
          FROM HOADON h 
          JOIN KHACHHANG kh ON h.MAKH = kh.MAKH
          JOIN CTHD ct ON ct.MAHD = h.MAHD
          GROUP BY h.MAHD, h.NGAY, kh.TENKH, kh.DIACHI
          ORDER BY TONGTRIGIA DESC)
    WHERE ROWNUM = 1;


SELECT * FROM cau_22;
--23.L?y ra hóa ??n có t?ng tr? giá l?n nh?t trong tháng 5/2016 g?m các thông tin: S? hóa 
--??n, ngày, tên khách hàng, ??a ch? khách hàng, t?ng tr? giá c?a hóa ??n.
CREATE OR REPLACE VIEW cau_23
AS
    SELECT *
    FROM (SELECT h.MAHD, h.NGAY, kh.TENKH, kh.DIACHI, SUM(ct.GIABAN * ct.SL) as TONGTRIGIA
          FROM HOADON h 
          JOIN KHACHHANG kh ON h.MAKH = kh.MAKH
          JOIN CTHD ct ON ct.MAHD = h.MAHD
          WHERE h.NGAY BETWEEN to_date('1/5/2016','DD-MM-YYYY') AND to_date('31/5/2016','DD-MM-YYYY')
          GROUP BY h.MAHD, h.NGAY, kh.TENKH, kh.DIACHI
          ORDER BY TONGTRIGIA DESC)
    WHERE ROWNUM = 1;


SELECT * FROM cau_23;
--24.??m xem m?i khách hàng có bao nhiêu hóa ??n.
CREATE OR REPLACE VIEW cau_24
AS
    SELECT MAKH, COUNT(MAHD) AS SOHD
    FROM HOADON
    GROUP BY MAKH;
SELECT * FROM cau_24;
--Câu 4: T?o các procedure sau:
--SET SERVEROUTPUT ON 
--1. L?y ra danh các khách hàng ?ã mua hàng trong ngày X, v?i X là tham s? truy?n vào.
CREATE OR REPLACE PROCEDURE sp_cau1(v_ngay IN DATE)
AS
    v_tenkh KHACHHANG.TENKH%TYPE;
    v_found NUMBER := 0;
    CURSOR c_cau1
    IS 
        SELECT KHACHHANG.TENKH
        FROM KHACHHANG
        JOIN HOADON ON KHACHHANG.MAKH = HOADON.MAKH
        WHERE HOADON.NGAY = v_ngay;
BEGIN
    OPEN c_cau1;
    LOOP
        FETCH c_cau1 INTO v_tenkh;
        EXIT WHEN c_cau1%NOTFOUND;
        dbms_output.put_line('Ten khach hang: '||v_tenkh);
        v_found := 1;
    END LOOP;
    CLOSE c_cau1;
    
    IF v_found = 0 THEN
        dbms_output.put_line('Khong co khach hang nao trong ngay - '|| v_ngay);
    END IF;
END;

SET SERVEROUTPUT ON 
EXEC sp_cau1('26-MAY-16');
--2. L?y ra danh sách khách hàng có t?ng tr? giá các ??n hàng l?n h?n X (X là tham s?).
CREATE OR REPLACE PROCEDURE sp_cau2(X IN NUMBER)
AS
    v_tenkh KHACHHANG.TENKH%TYPE;
    v_found NUMBER := 0;
    CURSOR c_cau2
    IS 
        SELECT KHACHHANG.TENKH
        FROM KHACHHANG
        JOIN HOADON ON KHACHHANG.MAKH = HOADON.MAKH
        JOIN CTHD ON HOADON.MAHD = CTHD.MAHD
        GROUP BY KHACHHANG.TENKH
        HAVING SUM(CTHD.SL * CTHD.GIABAN) > X;
BEGIN
    OPEN c_cau2;
    LOOP
        FETCH c_cau2 INTO v_tenkh;
        EXIT WHEN c_cau2%NOTFOUND;
        dbms_output.put_line('Ten khach hang co don hang lon hon '|| X || ' : '||v_tenkh);
        v_found := 1;
    END LOOP;
    CLOSE c_cau2;
    
    IF v_found = 0 THEN
        dbms_output.put_line('Khong co don hang nao lon hon - '|| X);
    END IF;
END;

EXEC sp_cau2(20000*30000);

--3. L?y ra danh sách X khách hàng có t?ng tr? giá các ??n hàng l?n nh?t 
CREATE OR REPLACE PROCEDURE sp_cau3(X IN NUMBER)
AS
    v_tenkh KHACHHANG.TENKH%TYPE;
    v_found NUMBER := 0;
    CURSOR c_cau3
    IS
        SELECT KHACHHANG.TENKH
        FROM KHACHHANG
        JOIN HOADON ON KHACHHANG.MAKH = HOADON.MAKH
        JOIN CTHD ON HOADON.MAHD = CTHD.MAHD
        GROUP BY KHACHHANG.TENKH
        ORDER BY SUM(CTHD.SL * CTHD.GIABAN) DESC
        FETCH FIRST X ROWS ONLY;
BEGIN
    OPEN c_cau3;
    LOOP
        FETCH c_cau3 INTO v_tenkh;
        EXIT WHEN c_cau3%NOTFOUND;
        dbms_output.put_line('Ten khach hang: '||v_tenkh);
        v_found := 1;
    END LOOP;
    CLOSE c_cau3;
    
    IF v_found = 0 THEN
        dbms_output.put_line('Khong co khach hang nao!');
    END IF;
END;

EXEC sp_cau3(3);
EXEC sp_cau3(1);
--4. L?y ra danh sách X m?t hàng có s? l??ng bán l?n nh?t.
CREATE OR REPLACE PROCEDURE sp_cau4(X IN NUMBER)
AS
    v_tenvt VATTU.TENVT%TYPE;
    v_found NUMBER := 0;
    v_soluong NUMBER;
    CURSOR c_cau4
    IS
        SELECT VATTU.TENVT, SUM(CTHD.SL)
        FROM VATTU
        JOIN CTHD ON CTHD.MAVT = VATTU.MAVT
        GROUP BY VATTU.TENVT
        ORDER BY SUM(CTHD.SL) DESC
        FETCH FIRST X ROWS ONLY;
BEGIN
    OPEN c_cau4;
    LOOP
        FETCH c_cau4 INTO v_tenvt, v_soluong;
        EXIT WHEN c_cau4%NOTFOUND;
        dbms_output.put_line('Ten vat tu: '||v_tenvt || ', co so luong: ' ||v_soluong);
        v_found := 1;
    END LOOP;
    CLOSE c_cau4;
    
    IF v_found = 0 THEN
        dbms_output.put_line('Khong co vat tu nao!');
    END IF;
END;

EXEC sp_cau4(5);
--5. L?y ra danh sách X m?t hàng bán ra có lãi ít nh?t.
CREATE OR REPLACE PROCEDURE sp_cau5(X IN NUMBER)
AS
    v_tenvt VATTU.TENVT%TYPE;
    v_found NUMBER := 0;
    v_lai NUMBER;
    CURSOR c_cau5
    IS
        SELECT VATTU.TENVT, SUM((CTHD.GIABAN - VATTU.GIAMUA) * CTHD.SL) AS laixuat
        FROM VATTU
        JOIN CTHD ON CTHD.MAVT = VATTU.MAVT
        GROUP BY VATTU.TENVT
        ORDER BY laixuat ASC
        FETCH FIRST X ROWS ONLY;
BEGIN
    OPEN c_cau5;
    LOOP
        FETCH c_cau5 INTO v_tenvt, v_lai;
        EXIT WHEN c_cau5%NOTFOUND;
        dbms_output.put_line('Ten vat tu: '||v_tenvt || ', co lai xuat: ' ||v_lai);
        v_found := 1;
    END LOOP;
    CLOSE c_cau5;
    
    IF v_found = 0 THEN
        dbms_output.put_line('Khong co vat tu nao!');
    END IF;
END;

EXEC sp_cau5(3);
--6. L?y ra danh sách X ??n hàng có t?ng tr? giá l?n nh?t (X là tham s?).
CREATE OR REPLACE PROCEDURE sp_cau6(X IN NUMBER)
AS
    v_mahd HOADON.MAHD%TYPE;
    v_found NUMBER := 0;
    v_tongtg NUMBER;
    CURSOR c_cau6
    IS
        SELECT CTHD.MAHD, SUM(CTHD.GIABAN * CTHD.SL) AS TONGTG
        FROM HOADON
        JOIN CTHD ON CTHD.MAHD = HOADON.MAHD
        GROUP BY CTHD.MAHD
        ORDER BY TONGTG DESC
        FETCH FIRST X ROWS ONLY;
BEGIN
    OPEN c_cau6;
    LOOP
        FETCH c_cau6 INTO v_mahd, v_tongtg;
        EXIT WHEN c_cau6%NOTFOUND;
        dbms_output.put_line('Ma hoa don: '||v_mahd || ' - co tong tri gia: ' ||v_tongtg);
        v_found := 1;
    END LOOP;
    CLOSE c_cau6;
    
    IF v_found = 0 THEN
        dbms_output.put_line('Khong hoa don tu nao!');
    END IF;
END;

EXEC sp_cau6(4);
--7. Tính giá tr? cho c?t khuy?n mãi nh? sau: Khuy?n mãi 5% n?u SL > 100, 10% n?u SL > 500.
CREATE OR REPLACE PROCEDURE sp_cau7
AS
BEGIN
    UPDATE CTHD
    SET KHUYENMAI = 0.05
    WHERE SL > 100 AND SL < 500;
        
    UPDATE CTHD
    SET KHUYENMAI = 0.1
    WHERE SL > 500;
END;

EXEC sp_cau7;
--8. Tính l?i s? l??ng t?n cho t?t c? các m?t hàng (SLTON = SLTON – t?ng SL bán ???c).
CREATE OR REPLACE PROCEDURE sp_cau8
AS
BEGIN
    UPDATE VATTU
    SET SLTON = SLTON - (SELECT SUM(SL) FROM CTHD WHERE CTHD.MAVT = VATTU.MAVT GROUP BY CTHD.MAVT)
    WHERE VATTU.MAVT IN (SELECT MAVT FROM CTHD);
END;

EXEC sp_cau8;
--9. Tính tr? giá cho m?i hóa ??n.
CREATE OR REPLACE PROCEDURE sp_cau9
AS
    CURSOR c_cau9
    IS
        SELECT h.MAHD, SUM(c.GIABAN * c.SL) AS TONGTRIGIA
        FROM HOADON h JOIN CTHD c ON h.MAHD = c.MAHD
        GROUP BY h.MAHD;
BEGIN
    FOR r IN c_cau9
        LOOP
            UPDATE HOADON SET TONGTG = r.TONGTRIGIA WHERE MAHD = r.MAHD;
        END LOOP;
END;

EXEC sp_cau9;
--Câu 5: T?o các function sau:
--1. Vi?t hàm tính doanh thu c?a n?m, v?i n?m là tham s? truy?n vào.
CREATE OR REPLACE FUNCTION func_CAU_1 (year number)
RETURN number
IS
   v_doanh_thu NUMBER := 0;
BEGIN
   SELECT SUM(TONGTG) INTO v_doanh_thu
   FROM HOADON
   WHERE EXTRACT(YEAR FROM NGAY) = year;
   
   RETURN v_doanh_thu;
END;


SELECT func_CAU_1(2023) FROM dual;

SELECT * FROM HOADON;
--2. Vi?t hàm tính doanh thu c?a tháng, n?m, v?i tháng và n?m là 2 tham s? truy?n vào.
CREATE OR REPLACE FUNCTION func_CAU_2 (v_month number, v_year number)
RETURN number
IS
   v_doanh_thu NUMBER := 0;
BEGIN
   SELECT SUM(TONGTG) INTO v_doanh_thu
   FROM HOADON
   WHERE EXTRACT(YEAR FROM NGAY) = v_year and EXTRACT(MONTH FROM NGAY) = v_month;
   
   RETURN v_doanh_thu;
END;
SELECT func_CAU_2(6, 2016) FROM dual;
--3. Vi?t hàm tính doanh thu c?a khách hàng v?i mã khách hàng là tham s? truy?n vào.
CREATE OR REPLACE FUNCTION func_cau_3 (v_MaKH VARCHAR2)
RETURN number
IS
   v_doanh_thu NUMBER := 0;
BEGIN
   SELECT SUM(TONGTG) INTO v_doanh_thu
   FROM HOADON
   WHERE MAKH = v_MaKH
   GROUP BY MAKH;

   RETURN v_doanh_thu;
END;
SELECT func_cau_3('KH01') FROM dual;
SELECT func_cau_3('KH02') FROM dual;
--4. Vi?t hàm tính t?ng s? l??ng bán ???c cho t?ng m?t hàng theo tháng, n?m nào ?ó. V?i 
--mã hàng, tháng và n?m là các tham s? truy?n vào, n?u tháng không nh?p vào t?c là tính 
--t?t c? các tháng.
CREATE OR REPLACE FUNCTION func_cau_4 (v_MaVT VARCHAR2, v_Thang NUMBER DEFAULT NULL, v_Nam NUMBER)
RETURN number
IS
   v_SoLuong NUMBER := 0;
BEGIN
    IF v_Thang IS NULL THEN
       SELECT SUM(ct.SL) INTO v_SoLuong
       FROM CTHD ct, HOADON hd
       WHERE ct.MaHD = hd.MaHD and ct.MAVT = v_MaVT And  EXTRACT(YEAR FROM hd.NGAY) = v_Nam
       GROUP BY ct.MAVT;
    ELSE
       SELECT SUM(ct.SL) INTO v_SoLuong
       FROM CTHD ct, HOADON hd
       WHERE ct.MaHD = hd. MaHD and ct.MAVT = v_MaVT And  EXTRACT(YEAR FROM hd.NGAY) = v_Nam AND EXTRACT(MONTH FROM hd.NGAY) = v_Thang
       GROUP BY ct.MAVT;
    END IF;

   RETURN v_SoLuong;
END;
SELECT func_cau_4('VT01',null, 2016) FROM dual;
SELECT func_cau_4('VT01',5, 2016) FROM dual;
--5. Vi?t hàm tính lãi ((giá bán – giá mua ) * s? l??ng bán ???c) cho t?ng m?t hàng, v?i mã 
--m?t hàng là tham s? truy?n vào. N?u mã m?t hàng không truy?n vào thì tính cho t?t c? 
--các m?t hàng.
CREATE OR REPLACE FUNCTION func_cau_5 (v_MaVT VARCHAR2 DEFAULT NULL)
RETURN NUMBER
IS
   v_LaiSuat NUMBER := 0;
BEGIN
    IF v_MaVT IS NOT NULL THEN
        SELECT SUM((CT.GIABAN - VT.GIAMUA) * CT.SL) INTO v_LaiSuat
        FROM CTHD CT JOIN VATTU VT ON CT.MAVT = VT.MAVT
        WHERE CT.MAVT = v_MaVT;
    ELSE
        SELECT SUM((CT.GIABAN - VT.GIAMUA) * CT.SL) INTO v_LaiSuat
        FROM CTHD CT JOIN VATTU VT ON CT.MAVT = VT.MAVT;
    END IF;

   RETURN v_LaiSuat;
END;

SELECT func_cau_5('VT05') FROM dual;
SELECT func_cau_5() FROM dual;
--Câu 6: T?o các trigger ?? th?c hi?n các ràng bu?c sau:
--1. Th?c hi?n vi?c ki?m tra các ràng bu?c khóa ngo?i.
CREATE OR REPLACE TRIGGER trg_cau1
BEFORE INSERT ON CTHD
FOR EACH ROW
DECLARE 
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM VATTU
    WHERE MAVT = :NEW.MAVT;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Khong ton tai ma san pham');
    END IF;
END;

CREATE OR REPLACE TRIGGER trg_MAKH
BEFORE INSERT ON HOADON
FOR EACH ROW
DECLARE 
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM KHACHHANG
    WHERE MAKH = :NEW.MAKH;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Khong ton tai ma khach hang');
    END IF;
END;
--2. Không cho phép user nh?p vào hai v?t t? có cùng tên.
CREATE OR REPLACE TRIGGER trg_cau2
BEFORE INSERT ON VATTU
FOR EACH ROW
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM VATTU
  WHERE TENVT = :NEW.TENVT;
  
  IF v_count > 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Khong duoc nhap vao ten vat tu da ton tai');
  END IF;
END;
INSERT INTO VATTU VALUES('VT10', N'Xi m?ng', 'Bao', 4000, 300);
INSERT INTO VATTU VALUES('VT10', N'Xi m?ng 1', 'Bao', 4000, 300);
--3. Khi user ??t hàng thì KHUYENMAI là 5% n?u SL >100, 10% n?u SL > 500.
CREATE OR REPLACE TRIGGER trg_cau3
BEFORE INSERT OR UPDATE ON CTHD
FOR EACH ROW
BEGIN
    IF :NEW.SL > 100 AND :NEW.SL < 200 THEN
        :NEW.KHUYENMAI := 0.05;
    ELSIF :NEW.SL > 200 THEN
        :NEW.KHUYENMAI := 0.1;
    ELSE
        :NEW.KHUYENMAI := 0;
    END IF;
END;
INSERT INTO CTHD VALUES('HD011', 'VT01', 101, NULL, 150);
INSERT INTO CTHD VALUES('HD011', 'VT02', 250, NULL, 3050);
INSERT INTO CTHD VALUES('HD011', 'VT04', 90, NULL, 200);
--4. Ch? cho phép mua các m?t hàng có s? l??ng t?n l?n h?n ho?c b?ng s? l??ng c?n mua và 
--tính l?i s? l??ng t?n m?i khi có ??n hàng.
CREATE OR REPLACE TRIGGER trg_cau4
BEFORE INSERT OR UPDATE ON CTHD
FOR EACH ROW
DECLARE
  v_Soluong NUMBER;
BEGIN
    SELECT SLTON INTO v_Soluong FROM VATTU WHERE MAVT = :NEW.MAVT;
    IF :NEW.SL > v_Soluong THEN
        RAISE_APPLICATION_ERROR(-20001, 'So luong dat hang lon hon so luong ton');
    ELSE
        UPDATE VATTU
        SET SLTON = SLTON - :NEW.SL
        WHERE MAVT = :NEW.MAVT;
    END IF;
END;
INSERT INTO CTHD VALUES ('HD011', 'VT09', 3, NULL, 1000);
INSERT INTO CTHD VALUES ('HD011', 'VT09', 2, NULL, 1000);
--5. Không cho phép user xóa m?t lúc nhi?u h?n m?t v?t t?.
CREATE OR REPLACE TRIGGER trg_cau5
BEFORE DELETE ON VATTU
FOR EACH ROW
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM VATTU WHERE MAVT = :OLD.MAVT;
  IF v_count > 1 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Khong the xoa nhieu hon mot vat tu');
  END IF;
END;

DELETE FROM VATTU WHERE MAVT IN ('VT11', 'VT12');
DELETE FROM VATTU WHERE MAVT = 'VT11';

--6. M?i hóa ??n cho phép bán t?i ?a 5 m?t hàng.
CREATE OR REPLACE TRIGGER trg_cau6
BEFORE INSERT ON CTHD
FOR EACH ROW
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM CTHD WHERE MAHD = :NEW.MAHD;
  IF v_count + 1 > 5 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Moi hoa don cho phep ban toi da 5 mat hang');
  END IF;
END;
INSERT INTO CTHD VALUES ('HD011', 'VT04', 110, NULL, 50000);
INSERT INTO CTHD VALUES ('HD011', 'VT05', 110, NULL, 50000);

--7. M?i hóa ??n có t?ng tr? giá t?i ?a 50000000
CREATE OR REPLACE TRIGGER trg_cau7
BEFORE INSERT OR UPDATE ON HOADON
FOR EACH ROW
BEGIN
  IF :NEW.TONGTG > 50000000 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Tong tri gia lon hon 50000000');
  END IF;
END;

UPDATE HOADON
SET TONGTG = 50000001
WHERE MAHD ='HD011';