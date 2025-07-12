document.addEventListener('DOMContentLoaded', function () {
    const shiftSelector = document.getElementById('shiftSelector');
    const timeInInput = document.getElementById('timeIn');
    const timeOutInput = document.getElementById('timeOut');
    const shiftInfo = document.getElementById('shiftInfo');
    const shiftDetails = document.getElementById('shiftDetails');

    const shifts = {
        'Ca sáng': { in: '07:00', out: '12:00' },
        'Ca trưa': { in: '12:00', out: '17:00' },
        'Ca chiều': { in: '17:00', out: '22:00' }
    };

    shiftSelector.addEventListener('change', function () {
        const selected = this.value;
        if (shifts[selected]) {
            timeInInput.value = shifts[selected].in;
            timeOutInput.value = shifts[selected].out;
            shiftDetails.textContent = `${selected}: ${shifts[selected].in} - ${shifts[selected].out}`;
            shiftInfo.style.display = 'block';
        } else {
            timeInInput.value = '';
            timeOutInput.value = '';
            shiftInfo.style.display = 'none';
        }
    });
});