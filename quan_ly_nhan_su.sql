
CREATE DATABASE IF NOT EXISTS `quan_ly_nhan_su`;
USE `quan_ly_nhan_su`;

CREATE TABLE `qlnv_chamcong` (
  `id` int(11) NOT NULL,
  `MaNV` varchar(8) NOT NULL,
  `Ngay` date NOT NULL,
  `GioVao` time NOT NULL,
  `GioRa` time NOT NULL,
  `OT` tinyint(1) NOT NULL,
  `ThoiGianLamViec` time NOT NULL,
  `ThoiGian_thap_phan` float NOT NULL,
  `status` ENUM('pending', 'approved', 'rejected') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_chamcong`
--

--
-- Triggers `qlnv_chamcong`
--
DELIMITER $$
CREATE TRIGGER `before_insert_to_cham_cong` BEFORE INSERT ON `qlnv_chamcong` FOR EACH ROW BEGIN
            SET NEW.ThoiGianLamViec = '08:00:00';
            SET NEW.ThoiGian_thap_phan = 1;
       END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_update_to_cham_cong` BEFORE UPDATE ON `qlnv_chamcong` FOR EACH ROW BEGIN
            SET NEW.ThoiGianLamViec = '08:00:00';
            SET NEW.ThoiGian_thap_phan = 1;
       END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_chamcongngay`
--

CREATE TABLE `qlnv_chamcongngay` (
  `MaChamCong` int(11) NOT NULL,
  `MaNV` varchar(8) NOT NULL,
  `Nam` year(4) NOT NULL DEFAULT (YEAR(CURDATE())),
  `Thang` int(11) NOT NULL,
  `SoNgayThang` int(11) NOT NULL,
  `Ngay1` float NOT NULL DEFAULT -1,
  `Ngay2` float NOT NULL DEFAULT -1,
  `Ngay3` float NOT NULL DEFAULT -1,
  `Ngay4` float NOT NULL DEFAULT -1,
  `Ngay5` float NOT NULL DEFAULT -1,
  `Ngay6` float NOT NULL DEFAULT -1,
  `Ngay7` float NOT NULL DEFAULT -1,
  `Ngay8` float NOT NULL DEFAULT -1,
  `Ngay9` float NOT NULL DEFAULT -1,
  `Ngay10` float NOT NULL DEFAULT -1,
  `Ngay11` float NOT NULL DEFAULT -1,
  `Ngay12` float NOT NULL DEFAULT -1,
  `Ngay13` float NOT NULL DEFAULT -1,
  `Ngay14` float NOT NULL DEFAULT -1,
  `Ngay15` float NOT NULL DEFAULT -1,
  `Ngay16` float NOT NULL DEFAULT -1,
  `Ngay17` float NOT NULL DEFAULT -1,
  `Ngay18` float NOT NULL DEFAULT -1,
  `Ngay19` float NOT NULL DEFAULT -1,
  `Ngay20` float NOT NULL DEFAULT -1,
  `Ngay21` float NOT NULL DEFAULT -1,
  `Ngay22` float NOT NULL DEFAULT -1,
  `Ngay23` float NOT NULL DEFAULT -1,
  `Ngay24` float NOT NULL DEFAULT -1,
  `Ngay25` float NOT NULL DEFAULT -1,
  `Ngay26` float NOT NULL DEFAULT -1,
  `Ngay27` float NOT NULL DEFAULT -1,
  `Ngay28` float NOT NULL DEFAULT -1,
  `Ngay29` float NOT NULL DEFAULT -1,
  `Ngay30` float NOT NULL DEFAULT -1,
  `Ngay31` float NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_chamcongngay`
--


-- --------------------------------------------------------

--
-- Table structure for table `qlnv_chamcongthang`
--

CREATE TABLE `qlnv_chamcongthang` (
  `id` int(11) NOT NULL,
  `MaNV` varchar(8) NOT NULL,
  `Nam` year(4) NOT NULL DEFAULT (YEAR(CURDATE())),
  `T1` float NOT NULL DEFAULT -1,
  `T2` float NOT NULL DEFAULT -1,
  `T3` float NOT NULL DEFAULT -1,
  `T4` float NOT NULL DEFAULT -1,
  `T5` float NOT NULL DEFAULT -1,
  `T6` float NOT NULL DEFAULT -1,
  `T7` float NOT NULL DEFAULT -1,
  `T8` float NOT NULL DEFAULT -1,
  `T9` float NOT NULL DEFAULT -1,
  `T10` float NOT NULL DEFAULT -1,
  `T11` float NOT NULL DEFAULT -1,
  `T12` float NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_chamcongthang`
--


-- --------------------------------------------------------

--
-- Table structure for table `qlnv_chamcongtongketthang`
--

CREATE TABLE `qlnv_chamcongtongketthang` (
  `Id` int(11) NOT NULL,
  `MaNhanVien` varchar(8) NOT NULL,
  `Nam` year(4) NOT NULL,
  `Thang` int(11) NOT NULL,
  `SoNgayDiLam` int(11) NOT NULL DEFAULT 0,
  `SoNgayDiVang` int(11) NOT NULL DEFAULT 0,
  `SoNgayTangCa` int(11) NOT NULL DEFAULT 0,
  `TongSoNgay` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_chamcongtongketthang`
--


--
-- Triggers `qlnv_chamcongtongketthang`
--
DELIMITER $$
CREATE TRIGGER `delete_tongket_luong` BEFORE DELETE ON `qlnv_chamcongtongketthang` FOR EACH ROW BEGIN
    DELETE FROM `qlnv_luong`
    WHERE MaNV = OLD.MaNhanVien AND Nam = OLD.Nam AND Thang = OLD.Thang;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_data_tongket_tinh_luong` BEFORE INSERT ON `qlnv_chamcongtongketthang` FOR EACH ROW BEGIN
    DECLARE tongNgayCong double;
    DECLARE luongDuocNhan double;
    DECLARE soNgayChuan double;
    DECLARE sotienphat double;
    DECLARE sotienthuong double;
    DECLARE luongCoDinh double;
    DECLARE luongchamcong double;
    DECLARE donGiaNgay double;

    SET soNgayChuan = NEW.SoNgayDiLam + NEW.SoNgayDiVang;

    IF (NEW.Thang = 1) THEN
        SET tongNgayCong = (SELECT cct.T1 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 2) THEN
        SET tongNgayCong = (SELECT cct.T2 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 3) THEN
        SET tongNgayCong = (SELECT cct.T3 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 4) THEN
        SET tongNgayCong = (SELECT cct.T4 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 5) THEN
        SET tongNgayCong = (SELECT cct.T5 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 6) THEN
        SET tongNgayCong = (SELECT cct.T6 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 7) THEN
        SET tongNgayCong = (SELECT cct.T7 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 8) THEN
        SET tongNgayCong = (SELECT cct.T8 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 9) THEN
        SET tongNgayCong = (SELECT cct.T9 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 10) THEN
        SET tongNgayCong = (SELECT cct.T10 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 11) THEN
        SET tongNgayCong = (SELECT cct.T11 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSE
        SET tongNgayCong = (SELECT cct.T12 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    END IF;

    IF tongNgayCong IS NULL OR tongNgayCong = -1 THEN
        SET tongNgayCong = 0;
    END IF;

    SET luongCoDinh = (SELECT nv.Luong FROM qlnv_nhanvien nv WHERE nv.MaNhanVien = NEW.MaNhanVien);
    IF luongCoDinh IS NULL THEN
        SET luongCoDinh = 0;
    END IF;

    IF soNgayChuan <= 0 THEN
        SET donGiaNgay = 0;
    ELSE
        SET donGiaNgay = luongCoDinh / soNgayChuan;
    END IF;

    SET luongchamcong = ROUND(tongNgayCong * donGiaNgay, -3);

    SET sotienphat = (SELECT SUM(tp.Tien)
                      FROM qlnv_thuongphat tp
                      WHERE tp.MaNV = NEW.MaNhanVien AND MONTH(tp.Ngay) = NEW.Thang
                     AND YEAR(tp.Ngay) = NEW.Nam AND tp.Loai = 1);

    IF sotienphat IS NULL THEN
        SET sotienphat = 0;
     END IF;


    SET sotienthuong = (SELECT SUM(tp.Tien)
                      FROM qlnv_thuongphat tp
                      WHERE tp.MaNV = NEW.MaNhanVien AND MONTH(tp.Ngay) = NEW.Thang
                     AND YEAR(tp.Ngay) = NEW.Nam AND tp.Loai = 0);

    IF sotienthuong IS NULL THEN
        SET sotienthuong = 0;
     END IF;

    -- Thưởng chuyên cần nếu đi làm đủ 27 ngày
    IF tongNgayCong >= 27 THEN
        SET sotienthuong = sotienthuong + 500000;
    END IF;

    SET luongDuocNhan = ROUND(luongchamcong - sotienphat + sotienthuong, -3);

    INSERT INTO `qlnv_luong` (`id`, `MaNV`, `Nam`, `Thang`, `LuongCoDinh`, `LuongChamCong`, `SoTienThuong`, `SoTienPhat`, `TongSoTien`)
    VALUES (NULL, NEW.MaNhanVien, NEW.Nam, NEW.Thang, luongCoDinh, luongchamcong, sotienthuong, sotienphat, luongDuocNhan);

    END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_tongketthang_luong` AFTER UPDATE ON `qlnv_chamcongtongketthang` FOR EACH ROW BEGIN
    DECLARE tongNgayCong double;
    DECLARE luongCoDinh double;
    DECLARE soNgayChuan double;
    DECLARE sotienphat double;
    DECLARE luongchamcong double;
    DECLARE luongDuocNhan double;
    DECLARE sotienthuong double;
    DECLARE donGiaNgay double;

    SET soNgayChuan = NEW.SoNgayDiLam + NEW.SoNgayDiVang;

    IF (NEW.Thang = 1) THEN
        SET tongNgayCong = (SELECT cct.T1 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 2) THEN
        SET tongNgayCong = (SELECT cct.T2 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 3) THEN
        SET tongNgayCong = (SELECT cct.T3 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 4) THEN
        SET tongNgayCong = (SELECT cct.T4 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 5) THEN
        SET tongNgayCong = (SELECT cct.T5 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 6) THEN
        SET tongNgayCong = (SELECT cct.T6 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 7) THEN
        SET tongNgayCong = (SELECT cct.T7 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 8) THEN
        SET tongNgayCong = (SELECT cct.T8 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 9) THEN
        SET tongNgayCong = (SELECT cct.T9 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 10) THEN
        SET tongNgayCong = (SELECT cct.T10 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSEIF (NEW.Thang = 11) THEN
        SET tongNgayCong = (SELECT cct.T11 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    ELSE
        SET tongNgayCong = (SELECT cct.T12 FROM qlnv_chamcongthang cct WHERE cct.Nam = NEW.Nam AND NEW.MaNhanVien = cct.MaNV);
    END IF;

    IF tongNgayCong IS NULL OR tongNgayCong = -1 THEN
        SET tongNgayCong = 0;
    END IF;

    SET luongCoDinh = (SELECT l.LuongCoDinh FROM qlnv_luong l WHERE NEW.MaNhanVien = l.MaNV AND NEW.Nam = l.Nam AND New.Thang = l.Thang);
    IF luongCoDinh IS NULL THEN
        SET luongCoDinh = 0;
    END IF;

    IF soNgayChuan <= 0 THEN
        SET donGiaNgay = 0;
    ELSE
        SET donGiaNgay = luongCoDinh / soNgayChuan;
    END IF;

    SET luongchamcong = ROUND(tongNgayCong * donGiaNgay, -3);

    SET sotienphat = (SELECT SUM(tp.Tien)
                      FROM qlnv_thuongphat tp
                      WHERE tp.MaNV = NEW.MaNhanVien AND MONTH(tp.Ngay) = NEW.Thang
                     AND YEAR(tp.Ngay) = NEW.Nam AND tp.Loai = 1);

    IF sotienphat IS NULL THEN
        SET sotienphat = 0;
     END IF;


    SET sotienthuong = (SELECT SUM(tp.Tien)
                      FROM qlnv_thuongphat tp
                      WHERE tp.MaNV = NEW.MaNhanVien AND MONTH(tp.Ngay) = NEW.Thang
                     AND YEAR(tp.Ngay) = NEW.Nam AND tp.Loai = 0);

    IF sotienthuong IS NULL THEN
        SET sotienthuong = 0;
     END IF;

    -- Thưởng chuyên cần nếu đi làm đủ 27 ngày
    IF tongNgayCong >= 27 THEN
        SET sotienthuong = sotienthuong + 500000;
    END IF;

    SET luongDuocNhan = ROUND(luongchamcong - sotienphat + sotienthuong, -3);

    UPDATE `qlnv_luong`
    SET `LuongChamCong`= luongchamcong, 
        `SoTienThuong` = CASE WHEN ManualEdit = 0 THEN sotienthuong ELSE SoTienThuong END,
        `SoTienPhat` = CASE WHEN ManualEdit = 0 THEN sotienphat ELSE SoTienPhat END,
        `TongSoTien` = ROUND(luongchamcong - SoTienPhat + SoTienThuong, -3)
    WHERE MaNV = NEW.MaNhanVien AND Nam = NEW.Nam AND Thang = New.Thang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_chucvu`
--

CREATE TABLE `qlnv_chucvu` (
  `MaCV` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `TenCV` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `qlnv_chucvu`
--

INSERT INTO `qlnv_chucvu` (`MaCV`, `TenCV`) VALUES
('GD', 'Giám đốc'),
('NV', 'Nhân viên'),
('TTS', 'Thực tập sinh');

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_congty`
--

CREATE TABLE `qlnv_congty` (
  `ID` int(11) NOT NULL,
  `TenCongTy` varchar(100) NOT NULL,
  `DiaChi` varchar(100) NOT NULL,
  `LogoPath` varchar(100) NOT NULL,
  `SoDienThoai` varchar(11) NOT NULL,
  `MaSoDoanhNghiep` varchar(20) NOT NULL,
  `NgayThanhLap` date NOT NULL DEFAULT (CURDATE())
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_congty`
--

INSERT INTO `qlnv_congty` (`ID`, `TenCongTy`, `DiaChi`, `LogoPath`, `SoDienThoai`, `MaSoDoanhNghiep`, `NgayThanhLap`) VALUES
(1, 'Công ty tư vấn giải pháp phần mềm quản lý nhân sự', '334 Đ. Nguyễn Trãi, Thanh Xuân Trung, Thanh Xuân, Hà Nội', 'web/img/favicon.png', '0986259999', '0869886889', '2022-12-18');

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_hopdong`
--

CREATE TABLE `qlnv_hopdong` (
  `id` int(11) NOT NULL,
  `MaHopDong` varchar(8) NOT NULL,
  `LoaiHopDong` varchar(30) NOT NULL,
  `NgayBatDau` date NOT NULL,
  `NgayKetThuc` date DEFAULT NULL,
  `GhiChu` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_hopdong`
--

INSERT INTO `qlnv_hopdong` (`id`, `MaHopDong`, `LoaiHopDong`, `NgayBatDau`, `NgayKetThuc`, `GhiChu`) VALUES
(1, 'HD0001', 'Hop dong lao dong', '2024-01-01', NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_imagedata`
--

CREATE TABLE `qlnv_imagedata` (
  `ID_image` varchar(40) NOT NULL,
  `PathToImage` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_imagedata`
--

INSERT INTO `qlnv_imagedata` (`ID_image`, `PathToImage`) VALUES
('logo_web', 'web/img/favicon.png'),
('none_image_profile', 'web/img/No_Image.png');

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_luong`
--

CREATE TABLE `qlnv_luong` (
  `id` int(11) NOT NULL,
  `MaNV` varchar(8) NOT NULL,
  `Nam` year(4) NOT NULL,
  `Thang` int(11) NOT NULL,
  `LuongCoDinh` double NOT NULL,
  `LuongChamCong` double NOT NULL,
  `SoTienThuong` double NOT NULL DEFAULT 0,
  `SoTienPhat` double NOT NULL DEFAULT 0,
  `TongSoTien` double NOT NULL,
  `ManualEdit` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_luong`
--


-- --------------------------------------------------------

--
-- Table structure for table `qlnv_nhanvien`
--

CREATE TABLE `qlnv_nhanvien` (
  `MaNhanVien` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `MaChucVu` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `MaPhongBan` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `Luong` double NOT NULL,
  `GioiTinh` varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Nam',
  `MaHD` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `TenNV` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `NgaySinh` date NOT NULL,
  `NoiSinh` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `SoCMT` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `DienThoai` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `DiaChi` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `TTHonNhan` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Độc thân',
  `DanToc` varchar(10) COLLATE utf8_unicode_ci DEFAULT 'Kinh',
  `MATDHV` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NgayCMND` date DEFAULT NULL,
  `NoiCMND` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BHYT` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `BHXH` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `ID_profile_image` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'none_image_profile'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `qlnv_nhanvien`
--

INSERT INTO `qlnv_nhanvien` (`MaNhanVien`, `MaChucVu`, `MaPhongBan`, `Luong`, `GioiTinh`, `MaHD`, `TenNV`, `NgaySinh`, `NoiSinh`, `SoCMT`, `DienThoai`, `DiaChi`, `Email`, `TTHonNhan`, `DanToc`, `MATDHV`, `NgayCMND`, `NoiCMND`, `BHYT`, `BHXH`, `ID_profile_image`) VALUES
('AD001', 'GD', 'PBGD', 15000000, 'Nam', 'HD0001', 'Quan tri vien', '1990-01-01', 'Viet Nam', '012345678901', '0900000000', 'Ha Noi', 'admin@example.com', 'Doc than', 'Kinh', NULL, NULL, NULL, '', '', 'none_image_profile');

--
-- Triggers `qlnv_nhanvien`
--
DELIMITER $$
CREATE TRIGGER `befor_update_nhanvien` BEFORE UPDATE ON `qlnv_nhanvien` FOR EACH ROW BEGIN
    IF NEW.MaChucVu != OLD.MaChucVu THEN
    	UPDATE qlnv_thoigiancongtac tg SET tg.DuongNhiem = 0, tg.NgayKetThuc = CURRENT_DATE() WHERE tg.MaNV = OLD.MaNhanVien AND tg.DuongNhiem = 1;
        INSERT INTO qlnv_thoigiancongtac(MaNV, MaCV, NgayNhanChuc, NgayKetThuc, DuongNhiem) VALUES (OLD.MaNhanVien, NEW.MaChucVu, CURRENT_DATE(), NULL, '1');   	
        
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_phanquyenuser`
--

CREATE TABLE `qlnv_phanquyenuser` (
  `id_user` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_phanquyenuser`
--

INSERT INTO `qlnv_phanquyenuser` (`id_user`, `role_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_phongban`
--

CREATE TABLE `qlnv_phongban` (
  `MaPB` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `TenPB` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `diachi` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sodt` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MaTruongPhong` varchar(8) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `qlnv_phongban`
--

INSERT INTO `qlnv_phongban` (`MaPB`, `TenPB`, `diachi`, `sodt`, `MaTruongPhong`) VALUES
('PBGD', 'Quan ly', NULL, NULL, 'AD001');

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_role`
--

CREATE TABLE `qlnv_role` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(20) NOT NULL,
  `role_folder` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_role`
--

INSERT INTO `qlnv_role` (`role_id`, `role_name`, `role_folder`) VALUES
(1, 'Admin', ''),
(2, 'Trưởng Phòng', 'tp/'),
(3, 'Nhân Viên', 'user/');

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_thoigiancongtac`
--

CREATE TABLE `qlnv_thoigiancongtac` (
  `id` int(11) NOT NULL,
  `MaNV` varchar(8) NOT NULL,
  `MaCV` varchar(8) NOT NULL,
  `NgayNhanChuc` date NOT NULL DEFAULT (CURDATE()),
  `NgayKetThuc` date DEFAULT NULL,
  `DuongNhiem` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_thoigiancongtac`
--

INSERT INTO `qlnv_thoigiancongtac` (`id`, `MaNV`, `MaCV`, `NgayNhanChuc`, `NgayKetThuc`, `DuongNhiem`) VALUES
(1, 'AD001', 'GD', '2024-01-01', NULL, '1');

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_thuongphat`
--

CREATE TABLE `qlnv_thuongphat` (
  `id` int(11) NOT NULL,
  `MaNV` varchar(8) NOT NULL,
  `Loai` tinyint(1) DEFAULT 0,
  `LyDo` varchar(100) NOT NULL,
  `Tien` double NOT NULL,
  `Ngay` date NOT NULL,
  `GhiChu` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_thuongphat`
--


--
-- Triggers `qlnv_thuongphat`
--
DELIMITER $$
CREATE TRIGGER `delete_thuongphat_luong` AFTER DELETE ON `qlnv_thuongphat` FOR EACH ROW BEGIN
    DECLARE sotienphat double;
    DECLARE luongchamcong double;
    DECLARE luongDuocNhan double;
    DECLARE sotienthuong double;
    
    SET luongchamcong = (SELECT l.LuongChamCong
                        FROM qlnv_luong l
                        WHERE l.Nam = YEAR(OLD.Ngay) 
                         AND l.Thang = MONTH(OLD.Ngay) 
                         AND l.MaNV = OLD.MaNV);
    
    SET sotienphat = (SELECT SUM(tp.Tien) 
                      FROM qlnv_thuongphat tp 
                      WHERE tp.MaNV = OLD.MaNV AND MONTH(tp.Ngay) = MONTH(OLD.Ngay)
                     AND YEAR(tp.Ngay) = YEAR(OLD.Ngay) AND tp.Loai = 1);
    
    IF sotienphat IS NULL THEN
    	SET sotienphat = 0;
     END IF;
    
  
    set sotienthuong = (SELECT SUM(tp.Tien) 
                      FROM qlnv_thuongphat tp 
                      WHERE tp.MaNV = OLD.MaNV AND MONTH(tp.Ngay) = MONTH(OLD.Ngay)
                     AND YEAR(tp.Ngay) = YEAR(OLD.Ngay) AND tp.Loai = 0);
                     
    IF sotienthuong IS NULL THEN
    	SET sotienthuong = 0;
     END IF;
    
    SET luongDuocNhan = ROUND(luongchamcong - sotienphat + sotienthuong, -3);
   
    UPDATE `qlnv_luong`
    SET `SoTienThuong` = sotienthuong, `SoTienPhat` = sotienphat, `TongSoTien` = luongDuocNhan
    WHERE Nam = YEAR(OLD.Ngay) AND Thang = MONTH(OLD.Ngay) AND MaNV = OLD.MaNV;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_thuongphat_luong` AFTER INSERT ON `qlnv_thuongphat` FOR EACH ROW BEGIN
    DECLARE sotienphat double;
    DECLARE luongchamcong double;
    DECLARE luongDuocNhan double;
    DECLARE sotienthuong double;
    
    SET luongchamcong = (SELECT l.LuongChamCong
                        FROM qlnv_luong l
                        WHERE l.Nam = YEAR(NEW.Ngay) 
                         AND l.Thang = MONTH(NEW.Ngay) 
                         AND l.MaNV = NEW.MaNV);
    
    SET sotienphat = (SELECT SUM(tp.Tien) 
                      FROM qlnv_thuongphat tp 
                      WHERE tp.MaNV = NEW.MaNV AND MONTH(tp.Ngay) = MONTH(NEW.Ngay)
                     AND YEAR(tp.Ngay) = YEAR(NEW.Ngay) AND tp.Loai = 1);
    
    IF sotienphat IS NULL THEN
    	SET sotienphat = 0;
     END IF;
    
  
    set sotienthuong = (SELECT SUM(tp.Tien) 
                      FROM qlnv_thuongphat tp 
                      WHERE tp.MaNV = NEW.MaNV AND MONTH(tp.Ngay) = MONTH(NEW.Ngay)
                     AND YEAR(tp.Ngay) = YEAR(NEW.Ngay) AND tp.Loai = 0);
                     
    IF sotienthuong IS NULL THEN
    	SET sotienthuong = 0;
     END IF;
    
    SET luongDuocNhan = ROUND(luongchamcong - sotienphat + sotienthuong, -3);
   
    UPDATE `qlnv_luong`
    SET `SoTienThuong` = sotienthuong, `SoTienPhat` = sotienphat, `TongSoTien` = luongDuocNhan
    WHERE Nam = YEAR(NEW.Ngay) AND Thang = MONTH(NEW.Ngay) AND MaNV = NEW.MaNV;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_thuongphat_luong` AFTER UPDATE ON `qlnv_thuongphat` FOR EACH ROW BEGIN
    DECLARE sotienphat double;
    DECLARE luongchamcong double;
    DECLARE luongDuocNhan double;
    DECLARE sotienthuong double;
    
    SET luongchamcong = (SELECT l.LuongChamCong
                        FROM qlnv_luong l
                        WHERE l.Nam = YEAR(OLD.Ngay) 
                         AND l.Thang = MONTH(OLD.Ngay) 
                         AND l.MaNV = OLD.MaNV);
    
    SET sotienphat = (SELECT SUM(tp.Tien) 
                      FROM qlnv_thuongphat tp 
                      WHERE tp.MaNV = OLD.MaNV AND MONTH(tp.Ngay) = MONTH(OLD.Ngay)
                     AND YEAR(tp.Ngay) = YEAR(OLD.Ngay) AND tp.Loai = 1);
    
    IF sotienphat IS NULL THEN
    	SET sotienphat = 0;
     END IF;
    
  
    set sotienthuong = (SELECT SUM(tp.Tien) 
                      FROM qlnv_thuongphat tp 
                      WHERE tp.MaNV = OLD.MaNV AND MONTH(tp.Ngay) = MONTH(OLD.Ngay)
                     AND YEAR(tp.Ngay) = YEAR(OLD.Ngay) AND tp.Loai = 0);
                     
    IF sotienthuong IS NULL THEN
    	SET sotienthuong = 0;
     END IF;
    
    SET luongDuocNhan = ROUND(luongchamcong - sotienphat + sotienthuong, -3);
   
    UPDATE `qlnv_luong`
    SET `SoTienThuong` = sotienthuong, `SoTienPhat` = sotienphat, `TongSoTien` = luongDuocNhan
    WHERE Nam = YEAR(OLD.Ngay) AND Thang = MONTH(OLD.Ngay) AND MaNV = OLD.MaNV;
    
    SET luongchamcong = (SELECT l.LuongChamCong
                        FROM qlnv_luong l
                        WHERE l.Nam = YEAR(NEW.Ngay) 
                         AND l.Thang = MONTH(NEW.Ngay) 
                         AND l.MaNV = NEW.MaNV);
    
    SET sotienphat = (SELECT SUM(tp.Tien) 
                      FROM qlnv_thuongphat tp 
                      WHERE tp.MaNV = NEW.MaNV AND MONTH(tp.Ngay) = MONTH(NEW.Ngay)
                     AND YEAR(tp.Ngay) = YEAR(NEW.Ngay) AND tp.Loai = 1);
    
    IF sotienphat IS NULL THEN
    	SET sotienphat = 0;
     END IF;
    
  
    set sotienthuong = (SELECT SUM(tp.Tien) 
                      FROM qlnv_thuongphat tp 
                      WHERE tp.MaNV = NEW.MaNV AND MONTH(tp.Ngay) = MONTH(NEW.Ngay)
                     AND YEAR(tp.Ngay) = YEAR(NEW.Ngay) AND tp.Loai = 0);
                     
    IF sotienthuong IS NULL THEN
    	SET sotienthuong = 0;
     END IF;
    
    SET luongDuocNhan = ROUND(luongchamcong - sotienphat + sotienthuong, -3);
   
    UPDATE `qlnv_luong`
    SET `SoTienThuong` = sotienthuong, `SoTienPhat` = sotienphat, `TongSoTien` = luongDuocNhan
    WHERE Nam = YEAR(NEW.Ngay) AND Thang = MONTH(NEW.Ngay) AND MaNV = NEW.MaNV;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_trinhdohocvan`
--

CREATE TABLE `qlnv_trinhdohocvan` (
  `MATDHV` varchar(8) NOT NULL,
  `TenTDHV` varchar(50) NOT NULL,
  `ChuyenNganh` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_trinhdohocvan`
--

INSERT INTO `qlnv_trinhdohocvan` (`MATDHV`, `TenTDHV`, `ChuyenNganh`) VALUES
('SV001', 'Chưa tốt nghiệp', 'Khoa học dữ liệu'),
('SV002', 'Chưa tốt nghiệp', 'Hóa Dược'),
('SV003', 'Chưa tốt nghiệp', 'Vật Lý'),
('TNKHMTTT', 'Tốt Nghiệp', 'Khoa học máy tính và thông tin'),
('TS001', 'Thạc Sĩ', 'Khoa học dữ liệu');

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_user`
--

CREATE TABLE `qlnv_user` (
  `Id_user` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(32) NOT NULL,
  `tennguoidung` varchar(50) NOT NULL,
  `MaNhanVien` varchar(8) NOT NULL,
  `LastLogin` datetime DEFAULT NULL,
  `register` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_user`
--

INSERT INTO `qlnv_user` (`Id_user`, `username`, `password`, `tennguoidung`, `MaNhanVien`, `LastLogin`, `register`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Administrator', 'AD001', NULL, CURRENT_TIMESTAMP());

--
-- Indexes for dumped tables
--

--
-- Indexes for table `qlnv_chamcong`
--
ALTER TABLE `qlnv_chamcong`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qlnv_chamcongngay`
--
ALTER TABLE `qlnv_chamcongngay`
  ADD PRIMARY KEY (`MaChamCong`);

--
-- Indexes for table `qlnv_chamcongthang`
--
ALTER TABLE `qlnv_chamcongthang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qlnv_chamcongtongketthang`
--
ALTER TABLE `qlnv_chamcongtongketthang`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `qlnv_chucvu`
--
ALTER TABLE `qlnv_chucvu`
  ADD PRIMARY KEY (`MaCV`);

--
-- Indexes for table `qlnv_congty`
--
ALTER TABLE `qlnv_congty`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `qlnv_hopdong`
--
ALTER TABLE `qlnv_hopdong`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qlnv_imagedata`
--
ALTER TABLE `qlnv_imagedata`
  ADD PRIMARY KEY (`ID_image`);

--
-- Indexes for table `qlnv_luong`
--
ALTER TABLE `qlnv_luong`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qlnv_nhanvien`
--
ALTER TABLE `qlnv_nhanvien`
  ADD PRIMARY KEY (`MaNhanVien`);

--
-- Indexes for table `qlnv_phanquyenuser`
--
ALTER TABLE `qlnv_phanquyenuser`
  ADD PRIMARY KEY (`id_user`,`role_id`);

--
-- Indexes for table `qlnv_phongban`
--
ALTER TABLE `qlnv_phongban`
  ADD PRIMARY KEY (`MaPB`);

--
-- Indexes for table `qlnv_thoigiancongtac`
--
ALTER TABLE `qlnv_thoigiancongtac`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qlnv_thuongphat`
--
ALTER TABLE `qlnv_thuongphat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qlnv_trinhdohocvan`
--
ALTER TABLE `qlnv_trinhdohocvan`
  ADD PRIMARY KEY (`MATDHV`);

--
-- Indexes for table `qlnv_user`
--
ALTER TABLE `qlnv_user`
  ADD PRIMARY KEY (`Id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `qlnv_chamcong`
--
ALTER TABLE `qlnv_chamcong`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `qlnv_chamcongngay`
--
ALTER TABLE `qlnv_chamcongngay`
  MODIFY `MaChamCong` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `qlnv_chamcongthang`
--
ALTER TABLE `qlnv_chamcongthang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `qlnv_chamcongtongketthang`
--
ALTER TABLE `qlnv_chamcongtongketthang`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `qlnv_congty`
--
ALTER TABLE `qlnv_congty`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `qlnv_hopdong`
--
ALTER TABLE `qlnv_hopdong`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `qlnv_luong`
--
ALTER TABLE `qlnv_luong`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `qlnv_thoigiancongtac`
--
ALTER TABLE `qlnv_thoigiancongtac`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `qlnv_thuongphat`
--
ALTER TABLE `qlnv_thuongphat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `qlnv_user`
--
ALTER TABLE `qlnv_user`
  MODIFY `Id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
