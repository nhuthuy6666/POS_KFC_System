$(document).ready(function () {
    const rowsPerPage = 3;
    const rows = $('#promotionTable tr');
    const rowsCount = rows.length;
    const totalPages = Math.ceil(rowsCount / rowsPerPage);
    let currentPage = 1;

    function displayPage(page) {
        rows.hide();
        const start = (page - 1) * rowsPerPage;
        const end = start + rowsPerPage;
        rows.slice(start, end).show();

        const startItem = start + 1;
        const endItem = Math.min(end, rowsCount);
        $('#paginationInfo').text(`Hiển thị ${startItem} đến ${endItem} trên tổng số ${rowsCount}`);

        currentPage = page;

        // Cập nhật active
        $('#pagination .page-item').removeClass('active');
        if (page === 1) {
            $('#firstPage').addClass('active');
        } else if (page === totalPages) {
            $('#lastPage').addClass('active');
        }
    }

    function createPagination() {
        let pagination = `
                <ul class="pagination mb-0">
                    <li class="page-item page-arrow"><a class="page-link" href="#" id="prevPage">&laquo;</a></li>
                    <li class="page-item" id="firstPage"><a class="page-link" href="#">1</a></li>
                    <li class="page-item disabled"><a class="page-link" href="#">...</a></li>
                    <li class="page-item" id="lastPage"><a class="page-link" href="#">${totalPages}</a></li>
                    <li class="page-item page-arrow"><a class="page-link" href="#" id="nextPage">&raquo;</a></li>
                </ul>
            `;
        $('#pagination').html(pagination);

        // Xử lý sự kiện click
        $('#firstPage a').click(function (e) {
            e.preventDefault();
            displayPage(1);
        });

        $('#lastPage a').click(function (e) {
            e.preventDefault();
            displayPage(totalPages);
        });

        $('#prevPage').click(function (e) {
            e.preventDefault();
            if (currentPage > 1) displayPage(currentPage - 1);
        });

        $('#nextPage').click(function (e) {
            e.preventDefault();
            if (currentPage < totalPages) displayPage(currentPage + 1);
        });

        displayPage(1);
        $('#firstPage').addClass('active');
    }

    if (rowsCount > 0) {
        createPagination();
    } else {
        $('#pagination').html('');
        $('#paginationInfo').text('Không có đơn hàng nào.');
    }

    // toast
    function showToast(message) {
        const toastEl = document.getElementById('warningToast');
        const toastBody = toastEl.querySelector('.toast-body');

        toastBody.innerHTML = `<i class="bi bi-info-circle-fill me-2"></i> ${message}`;

        const toast = bootstrap.Toast.getOrCreateInstance(toastEl);
        toast.show();
    }



    let originalPromoProductIds = [];
    // Click vào hàng khuyến mãi
    $('#promotionTable').on('click', '.promotion-row', function (e) {
        // Nếu người dùng click vào nút Xóa thì bỏ qua
        if ($(e.target).closest('.btn-delete').length) return;

        const promoId = $(this).data('id');
        const promoName = $(this).data('name');

        $('#selectedPromotionId').val(promoId);
        $('#promoTitle').text(promoName);
        $('#productListContainer').html('<p>Đang tải sản phẩm...</p>');

        $.get('/Products/GetProducts', function (response) {
            if (response.success) {
                const products = response.data;
                originalPromoProductIds = products
                    .filter(p => p.PromotionId === promoId)
                    .map(p => p.ProductId); // lưu ID sản phẩm đã được áp dụng

                let html = '<div class="list-group">';
                products.forEach(p => {
                    const isChecked = p.PromotionId === promoId ? 'checked' : '';
                    html += `
                <label class="list-group-item d-flex align-items-center">
                    <input 
                        type="checkbox" 
                        name="selectedProductIds" 
                        value="${p.ProductId}" 
                        class="form-check-input me-2 product-checkbox"
                        ${isChecked}
                        data-current-promotion="${p.PromotionId || ''}" />
                    
                    <img src="/Content/images/products/${p.ProductImage}" alt="" style="width: 40px; height: 40px; object-fit: cover; margin-right: 8px;" />
                    ${p.ProductName} (${p.ProductTypeName})
                </label>`;
                });
                html += '</div>';
                $('#productListContainer').html(html);
            } else {
                $('#productListContainer').html('<p>Lỗi khi tải sản phẩm.</p>');
            }
        });

        $('#applyPromotionModal').modal('show');
    });

    //Close modal
    $(document).on('click', '#applyPromotionModal .btn-secondary', function () {
        $('#applyPromotionModal').modal('hide');
    });

    // Submit modal
    $('#applyPromotionForm').on('submit', function (e) {
        e.preventDefault();
        const promoId = $('#selectedPromotionId').val();

        const selected = [];
        $('input[name="selectedProductIds"]:checked').each(function () {
            selected.push(parseInt($(this).val()));
        });

        if (selected.length === 0 && originalPromoProductIds.length === 0) {
            $('#applyPromotionModal').modal('hide');
            showToast("Hãy chọn ít nhất một sản phẩm.");
            return;
        }

        // Tìm sản phẩm cần gỡ khuyến mãi (đã có khuyến mãi nhưng bị bỏ tích)
        const toRemove = originalPromoProductIds.filter(id => !selected.includes(id));

        $.ajax({
            url: '/Promotions/ApplyToProducts',
            type: 'POST',
            data: {
                promotionId: promoId,
                productIds: selected
            },
            traditional: true,
            success: function () {
                // Nếu có sản phẩm cần gỡ khuyến mãi
                if (toRemove.length > 0) {
                    $.ajax({
                        url: '/Promotions/RemoveFromProducts',
                        type: 'POST',
                        data: {
                            promotionId: promoId,
                            productIds: toRemove
                        },
                        traditional: true,
                        complete: function () {
                            $('#applyPromotionModal').modal('hide');
                            showToast("Đã cập nhật khuyến mãi");
                        }
                    });
                } else {
                    $('#applyPromotionModal').modal('hide');
                    showToast("Đã áp dụng khuyến mãi");
                }
            }
        });
    });

    // Áp dụng cho tất cả sản phẩm
    $('#btnApplyAll').click(function () {
        const promoId = $('#selectedPromotionId').val();
        if (!promoId) return;

        $.post('/Promotions/ApplyToAllProducts', { promotionId: promoId }, function (res) {
            $('#applyPromotionModal').modal('hide');
            showToast("Đã áp dụng cho tất cả sản phẩm.");
        });
    });

    // Huỷ áp dụng khỏi các sản phẩm đã áp dụng
    $('#btnRemovePromotion').click(function () {
        const promoId = $('#selectedPromotionId').val();
        if (!promoId) return;

        $.post('/Promotions/RemoveFromAppliedProducts', { promotionId: promoId }, function (res) {
            $('#applyPromotionModal').modal('hide');
            showToast("Đã huỷ áp dụng khuyến mãi.");
        });
    });
});

$('#confirmDeleteModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    var promoId = button.data('id');
    var promoName = button.data('name');

    var modal = $(this);
    modal.find('#promoName').text(promoName);
    modal.find('#deletePromoId').val(promoId);
});