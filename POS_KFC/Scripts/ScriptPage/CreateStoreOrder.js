$(document).ready(function () {
    $("form").on("submit", function (e) {
        let isValid = true;

        // Kiểm tra tất cả các dropdown nguyên liệu
        $(".ingredient-select").each(function () {
            if ($(this).val() === "" || $(this).val() === null) {
                isValid = false;
            }
        });

        if (!isValid) {
            e.preventDefault(); // Ngăn form submit
            let toast = new bootstrap.Toast(document.getElementById("warningToast"));
            toast.show();
        }
    });
});

let index = 1;

$('#addRow').on('click', function () {
    let row = `<tr>
        <td>
            <select name="StoreOrderDetails[${index}].IngredientId" class="form-control ingredient-select">
                <option value="">Select Ingredient</option>
                ${window.ingredientDropdownHtml}
            </select>
        </td>
        <td>
            <input type="number" name="StoreOrderDetails[${index}].Quantity" class="form-control quantity-input" min="1" />
        </td>
        <td>
            <button type="button" class="btn btn-danger btn-remove">X</button>
        </td>
    </tr>`;
    $('#detailsTable tbody').append(row);
    index++;
});

$(document).on('click', '.btn-remove', function () {
    $(this).closest('tr').remove();
    calculateTotal();
});

$(document).on('change', '.ingredient-select, .quantity-input, #ShippingFee', function () {
    calculateTotal();
});

function calculateTotal() {
    let total = 0;
    $('#detailsTable tbody tr').each(function () {
        let ingredientId = $(this).find('.ingredient-select').val();
        let qty = parseInt($(this).find('.quantity-input').val()) || 0;
        let price = window.ingredientPrices[ingredientId] || 0;
        total += price * qty;
    });

    let shipping = parseFloat($('#ShippingFee').val()) || 0;
    total += shipping;

    $('#TotalPrice').val(total.toFixed(2));
}
