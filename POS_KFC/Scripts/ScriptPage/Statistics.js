function renderCharts(chartData) {
    const labels = chartData.labels;

    // 1️⃣ Biểu đồ số lượng đơn hàng
    const orderCountCtx = document.getElementById('orderCountChart').getContext('2d');
    new Chart(orderCountCtx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Số lượng đơn hàng',
                data: chartData.orderCountData,
                borderColor: '#FFC72C',
                backgroundColor: 'rgba(255, 199, 44, 0.1)',
                tension: 0.4,
                fill: true,
                pointBackgroundColor: '#FFC72C',
                pointBorderColor: '#E4002B',
                pointBorderWidth: 2,
                pointRadius: 6,
                pointHoverRadius: 8
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: true,
                    labels: {
                        color: '#2C3E50',
                        font: {
                            size: 14,
                            weight: 'bold'
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Số đơn hàng',
                        color: '#2C3E50',
                        font: {
                            size: 14,
                            weight: 'bold'
                        }
                    },
                    grid: {
                        color: 'rgba(0,0,0,0.1)'
                    },
                    ticks: {
                        color: '#6C757D'
                    }
                },
                x: {
                    grid: {
                        color: 'rgba(0,0,0,0.1)'
                    },
                    ticks: {
                        color: '#6C757D'
                    }
                }
            }
        }
    });

    // 2️⃣ Biểu đồ doanh thu - chi phí - lợi nhuận
    const revenueCtx = document.getElementById('revenueChart').getContext('2d');
    new Chart(revenueCtx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [
                {
                    label: 'Doanh thu',
                    data: chartData.revenueData,
                    backgroundColor: 'rgba(40, 167, 69, 0.8)',
                    borderColor: '#28A745',
                    borderWidth: 2,
                    borderRadius: 4
                },
                {
                    label: 'Chi phí',
                    data: chartData.costData,
                    backgroundColor: 'rgba(228, 0, 43, 0.8)',
                    borderColor: '#E4002B',
                    borderWidth: 2,
                    borderRadius: 4
                },
                {
                    label: 'Lợi nhuận',
                    data: chartData.profitData,
                    backgroundColor: 'rgba(255, 199, 44, 0.8)',
                    borderColor: '#FFC72C',
                    borderWidth: 2,
                    borderRadius: 4
                }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: true,
                    labels: {
                        color: '#2C3E50',
                        font: {
                            size: 14,
                            weight: 'bold'
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'VNĐ',
                        color: '#2C3E50',
                        font: {
                            size: 14,
                            weight: 'bold'
                        }
                    },
                    grid: {
                        color: 'rgba(0,0,0,0.1)'
                    },
                    ticks: {
                        color: '#6C757D',
                        callback: function (value) {
                            return new Intl.NumberFormat('vi-VN').format(value) + ' đ';
                        }
                    }
                },
                x: {
                    grid: {
                        color: 'rgba(0,0,0,0.1)'
                    },
                    ticks: {
                        color: '#6C757D'
                    }
                }
            }
        }
    });
}
