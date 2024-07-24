--C�u 2:
INSERT INTO KHACHHANG
VALUES ('KH01', N'Nguy?n Th? B�', N'T�n B�nh', '38457895', 'bnt@yahoo.com');
INSERT INTO KHACHHANG
VALUES ('KH02', N'L� Ho�ng Nam', N'B�nh Ch�nh', '39878987', 'namlehoang@gmail.com');
INSERT INTO KHACHHANG
VALUES ('KH03', N'Tr?n Th? Chi�u', N'T�n B�nh', '38457895', NULL);
INSERT INTO KHACHHANG
VALUES ('KH04', N'Mai Th? Qu? Anh', N'B�nh Ch�nh', NULL, NULL);
INSERT INTO KHACHHANG
VALUES ('KH05', N'L� V?n S�ng', N'Qu?n 10', NULL , 'sanglv@hcm.vnn.vn');
INSERT INTO KHACHHANG
VALUES ('KH06', N'Tr?n Ho�ng', N'T�n B�nh', '38457897', NULL);
------------------------------------------------------------------------------------
INSERT INTO VATTU
VALUES ('VT01', N'Xi m?ng', 'Bao', 50000, 5000);
INSERT INTO VATTU
VALUES ('VT02', N'C�t', N'Kh?i', 45000, 5000);
INSERT INTO VATTU
VALUES ('VT03', N'G?ch ?ng ', N'Vi�n', 120, 800000);
INSERT INTO VATTU
VALUES ('VT04', N'G?ch th? ', N'Vi�n', 110, 800000);
INSERT INTO VATTU
VALUES ('VT05', N'?� l?n', N'Vi�n', 25000, 100000);
INSERT INTO VATTU
VALUES ('VT06', N'?� nh?  ', N'Kh?i', 33000, 100000);
INSERT INTO VATTU
VALUES ('VT07', N'Lam gi�', N'C�i', 15000, 50000);
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

--C�u 3: T?o c�c view sau:
--1. Hi?n th? danh s�ch c�c kh�ch h�ng c� ??a ch? l� �T�n B�nh� g?m m� kh�ch h�ng, t�n 
--kh�ch h�ng, ??a ch?, ?i?n tho?i, v� ??a ch? E-mail.
CREATE OR REPLACE VIEW cau_1
AS
    SELECT *
    FROM KHACHHANG
    WHERE DIACHI = N'T�n B�nh';
    
SELECT * FROM cau_1;
--2. Hi?n th? danh s�ch c�c kh�ch h�ng g?m c�c th�ng tin m� kh�ch h�ng, t�n kh�ch h�ng, 
--??a ch? v� ??a ch? E-mail c?a nh?ng kh�ch h�ng ch?a c� s? ?i?n tho?i.
CREATE OR REPLACE VIEW cau_2
AS
    SELECT *
    FROM KHACHHANG
    WHERE DT IS NULL;
    
SELECT * FROM cau_2;
--3. Hi?n th? danh s�ch c�c kh�ch h�ng ch?a c� s? ?i?n tho?i v� c?ng ch?a c� ??a ch? Email 
--g?m m� kh�ch h�ng, t�n kh�ch h�ng, ??a ch?.
CREATE OR REPLACE VIEW cau_3
AS
    SELECT MAKH, TENKH, DIACHI
    FROM KHACHHANG
    WHERE DT IS NULL AND EMAIL IS NULL;
    
SELECT * FROM cau_3;
--4. Hi?n th? danh s�ch c�c kh�ch h�ng ?� c� s? ?i?n tho?i v� ??a ch? E-mail g?m m� kh�ch 
--h�ng, t�n kh�ch h�ng, ??a ch?, ?i?n tho?i, v� ??a ch? E-mail.
CREATE OR REPLACE VIEW cau_4
AS
    SELECT *
    FROM KHACHHANG
    WHERE DT IS NOT NULL AND EMAIL IS NOT NULL;
    
SELECT * FROM cau_4;
--5. Hi?n th? danh s�ch c�c v?t t? c� ??n v? t�nh l� �C�i� g?m m� v?t t?, t�n v?t t? v� gi� 
--mua.
CREATE OR REPLACE VIEW cau_5
AS
    SELECT MAVT, TENVT, GIAMUA
    FROM VATTU
    WHERE DTV = N'C�i';
    
SELECT * FROM cau_5;
--6. Hi?n th? danh s�ch c�c v?t t? g?m m� v?t t?, t�n v?t t?, ??n v? t�nh v� gi� mua m� c� gi� 
--mua tr�n 25000.
CREATE OR REPLACE VIEW cau_6
AS
    SELECT MAVT, TENVT, DTV, GIAMUA
    FROM VATTU
    WHERE GIAMUA > 25000;
    
SELECT * FROM cau_6;
--7. Hi?n th? danh s�ch c�c v?t t? l� �G?ch� (bao g?m c�c lo?i g?ch) g?m m� v?t t?, t�n v?t 
--t?, ??n v? t�nh v� gi� mua. 
CREATE OR REPLACE VIEW cau_7
AS
    SELECT MAVT, TENVT, DTV, GIAMUA
    FROM VATTU
    WHERE TENVT LIKE N'G?ch%';
    
SELECT * FROM cau_7;
--8. Hi?n th? danh s�ch c�c v?t t? g?m m� v?t t?, t�n v?t t?, ??n v? t�nh v� gi� mua m� c� gi� 
--mua n?m trong kho?ng t? 20000 ??n 40000.
CREATE OR REPLACE VIEW cau_8
AS
    SELECT MAVT, TENVT, DTV, GIAMUA
    FROM VATTU
    WHERE GIAMUA BETWEEN 20000 and 40000;
    
SELECT * FROM cau_8;
--9. L?y ra c�c th�ng tin g?m M� h�a ??n, ng�y l?p h�a ??n, t�n kh�ch h�ng, ??a ch? kh�ch 
--h�ng v� s? ?i?n tho?i
CREATE OR REPLACE VIEW cau_9
AS
    SELECT hd.MAHD, hd.NGAY, kh.TENKH, kh.DIACHI, kh.DT
    FROM HOADON hd JOIN KHACHHANG kh ON hd.MAKH = kh.MAKH;
    
SELECT * FROM cau_9;

--10.L?y ra c�c th�ng tin g?m M� h�a ??n, t�n kh�ch h�ng, ??a ch? kh�ch h�ng v� s? ?i?n 
--tho?i c?a ng�y 25/5/2016.
CREATE OR REPLACE VIEW cau_10
AS
    SELECT hd.MAHD, hd.NGAY, kh.TENKH, kh.DIACHI, kh.DT
    FROM HOADON hd JOIN KHACHHANG kh ON hd.MAKH = kh.MAKH
    WHERE hd.NGAY = to_date('25/5/2016', 'DD-MM-yyyy');
    
SELECT * FROM cau_10;
--11.L?y ra c�c th�ng tin g?m M� h�a ??n, ng�y l?p h�a ??n, t�n kh�ch h�ng, ??a ch? kh�ch 
--h�ng v� s? ?i?n tho?i c?a nh?ng h�a ??n trong th�ng 6/2016.
CREATE OR REPLACE VIEW cau_11
AS
    SELECT hd.MAHD, hd.NGAY, kh.TENKH, kh.DIACHI, kh.DT
    FROM HOADON hd JOIN KHACHHANG kh ON hd.MAKH = kh.MAKH
    WHERE hd.NGAY BETWEEN to_date('1/6/2016', 'DD-MM-yyyy') AND to_date('30/6/2016', 'DD-MM-yyyy');
    
SELECT * FROM cau_11;
--12.L?y ra danh s�ch nh?ng kh�ch h�ng (t�n kh�ch h�ng, ??a ch?, s? ?i?n tho?i) ?� mua h�ng 
--trong th�ng 6/2016.
CREATE OR REPLACE VIEW cau_12
AS
    SELECT kh.TENKH, kh.DIACHI, kh.DT
    FROM KHACHHANG kh
    WHERE kh.MAKH IN (SELECT HOADON.MAKH FROM HOADON WHERE HOADON.MAKH = kh.MAKH 
                    AND (HOADON.NGAY BETWEEN to_date('1/6/2016', 'DD-MM-yyyy') AND to_date('30/6/2016', 'DD-MM-yyyy')));
    
SELECT * FROM cau_12;
--13.L?y ra danh s�ch nh?ng kh�ch h�ng kh�ng mua h�ng trong th�ng 6/2016 g?m c�c th�ng 
--tin t�n kh�ch h�ng, ??a ch?, s? ?i?n tho?i.
CREATE OR REPLACE VIEW cau_13
AS
    SELECT kh.TENKH, kh.DIACHI, kh.DT
    FROM KHACHHANG kh
    WHERE kh.MAKH NOT IN (SELECT HOADON.MAKH FROM HOADON WHERE HOADON.MAKH = kh.MAKH 
                    AND (HOADON.NGAY BETWEEN to_date('1/6/2016', 'DD-MM-yyyy') AND to_date('30/6/2016', 'DD-MM-yyyy')));
    
SELECT * FROM cau_13;
--14.L?y ra c�c chi ti?t h�a ??n g?m c�c th�ng tin m� h�a ??n, m� v?t t?, t�n v?t t?, ??n v? 
--t�nh, gi� b�n, gi� mua, s? l??ng, tr? gi� mua (gi� mua * s? l??ng), tr? gi� b�n (gi� b�n * 
--s? l??ng).
CREATE OR REPLACE VIEW cau_14
AS
    SELECT CT.MAHD, CT.MAVT, VT.TENVT, VT.DTV, CT.GIABAN, VT.GIAMUA, CT.SL, 
            VT.GIAMUA * CT.SL AS "Tr? gi� mua", CT.GIABAN * CT.SL AS "Tr? gi� b�n"
    FROM CTHD CT JOIN VATTU VT ON CT.MAVT = VT.MAVT;
    
SELECT * FROM cau_14;
--15.L?y ra c�c chi ti?t h�a ??n g?m c�c th�ng tin m� h�a ??n, m� v?t t?, t�n v?t t?, ??n v? 
--t�nh, gi� b�n, gi� mua, s? l??ng, tr? gi� mua (gi� mua * s? l??ng), tr? gi� b�n (gi� b�n * 
--s? l??ng) m� c� gi� b�n l?n h?n ho?c b?ng gi� mua.
CREATE OR REPLACE VIEW cau_15
AS
    SELECT CT.MAHD, CT.MAVT, VT.TENVT, VT.DTV, CT.GIABAN, VT.GIAMUA, CT.SL, 
            VT.GIAMUA * CT.SL AS "Tr? gi� mua", CT.GIABAN * CT.SL AS "Tr? gi� b�n"
    FROM CTHD CT JOIN VATTU VT ON CT.MAVT = VT.MAVT
    WHERE CT.GIABAN >= VT.GIAMUA;
    
SELECT * FROM cau_15;
--16.L?y ra c�c th�ng tin g?m m� h�a ??n, m� v?t t?, t�n v?t t?, ??n v? t�nh, gi� b�n, gi� mua, 
--s? l??ng, tr? gi� mua (gi� mua * s? l??ng), tr? gi� b�n (gi� b�n * s? l??ng) v� c?t khuy?n 
--m�i v?i khuy?n m�i 10% cho nh?ng m?t h�ng b�n trong m?t h�a ??n l?n h?n 100.
CREATE OR REPLACE VIEW cau_16
AS
    SELECT CT.MAHD, CT.MAVT, VT.TENVT, VT.DTV, CT.GIABAN, VT.GIAMUA, CT.SL, 
            VT.GIAMUA * CT.SL AS "Tr? gi� mua", CT.GIABAN * CT.SL AS "Tr? gi� b�n", (CT.GIABAN * CT.SL * 0.1) AS "Khuy?n m�i"
    FROM CTHD CT JOIN VATTU VT ON CT.MAVT = VT.MAVT
    WHERE CT.SL > 100;
    
SELECT * FROM cau_16;
--17.T�m ra nh?ng m?t h�ng ch?a b�n ???c.
CREATE OR REPLACE VIEW cau_17
AS
    SELECT VT.*
    FROM VATTU VT
    WHERE VT.MAVT NOT IN (SELECT CT.MAVT FROM CTHD CT WHERE CT.MAVT = VT.MAVT);
    
SELECT * FROM cau_17;
--18.T?o b?ng t?ng h?p g?m c�c th�ng tin: m� h�a ??n, ng�y h�a ??n, t�n kh�ch h�ng, ??a 
--ch?, s? ?i?n tho?i, t�n v?t t?, ??n v? t�nh, gi� mua, gi� b�n, s? l??ng, tr? gi� mua, tr? gi� 
--b�n. 
CREATE OR REPLACE VIEW cau_18
AS
    SELECT CT.MAHD, HD.NGAY, KH.TENKH, KH.DIACHI, KH.DT, VT.TENVT, VT.DTV, CT.GIABAN, VT.GIAMUA, CT.SL, 
            VT.GIAMUA * CT.SL AS "Tr? gi� mua", CT.GIABAN * CT.SL AS "Tr? gi� b�n"
    FROM CTHD CT JOIN VATTU VT ON CT.MAVT = VT.MAVT 
    JOIN HOADON HD ON HD.MAHD = CT.MAHD
    JOIN KHACHHANG KH ON KH.MAKH = HD.MAKH;
    
SELECT * FROM cau_18;
--19.T?o b?ng t?ng h?p th�ng 5/2016 g?m c�c th�ng tin: m� h�a ??n, ng�y h�a ??n, t�n 
--kh�ch h�ng, ??a ch?, s? ?i?n tho?i, t�n v?t t?, ??n v? t�nh, gi� mua, gi� b�n, s? l??ng, tr? 
--gi� mua, tr? gi� b�n. 
CREATE OR REPLACE VIEW cau_19
AS
    SELECT CT.MAHD, HD.NGAY, KH.TENKH, KH.DIACHI, KH.DT, VT.TENVT, VT.DTV, CT.GIABAN, VT.GIAMUA, CT.SL, 
            VT.GIAMUA * CT.SL AS "Tr? gi� mua", CT.GIABAN * CT.SL AS "Tr? gi� b�n"
    FROM CTHD CT JOIN VATTU VT ON CT.MAVT = VT.MAVT 
    JOIN HOADON HD ON HD.MAHD = CT.MAHD
    JOIN KHACHHANG KH ON KH.MAKH = HD.MAKH
    WHERE HD.NGAY BETWEEN to_date('1/5/2016', 'DD-MM-yyyy') AND to_date('31/5/2016', 'DD-MM-yyyy');
    
SELECT * FROM cau_19;
--20.T?o b?ng t?ng h?p qu� 1 � 2016 g?m c�c th�ng tin: m� h�a ??n, ng�y h�a ??n, t�n 
--kh�ch h�ng, ??a ch?, s? ?i?n tho?i, t�n v?t t?, ??n v? t�nh, gi� mua, gi� b�n, s? l??ng, tr? 
--gi� mua, tr? gi� b�n. 
CREATE OR REPLACE VIEW cau_20
AS
    SELECT CT.MAHD, HD.NGAY, KH.TENKH, KH.DIACHI, KH.DT, VT.TENVT, VT.DTV, CT.GIABAN, VT.GIAMUA, CT.SL, 
            VT.GIAMUA * CT.SL AS "Tr? gi� mua", CT.GIABAN * CT.SL AS "Tr? gi� b�n"
    FROM CTHD CT JOIN VATTU VT ON CT.MAVT = VT.MAVT 
    JOIN HOADON HD ON HD.MAHD = CT.MAHD
    JOIN KHACHHANG KH ON KH.MAKH = HD.MAKH
    WHERE HD.NGAY BETWEEN to_date('1/1/2016', 'DD-MM-yyyy') AND to_date('31/3/2016', 'DD-MM-yyyy');
    
SELECT * FROM cau_20;
--21.L?y ra danh s�ch c�c h�a ??n g?m c�c th�ng tin: S? h�a ??n, ng�y, t�n kh�ch h�ng, ??a 
--ch? kh�ch h�ng, t?ng tr? gi� c?a h�a ??n.
CREATE OR REPLACE VIEW cau_21
AS
    SELECT HD.MAHD, HD.NGAY, KH.TENKH, KH.DIACHI, HD.TONGTG
    FROM HOADON HD JOIN KHACHHANG KH ON KH.MAKH = HD.MAKH;
    
SELECT * FROM cau_21;
--22.L?y ra h�a ??n c� t?ng tr? gi� l?n nh?t g?m c�c th�ng tin: S? h�a ??n, ng�y, t�n kh�ch 
--h�ng, ??a ch? kh�ch h�ng, t?ng tr? gi� c?a h�a ??n.
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
--23.L?y ra h�a ??n c� t?ng tr? gi� l?n nh?t trong th�ng 5/2016 g?m c�c th�ng tin: S? h�a 
--??n, ng�y, t�n kh�ch h�ng, ??a ch? kh�ch h�ng, t?ng tr? gi� c?a h�a ??n.
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
--24.??m xem m?i kh�ch h�ng c� bao nhi�u h�a ??n.
CREATE OR REPLACE VIEW cau_24
AS
    SELECT MAKH, COUNT(MAHD) AS SOHD
    FROM HOADON
    GROUP BY MAKH;
SELECT * FROM cau_24;
--C�u 4: T?o c�c procedure sau:
--SET SERVEROUTPUT ON 
--1. L?y ra danh c�c kh�ch h�ng ?� mua h�ng trong ng�y X, v?i X l� tham s? truy?n v�o.
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
--2. L?y ra danh s�ch kh�ch h�ng c� t?ng tr? gi� c�c ??n h�ng l?n h?n X (X l� tham s?).
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

--3. L?y ra danh s�ch X kh�ch h�ng c� t?ng tr? gi� c�c ??n h�ng l?n nh?t 
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
--4. L?y ra danh s�ch X m?t h�ng c� s? l??ng b�n l?n nh?t.
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
--5. L?y ra danh s�ch X m?t h�ng b�n ra c� l�i �t nh?t.
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
--6. L?y ra danh s�ch X ??n h�ng c� t?ng tr? gi� l?n nh?t (X l� tham s?).
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
--7. T�nh gi� tr? cho c?t khuy?n m�i nh? sau: Khuy?n m�i 5% n?u SL > 100, 10% n?u SL > 500.
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
--8. T�nh l?i s? l??ng t?n cho t?t c? c�c m?t h�ng (SLTON = SLTON � t?ng SL b�n ???c).
CREATE OR REPLACE PROCEDURE sp_cau8
AS
BEGIN
    UPDATE VATTU
    SET SLTON = SLTON - (SELECT SUM(SL) FROM CTHD WHERE CTHD.MAVT = VATTU.MAVT GROUP BY CTHD.MAVT)
    WHERE VATTU.MAVT IN (SELECT MAVT FROM CTHD);
END;

EXEC sp_cau8;
--9. T�nh tr? gi� cho m?i h�a ??n.
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
--C�u 5: T?o c�c function sau:
--1. Vi?t h�m t�nh doanh thu c?a n?m, v?i n?m l� tham s? truy?n v�o.
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
--2. Vi?t h�m t�nh doanh thu c?a th�ng, n?m, v?i th�ng v� n?m l� 2 tham s? truy?n v�o.
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
--3. Vi?t h�m t�nh doanh thu c?a kh�ch h�ng v?i m� kh�ch h�ng l� tham s? truy?n v�o.
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
--4. Vi?t h�m t�nh t?ng s? l??ng b�n ???c cho t?ng m?t h�ng theo th�ng, n?m n�o ?�. V?i 
--m� h�ng, th�ng v� n?m l� c�c tham s? truy?n v�o, n?u th�ng kh�ng nh?p v�o t?c l� t�nh 
--t?t c? c�c th�ng.
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
--5. Vi?t h�m t�nh l�i ((gi� b�n � gi� mua ) * s? l??ng b�n ???c) cho t?ng m?t h�ng, v?i m� 
--m?t h�ng l� tham s? truy?n v�o. N?u m� m?t h�ng kh�ng truy?n v�o th� t�nh cho t?t c? 
--c�c m?t h�ng.
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
--C�u 6: T?o c�c trigger ?? th?c hi?n c�c r�ng bu?c sau:
--1. Th?c hi?n vi?c ki?m tra c�c r�ng bu?c kh�a ngo?i.
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
--2. Kh�ng cho ph�p user nh?p v�o hai v?t t? c� c�ng t�n.
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
--3. Khi user ??t h�ng th� KHUYENMAI l� 5% n?u SL >100, 10% n?u SL > 500.
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
--4. Ch? cho ph�p mua c�c m?t h�ng c� s? l??ng t?n l?n h?n ho?c b?ng s? l??ng c?n mua v� 
--t�nh l?i s? l??ng t?n m?i khi c� ??n h�ng.
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
--5. Kh�ng cho ph�p user x�a m?t l�c nhi?u h?n m?t v?t t?.
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

--6. M?i h�a ??n cho ph�p b�n t?i ?a 5 m?t h�ng.
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

--7. M?i h�a ??n c� t?ng tr? gi� t?i ?a 50000000
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