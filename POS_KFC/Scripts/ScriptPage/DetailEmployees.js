document.addEventListener("DOMContentLoaded", function () {
    // XÓA LỊCH LÀM VIỆC
    document.querySelectorAll(".btn-delete-worklog").forEach(button => {
        button.addEventListener("click", function () {
            const workLogId = this.getAttribute("data-id");
            const row = this.closest("tr");
            const tbody = row.closest("tbody");
            const cardBody = row.closest(".card-body");
            const formData = new FormData();

            const container = document.getElementById("worklog-container");
            const employeeId = container.getAttribute("data-employee-id");

            const token = document.querySelector('input[name="__RequestVerificationToken"]').value;
            formData.append("__RequestVerificationToken", token);

            fetch(`/WorkLogs/DeleteConfirmed/${workLogId}`, {
                method: "POST",
                body: formData
            })
                .then(response => {
                    if (response.ok) {
                        row.remove();
                        if (tbody.children.length === 0) {
                            const emptyHtml = `
                                <div class="empty-state">
                                    <p>Chưa đăng ký lịch làm việc trong tuần</p>
                                    <a class="btn btn-danger" href="/WorkLogs/Create?employeeId=${employeeId}">Tạo lịch làm việc</a>
                                </div>
                            `;
                            cardBody.innerHTML = emptyHtml;
                        }
                    } else {
                        alert("Xóa không thành công.");
                    }
                })
                .catch(error => {
                    console.error("Lỗi:", error);
                });
        });
    });

    // XÓA TÀI KHOẢN
    document.querySelectorAll('.delete-account-btn').forEach(button => {
        button.addEventListener('click', function () {
            const accountId = this.dataset.id;
            const row = this.closest('tr');
            const tbody = row.closest('tbody');
            const tableContainer = document.getElementById('account-table-container'); 
            const employeeId = tableContainer.getAttribute('data-employee-id'); 

            const token = document.querySelector('input[name="__RequestVerificationToken"]').value;
            const formData = new FormData();
            formData.append("__RequestVerificationToken", token);

            fetch(`/EmployeeAccounts/DeleteConfirmed/${accountId}`, {
                method: 'POST',
                body: formData
            })
                .then(res => {
                    if (res.ok) {
                        row.remove();
                        if (tbody.children.length === 0) {
                            tableContainer.innerHTML = `
                                <div class="empty-state">
                                    <p>Nhân viên chưa có tài khoản hệ thống</p>
                                    <a class="btn btn-danger" href="/EmployeeAccounts/Create?employeeId=${employeeId}">Tạo tài khoản</a>
                                </div>
                            `;
                        }
                    } else {
                        alert("Xóa thất bại!");
                    }
                })
                .catch(error => {
                    console.error("Lỗi:", error);
                    alert("Đã xảy ra lỗi!");
                });
        });
    });
});
