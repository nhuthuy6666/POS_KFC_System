function previewAvatar(input) {
    const updateBtn = document.getElementById('updateBtn');
    const selectedFile = document.getElementById('selectedFile');

    if (input.files && input.files[0]) {
        const file = input.files[0];

        // Hiển thị tên file
        selectedFile.textContent = `Đã chọn: ${file.name}`;

        // Enable update button
        updateBtn.disabled = false;

        // Preview image
        const reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById('avatarPreview').src = e.target.result;
        };
        reader.readAsDataURL(file);
    } else {
        selectedFile.textContent = '';
        updateBtn.disabled = true;
    }
}