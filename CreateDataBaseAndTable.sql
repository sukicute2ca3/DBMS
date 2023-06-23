CREATE DATABASE DoAnHeCoSoDuLieu;
use  DoAnHeCoSoDuLieu
go

CREATE table Loai_SP(
    Ma_LoaiSP VARCHAR(6),
    Ten_LoaiSP NVARCHAR(20),
    PRIMARY KEY(Ma_LoaiSP)
);

CREATE TABLE NhanVien(
    Ma_NhanVien VARCHAR(6),
    NgaySinh_NhanVien date,
    Ten_NhanVien NVARCHAR(30),
    DiaChi_NhanVien NVARCHAR(20),
    SDT_NhanVien Char(10),
    Ma_QuanLi VARCHAR(6),
    primary KEY (Ma_NhanVien),
    FOREIGN KEY (Ma_QuanLi) REFERENCES NhanVien(Ma_NhanVien)
);

CREATE TABLE KhachHang(
    SDT_KhachHang Char(10),
    Ten_KhachHang NVARCHAR(30),
    DiaChi_KhachHang NVARCHAR(20),
    GioiTinh_KhachHang NVARCHAR(6),
    NgaySinh_KhachHang Date,
    primary KEY (SDT_KhachHang)
);

CREATE TABLE CaLam(
    ThoiGianQuyDinh varchar(20),
    TenCa NVARCHAR(20),
    PRIMARY KEY (ThoiGianQuyDinh)
);

CREATE TABLE NguyenLieu(
    Ma_NguyenLieu VARCHAR(6),
    Ten_NguyenLieu NVARCHAR(20),
    SoLuong_NguyenLieu Float check (SoLuong_NguyenLieu > 0 ) , -- chú ý
    -- Gia_Nhap INTEGER,
    PRIMARY key (Ma_NguyenLieu)
);

CREATE TABLE SanPham(
    Ma_SP VARCHAR(6),
    Ten_SP NVARCHAR(20),
    Gia_SP INTEGER check(Gia_SP > 0),
    Ma_LoaiSP VARCHAR(6),
    PRIMARY KEY(Ma_SP),
    FOREIGN KEY (Ma_LoaiSP) REFERENCES Loai_SP(Ma_LoaiSP)
);

CREATE TABLE HoaDon(
    Ma_HoaDon VARCHAR(6),
    Ngay_Lap date,
    TongTien_HoaDon INTEGER, -- suy luận logic
    SDT_KhachHang Char(10),
    Ma_NhanVien VARCHAR(6),
    PRIMARY KEY(Ma_HoaDon),
    FOREIGN KEY (SDT_KhachHang) REFERENCES KhachHang(SDT_KhachHang),
    FOREIGN KEY (Ma_NhanVien) REFERENCES NhanVien(Ma_NhanVien)
);

CREATE TABLE PhieuNhap(
    Ma_PhieuNhap VARCHAR(6),
    Ngay_Nhap date,
    TongTien_Nhap Float ,
    Ma_NhanVien varchar(6),
    PRIMARY KEY(Ma_PhieuNhap),
    FOREIGN KEY(Ma_NhanVien) REFERENCES NhanVien(Ma_NhanVien)
);


CREATE TABLE SanPham_NguyenLieu(
    Ma_SP varchar(6),
    Ma_NguyenLieu varchar(6),
    CongThuc Float check (CongThuc > 0), -- chú ý đây là đơn vị nguyên liệu của công thức hay công thức = tp nguyên liệu
    PRIMARY key (Ma_SP,Ma_NguyenLieu),
    FOREIGN KEY (Ma_SP) REFERENCES SanPham(Ma_Sp),
    FOREIGN key (Ma_NguyenLieu) REFERENCES NguyenLieu(Ma_NguyenLieu)
);

CREATE TABLE NguyenLieu_PhieuNhap(
    Ma_NguyenLieu varchar(6),
    Ma_PhieuNhap varchar(6),
    ThoiHan_SuDung DATE,
    SoLuong_Nhap Float check(SoLuong_Nhap > 0),
    DonVi_Tinh NVARCHAR(6),
    Gia_Nhap INTEGER check(Gia_Nhap > 0),
    primary key (Ma_NguyenLieu,Ma_PhieuNhap,ThoiHan_SuDung),
    FOREIGN KEY (Ma_NguyenLieu) REFERENCES NguyenLieu(Ma_NguyenLieu),
    FOREIGN KEY (Ma_PhieuNhap) REFERENCES PhieuNhap(Ma_PhieuNhap)
);

CREATE table SanPham_HoaDon(
    Ma_SP varchar(6),
    Ma_HoaDon varchar(6),
    SoLuong_SP INTEGER check(SoLuong_Sp > 0),
    PRIMARY KEY (Ma_SP,Ma_HoaDon),
    FOREIGN KEY (Ma_SP) REFERENCES SanPham(Ma_Sp),
    FOREIGN KEY (Ma_HoaDon) REFERENCES HoaDon(Ma_HoaDon)
);

CREATE table NhanVien_CaLam(
    Ma_NhanVien VARCHAR(6),
    ThoiGianQuyDinh varchar(20),
    Ngay_Lam DATE,
    ThoiGian_BatDau TIME,
    ThoiGian_KetThuc TIME,
    PRIMARY KEY(Ma_NhanVien,ThoiGianQuyDinh,Ngay_Lam),
    FOREIGN KEY (Ma_NhanVien) REFERENCES NhanVien(Ma_NhanVien),
    FOREIGN KEY (ThoiGianQuyDinh) REFERENCES CaLam(ThoiGianQuyDinh)
);



------------------------------------Trigger------------------------------------


CREATE TRIGGER CapNhat_TongTien_HoaDon
ON SanPham_HoaDon 
for INSERT 
AS

	UPDATE HoaDon
	SET HoaDon.TongTien_HoaDon = A.TongTien 
	From (select Ma_HoaDon, SUM(SanPham_HoaDon.SoLuong_SP *  SanPham.Gia_SP) as TongTien 
	from SanPham_HoaDon 
	INNER JOIN SanPham ON SanPham.Ma_SP = SanPham_HoaDon.Ma_SP 
	GROUP by Ma_HoaDon) as A
	where HoaDon.Ma_HoaDon = A.Ma_HoaDon;

------------------------------------------------------------------------


CREATE TRIGGER CapNhat_TongTien_NhapHang
ON NguyenLieu_PhieuNhap 
for INSERT 
AS
	UPDATE PhieuNhap
	SET PhieuNhap.TongTien_Nhap = A.Gia_Nhap
	FROM PhieuNhap inner join (select Ma_PhieuNhap, Sum(NguyenLieu_PhieuNhap.Gia_Nhap * NguyenLieu_PhieuNhap.SoLuong_Nhap) as Gia_Nhap
	from  NguyenLieu_PhieuNhap INNER join NguyenLieu on NguyenLieu_PhieuNhap.Ma_NguyenLieu = NguyenLieu.Ma_NguyenLieu
	GROUP by Ma_PhieuNhap) as A on PhieuNhap.Ma_PhieuNhap = A.Ma_PhieuNhap;

------------------------------------------------------------------------

CREATE TRIGGER CapNhat_TongSoLuong_NguyenLieu
ON NguyenLieu_PhieuNhap 
for INSERT 
AS

	UPDATE NguyenLieu
	SET NguyenLieu.SoLuong_NguyenLieu = ( B.TongNhap+A.SoLuong_NguyenLieu) 
from NguyenLieu as A inner join (select Ma_NguyenLieu, sum(SoLuong_Nhap) as TongNhap from NguyenLieu_PhieuNhap
group by Ma_NguyenLieu) as B on A.Ma_NguyenLieu= B.Ma_NguyenLieu;

------------------------------------------------------------------------


create Trigger CapNhat_TongSoLuong_NguyenLieu_KhiKhachHangMua
On SanPham_HoaDon
for insert 
as 


Update NguyenLieu
set NguyenLieu.SoLuong_NguyenLieu = (A.SoLuong_NguyenLieu - B.SoLuongLayRa)
from NguyenLieu as A inner join (select SanPham_NguyenLieu.Ma_NguyenLieu,sum(SoLuong_SP * CongThuc) as SoLuongLayRa from SanPham_NguyenLieu inner join SanPham_HoaDon on SanPham_NguyenLieu.Ma_SP = SanPham_HoaDon.Ma_SP
group by SanPham_NguyenLieu.Ma_NguyenLieu ) as B on A.Ma_NguyenLieu = B.Ma_NguyenLieu

-----------------------------------Cursor(Con trỏ)--------------------------------------
begin

DECLARE @SoLuong FLOAT

DECLARE @MaNguyenLieu VARCHAR(6)
DECLARE @Cursor CURSOR

SET @Cursor = CURSOR FOR
SELECT Ma_NguyenLieu FROM NguyenLieu

OPEN @Cursor
FETCH NEXT FROM @Cursor INTO @MaNguyenLieu

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SoLuong = (SELECT SoLuong_NguyenLieu FROM NguyenLieu WHERE Ma_NguyenLieu = @MaNguyenLieu)

    IF @SoLuong < 2
    BEGIN
        PRINT N'Số lượng nguyên liệu của ' + @MaNguyenLieu + N' sắp hết'
    END
    

    FETCH NEXT FROM @Cursor INTO @MaNguyenLieu
END

CLOSE @Cursor
DEALLOCATE @Cursor
END

------------------------------------------------------------------------------




