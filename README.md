# Quản Lý Nhân Sự

Ứng dụng web quản lý nhân sự được xây dựng bằng Flask và MySQL, cung cấp các chức năng toàn diện cho việc quản lý nhân viên, chấm công, lương bổng và phòng ban.

## Tính Năng Chính

- **Quản lý nhân viên**: Thêm, sửa, xóa và xem thông tin nhân viên
- **Chấm công**: Ghi nhận giờ vào/ra, tính toán thời gian làm việc
- **Quản lý lương**: Tính lương dựa trên chấm công và các khoản thưởng/phạt
- **Quản lý phòng ban**: Tổ chức nhân viên theo phòng ban
- **Báo cáo và thống kê**: Xuất báo cáo PDF, Excel và biểu đồ
- **Quản lý tài khoản**: Phân quyền người dùng (Admin/User)

## Yêu Cầu Hệ Thống

- Python 3.11 trở lên (khuyến nghị 3.11 hoặc 3.12 để tương thích tốt nhất)
- MySQL Server 5.7 trở lên
- MySQL Workbench (tùy chọn, để quản lý database)
- wkhtmltopdf (cho chức năng xuất PDF)

## Cài Đặt

### 1. Cài đặt Python và MySQL

- Tải và cài đặt Python từ [python.org](https://www.python.org/)
- Tải và cài đặt MySQL Server từ [dev.mysql.com](https://dev.mysql.com/downloads/mysql/)
- Tải và cài đặt MySQL Workbench từ [dev.mysql.com](https://dev.mysql.com/downloads/workbench/)

### 2. Cài đặt wkhtmltopdf

- Tải từ [wkhtmltopdf.org](https://wkhtmltopdf.org/downloads.html)
- Chọn phiên bản Windows 64-bit và cài đặt

### 3. Chuẩn bị dự án

```bash
# Clone hoặc tải dự án về máy
cd quanlynhansu-master

# Chạy file run.bat để cài đặt dependencies và khởi chạy
run.bat
```

File `run.bat` sẽ tự động:
- Cài đặt các thư viện Python cần thiết
- Khởi chạy server Flask
- Mở trình duyệt đến http://127.0.0.1:5000

### 4. Thiết lập Database

1. **Mở MySQL Workbench**
   - Khởi chạy MySQL Workbench từ menu Start

2. **Kết nối đến MySQL Server**
   - Trong cửa sổ MySQL Workbench, click vào "+" để tạo kết nối mới
   - Nhập thông tin:
     - Connection Name: `quan_ly_nhan_su` (tùy chọn)
     - Hostname: `localhost`
     - Port: `3306`
     - Username: `root`
     - Password: Nhập password bạn đã đặt khi cài MySQL
   - Click "Test Connection" để kiểm tra
   - Click "OK" để lưu

3. **Tạo Database**
   - Double-click vào kết nối vừa tạo để mở
   - Trong cửa sổ Query, nhập: `CREATE DATABASE quan_ly_nhan_su;`
   - Click nút Execute (thunder icon) để chạy

4. **Import dữ liệu**
   - Trong menu, chọn "Server" > "Data Import"
   - Chọn "Import from Self-Contained File"
   - Browse đến file `quan_ly_nhan_su.sql` trong thư mục dự án
   - Chọn Default Target Schema: `quan_ly_nhan_su`
   - Click "Start Import"

**Lưu ý**: Nếu không dùng MySQL Workbench, bạn có thể dùng command line:
```bash
mysql -u root -p quan_ly_nhan_su < quan_ly_nhan_su.sql
```

## Chạy Ứng Dụng

### Cách 1: Sử dụng run.bat (khuyến nghị)

Double-click vào file `run.bat` trong thư mục dự án.

### Cách 2: Chạy thủ công

```bash
# Cài đặt dependencies
pip install -r requirements.txt

# Chạy ứng dụng
python quan_ly_nhan_su.py
```

Truy cập http://127.0.0.1:5000 trong trình duyệt.

## Tài Khoản Demo

Sau khi import database thành công, bạn có thể đăng nhập với các tài khoản sau:

### Tài khoản Admin (quyền cao nhất - có thể quản lý tất cả):
- **Username**: `admin`
- **Password**: `admin`

### Tài khoản User (quyền hạn chế - chỉ xem và chỉnh sửa thông tin cá nhân):
- **Username**: `namsiunhon` (Lã Đức Nam) - **Password**: `12345`
- **Username**: `nghiaphamhong` (Pham Hong Nghia) - **Password**: `12345`
- **Username**: `phamnhatvuong` (Phạm Nhật Vượng) - **Password**: `12345`
- **Username**: `letailinh` (Lê Tài Linh) - **Password**: `12345`
- **Username**: `duongnam` (Dương Văn Nam) - **Password**: `12345`

**Lưu ý**: Password được lưu dưới dạng MD5 hash trong database. Để thay đổi password, sử dụng chức năng "Đổi mật khẩu" trong hệ thống.

## Cấu Trúc Dự Án

```
quanlynhansu-master/
├── app.py                      # File chính của ứng dụng Flask
├── quan_ly_nhan_su.py          # Entry point để chạy ứng dụng
├── quan_ly_nhan_su.sql         # Schema và dữ liệu mẫu database
├── requirements.txt            # Danh sách thư viện Python
├── run.bat                     # Script khởi chạy tự động
├── templates/                  # Templates HTML
│   ├── general/
│   ├── employees/
│   ├── chamcong/
│   ├── chucvu/
│   ├── hopdong/
│   ├── luong/
│   ├── phongban/
│   └── ...
├── static/                     # Static files (CSS, JS, images)
│   ├── css/
│   ├── js/
│   ├── images/
│   ├── vendor/
│   └── web/
├── data_img/                   # Tài liệu hướng dẫn
└── README.md                   # Tài liệu này
```

## Công Nghệ Sử Dụng

- **Backend**: Flask 2.1.3
- **Database**: MySQL
- **Frontend**: HTML5, CSS3, JavaScript, Bootstrap
- **Charts**: Matplotlib, Seaborn
- **PDF Export**: pdfkit, wkhtmltopdf
- **Excel Export**: openpyxl

## Cấu Hình

Các cấu hình database có thể sửa trong file `app.py`:

```python
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'your_password'
app.config['MYSQL_DB'] = 'quan_ly_nhan_su'
app.config['MYSQL_PORT'] = 3306
```

## Khắc Phục Sự Cố

### Lỗi kết nối MySQL
- Đảm bảo MySQL Server đang chạy
- Kiểm tra username/password trong `app.py`
- Đảm bảo database `quan_ly_nhan_su` đã được tạo và import dữ liệu

### Lỗi thư viện Python
- Chạy `pip install -r requirements.txt` để cài lại dependencies
- Nếu gặp lỗi với mysqlclient, hãy sử dụng Python 3.11

### Lỗi xuất PDF
- Đảm bảo wkhtmltopdf đã được cài đặt và thêm vào PATH

## Đóng Góp

Mọi đóng góp đều được chào đón! Vui lòng tạo issue hoặc pull request trên GitHub.

## Giấy Phép

Dự án này được phân phối dưới giấy phép MIT.