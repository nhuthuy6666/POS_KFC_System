$(document).ready(function () {
    const rowsPerPage = 6;
    const rows = $('#productList .col');
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
});
