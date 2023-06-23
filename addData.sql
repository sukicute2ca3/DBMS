insert into Loai_SP
VALUES 
    ('Kem','Kem'),
    ('Qua',N'Trà Hoa Quả'),
    ('Sua',N'Trà Sữa')


INSERT into SanPham
VALUES
    ('Kem001',N'Kem Ốc Quế',10000,'Kem'),
    ('Kem002',N'Hồng Trà Kem',25000,'Kem'),
    ('Kem003',N'Super Sundae Lô Hội',25000,'Kem'),	
    ('Kem004',N'Super Sundae Xoài',25000,'Kem'),
    ('Kem005',N'Super Sundae Socola',25000,'Kem'),
    ('Kem006',N'Sữa Kem Lắc Đào',25000,'Kem'),

    ('Qua001',N'Hồng Trà Chanh',22000,'Qua'),
    ('Qua002',N'Trà Chanh Lô Hội',20000,'Qua'),
    ('Qua003',N'Trà Ô Long 4 Mùa',20000,'Qua'),

    ('Sua001',N'Trà Sữa Bá Vương',30000,'Sua'),
    ('Sua002',N'Trà Sữa Nướng',25000,'Sua'),
    ('Sua003',N'Trà Sữa 3Q',25000,'Sua'),
    ('Sua004',N'Trà Sữa Thạch Dừa',25000,'Sua'),
    ('Sua005',N'Trà Sữa Trân Châu',25000,'Sua');

INSERT into NhanVien
VALUES 
    ('NV001','2003-04-30',N'Phạm Văn Quyết',N'Hưng Yên','0981774713',Null),
    ('NV002','2003-03-19',N'Lê Văn Hoàng',N'Thái Bình','0987654321','NV001'),
    ('NV003','2002-01-01',N'Nguyễn Ngọc Minh',N'Hải Dương','0981234567','NV001');

INSERT into KhachHang
VALUES
    ('0912345876',N'Bùi Trung Đức',N'Yên Bái',N'Nam','2003-12-01'),
    ('0932145678',N'Vũ Thuỳ Dương',N'Hà Nội',N'Nữ','2003-03-13'),
    ('0912365478',N'Kiều Thanh Huyền',N'Nam Định',N'Nữ','2003-05-01'),
	('0981774713',N'Nguyễn Minh Tú',N'Thái Bình',N'Nam','2023-04-06');

INSERT into CaLam
VALUES
    ('8:00 - 13:00',N'Ca Sáng'),
    ('13:00 - 18:00',N'Ca Chiều'),
    ('18:00 - 23:00',N'Ca Tối'),
    ('8:00 - 23:00',N'Cả Ngày');

INSERT into NguyenLieu(Ma_NguyenLieu,Ten_NguyenLieu,SoLuong_NguyenLieu)
VALUES
    ('NL001',N'Bột Sữa Lắc',25),
    ('NL002',N'Bột Trà Sữa',15),
    ('NL003',N'Bột Thực Vật',15),
    ('NL004',N'Sucrose',20),
    ('NL005',N'Nước Trái Cây',25),
    ('NL006',N'Mứt',10),
    ('NL007',N'Trân Châu',5);



INSERT into HoaDon(Ma_HoaDon,Ngay_Lap,TongTien_HoaDon,SDT_KhachHang,Ma_NhanVien)
VALUES
    ('HD001','2023-05-16',0, '0912345876','NV001'),
    ('HD002','2023-05-17',0,'0932145678','NV002'),
    ('HD003','2023-05-18',0,'0912365478','NV003'),
	('HD004','2023-05-19',0,'0981774713','NV003'),
	('HD005','2023-05-24',0,'0981774713','NV002');


INSERT INTO PhieuNhap(Ma_PhieuNhap,Ngay_Nhap,TongTien_Nhap,Ma_NhanVien)
VALUES
    ('PN001','2023-05-16', 0, 'NV001'),
    ('PN002','2023-05-18', 0, 'NV002');




INSERT INTO SanPham_NguyenLieu
VALUES 
    ('Kem001','NL001',0.1),
    ('Kem002','NL002',0.3),
    ('Kem003','NL003',0.2),
    ('Kem003','NL006',0.1),
    ('Kem004','NL003',0.25),
    ('Kem004','NL006',0.05),
    ('Kem005','NL003',0.2),
    ('Kem005','NL004',0.1),
    ('Kem006','NL003',0.2),
    ('Kem006','NL006',0.05),
    ('Kem006','NL004',0.05),

    ('Qua001','NL005',0.15),
    ('Qua001','NL004',0.1),
    ('Qua002','NL005',0.2),
    ('Qua002','NL004',0.05),
    ('Qua003','NL005',0.1),
    ('Qua003','NL004',0.15),

    ('Sua001','NL001',0.15),
    ('Sua001','NL002',0.15),
    ('Sua002','NL002',0.15),
    ('Sua002','NL003',0.1),
    ('Sua002','NL004',0.05),
    ('Sua003','NL001',0.15),
    ('Sua003','NL003',0.1),
    ('Sua003','NL004',0.05),
    ('Sua004','NL001',0.15),
    ('Sua004','NL002',0.1),
    ('Sua004','NL004',0.05),
    ('Sua005','NL002',0.15),
    ('Sua005','NL004',0.05),
    ('Sua005','NL007',0.1);
   

INSERT INTO NguyenLieu_PhieuNhap
VALUES
    ('NL001','PN001', '2025-05-16', 3, 'Kg', 25000),
    ('NL002','PN001', '2025-05-16', 3, 'Kg', 25000),
    ('NL003','PN001', '2025-05-16', 3, 'Kg', 20000),
    ('NL004','PN001', '2025-05-16', 2, N'Hộp', 15000),
    ('NL005','PN001', '2025-05-16', 2, N'Hộp', 35000),
    ('NL006','PN001', '2025-05-16', 2, N'Hộp', 30000),
    ('NL007','PN001', '2025-05-16', 2, N'Hộp', 20000),
    ('NL001','PN002', '2025-05-16', 4, 'Kg', 25000),
    ('NL003','PN002', '2025-05-16', 1, 'Kg', 20000),
	('NL005','PN002','2025-05-16', 4,  N'Hộp', 25000);

   

INSERT INTO SanPham_HoaDon
VALUES
    ('Kem001','HD001',1),
    ('Kem002','HD001',1),

    ('Kem001','HD002',1),
    ('Qua003','HD002',1),

    ('Kem001','HD003',3),
	('Kem001','HD004',2),
    ('Qua003','HD004',1),

	('Sua005','HD005',2),
    ('Qua003','HD005',1);


INSERT INTO NhanVien_CaLam
VALUES

    ('NV001','8:00 - 23:00','2023-05-16','8:00','23:00'),
    ('NV002','8:00 - 13:00','2023-05-16','8:00','13:00'),
    ('NV002','13:00 - 18:00','2023-05-16','13:00','18:00'),
    ('NV003','18:00 - 23:00','2023-05-16','18:00','23:00'),

    ('NV001','8:00 - 23:00','2023-05-17','8:00','23:00'),
    ('NV002','8:00 - 13:00','2023-05-17','8:00','13:00'),
    ('NV003','13:00 - 18:00','2023-05-17','13:00','18:00'),
    ('NV003','18:00 - 23:00','2023-05-17','18:00','23:00'),

    ('NV001','8:00 - 23:00','2023-05-18','8:00','23:00'),
    ('NV003','8:00 - 13:00','2023-05-18','8:00','13:00'),
    ('NV002','13:00 - 18:00','2023-05-18','13:00','18:00'),
    ('NV002','18:00 - 23:00','2023-05-18','18:00','23:00');



	

------------------------------------------------------------------------------
INSERT INTO PhieuNhap(Ma_PhieuNhap,Ngay_Nhap,TongTien_Nhap,Ma_NhanVien)
VALUES
    ('PN003','2023-05-20', 0, 'NV001')
INSERT INTO NguyenLieu_PhieuNhap
VALUES
    ('NL001','PN003', '2025-05-20', 3, 'Kg', 25000),
	('NL003','PN003', '2025-05-20', 3, 'Kg', 20000);


insert into HoaDon
VALUES('HD006','2023-05-26',0,'0932145678','NV001')

insert into SanPham_HoaDon
VALUES
('Kem001','HD006',1),
('Qua002','HD006',1),
('Sua003','HD006',1);

insert into KhachHang
values
('0559939520',N'Mai Vân Anh',N'Hà Nội',N'Nữ','2004-04-01')
insert into HoaDon
VALUES
('HD007','2023-05-28',0,'0559939520','NV001')
insert into SanPham_HoaDon
values
('Kem002','HD007',2)


insert into KhachHang
values
('0559939521',N'Lê Nguyễn Phương Anh',N'Hồ Chí Minh',N'Nữ','2004-08-06')
insert into HoaDon
VALUES
('HD009','2023-05-28',0,'0559939520','NV001')

insert into SanPham_HoaDon
values
('kem002','HD008',1);

insert into HoaDon
VALUES
('HD009','2023-05-28',0,'0559939520','NV001')

insert into SanPham_HoaDon
values
('kem002','HD009',1),
('Qua001','HD009',1);
insert into HoaDon
VALUES
('HD010','2023-05-28',0,'0559939521','NV001')

insert into SanPham_HoaDon
values
('kem002','HD010',2);



Select * from KhachHang
select * from HoaDon