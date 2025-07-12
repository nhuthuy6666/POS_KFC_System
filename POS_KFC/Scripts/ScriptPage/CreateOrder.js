let selectedProducts = [];
const orderItems = document.getElementById("orderItems");
const totalPrice = document.getElementById("totalPrice");
const hiddenTotal = document.getElementById("TotalPrice");
const promotionList = document.getElementById("promotionList");
const selectedProductsInput = document.getElementById("SelectedProductsJson");


function validateBeforeSubmit() {
    console.log("Selected products:", selectedProducts);
    if (selectedProducts.length === 0) {
        const toastEl = document.getElementById('warningToast');
        if (toastEl) {
            const toast = new bootstrap.Toast(toastEl, { animation: true, delay: 3000 });
            toast.show();
        }
        return false; 
    }
    return true; 
}


function updateDisplay() {
    orderItems.innerHTML = "";
    promotionList.innerHTML = "";
    let total = 0;

    if (selectedProducts.length === 0) {
        orderItems.innerHTML = `
                        <div class="empty-state">
                            <i class="bi bi-basket3 display-4 text-muted mb-3"></i>
                            <p>Chưa có món nào được chọn</p>
                        </div>`;
        promotionList.innerHTML = `
                        <div class="empty-state">
                            <i class="bi bi-percent display-4 text-muted mb-3"></i>
                            <p>Không có khuyến mãi nào được áp dụng</p>
                        </div>`;
        totalPrice.innerText = "0₫";
        hiddenTotal.value = 0;
        selectedProductsInput.value = "";
        updateAddButtonStates();
        return;
    }

    selectedProducts.forEach(p => {
        const fullPrice = p.unitPrice + p.promoValue;
        const promoDisplay = p.promoValue > 0 ?
            `<div class="small"><span class="original-price">${fullPrice.toLocaleString()}₫</span> <span class="discount-price">-${p.promoValue.toLocaleString()}₫</span></div>` : "";

        const item = document.createElement("div");
        item.className = "order-item";
        item.dataset.id = p.productId;
        item.innerHTML = `
                        <div class="d-flex justify-content-between align-items-center p-3">
                            <div class="flex-grow-1">
                                <div class="fw-bold">${p.name}</div>
                                <div class="text-muted small">Số lượng: ${p.quantity}</div>
                                ${promoDisplay}
                            </div>
                            <div class="text-end">
                                <div class="price-display">${(p.unitPrice * p.quantity).toLocaleString()}₫</div>
                                <small class="text-muted">Xóa ✕</small>
                            </div>
                        </div>
                    `;

        item.addEventListener("click", () => {
            selectedProducts = selectedProducts.filter(prod => prod.productId !== p.productId);
            updateDisplay();
        });

        orderItems.appendChild(item);

        if (p.promoValue > 0 && p.promoName) {
            const promoItem = document.createElement("div");
            promoItem.className = "promotion-list-item";
            promoItem.innerHTML = `
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="fw-semibold text-danger"><i class="bi bi-gift-fill"></i> ${p.promoName}</span>
                                <span class="fw-bold text-success">-${(p.promoValue * p.quantity).toLocaleString()}₫</span>
                            </div>
                        `;
            promotionList.appendChild(promoItem);
        }

        total += p.unitPrice * p.quantity;
    });

    totalPrice.innerText = total.toLocaleString() + "₫";
    hiddenTotal.value = total;

    selectedProductsInput.value = JSON.stringify(selectedProducts.map(p => ({
        productId: p.productId,
        quantity: p.quantity
    })));

    updateAddButtonStates();
}

document.getElementById("menuItems").addEventListener("click", function (e) {
    const button = e.target.closest(".add-to-order");
    if (!button) return;

    const productId = parseInt(button.dataset.id);
    const name = button.dataset.name;
    const price = parseInt(button.dataset.price);
    const promoValue = parseFloat(button.dataset.promotion);
    const promoName = button.dataset.promotionname;
    const finalPrice = price - price * promoValue;

    const existing = selectedProducts.find(p => p.productId === productId);
    if (existing) {
        existing.quantity += 1;
    } else {
        selectedProducts.push({
            productId,
            name,
            unitPrice: finalPrice,
            quantity: 1,
            promoName,
            promoValue: price * promoValue
        });
    }

    updateDisplay();
});

function updateAddButtonStates() {
    document.querySelectorAll(".add-to-order").forEach(button => {
        const productId = parseInt(button.dataset.id);
        const existing = selectedProducts.find(p => p.productId === productId);
        if (existing) {
            button.innerHTML = `<i class="bi bi-bag-plus"></i>+${existing.quantity}`;
            button.classList.add("added");
        } else {
            button.innerHTML = `<i class="bi bi-plus-circle"></i> Thêm`;
            button.classList.remove("added");
        }
    });
}

document.getElementById("searchInput").addEventListener("input", function () {
    const keyword = this.value.toLowerCase();
    document.querySelectorAll("#menuItems > div").forEach(item => {
        const title = item.querySelector("h6").innerText.toLowerCase();
        item.style.display = title.includes(keyword) ? "block" : "none";
    });
});

// Initialize
updateDisplay();