<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Locale" %>
<%-- Scriptlet: nhận dữ liệu từ request, ép kiểu số thực và tính toán. --%>
<%
    request.setCharacterEncoding("UTF-8");
    double rate = 0;
    double usd = 0;
    double vnd = 0;
    String error = null;

    try {
        String rateInput = request.getParameter("rate");
        String usdInput = request.getParameter("usd");
        if (rateInput == null || usdInput == null
                || rateInput.isBlank() || usdInput.isBlank()
                || rateInput.length() > 64 || usdInput.length() > 64) {
            throw new NumberFormatException();
        }

        rate = Double.parseDouble(rateInput.trim());
        usd = Double.parseDouble(usdInput.trim());
        if (!Double.isFinite(rate) || !Double.isFinite(usd) || rate <= 0 || usd < 0) {
            throw new NumberFormatException();
        }

        vnd = usd * rate;
        if (!Double.isFinite(vnd)) {
            throw new NumberFormatException();
        }
    } catch (NumberFormatException exception) {
        response.setStatus(400);
        error = "Dữ liệu đầu vào không hợp lệ. Vui lòng nhập tỉ giá lớn hơn 0 và lượng USD không âm.";
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kết quả chuyển đổi - JSP</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
    <main class="card">
        <p class="tag">CODEGYM · JAVA SERVER PAGES</p>
        <h1>Kết quả chuyển đổi</h1>
        <% if (error == null) { %>
            <%-- Expression: in các giá trị Java vào giao diện HTML. --%>
            <div class="details">
                <p>Tỉ giá: <strong id="rate-value"><%= rate %></strong> VNĐ/USD</p>
                <p>Lượng USD: <strong id="usd-value"><%= usd %></strong> USD</p>
            </div>
            <div class="result">
                <p>Thành tiền</p>
                <div class="money"><strong id="vnd-result"><%= String.format(Locale.US, "%.2f", vnd) %></strong> VNĐ</div>
            </div>
        <% } else { %>
            <div class="error">
                <h2>Lỗi xử lý!</h2>
                <p id="error-message"><%= error %></p>
            </div>
        <% } %>
        <a class="button" href="index.jsp">Quay lại trang chủ</a>
    </main>
</body>
</html>
