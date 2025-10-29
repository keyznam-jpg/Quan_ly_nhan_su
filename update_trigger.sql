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

    UPDATE `qlnv_luong`
    SET `LuongChamCong`= luongchamcong, 
        `SoTienThuong` = CASE WHEN ManualEdit = 0 THEN sotienthuong ELSE SoTienThuong END,
        `SoTienPhat` = CASE WHEN ManualEdit = 0 THEN sotienphat ELSE SoTienPhat END,
        `TongSoTien` = ROUND(luongchamcong - SoTienPhat + SoTienThuong, -3)
    WHERE MaNV = NEW.MaNhanVien AND Nam = NEW.Nam AND Thang = New.Thang;
END$$
DELIMITER ;