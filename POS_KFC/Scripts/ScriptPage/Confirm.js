window.onload = function () {
    var orderId = document.getElementById("orderId").value;
    var downloadUrl = '/Orders/PrintOrder?id=' + orderId;

    var link = document.createElement('a');
    link.href = downloadUrl;
    link.download = 'HoaDon_KFC_' + orderId + '.pdf';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);

    // Hiển thị toast
    var toastEl = document.getElementById('printToast');
    if (toastEl) {
        var toast = new bootstrap.Toast(toastEl, { animation: true, delay: 3000 });
        toast.show();
    }
};
