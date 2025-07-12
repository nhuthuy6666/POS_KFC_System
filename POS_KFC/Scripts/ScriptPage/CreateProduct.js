function previewImage(event) {
    const input = event.target;
    const preview = document.getElementById("preview");
    const label = input.nextElementSibling;
    const noImage = document.querySelector('.kfc-no-image');

    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function (e) {
            preview.src = e.target.result;
            preview.style.display = "block";

            // Hide no-image placeholder
            if (noImage) {
                noImage.style.display = 'none';
            }

            // Update label
            label.innerHTML = '<i class="bi bi-check-circle me-2"></i>Đã chọn: ' + input.files[0].name;
            label.style.background = 'linear-gradient(135deg, var(--success-green) 0%, #20A83A 100%)';
            label.style.color = 'white';
            label.style.borderColor = 'var(--success-green)';
        };
        reader.readAsDataURL(input.files[0]);
    }
}