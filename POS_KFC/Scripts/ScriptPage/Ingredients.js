$(document).ready(function () {
    const rowsPerPage = 6;
    const rows = $('#storeOrderTable tbody tr');
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

// Phân trang cho nguyên liệu
const ingRowsPerPage = 10;
const ingRows = $('#orderTable tr');
const ingRowsCount = ingRows.length;
const ingTotalPages = Math.ceil(ingRowsCount / ingRowsPerPage);
let ingCurrentPage = 1;

function displayIngredientPage(page) {
    ingRows.hide();
    const start = (page - 1) * ingRowsPerPage;
    const end = start + ingRowsPerPage;
    ingRows.slice(start, end).show();

    const startItem = start + 1;
    const endItem = Math.min(end, ingRowsCount);
    $('#ingredientPaginationInfo').text(`Hiển thị ${startItem} đến ${endItem} trên tổng số ${ingRowsCount}`);
    ingCurrentPage = page;

    // Update active class
    $('#ingredientPagination .page-item').removeClass('active');
    if (page === 1) {
        $('#ingFirstPage').addClass('active');
    } else if (page === ingTotalPages) {
        $('#ingLastPage').addClass('active');
    }
}

function createIngredientPagination() {
    let pagination = `
        <ul class="pagination mb-0">
            <li class="page-item page-arrow"><a class="page-link" href="#" id="ingPrevPage">&laquo;</a></li>
            <li class="page-item" id="ingFirstPage"><a class="page-link" href="#">1</a></li>
            <li class="page-item disabled"><a class="page-link" href="#">...</a></li>
            <li class="page-item" id="ingLastPage"><a class="page-link" href="#">${ingTotalPages}</a></li>
            <li class="page-item page-arrow"><a class="page-link" href="#" id="ingNextPage">&raquo;</a></li>
        </ul>
    `;
    $('#ingredientPagination').html(pagination);

    $('#ingFirstPage a').click(function (e) {
        e.preventDefault();
        displayIngredientPage(1);
    });

    $('#ingLastPage a').click(function (e) {
        e.preventDefault();
        displayIngredientPage(ingTotalPages);
    });

    $('#ingPrevPage').click(function (e) {
        e.preventDefault();
        if (ingCurrentPage > 1) displayIngredientPage(ingCurrentPage - 1);
    });

    $('#ingNextPage').click(function (e) {
        e.preventDefault();
        if (ingCurrentPage < ingTotalPages) displayIngredientPage(ingCurrentPage + 1);
    });

    displayIngredientPage(1);
    $('#ingFirstPage').addClass('active');
}

if (ingRowsCount > 0) {
    createIngredientPagination();
} else {
    $('#ingredientPagination').html('');
    $('#ingredientPaginationInfo').text('Không có nguyên liệu nào.');
}

// xử lý click
document.addEventListener("DOMContentLoaded", function () {
    const rows = document.querySelectorAll(".store-order-row");
    rows.forEach(row => {
        row.addEventListener("click", function () {
            const id = this.getAttribute("data-id");
            if (id) {
                window.location.href = `/StoreOrders/Details/${id}`;
            }
        });
    });
});