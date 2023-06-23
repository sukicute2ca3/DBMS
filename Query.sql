--1. Truy vấn về loại sản phẩm (Loai_SP):
--1.1.  Lấy danh sách tất cả loại sản phẩm.
	select * from Loai_SP
--1.2. Tìm loại sản phẩm có tên là "Trà Sữa".
	select * from Loai_SP where Ten_LoaiSP = N'Trà Sữa'
--1.3. Liệt kê loại sản phẩm theo mã loại sản phẩm.
	select SanPham.Ma_LoaiSP, Ten_SP, Gia_SP, Ten_LoaiSP from SanPham inner join Loai_SP on SanPham.Ma_LoaiSP = Loai_SP.Ma_LoaiSP
--2. Truy vấn về ca làm (CaLam):
--2.1. Lấy danh sách tất cả các ca làm.
	select TenCa from CaLam  
--2.2. Tìm ca làm có tên là "Ca Tối".
	select * from CaLam where TenCa = N'Ca Tối'
--2.3. Liệt kê ca làm theo thời gian quy định.
	select * from CaLam 
--3. Truy vấn về nguyên liệu trong phiếu nhập (NguyenLieu_PhieuNhap):
--3.1. Lấy danh sách tất cả nguyên liệu trong phiếu nhập.
--sửa
	Select * from PhieuNhap inner join NguyenLieu_PhieuNhap on PhieuNhap.Ma_PhieuNhap = NguyenLieu_PhieuNhap.Ma_PhieuNhap
--4. Truy vấn về công thức sản phẩm (SanPham_NguyenLieu):
--4.1. Lấy danh sách tất cả công thức sản phẩm.
	select * from SanPham_NguyenLieu
--4.2. Tìm công thức sản phẩm với mã sản phẩm là "Kem006".
	select * from SanPham_NguyenLieu where Ma_SP = N'Kem006'
--4.3. Liệt kê các sản phẩm được làm ra từ "Bột Sữa Lắc".
	select A.Ma_SP, Ten_SP, Gia_SP from SanPham as A inner join 
	(select NguyenLieu.Ma_NguyenLieu, Ten_NguyenLieu, SanPham_NguyenLieu.Ma_SP from SanPham_NguyenLieu inner join  NguyenLieu on SanPham_NguyenLieu.Ma_NguyenLieu = NguyenLieu.Ma_NguyenLieu) as B
	on A.Ma_SP = B.Ma_SP where Ten_NguyenLieu = N'Bột Sữa Lắc'
--5. Truy vấn về nhân viên làm việc trong ca làm (NhanVien_CaLam):
--5.1. Lấy danh sách tất cả nhân viên làm việc trong ca làm.
	select * from NhanVien_CaLam
--5.2. Tìm nhân viên làm việc trong ca làm có thời gian quy định là "8:00 - 23:00" vào ngày '2023-05-17'.
	
	select A.Ma_NhanVien, Ten_NhanVien, SDT_NhanVien
	from(select * from NhanVien_CaLam where ThoiGianQuyDinh = '8:00 - 23:00' and Ngay_Lam = '2023-05-17')
	as A inner join NhanVien as b on A.Ma_NhanVien = B.Ma_NhanVien
--5.3. Liệt kê nhân viên làm việc ca '8:00 - 23:00' trong tháng 5.
	select A.Ma_NhanVien, Ten_NhanVien, SDT_NhanVien from (select Ma_NhanVien from NhanVien_CaLam
	where ThoiGianQuyDinh = '8:00 - 23:00' and Ngay_Lam like '%-05-%'
	group by Ma_NhanVien) as A inner join NhanVien as B
	on A.Ma_NhanVien = B.Ma_NhanVien
--6. Truy vấn về sản phẩm trong hóa đơn (SanPham_HoaDon):
--6.1. Lấy danh sách tất cả sản phẩm trong hóa đơn.

	select DISTINCT Ma_SP from SanPham_HoaDon

	--6.1.1. Sản phẩm nào bán được nhiều nhất
		SELECT A.*, B.TongSoLuong_SP
		FROM SanPham AS A INNER JOIN (
		SELECT Ma_SP, SUM(SoLuong_SP) AS TongSoLuong_SP
		FROM HoaDon INNER JOIN SanPham_HoaDon ON HoaDon.Ma_HoaDon = SanPham_HoaDon.Ma_HoaDon
		GROUP BY Ma_SP HAVING SUM(SoLuong_SP) = (
			SELECT MAX(TongSoLuong_SP)
			FROM (
				SELECT Ma_SP, SUM(SoLuong_SP) AS TongSoLuong_SP
				FROM HoaDon INNER JOIN SanPham_HoaDon ON HoaDon.Ma_HoaDon = SanPham_HoaDon.Ma_HoaDon
				GROUP BY Ma_SP) AS T) ) AS B ON A.Ma_SP = B.Ma_SP;
	--6.1.2. Hóa đơn có tổng tiền lớn nhất
		select A.* from HoaDon as A inner join
		(select Max(TongTien_HoaDon) as TongTien_HoaDon from HoaDon) as B on A.TongTien_HoaDon = B.TongTien_HoaDon
	--6.1.3. Tổng tiền hóa đơn trong tháng 5
		select Sum(TongTien_HoaDon) as TongTien_TatCa_HoaDon from HoaDon
		where Ngay_Lap like '%-05-%'
	--6.1.4. Các khách hàng mua Sản phẩm 'Kem Ốc Quế' và số lượng mua
		select F.SDT_KhachHang, Ten_KhachHang, sum(SoLuong_SP) as SoSanPhamMua from KhachHang as E inner join
		(select D.*, SDT_KhachHang from HoaDon as C inner join
		(select A.Ma_SP,Ten_SP,Ma_HoaDon, SoLuong_SP  from SanPham as A inner join (select * from SanPham_HoaDon) as B on A.Ma_SP = B.Ma_SP) as D on
		C.Ma_HoaDon = D.Ma_HoaDon) as F on E.SDT_KhachHang = F.SDT_KhachHang
		where Ten_SP = N'Kem Ốc Quế'
		group by F.SDT_KhachHang,Ten_KhachHang
	--6.1.5. Liệt kê các sản phẩm chưa có ai mua 
		select A.Ma_SP,Ten_SP from SanPham as A left join (
		select DISTINCT  Ma_SP from SanPham_HoaDon) as B on A.Ma_SP = B.Ma_SP
		where B.Ma_SP is NULL
	--6.1.6. Tổng số tiền mà mỗi sản phẩm được bán ra
		select A.Ma_SP,B.Tong_SoLuong*Gia_SP as TongTien_SanPham from SanPham as A inner join(
		select Ma_SP, sum(SoLuong_SP) as Tong_SoLuong from SanPham_HoaDon
		group by Ma_SP) as B on A.Ma_SP =B.Ma_SP
--6.2. Tìm sản phẩm trong hóa đơn với mã hóa đơn là "HD001".
	select Ma_HoaDon, Ten_SP, SoLuong_SP, Gia_SP from (select * from SanPham_HoaDon where Ma_HoaDon = 'HD001') as A
	inner join SanPham as B on A.Ma_SP = B.Ma_SP
--7. Truy vấn về thông tin nhân viên (NhanVien):
--7.1. Lấy danh sách tất cả nhân viên.
	select * from NhanVien
	--7.1.1. Tìm nhân viên bán được nhiều hóa đơn nhất
		select NhanVien.Ma_NhanVien, count(NhanVien.Ma_NhanVien) as SoHoaDonBanDuoc from NhanVien inner join HoaDon on NhanVien.Ma_NhanVien = HoaDon.Ma_NhanVien
		group by NhanVien.Ma_NhanVien
	--7.1.2. Tìm nhân viên bán được nhiều tiền nhất
		select Top 1 NhanVien.Ma_NhanVien,  sum(TongTien_HoaDon) as TongTienBan from NhanVien inner join HoaDon on NhanVien.Ma_NhanVien = HoaDon.Ma_NhanVien
		group by NhanVien.Ma_NhanVien ORDER BY TongTienBan DESC;
	--7.1.3. Xem quản lí của nhân viên

		select Ma_NhanVien,Ten_NhanVien, Ma_QuanLi from NhanVien
--7.2. Tìm nhân viên có tên là "Phạm Văn Quyết".
	select * from NhanVien where Ten_NhanVien = N'Phạm Văn Quyết'
	--7.2.1. Nhân viên có tên là "Phạm Văn Quyết" có đi làm vào ngày '2023-05-16'
		select NhanVien.Ma_NhanVien, Ten_NhanVien,SDT_NhanVien, Ngay_Lam, ThoiGian_BatDau,ThoiGian_KetThuc from NhanVien inner join NhanVien_CaLam on NhanVien.Ma_NhanVien = NhanVien_CaLam.Ma_NhanVien
		where Ten_NhanVien = N'Phạm Văn Quyết' and Ngay_Lam = '2023-05-16'
--7.3. Liệt kê nhân viên theo địa chỉ.
	select * from NhanVien where DiaChi_NhanVien = N'Hải Dương'
	--7.3.1. Có bao nhiêu nhân viên ở Hải Dương
		select count(Ma_NhanVien) as SoNhanVien_DiaChi_HaiDuong from NhanVien
		where DiaChi_NhanVien = N'Hải Dương'
		group by Ma_NhanVien
--8. Truy vấn về thông tin khách hàng (KhachHang):
--8.1. Lấy danh sách tất cả khách hàng.
	select * from KhachHang 
	--8.1.1. Tìm khách hàng mua nhiều lần nhất.
		select KhachHang.SDT_KhachHang, Ten_KhachHang, D.SoHoaDon from KhachHang inner join (
		select SDT_KhachHang, A.SoHoaDon from
		(select KhachHang.SDT_KhachHang, count(KhachHang.SDT_KhachHang) as SoHoaDon from KhachHang
		inner join HoaDon on KhachHang.SDT_KhachHang = HoaDon.SDT_KhachHang
		group by KhachHang.SDT_KhachHang) as A
		inner join
		(select max(B.SoHoaDon) as SoHoaDon
		from(
		select count(KhachHang.SDT_KhachHang) as SoHoaDon from KhachHang inner join HoaDon on KhachHang.SDT_KhachHang = HoaDon.SDT_KhachHang
		group by KhachHang.SDT_KhachHang)as B ) as C  on A.SoHoaDon = C.SoHoaDon ) as D on KhachHang.SDT_KhachHang = D.SDT_KhachHang
			
--8.2. Tìm khách hàng có số điện thoại là "0559939520".
	select * from KhachHang where SDT_KhachHang = '0559939520'
-- 8.3. Liệt kê khách hàng theo giới tính.
	select * from KhachHang 
	order by GioiTinh_KhachHang
--9. Truy vấn về hóa đơn (HoaDon):
--9.1. Lấy danh sách tất cả hóa đơn.
	select * from HoaDon --TongTien_HoaDon là thuộc tính suy diễn nên em sử dụng trigger
	--9.1.1. liệt kê xem nhân viên đã lập được tổng bao nhiêu hóa đơn
		select Ma_NhanVien,count(Ma_NhanVien) as Tong_SoHoaDon from HoaDon
		group by Ma_NhanVien
--9.2. Tìm hóa đơn được lập vào ngày "2023-05-28".
	select * from HoaDon where Ngay_Lap = '2023-05-28'
--9.3. Liệt kê hóa đơn theo mã nhân viên.
	select * from HoaDon 
	order by Ma_NhanVien
--10. Truy vấn về phiếu nhập (PhieuNhap):
--10.1. Lấy danh sách tất cả phiếu nhập.
	select * from PhieuNhap --TongTien_Nhap là thuộc tính suy diễn em sử dụng trigger
--10.2. Tìm phiếu nhập được nhập vào ngày "2023-05-18".
	select * from PhieuNhap 
	where Ngay_Nhap = '2023-05-18'
--10.3. Liệt kê phiếu nhập theo mã nhân viên.
	select * from PhieuNhap
	order by Ma_NhanVien
--11. Truy vấn về thông tin sản phẩm (SanPham):
--11.1. Truy vấn về thông tin sản phẩm (SanPham):
	select * from SanPham
--11.2.	Tìm sản phẩm có giá lớn hơn 20000.
	select * from SanPham 
	where Gia_SP > 20000
	order by Gia_SP
--11.3. Liệt kê sản phẩm theo loại sản phẩm.
	select * from SanPham
	order by Ma_LoaiSP
--12. Truy vấn về thông tin nguyên liệu (NguyenLieu):
--12.1. Lấy danh sách tất cả nguyên liệu.
	select * from NguyenLieu
	--12.1. Thông báo Nguyên Liệu sắp hết hạn 
		SELECT *
		FROM NguyenLieu_PhieuNhap
		WHERE DATEADD(year, 0, ThoiHan_SuDung) <= DATEADD(MONTH, 1, GETDATE());
		-- DATEADD(year, 0, ThoiHan_SuDung) được sử dụng để tính toán ngày hết hạn của sản phẩm
		--  DATEADD(MONTH, 1, GETDATE()) được sử dụng để tính toán ngày hiện tại trong 1 tháng nữa.
	--Số lượng nguyên liệu là thuộc tính suy diễn em sử dụng trigger và em có sử dụng con trỏ để thông báo nguyên liệu sắp hết(insert SanPham_HoaDon)
--12.2. Tìm nguyên liệu có số lượng lớn hơn 20.
	select * from NguyenLieu
	where SoLuong_NguyenLieu > 20
--12.3. Liệt kê nguyên liệu theo tên nguyên liệu.
	select * from NguyenLieu
	order by Ten_NguyenLieu

