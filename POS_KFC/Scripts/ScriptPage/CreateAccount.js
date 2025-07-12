document.addEventListener("DOMContentLoaded", function () {
    const fileInput = document.querySelector('input[name="AvatarUpload"]');
    const previewImage = document.getElementById('avatarPreview');
    const form = document.querySelector("form");

    fileInput.addEventListener('change', function (e) {
        const file = e.target.files[0];
        if (file && file.type.startsWith('image/')) {
            const reader = new FileReader();
            reader.onload = function (e) {
                previewImage.src = e.target.result;
                previewImage.style.display = 'block';
            };
            reader.readAsDataURL(file);
        } else {
            previewImage.src = "#";
            previewImage.style.display = 'none';
        }
    });

    form.addEventListener("submit", function (e) {
        const password = document.querySelector("#Password").value;
        const confirm = document.querySelector("#ConfirmPassword").value;
        const errorSpan = document.querySelector("[data-valmsg-for='ConfirmPassword']");

        if (password !== confirm) {
            e.preventDefault();
            errorSpan.textContent = "Mật khẩu nhập lại không khớp.";
        } else {
            errorSpan.textContent = "";
        }
    });
});