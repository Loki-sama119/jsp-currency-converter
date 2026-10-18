<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chuyển đổi tiền tệ - JSP</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
    <main class="card">
        <p class="tag">CODEGYM · JAVA SERVER PAGES</p>
        <h1>USD to VND Converter</h1>
        <p class="intro">Nhập tỉ giá và số USD để tính số tiền VNĐ.</p>
        <div class="currencies" aria-label="Chuyển đổi từ USD sang VNĐ">
            <span>USD</span><span class="arrow" aria-hidden="true">→</span><span>VNĐ</span>
        </div>
        <form action="converter.jsp" method="POST" accept-charset="UTF-8">
            <label for="rate">Tỉ giá (VNĐ / USD)</label>
            <input id="rate" type="number" name="rate" value="25000" min="0"
                   step="any" required aria-describedby="rate-hint">
            <p id="rate-hint" class="hint">25000 là tỉ giá ví dụ. Tỉ giá nhập vào phải lớn hơn 0.</p>
            <label for="usd">Lượng USD cần đổi</label>
            <input id="usd" type="number" name="usd" min="0" step="any"
                   placeholder="Ví dụ: 100" required>
            <button type="submit">Tính toán</button>
        </form>
        <p class="formula">VNĐ = USD × Tỉ giá</p>
    </main>
</body>
</html>
