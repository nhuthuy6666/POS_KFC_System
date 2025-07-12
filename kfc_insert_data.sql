USE KFC_Manage
go
-- Dữ liệu cho bảng Position
DELETE FROM Position;
INSERT INTO Position (PositionName, HourlyWage) VALUES
(N'Quản lý', 50000),
(N'Thu ngân', 30000),
(N'Phục vụ', 28000),
(N'Vận chuyển', 32000);
go

-- Dữ liệu cho bảng Customer
DELETE FROM Customer;
INSERT INTO Customer (FirstName, LastName, Phone, Email, Address, Birthday, Gender) VALUES
(N'Lê', N'Văn Bình', '0905123456', 'binhlv@example.com', N'10 Trần Phú, Lộc Thọ, Nha Trang', '1991-07-18', 1),
(N'Nguyễn', N'Thị Mai', '0987654321', 'maint@example.com', N'258 Thống Nhất, Vạn Thắng, Nha Trang', '1993-03-22', 0),
(N'Trần', N'Hoàng Nam', '0911223344', 'namth@example.com', N'46 Lê Thánh Tôn, Tân Lập, Nha Trang', '1995-11-05', 1),
(N'Phạm', N'Thu Hà', '0977889900', 'hapt@example.com', N'88 Yersin, Phương Sài, Nha Trang', '1990-09-12', 0),
(N'Hoàng', N'Đức Anh', '0933445566', 'anhhd@example.com', N'12 Nguyễn Trãi, Phước Tân, Nha Trang', '1992-05-30', 1),
(N'Vũ', N'Thị Hương', '0966554433', 'huongvt@example.com', N'30 Nguyễn Thị Minh Khai, Xương Huân, Nha Trang', '1994-01-15', 0),
(N'Đặng', N'Văn Mạnh', '0944332211', 'manhdv@example.com', N'52A Đường 23/10, Phương Sơn, Nha Trang', '1989-08-02', 1),
(N'Bùi', N'Thị Phương', '0922113344', 'phuongbt@example.com', N'79 Ngô Gia Tự, Tân An, Nha Trang', '1996-04-25', 0),
(N'Cao', N'Quốc Cường', '0955667788', 'cuongcq@example.com', N'15 Võ Thị Sáu, Vĩnh Nguyên, Nha Trang', '1997-12-10', 1),
(N'Mai', N'Thị Lệ', '0999887766', 'letm@example.com', N'28 Củ Chi, Vĩnh Hải, Nha Trang', '1993-06-03', 0);
go

-- Dữ liệu cho bảng ProductType
DELETE FROM ProductType;
INSERT INTO ProductType (ProductTypeName) VALUES
(N'Gà rán'),
(N'Burger'),
(N'Nước giải khát'),
(N'Món ăn kèm'),
(N'Tráng miệng'),
(N'Combo'),
(N'Gà sốt'),
(N'Salad'),
(N'Bánh mì'),
(N'Đồ ăn sáng');
go

-- Dữ liệu cho bảng Promotion
DELETE FROM Promotion;
INSERT INTO Promotion (PromotionName, PromotionPrice) VALUES
(N'Giảm 30%', 0.3),
(N'Flash sale 50%', 0.5),
(N'Giảm giá cho công thức mới', 0.2),
(N'Giảm 50%', 0.5),
(N'Hot sale', 0.7),
(N'Khuyến mãi đặc biệt', 0.3),
(N'Tri ân khách hàng', 0.2),
(N'Ưu đãi sinh nhật', 0.15),
(N'Giờ vàng giá sốc', 0.3),
(N'Khuyến mãi đặc biệt tháng 5', 0.25),
(N'Không có', 0);
go

-- Dữ liệu cho bảng Supplier
DELETE FROM Supplier;
INSERT INTO Supplier (SupplierName, Phone, Email, Address) VALUES
(N'Công ty TNHH Thực phẩm A', '02812345678', 'thucphama@example.com', N'Khu công nghiệp X, TP.HCM'),
(N'Nhà cung cấp B', '0909876543', 'nhacungcapb@example.com', N'Đường Y, Hà Nội'),
(N'Công ty CP Nước giải khát C', '02498765432', 'nuocgiaikhatc@example.com', N'Khu công nghiệp Z, Bình Dương'),
(N'DNTN Nguyên liệu D', '0933221144', 'nguyenlieud@example.com', N'Đường T, Đồng Nai'),
(N'Hợp tác xã Nông sản E', '02711223344', 'nongsane@example.com', N'Tỉnh Vĩnh Long'),
(N'Công ty TNHH Bao bì F', '02511334455', 'baobif@example.com', N'Khu công nghiệp U, Long An'),
(N'Nhà phân phối G', '0911223355', 'phanphoig@example.com', N'Đường Q, Đà Nẵng'),
(N'Cơ sở sản xuất H', '02611445566', 'sanxuath@example.com', N'Tỉnh Tiền Giang'),
(N'Công ty TM & DV I', '0977665544', 'tmdvi@example.com', N'Đường S, Cần Thơ'),
(N'Xưởng chế biến J', '02911556677', 'chebienj@example.com', N'Tỉnh Bến Tre');
go

-- Dữ liệu cho bảng Product
DELETE FROM Product;
INSERT INTO Product (ProductTypeId, PromotionId, ProductName, Price, Description, ProductImage, LastRating, LastReview, LastReviewDate) VALUES
(1, 1, N'Gà rán truyền thống', 35000, N'Miếng gà rán giòn tan, hương vị truyền thống', 'ga_ran_tt.jpg', 4, N'Rất ngon!', '2025-05-05 10:00:00'),
(2, 2, N'Burger Zinger', 50000, N'Burger gà cay với lớp phủ giòn rụm', 'burger_zinger.jpg', 5, N'Tuyệt vời!', '2025-05-04 15:30:00'),
(3, 6, N'Pepsi lon', 15000, N'Nước ngọt có gas Pepsi mát lạnh', 'pepsi.jpg', 4, NULL, NULL),
(4, NULL, N'Khoai tây chiên vừa', 20000, N'Khoai tây chiên giòn rụm', 'khoai_tay.jpg', 3, N'Hơi mặn', '2025-05-03 18:45:00'),
(5, NULL, N'Kem vani', 12000, N'Kem vani mát lạnh, ngọt ngào', 'kem_vani.jpg', 5, N'Thơm ngon', '2025-05-06 09:15:00'),
(6, 5, N'Combo Gà rán + Pepsi', 60000, N'Combo tiết kiệm gồm 2 miếng gà rán và 1 lon Pepsi', 'combo_ga_pepsi.jpg', 4, N'Hợp lý', '2025-05-02 20:00:00'),
(7, NULL, N'Gà sốt phô mai', 40000, N'Miếng gà rán phủ sốt phô mai béo ngậy', 'ga_sot_pho_mai.jpg', 4, N'Béo ngậy, thích!', '2025-05-01 11:30:00'),
(8, NULL, N'Salad rau củ', 25000, N'Salad tươi mát với rau củ quả', 'salad.jpg', 3, NULL, NULL),
(2, NULL, N'Burger Tôm', 55000, N'Burger tôm thơm ngon, bổ dưỡng', 'burger_tom.jpg', 4, N'Lạ miệng', '2025-05-07 14:00:00'),
(1, NULL, N'Gà viên Popcorn', 30000, N'Gà viên chiên giòn, dễ ăn', 'ga_vien.jpg', 5, N'Rất thích hợp cho trẻ em', '2025-05-06 16:45:00'),
(1, 3, N'Gà rán cay', 37000, N'Miếng gà rán vị cay nồng hấp dẫn', 'ga_ran_cay.jpg', 4, N'Cay nhưng ngon', '2025-05-08 13:00:00'),
(1, NULL, N'Gà rán không xương', 38000, N'Miếng gà rán không xương tiện lợi', 'ga_khongxuong.jpg', 5, N'Ăn rất tiện', '2025-05-08 14:15:00'),
(2, 1, N'Burger Phô Mai', 52000, N'Burger gà phủ phô mai béo ngậy', 'burger_phomai.jpg', 4, N'Thơm béo', '2025-05-07 11:00:00'),
(2, NULL, N'Burger Bò BBQ', 58000, N'Thịt bò nướng sốt BBQ đậm đà', 'burger_bo_bbq.jpg', 5, N'Rất ngon và đậm vị', '2025-05-07 12:00:00'),
(3, NULL, N'Seven Up', 15000, N'Nước ngọt có gas vị chanh tươi mát', 'sevenup.jpg', 3, NULL, NULL),
(3, NULL, N'Trà sữa KFC', 25000, N'Trà sữa trân châu ngọt ngào', 'trasua.jpg', 4, N'Uống ổn lắm', '2025-05-08 17:00:00'),
(4, NULL, N'Bắp cải trộn KFC', 18000, N'Món salad bắp cải giòn, sốt mayonnaise', 'bapcai_tron.jpg', 4, N'Mát và nhẹ bụng', '2025-05-07 17:45:00'),
(4, 9, N'Viên phô mai chiên', 22000, N'Phô mai que chiên giòn thơm lừng', 'pho_mai_chien.jpg', 5, N'Cực kỳ thích', '2025-05-09 16:20:00'),
(5, NULL, N'Kem sô cô la', 12000, N'Kem lạnh vị socola đậm đà', 'kem_socola.jpg', 4, NULL, NULL),
(5, NULL, N'Bánh flan', 15000, N'Bánh flan mềm mịn, vị caramel', 'flan.jpg', 5, N'Mềm và ngọt dịu', '2025-05-08 10:30:00'),
(6, 2, N'Combo 1 người', 75000, N'1 miếng gà rán, 1 khoai vừa, 1 Pepsi', 'combo1.jpg', 4, N'Rất tiện cho 1 người', '2025-05-07 18:00:00'),
(6, 4, N'Combo 2 người', 135000, N'2 gà rán, 2 nước, 2 khoai', 'combo2.jpg', 5, N'Đi 2 người là hợp lý', '2025-05-07 19:00:00'),
(7, NULL, N'Gà sốt mật ong', 43000, N'Gà rán phủ lớp mật ong thơm ngọt', 'ga_sot_matong.jpg', 4, N'Mới lạ', '2025-05-06 13:45:00'),
(7, 10, N'Gà sốt tiêu đen', 44000, N'Gà chiên sốt tiêu đen cay nồng', 'ga_sot_tieuden.jpg', 4, N'Cay nhưng đã', '2025-05-07 10:00:00'),
(8, NULL, N'Salad ức gà', 35000, N'Salad trộn với ức gà nướng, sốt mè rang', 'salad_ga.jpg', 5, N'Ăn healthy lắm', '2025-05-08 08:30:00'),
(9, NULL, N'Bánh mì thịt nguội', 28000, N'Bánh mì với thịt nguội và rau tươi', 'banhmi_thitnguoi.jpg', 3, NULL, NULL),
(10, 8, N'Combo sáng nhẹ nhàng', 39000, N'Bánh bao, cháo nhỏ và nước đậu', 'combo_sang.jpg', 4, N'Nạp năng lượng nhẹ nhàng', '2025-05-06 06:45:00'),
(10, NULL, N'Bánh cuốn nóng', 32000, N'Bánh cuốn thịt heo với hành phi, chả lụa', 'banh_cuon.jpg', 5, N'Nóng sốt và ngon', '2025-05-07 07:30:00');
go

-- Dữ liệu cho bảng Ingredient
DELETE FROM Ingredient;
INSERT INTO Ingredient (IngredientName, Price, Quantity) VALUES
(N'Gà tươi', 20000, 1000),
(N'Bột chiên giòn', 5000, 500),
(N'Bánh burger', 3000, 800),
(N'Thịt bò xay', 15000, 600),
(N'Xà lách', 1000, 1200),
(N'Cà chua', 800, 1500),
(N'Phô mai lát', 2000, 1000),
(N'Tôm tươi', 25000, 400),
(N'Bột mì', 4000, 700),
(N'Dầu ăn', 10000, 300);
go

-- Dữ liệu cho bảng IngredientSupplier 
DELETE FROM IngredientSupplier;
INSERT INTO IngredientSupplier (IngredientId, SupplierId) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 1),
(5, 3),
(6, 3),
(7, 1),
(8, 4),
(9, 1),
(10, 5);
go

-- Dữ liệu cho bảng Employee
DELETE FROM Employee;
INSERT INTO Employee (PositionId, FirstName, LastName, Birthday, Gender, Phone, Email, Address) VALUES
(1, N'Lê', N'Thị Nga', '1988-06-12', 0, '0903112233', 'ngalt@example.com', N'18 Hoàng Hoa Thám, Vĩnh Nguyên, Nha Trang'), -- Quản lý
(2, N'Phan', N'Văn Tùng', '1990-04-05', 1, '0989988776', 'tungpv@example.com', N'35 Trần Khát Chân, Phước Hải, Nha Trang'), -- Thu ngân
(3, N'Đinh', N'Thị Yến', '1992-12-20', 0, '0914455667', 'yentd@example.com', N'62 Nguyễn Đình Chiểu, Vĩnh Phước, Nha Trang'), -- Phục vụ
(4, N'Võ', N'Hữu Phúc', '1994-07-08', 1, '0975566778', 'phucvh@example.com', N'90A Cù Lao Trung, Vĩnh Thọ, Nha Trang'), -- Vận chuyển
(3, N'Trương', N'Thị Quỳnh', '1986-11-28', 0, '0936677889', 'quynhtt@example.com', N'21 Hai Bà Trưng, Xương Huân, Nha Trang'), -- Phục vụ
(4, N'Bạch', N'Công Sơn', '1995-03-15', 1, '0967788990', 'sonbc@example.com', N'48 Đoàn Thị Điểm, Vạn Thạnh, Nha Trang'), -- Vận chuyển
(3, N'Lâm', N'Thị Trúc', '1991-09-01', 0, '0948899001', 'truclt@example.com', N'75 Cao Bá Quát, Phước Hòa, Nha Trang'), -- Phục vụ
(2, N'Huỳnh', N'Văn Bảo', '1989-05-22', 1, '0929900112', 'baohv@example.com', N'105 Đường 2 tháng 4, Vĩnh Hải, Nha Trang'), -- Thu ngân
(1, N'Đỗ', N'Thị Tuyết', '1987-01-10', 0, '0950011223', 'tuyetdt@example.com', N'33A Nguyễn Thiện Thuật, Tân Lập, Nha Trang'), -- Quản lý
(4, N'Trịnh', N'Văn Khải', '1993-08-17', 1, '0991122334', 'khaitv@example.com', N'59 Hoàng Văn Thụ, Phước Tiến, Nha Trang'); -- Vận chuyển
go

INSERT INTO Employee (PositionId, FirstName, LastName, Birthday, Gender, Phone, Email, Address) VALUES
(1, N'Phạm Hồ', N'Như Thủy', '2004-04-06', 0, '0903112233', 'thuy1111@example.com', N'18 Hoàng Hoa Thám, Vĩnh Nguyên, Nha Trang'); -- Quản lý
go

-- Dữ liệu cho bảng EmployeeAccount
DELETE FROM EmployeeAccount;
INSERT INTO EmployeeAccount (EmployeeId, Avatar, AccountName, Password) VALUES
(1, 'nga.jpg', 'quanlynga', 'admin123'), 
(2, 'tung.png', 'thungantung', 'cashier456'),
(8, 'bao.psd', 'thunganbao', 'cashier789'), 
(9, 'tuyet.ai', 'quanlytuyet', 'admin456');
go

INSERT INTO EmployeeAccount (EmployeeId, Avatar, AccountName, Password) VALUES
(11, 'thuy.jpg', 'nhuthuy6666', 'nhuthuy666666');
go

-- Dữ liệu cho bảng CustomerAccount
DELETE FROM CustomerAccount;
INSERT INTO CustomerAccount (CustomerId, Avatar, AccountName, Password, BankAccount) VALUES
(1, 'binh.jpg', 'binhlv91', 'binh123', '100123456789'),
(2, 'mai.png', 'maint93', 'mai456', '200987654321'),
(3, 'nam.jpeg', 'namth95', 'nam789', '300112233445'),
(4, 'ha.gif', 'hapt90', 'ha012', '400778899001'),
(5, 'anh.bmp', 'anhhd92', 'anh345', '500334455667'),
(6, 'huong.tiff', 'huongvt94', 'huong678', '600990011223'),
(7, 'manh.svg', 'manhdv89', 'manh901', '700556677889'),
(8, 'phuong.psd', 'phuongbt96', 'phuong234', '800112233445'),
(9, 'cuong.ai', 'cuongcq97', 'cuong567', '900778899001'),
(10, 'le.eps', 'letm93', 'le890', '123456789012');
go

-- Dữ liệu cho bảng DeliveryOrder 
DELETE FROM DeliveryOrder;
INSERT INTO DeliveryOrder (Address, Phone, Status) VALUES
(N'15 Trần Phú, Lộc Thọ, Nha Trang', '0906112233', 0),
(N'280 Thống Nhất, Vạn Thắng, Nha Trang', '0986543210', 1),
(N'50 Lê Thánh Tôn, Tân Lập, Nha Trang', '0917788990', 0),
(N'92 Yersin, Phương Sài, Nha Trang', '0971234567', 1),
(N'18 Nguyễn Trãi, Phước Tân, Nha Trang', '0938899001', 0),
(N'35 Nguyễn Thị Minh Khai, Xương Huân, Nha Trang', '0962345678', 1),
(N'55 Đường 23/10, Phương Sơn, Nha Trang', '0949876543', 0),
(N'82 Ngô Gia Tự, Tân An, Nha Trang', '0923456789', 1),
(N'20 Võ Thị Sáu, Vĩnh Nguyên, Nha Trang', '0954567890', 0),
(N'31 Củ Chi, Vĩnh Hải, Nha Trang', '0995678901', 1);
go

-- Dữ liệu cho bảng Orders
DELETE FROM Orders;
INSERT INTO Orders (CustomerId, EmployeeId, OrderDate, OrderTime, TotalPrice) VALUES
(NULL, 1, '2025-05-28', '09:00:00', 120000),
(NULL, 2, '2025-05-28', '18:30:00', 175000),
(NULL, 3, '2025-05-27', '12:15:00', 98000),
(NULL, 1, '2025-05-27', '20:00:00', 155000),
(NULL, 2, '2025-05-26', '11:45:00', 160000),
(NULL, 3, '2025-05-26', '19:20:00', 112000),
(NULL, 1, '2025-05-25', '13:10:00', 143000),
(NULL, 2, '2025-05-25', '17:30:00', 130000),
(NULL, 3, '2025-05-24', '16:00:00', 178000),
(NULL, 1, '2025-05-24', '20:30:00', 195000),
(NULL, 2, '2025-05-23', '09:20:00', 122000),
(NULL, 3, '2025-05-23', '19:10:00', 154000),
(NULL, 1, '2025-05-22', '13:40:00', 99000),
(NULL, 2, '2025-05-22', '18:30:00', 121000),
(NULL, 3, '2025-05-21', '10:30:00', 158000),
(NULL, 1, '2025-05-21', '19:55:00', 179000),
(NULL, 2, '2025-05-20', '12:45:00', 162000),
(NULL, 3, '2025-05-20', '20:30:00', 109000),
(NULL, 1, '2025-05-19', '11:10:00', 123000),
(NULL, 2, '2025-05-19', '18:00:00', 134000),
(NULL, 3, '2025-05-18', '14:30:00', 167000),
(NULL, 1, '2025-05-18', '21:00:00', 178000),
(NULL, 2, '2025-05-17', '09:50:00', 110000),
(NULL, 3, '2025-05-17', '18:40:00', 125000),
(NULL, 1, '2025-05-16', '13:00:00', 142000),
(NULL, 2, '2025-05-16', '19:25:00', 156000),
(NULL, 3, '2025-05-15', '12:35:00', 120000),
(NULL, 1, '2025-05-15', '20:10:00', 135000),
(NULL, 2, '2025-05-14', '11:15:00', 153000),
(NULL, 3, '2025-05-14', '17:55:00', 141000),
(NULL, 1, '2025-05-13', '10:00:00', 165000),
(NULL, 2, '2025-05-13', '19:40:00', 118000),
(NULL, 3, '2025-05-12', '14:20:00', 172000),
(NULL, 1, '2025-05-12', '20:05:00', 159000),
(NULL, 2, '2025-05-11', '11:30:00', 126000),
(NULL, 3, '2025-05-11', '18:25:00', 174000),
(NULL, 1, '2025-05-10', '13:50:00', 144000),
(NULL, 2, '2025-05-10', '20:20:00', 180000),
(NULL, 3, '2025-05-09', '09:40:00', 160000),
(NULL, 1, '2025-05-09', '19:30:00', 131000);
go

-- Dữ liệu cho bảng OrdersProduct
DELETE FROM OrdersProduct;
INSERT INTO OrdersProduct (ProductId, OrderId, Quantity) VALUES
(1, 1, 2),
(2, 1, 1),
(3, 2, 1),
(4, 2, 2),
(5, 3, 3),
(1, 4, 2),
(6, 5, 1),
(2, 6, 3),
(7, 7, 1),
(3, 8, 2),
(4, 9, 2),
(1, 10, 1),
(5, 11, 2),
(6, 12, 2),
(2, 13, 1),
(7, 14, 3),
(3, 15, 2),
(4, 16, 1),
(5, 17, 2),
(1, 18, 1),
(2, 19, 2),
(6, 20, 1),
(3, 21, 3),
(7, 22, 1),
(4, 23, 1),
(5, 24, 2),
(1, 25, 1),
(2, 26, 2),
(3, 27, 1),
(6, 28, 1),
(7, 29, 2),
(4, 30, 2),
(5, 31, 3),
(1, 32, 1),
(2, 33, 2),
(3, 34, 1),
(6, 35, 2),
(7, 36, 1),
(4, 37, 2),
(5, 38, 1),
(1, 39, 3),
(2, 40, 1);
go

-- Dữ liệu cho bảng Invoice
DELETE FROM Invoice;
INSERT INTO Invoice (OrderId, DeliveryOrderId, ShippingFee, PromotionId, InvoicePrice, Status) VALUES
(1, NULL, 0, NULL, 120000, 1),
(2, NULL, 10000, NULL, 175000, 1),
(3, NULL, 5000, NULL, 98000, 1),
(4, NULL, 0, NULL, 155000, 1),
(5, NULL, 15000, NULL, 160000, 1),
(6, NULL, 0, NULL, 112000, 1),
(7, NULL, 20000, NULL, 143000, 1),
(8, NULL, 0, NULL, 130000, 1),
(9, NULL, 10000, NULL, 178000, 1),
(10, NULL, 0, NULL, 195000, 1),
(11, NULL, 0, NULL, 122000, 1),
(12, NULL, 0, NULL, 154000, 1),
(13, NULL, 5000, NULL, 99000, 1),
(14, NULL, 0, NULL, 121000, 1),
(15, NULL, 0, NULL, 158000, 1),
(16, NULL, 10000, NULL, 179000, 1),
(17, NULL, 0, NULL, 162000, 1),
(18, NULL, 20000, NULL, 109000, 1),
(19, NULL, 0, NULL, 123000, 1),
(20, NULL, 0, NULL, 134000, 1),
(21, NULL, 10000, NULL, 167000, 1),
(22, NULL, 0, NULL, 178000, 1),
(23, NULL, 0, NULL, 110000, 1),
(24, NULL, 0, NULL, 125000, 1),
(25, NULL, 0, NULL, 142000, 1),
(26, NULL, 15000, NULL, 156000, 1),
(27, NULL, 0, NULL, 120000, 1),
(28, NULL, 0, NULL, 135000, 1),
(29, NULL, 0, NULL, 153000, 1),
(30, NULL, 10000, NULL, 141000, 1),
(31, NULL, 0, NULL, 165000, 1),
(32, NULL, 0, NULL, 118000, 1),
(33, NULL, 0, NULL, 172000, 1),
(34, NULL, 0, NULL, 159000, 1),
(35, NULL, 0, NULL, 126000, 1),
(36, NULL, 0, NULL, 174000, 1),
(37, NULL, 8000, NULL, 144000, 1),
(38, NULL, 0, NULL, 180000, 1),
(39, NULL, 0, NULL, 160000, 1),
(40, NULL, 0, NULL, 131000, 1);
go

-- Dữ liệu cho bảng Receipt
DELETE FROM Receipt;
INSERT INTO Receipt (InvoiceId, PaymentDate, PaymentMethod, CustomerPaid, ChangeAmount) VALUES
(1,  '2025-05-28', N'Tiền mặt', 120000, 0),
(2,  '2025-05-28', N'Thẻ', 175000, 0),
(3,  '2025-05-27', N'Momo', 98000, 0),
(4,  '2025-05-27', N'Tiền mặt', 155000, 1000),
(5,  '2025-05-26', N'Thẻ', 160000, 0),
(6,  '2025-05-26', N'Tiền mặt', 112000, 0),
(7,  '2025-05-25', N'Momo', 143000, 2000),
(8,  '2025-05-25', N'Thẻ', 130000, 0),
(9,  '2025-05-24', N'Tiền mặt', 178000, 0),
(10, '2025-05-24', N'Tiền mặt', 195000, 0),
(11, '2025-05-23', N'Thẻ', 122000, 500),
(12, '2025-05-23', N'Momo', 154000, 0),
(13, '2025-05-22', N'Tiền mặt', 99000, 0),
(14, '2025-05-22', N'Thẻ', 121000, 0),
(15, '2025-05-21', N'Tiền mặt', 158000, 0),
(16, '2025-05-21', N'Momo', 179000, 0),
(17, '2025-05-20', N'Tiền mặt', 162000, 1000),
(18, '2025-05-20', N'Thẻ', 109000, 0),
(19, '2025-05-19', N'Momo', 123000, 0),
(20, '2025-05-19', N'Tiền mặt', 134000, 500),
(21, '2025-05-18', N'Tiền mặt', 167000, 0),
(22, '2025-05-18', N'Thẻ', 178000, 0),
(23, '2025-05-17', N'Momo', 110000, 0),
(24, '2025-05-17', N'Tiền mặt', 125000, 0),
(25, '2025-05-16', N'Thẻ', 142000, 0),
(26, '2025-05-16', N'Tiền mặt', 156000, 2000),
(27, '2025-05-15', N'Momo', 120000, 0),
(28, '2025-05-15', N'Thẻ', 135000, 0),
(29, '2025-05-14', N'Tiền mặt', 153000, 1000),
(30, '2025-05-14', N'Tiền mặt', 141000, 0),
(31, '2025-05-13', N'Thẻ', 165000, 0),
(32, '2025-05-13', N'Momo', 118000, 0),
(33, '2025-05-12', N'Tiền mặt', 172000, 0),
(34, '2025-05-12', N'Tiền mặt', 159000, 0),
(35, '2025-05-11', N'Thẻ', 126000, 0),
(36, '2025-05-11', N'Momo', 174000, 0),
(37, '2025-05-10', N'Tiền mặt', 144000, 0),
(38, '2025-05-10', N'Thẻ', 180000, 0),
(39, '2025-05-09', N'Tiền mặt', 160000, 0),
(40, '2025-05-09', N'Momo', 131000, 0);
go

-- Dữ liệu cho bảng ActivityLog
DELETE FROM ActivityLog;
INSERT INTO ActivityLog (UserType, AccountId, ActivityName, Result, ActivityDate) VALUES
('Customer', 1, N'Đăng nhập', 1, GETDATE()),
('Employee', 1, N'Thêm sản phẩm mới', 1, GETDATE()), -- Quản lý
('Customer', 5, N'Xem chi tiết đơn hàng', 1, GETDATE()),
('Employee', 2, N'Xuất hóa đơn', 1, GETDATE()), -- Thu ngân
('Customer', 2, N'Đổi mật khẩu', 1, GETDATE()),
('Employee', 1, N'Cập nhật khuyến mãi', 1, GETDATE()), -- Quản lý
('Customer', 8, N'Thanh toán đơn hàng', 1, GETDATE()),
('Employee', 2, N'Xem báo cáo doanh thu', 1, GETDATE()), -- Thu ngân
('Customer', 6, N'Đánh giá sản phẩm', 1, GETDATE()),
('Employee', 1, N'Thêm nhân viên mới', 1, GETDATE()); -- Quản lý
go

-- Dữ liệu cho bảng WorkLog 
DELETE FROM WorkLog;
INSERT INTO WorkLog (EmployeeId, WorkDate, TimeIn, TimeOut, ShiftName) VALUES
(1, '2025-05-07', '08:00:00', '17:00:00', N'Ca sáng'), -- Quản lý
(2, '2025-05-07', '14:00:00', '22:00:00', N'Ca chiều'), -- Thu ngân
(3, '2025-05-07', '09:00:00', '15:00:00', N'Ca sáng'), -- Phục vụ
(4, '2025-05-07', '17:00:00', '21:00:00', N'Ca tối'), -- Vận chuyển
(5, '2025-05-07', '11:00:00', '18:00:00', N'Ca trưa'), -- Phục vụ
(6, '2025-05-07', '07:00:00', '11:00:00', N'Ca sáng'), -- Vận chuyển
(7, '2025-05-07', '16:00:00', '22:00:00', N'Ca chiều'), -- Phục vụ
(8, '2025-05-07', '10:00:00', '18:00:00', N'Ca sáng'), -- Thu ngân
(9, '2025-05-07', '13:00:00', '21:00:00', N'Ca trưa'), -- Quản lý
(10, '2025-05-07', '19:00:00', '23:00:00', N'Ca tối'); -- Vận chuyển
go

-- Dữ liệu cho bảng StoreOrder
DELETE FROM StoreOrder;
INSERT INTO StoreOrder (OrderDate, ShippingFee, TotalPrice, Status) VALUES
('2025-05-07', 20000, 100000, 1),
('2025-05-06', 15000, 75000, 1),
('2025-05-07', 0, 150000, 1),
('2025-05-05', 25000, 120000, 1),
('2025-05-07', 10000, 90000, 1),
('2025-05-04', 0, 60000, 1),
('2025-05-07', 30000, 180000, 1),
('2025-05-03', 18000, 85000, 1),
('2025-05-07', 0, 110000, 1),
('2025-05-02', 22000, 95000, 1);
go

-- Dữ liệu cho bảng StoreOrderDetail 
DELETE FROM StoreOrderDetail;
INSERT INTO StoreOrderDetail (StoreOrderId, IngredientId, Quantity) VALUES
(1, 1, 5),
(1, 2, 10),
(2, 3, 8),
(2, 4, 3),
(3, 5, 12),
(3, 6, 15),
(4, 7, 7),
(4, 8, 2),
(5, 9, 9),
(5, 10, 4);
go

-- Dữ liệu cho bảng Transactions
DELETE FROM Transactions;
INSERT INTO Transactions (StoreOrderId, TransactionType, TransactionName, Amount, TransactionDate) VALUES
(1, N'Nhập hàng', N'Nhập gà tươi', 2000000, '2025-05-07'),
(2, N'Chi phí', N'Tiền điện cửa hàng', 500000, '2025-05-06'),
(3, N'Doanh thu', N'Bán hàng ngày 7/5', 3500000, '2025-05-07'),
(4, N'Chi phí', N'Lương nhân viên ca sáng', 1500000, '2025-05-05'),
(5, N'Nhập hàng', N'Nhập bột chiên giòn', 300000, '2025-05-07'),
(6, N'Chi phí', N'Tiền nước cửa hàng', 150000, '2025-05-04'),
(7, N'Doanh thu', N'Bán hàng online ngày 7/5', 2800000, '2025-05-07'),
(8, N'Chi phí', N'Chi phí marketing', 800000, '2025-05-03'),
(9, N'Nhập hàng', N'Nhập bánh burger', 400000, '2025-05-07'),
(10, N'Chi phí', N'Bảo trì thiết bị bếp', 200000, '2025-05-02');
go