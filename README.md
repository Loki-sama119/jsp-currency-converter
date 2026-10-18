# [Thực hành] Ứng dụng chuyển đổi tiền tệ - JSP

Ứng dụng Maven Webapp chuyển đổi USD sang VNĐ trực tiếp bằng JSP Scriptlet và Expression, theo đúng yêu cầu bài tập.

## Môi trường

- JDK 17 trở lên; môi trường triển khai dùng JDK 21.
- Maven.
- Apache Tomcat 10.1, Jakarta Servlet 6.0 và Jakarta Server Pages 3.1.

## Cấu trúc

```text
pom.xml
src/main/webapp/index.jsp
src/main/webapp/converter.jsp
src/main/webapp/WEB-INF/web.xml
src/main/webapp/assets/styles.css
```

## Chức năng theo đề bài

1. `index.jsp` có form gồm `rate`, `usd` và nút `Tính toán`.
2. Form dùng `method="POST"`, `action="converter.jsp"`.
3. `converter.jsp` nằm cùng cấp với `index.jsp`.
4. Scriptlet `<% %>` nhận tham số từ `request`, chuyển sang số thực bằng `Double.parseDouble()` và tính `vnd = usd * rate`.
5. Expression `<%= %>` hiển thị tỉ giá, lượng USD và kết quả ra HTML.
6. Tính toán nằm trực tiếp trong JSP; không có class Servlet xử lý chuyển đổi riêng.

Kết quả VNĐ được định dạng với 2 chữ số thập phân. Giá trị `25000` trong form chỉ là tỉ giá ví dụ, có thể thay đổi.

## Xử lý dữ liệu không hợp lệ

- Tỉ giá phải lớn hơn 0; lượng USD không âm.
- Dữ liệu thiếu, rỗng, không phải số, `NaN`, `Infinity` hoặc kết quả bị tràn số được báo lỗi với HTTP 400.
- Mỗi trường nhận tối đa 64 ký tự.
- Truy cập `converter.jsp` khi chưa có tham số cũng hiển thị thông báo và liên kết quay về form.

## Build và triển khai trên Windows

Mở PowerShell tại thư mục chứa `pom.xml`:

```powershell
mvn clean package
Copy-Item -LiteralPath '.\target\jsp-currency-converter.war' -Destination 'C:\Tools\apache-tomcat-10.1.60\webapps\jsp-currency-converter.war'
# Chỉ khởi động nếu Tomcat chưa chạy:
& 'C:\Tools\apache-tomcat-10.1.60\bin\startup.bat'
```

Mở <http://localhost:8080/jsp-currency-converter/>. Nếu Tomcat dùng cổng khác, thay cổng theo connector HTTP trong `conf/server.xml`.

Maven đóng gói hai trang JSP vào WAR. Tomcat biên dịch và thực thi JSP khi nhận request.

## Kiểm thử

- Tỉ giá `25000`, USD `100` → `2500000.00` VNĐ.
- Tỉ giá `25000.5`, USD `2.5` → `62501.25` VNĐ.
- Tỉ giá `0.1`, USD `0.2` → `0.02` VNĐ.
- Tỉ giá `25000`, USD `0` → `0.00` VNĐ.
- Sai hoặc thiếu dữ liệu → thông báo `Lỗi xử lý!` và hướng dẫn nhập lại.

Ví dụ POST trực tiếp:

```powershell
Invoke-WebRequest -Uri 'http://localhost:8080/jsp-currency-converter/converter.jsp' -Method POST -Body @{rate='25000'; usd='100'} -UseBasicParsing
```

## Nộp bài

Nộp link repository GitHub, nhánh `main`. `pom.xml` và cây `src/` nằm ngay tại gốc repository. `.gitignore` loại thư mục build `target/` khỏi Git.

## Kết quả kiểm thử thực tế

Đã kiểm tra ngày 18/10/2026 trên JDK 21, Apache Tomcat 10.1.60, cổng HTTP 8080:

- `mvn clean package`: `BUILD SUCCESS`.
- Trang chủ JSP và năm phép chuyển đổi POST tới `converter.jsp`: HTTP 200, kết quả đúng.
- Đã kiểm tra số thập phân, lượng USD bằng 0 và thay đổi tỉ giá.
- Tỉ giá, lượng USD và kết quả đều được Expression của JSP xuất thành HTML đúng UTF-8.
- Tám trường hợp dữ liệu không hợp lệ và truy cập trực tiếp khi thiếu tham số đều trả HTTP 400 kèm thông báo, không gây HTTP 500.
- CSS và liên kết quay lại `index.jsp`: HTTP 200.
