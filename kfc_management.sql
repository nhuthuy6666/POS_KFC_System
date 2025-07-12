/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2017                    */
/* Created on:     27/05/2025 11:52:26 am                       */
/*==============================================================*/

CREATE DATABASE KFC_Manage;
GO
USE KFC_Manage;
GO

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CustomerAccount') and o.name = 'FK_CUSTOMER_HASCUSTOM_CUSTOMER')
alter table CustomerAccount
   drop constraint FK_CUSTOMER_HASCUSTOM_CUSTOMER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Employee') and o.name = 'FK_EMPLOYEE_HASPOSITI_POSITION')
alter table Employee
   drop constraint FK_EMPLOYEE_HASPOSITI_POSITION
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('EmployeeAccount') and o.name = 'FK_EMPLOYEE_HASEMPLOY_EMPLOYEE')
alter table EmployeeAccount
   drop constraint FK_EMPLOYEE_HASEMPLOY_EMPLOYEE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('IngredientSupplier') and o.name = 'FK_INGREDIE_SUPPLIES_INGREDIE')
alter table IngredientSupplier
   drop constraint FK_INGREDIE_SUPPLIES_INGREDIE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('IngredientSupplier') and o.name = 'FK_INGREDIE_SUPPLIES2_SUPPLIER')
alter table IngredientSupplier
   drop constraint FK_INGREDIE_SUPPLIES2_SUPPLIER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Invoice') and o.name = 'FK_INVOICE_APPLIESPR_PROMOTIO')
alter table Invoice
   drop constraint FK_INVOICE_APPLIESPR_PROMOTIO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Invoice') and o.name = 'FK_INVOICE_GENERATES_ORDERS')
alter table Invoice
   drop constraint FK_INVOICE_GENERATES_ORDERS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Invoice') and o.name = 'FK_INVOICE_HASDELIVE_DELIVERY')
alter table Invoice
   drop constraint FK_INVOICE_HASDELIVE_DELIVERY
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Orders') and o.name = 'FK_ORDERS_PLACESORD_CUSTOMER')
alter table Orders
   drop constraint FK_ORDERS_PLACESORD_CUSTOMER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Orders') and o.name = 'FK_ORDERS_PROCESSES_EMPLOYEE')
alter table Orders
   drop constraint FK_ORDERS_PROCESSES_EMPLOYEE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('OrdersProduct') and o.name = 'FK_ORDERSPR_CONTAINSP_PRODUCT')
alter table OrdersProduct
   drop constraint FK_ORDERSPR_CONTAINSP_PRODUCT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('OrdersProduct') and o.name = 'FK_ORDERSPR_CONTAINSP_ORDERS')
alter table OrdersProduct
   drop constraint FK_ORDERSPR_CONTAINSP_ORDERS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Product') and o.name = 'FK_PRODUCT_BELONGSTO_PRODUCTT')
alter table Product
   drop constraint FK_PRODUCT_BELONGSTO_PRODUCTT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Product') and o.name = 'FK_PRODUCT_HASPROMOT_PROMOTIO')
alter table Product
   drop constraint FK_PRODUCT_HASPROMOT_PROMOTIO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Receipt') and o.name = 'FK_RECEIPT_GENERATES_INVOICE')
alter table Receipt
   drop constraint FK_RECEIPT_GENERATES_INVOICE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('StoreOrderDetail') and o.name = 'FK_STOREORD_CONTAINSI_STOREORD')
alter table StoreOrderDetail
   drop constraint FK_STOREORD_CONTAINSI_STOREORD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('StoreOrderDetail') and o.name = 'FK_STOREORD_CONTAINSI_INGREDIE')
alter table StoreOrderDetail
   drop constraint FK_STOREORD_CONTAINSI_INGREDIE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Transactions') and o.name = 'FK_TRANSACT_GENERATES_STOREORD')
alter table Transactions
   drop constraint FK_TRANSACT_GENERATES_STOREORD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('WorkLog') and o.name = 'FK_WORKLOG_LOGSWORK_EMPLOYEE')
alter table WorkLog
   drop constraint FK_WORKLOG_LOGSWORK_EMPLOYEE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ActivityLog')
            and   type = 'U')
   drop table ActivityLog
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Customer')
            and   type = 'U')
   drop table Customer
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CustomerAccount')
            and   name  = 'HASCUSTOMERACCOUNT_FK'
            and   indid > 0
            and   indid < 255)
   drop index CustomerAccount.HASCUSTOMERACCOUNT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CustomerAccount')
            and   type = 'U')
   drop table CustomerAccount
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DeliveryOrder')
            and   type = 'U')
   drop table DeliveryOrder
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Employee')
            and   name  = 'HASPOSITION_FK'
            and   indid > 0
            and   indid < 255)
   drop index Employee.HASPOSITION_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Employee')
            and   type = 'U')
   drop table Employee
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('EmployeeAccount')
            and   name  = 'HASEMPLOYEEACCOUNT_FK'
            and   indid > 0
            and   indid < 255)
   drop index EmployeeAccount.HASEMPLOYEEACCOUNT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('EmployeeAccount')
            and   type = 'U')
   drop table EmployeeAccount
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Ingredient')
            and   type = 'U')
   drop table Ingredient
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('IngredientSupplier')
            and   name  = 'SUPPLIES2_FK'
            and   indid > 0
            and   indid < 255)
   drop index IngredientSupplier.SUPPLIES2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('IngredientSupplier')
            and   type = 'U')
   drop table IngredientSupplier
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Invoice')
            and   name  = 'APPLIESPROMOTION_FK'
            and   indid > 0
            and   indid < 255)
   drop index Invoice.APPLIESPROMOTION_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Invoice')
            and   name  = 'HASDELIVERY_FK'
            and   indid > 0
            and   indid < 255)
   drop index Invoice.HASDELIVERY_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Invoice')
            and   name  = 'GENERATESINVOICE_FK'
            and   indid > 0
            and   indid < 255)
   drop index Invoice.GENERATESINVOICE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Invoice')
            and   type = 'U')
   drop table Invoice
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Orders')
            and   name  = 'PROCESSESORDER_FK'
            and   indid > 0
            and   indid < 255)
   drop index Orders.PROCESSESORDER_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Orders')
            and   name  = 'PLACESORDER_FK'
            and   indid > 0
            and   indid < 255)
   drop index Orders.PLACESORDER_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Orders')
            and   type = 'U')
   drop table Orders
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('OrdersProduct')
            and   name  = 'CONTAINSPRODUCT2_FK'
            and   indid > 0
            and   indid < 255)
   drop index OrdersProduct.CONTAINSPRODUCT2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('OrdersProduct')
            and   type = 'U')
   drop table OrdersProduct
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Position')
            and   type = 'U')
   drop table Position
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Product')
            and   name  = 'HASPROMOTION_FK'
            and   indid > 0
            and   indid < 255)
   drop index Product.HASPROMOTION_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Product')
            and   name  = 'BELONGSTOTYPE_FK'
            and   indid > 0
            and   indid < 255)
   drop index Product.BELONGSTOTYPE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Product')
            and   type = 'U')
   drop table Product
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ProductType')
            and   type = 'U')
   drop table ProductType
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Promotion')
            and   type = 'U')
   drop table Promotion
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Receipt')
            and   name  = 'GENERATESRECEIPT_FK'
            and   indid > 0
            and   indid < 255)
   drop index Receipt.GENERATESRECEIPT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Receipt')
            and   type = 'U')
   drop table Receipt
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Role')
            and   type = 'U')
   drop table Role
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Settings')
            and   type = 'U')
   drop table Settings
go

if exists (select 1
            from  sysobjects
           where  id = object_id('StoreOrder')
            and   type = 'U')
   drop table StoreOrder
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('StoreOrderDetail')
            and   name  = 'CONTAINSINGREDIENT2_FK'
            and   indid > 0
            and   indid < 255)
   drop index StoreOrderDetail.CONTAINSINGREDIENT2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('StoreOrderDetail')
            and   type = 'U')
   drop table StoreOrderDetail
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Supplier')
            and   type = 'U')
   drop table Supplier
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Transactions')
            and   name  = 'GENERATESTRANSACTION_FK'
            and   indid > 0
            and   indid < 255)
   drop index Transactions.GENERATESTRANSACTION_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Transactions')
            and   type = 'U')
   drop table Transactions
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('WorkLog')
            and   name  = 'LOGSWORK_FK'
            and   indid > 0
            and   indid < 255)
   drop index WorkLog.LOGSWORK_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('WorkLog')
            and   type = 'U')
   drop table WorkLog
go

/*==============================================================*/
/* Table: ActivityLog                                           */
/*==============================================================*/
create table ActivityLog (
   ActivityId           int                  identity,
   UserType             nvarchar(10)         not null 
      constraint CKC_USERTYPE_ACTIVITY check (UserType in ('Employee','Customer')),
   AccountId            int                  not null,
   ActivityName         nvarchar(255)        not null,
   Result               bit                  not null,
   ActivityDate         datetime             DEFAULT GETDATE(),
   constraint PK_ACTIVITYLOG primary key (ActivityId)
)
go

/*==============================================================*/
/* Table: Customer                                              */
/*==============================================================*/
create table Customer (
   CustomerId           int                  identity,
   FirstName            nvarchar(100)        not null,
   LastName             nvarchar(100)        not null,
   Phone                nvarchar(11)         null,
   Email                nvarchar(255)        null,
   Address              nvarchar(255)        null,
   Birthday             date                 null,
   Gender               bit                  null,
   constraint PK_CUSTOMER primary key (CustomerId)
)
go

/*==============================================================*/
/* Table: CustomerAccount                                       */
/*==============================================================*/
create table CustomerAccount (
   CustomerAccountId    int                  identity,
   CustomerId           int                  not null,
   Avatar               nvarchar(255)        null,
   AccountName          nvarchar(100)        not null,
   Password             nvarchar(255)        not null,
   BankAccount          nvarchar(255)        null,
   constraint PK_CUSTOMERACCOUNT primary key (CustomerAccountId)
)
go

/*==============================================================*/
/* Index: HASCUSTOMERACCOUNT_FK                                 */
/*==============================================================*/




create nonclustered index HASCUSTOMERACCOUNT_FK on CustomerAccount (CustomerId ASC)
go

/*==============================================================*/
/* Table: DeliveryOrder                                         */
/*==============================================================*/
create table DeliveryOrder (
   DeliveryOrderId      int                  identity,
   Address              nvarchar(255)        not null,
   Phone                nvarchar(11)         null,
   Status               bit                  not null,
   constraint PK_DELIVERYORDER primary key (DeliveryOrderId)
)
go

/*==============================================================*/
/* Table: Employee                                              */
/*==============================================================*/
create table Employee (
   EmployeeId           int                  identity,
   PositionId           int                  not null,
   FirstName            nvarchar(100)        not null,
   LastName             nvarchar(100)        not null,
   Birthday             date                 not null,
   Gender               bit                  not null,
   Phone                nvarchar(11)         not null,
   Email                nvarchar(255)        not null,
   Address              nvarchar(255)        null,
   constraint PK_EMPLOYEE primary key (EmployeeId)
)
go

/*==============================================================*/
/* Index: HASPOSITION_FK                                        */
/*==============================================================*/




create nonclustered index HASPOSITION_FK on Employee (PositionId ASC)
go

/*==============================================================*/
/* Table: EmployeeAccount                                       */
/*==============================================================*/
create table EmployeeAccount (
   EmployeeAccountId    int                  identity,
   EmployeeId           int                  not null,
   Avatar               nvarchar(255)        null,
   AccountName          nvarchar(100)        not null,
   Password             nvarchar(255)        not null,
   constraint PK_EMPLOYEEACCOUNT primary key (EmployeeAccountId)
)
go

/*==============================================================*/
/* Index: HASEMPLOYEEACCOUNT_FK                                 */
/*==============================================================*/




create nonclustered index HASEMPLOYEEACCOUNT_FK on EmployeeAccount (EmployeeId ASC)
go

/*==============================================================*/
/* Table: Ingredient                                            */
/*==============================================================*/
create table Ingredient (
   IngredientId         int                  identity,
   IngredientName       nvarchar(100)        not null,
   Price                int                  not null,
   Quantity             int                  not null,
   constraint PK_INGREDIENT primary key (IngredientId)
)
go

/*==============================================================*/
/* Table: IngredientSupplier                                    */
/*==============================================================*/
create table IngredientSupplier (
   IngredientId         int                  not null,
   SupplierId           int                  not null,
   constraint PK_INGREDIENTSUPPLIER primary key (IngredientId, SupplierId)
)
go

/*==============================================================*/
/* Index: SUPPLIES2_FK                                          */
/*==============================================================*/




create nonclustered index SUPPLIES2_FK on IngredientSupplier (SupplierId ASC)
go

/*==============================================================*/
/* Table: Invoice                                               */
/*==============================================================*/
create table Invoice (
   InvoiceId            int                  identity,
   DeliveryOrderId      int                  null,
   PromotionId          int                  null,
   OrderId              int                  not null,
   ShippingFee          int                  DEFAULT 0,
   InvoicePrice         int                  not null,
   Status               bit                  not null,
   constraint PK_INVOICE primary key (InvoiceId)
)
go

/*==============================================================*/
/* Index: GENERATESINVOICE_FK                                   */
/*==============================================================*/




create nonclustered index GENERATESINVOICE_FK on Invoice (OrderId ASC)
go

/*==============================================================*/
/* Index: HASDELIVERY_FK                                        */
/*==============================================================*/




create nonclustered index HASDELIVERY_FK on Invoice (DeliveryOrderId ASC)
go

/*==============================================================*/
/* Index: APPLIESPROMOTION_FK                                   */
/*==============================================================*/




create nonclustered index APPLIESPROMOTION_FK on Invoice (PromotionId ASC)
go

/*==============================================================*/
/* Table: Orders                                                */
/*==============================================================*/
create table Orders (
   OrderId              int                  identity,
   EmployeeId           int                  null,
   CustomerId           int                  null,
   OrderDate            date                 not null,
   OrderTime            time                 not null,
   TotalPrice           int                  not null,
   constraint PK_ORDERS primary key (OrderId)
)
go

/*==============================================================*/
/* Index: PLACESORDER_FK                                        */
/*==============================================================*/




create nonclustered index PLACESORDER_FK on Orders (CustomerId ASC)
go

/*==============================================================*/
/* Index: PROCESSESORDER_FK                                     */
/*==============================================================*/




create nonclustered index PROCESSESORDER_FK on Orders (EmployeeId ASC)
go

/*==============================================================*/
/* Table: OrdersProduct                                         */
/*==============================================================*/
create table OrdersProduct (
   ProductId            int                  not null,
   OrderId              int                  not null,
   Quantity             int                  not null,
   constraint PK_ORDERSPRODUCT primary key (ProductId, OrderId)
)
go

/*==============================================================*/
/* Index: CONTAINSPRODUCT2_FK                                   */
/*==============================================================*/




create nonclustered index CONTAINSPRODUCT2_FK on OrdersProduct (OrderId ASC)
go

/*==============================================================*/
/* Table: Position                                              */
/*==============================================================*/
create table Position (
   PositionId           int                  identity,
   PositionName         nvarchar(100)        not null,
   HourlyWage           int                  not null,
   constraint PK_POSITION primary key (PositionId)
)
go

/*==============================================================*/
/* Table: Product                                               */
/*==============================================================*/
create table Product (
   ProductId            int                  identity,
   PromotionId          int                  null,
   ProductTypeId        int                  not null,
   ProductName          nvarchar(255)        not null,
   Price                int                  not null,
   Description          nvarchar(255)        null,
   ProductImage         nvarchar(255)        null,
   LastRating           int                  null,
   LastReview           nvarchar(255)        null,
   LastReviewDate       datetime             null,
   constraint PK_PRODUCT primary key (ProductId)
)
go

/*==============================================================*/
/* Index: BELONGSTOTYPE_FK                                      */
/*==============================================================*/




create nonclustered index BELONGSTOTYPE_FK on Product (ProductTypeId ASC)
go

/*==============================================================*/
/* Index: HASPROMOTION_FK                                       */
/*==============================================================*/




create nonclustered index HASPROMOTION_FK on Product (PromotionId ASC)
go

/*==============================================================*/
/* Table: ProductType                                           */
/*==============================================================*/
create table ProductType (
   ProductTypeId        int                  identity,
   ProductTypeName      nvarchar(100)        not null,
   constraint PK_PRODUCTTYPE primary key (ProductTypeId)
)
go

/*==============================================================*/
/* Table: Promotion                                             */
/*==============================================================*/
create table Promotion (
   PromotionId          int                  identity,
   PromotionName        nvarchar(255)        not null,
   PromotionPrice       decimal(5,2)         not null,
   constraint PK_PROMOTION primary key (PromotionId)
)
go

/*==============================================================*/
/* Table: Receipt                                               */
/*==============================================================*/
create table Receipt (
   ReceiptId            int                  identity,
   InvoiceId            int                  not null,
   PaymentDate          date                 not null,
   PaymentMethod        nvarchar(50)         null,
   CustomerPaid         int                  not null,
   ChangeAmount         int                  not null,
   constraint PK_RECEIPT primary key (ReceiptId)
)
go

/*==============================================================*/
/* Index: GENERATESRECEIPT_FK                                   */
/*==============================================================*/




create nonclustered index GENERATESRECEIPT_FK on Receipt (InvoiceId ASC)
go

/*==============================================================*/
/* Table: Settings                                              */
/*==============================================================*/
create table Settings (
   SettingId            int                  identity,
   SettingName          nvarchar(100)        not null,
   SettingValue         nvarchar(255)        not null,
   constraint PK_SETTINGS primary key (SettingId)
)
go

/*==============================================================*/
/* Table: StoreOrder                                            */
/*==============================================================*/
create table StoreOrder (
   StoreOrderId         int                  identity,
   OrderDate            date                 not null,
   ShippingFee          int                  null,
   TotalPrice           int                  null,
   Status               bit                  not null,
   constraint PK_STOREORDER primary key (StoreOrderId)
)
go

/*==============================================================*/
/* Table: StoreOrderDetail                                      */
/*==============================================================*/
create table StoreOrderDetail (
   StoreOrderId         int                  not null,
   IngredientId         int                  not null,
   Quantity             int                  not null,
   constraint PK_STOREORDERDETAIL primary key (StoreOrderId, IngredientId)
)
go

/*==============================================================*/
/* Index: CONTAINSINGREDIENT2_FK                                */
/*==============================================================*/




create nonclustered index CONTAINSINGREDIENT2_FK on StoreOrderDetail (IngredientId ASC)
go

/*==============================================================*/
/* Table: Supplier                                              */
/*==============================================================*/
create table Supplier (
   SupplierId           int                  identity,
   SupplierName         nvarchar(200)        not null,
   Phone                nvarchar(11)         null,
   Email                nvarchar(255)        null,
   Address              nvarchar(255)        null,
   constraint PK_SUPPLIER primary key (SupplierId)
)
go

/*==============================================================*/
/* Table: Transactions                                          */
/*==============================================================*/
create table Transactions (
   TransactionId        int                  identity,
   StoreOrderId         int                  null,
   TransactionType      nvarchar(50)         null,
   TransactionName      nvarchar(255)        not null,
   Amount               int                  not null,
   TransactionDate      date                 not null,
   constraint PK_TRANSACTIONS primary key (TransactionId)
)
go

/*==============================================================*/
/* Index: GENERATESTRANSACTION_FK                               */
/*==============================================================*/




create nonclustered index GENERATESTRANSACTION_FK on Transactions (StoreOrderId ASC)
go

/*==============================================================*/
/* Table: WorkLog                                               */
/*==============================================================*/
create table WorkLog (
   WorkLogId            int                  identity,
   EmployeeId           int                  not null,
   WorkDate             date                 not null,
   TimeIn               time                 null,
   TimeOut              time                 null,
   ShiftName            nvarchar(50)         null,
   constraint PK_WORKLOG primary key (WorkLogId)
)
go

/*==============================================================*/
/* Index: LOGSWORK_FK                                           */
/*==============================================================*/




create nonclustered index LOGSWORK_FK on WorkLog (EmployeeId ASC)
go

alter table CustomerAccount
   add constraint FK_CUSTOMER_HASCUSTOM_CUSTOMER foreign key (CustomerId)
      references Customer (CustomerId)
         on delete cascade
go

alter table Employee
   add constraint FK_EMPLOYEE_HASPOSITI_POSITION foreign key (PositionId)
      references Position (PositionId)
go

alter table EmployeeAccount
   add constraint FK_EMPLOYEE_HASEMPLOY_EMPLOYEE foreign key (EmployeeId)
      references Employee (EmployeeId)
         on delete cascade
go

alter table IngredientSupplier
   add constraint FK_INGREDIE_SUPPLIES_INGREDIE foreign key (IngredientId)
      references Ingredient (IngredientId)
         on delete cascade
go

alter table IngredientSupplier
   add constraint FK_INGREDIE_SUPPLIES2_SUPPLIER foreign key (SupplierId)
      references Supplier (SupplierId)
         on delete cascade
go

alter table Invoice
   add constraint FK_INVOICE_APPLIESPR_PROMOTIO foreign key (PromotionId)
      references Promotion (PromotionId)
go

alter table Invoice
   add constraint FK_INVOICE_GENERATES_ORDERS foreign key (OrderId)
      references Orders (OrderId)
         on delete cascade
go

alter table Invoice
   add constraint FK_INVOICE_HASDELIVE_DELIVERY foreign key (DeliveryOrderId)
      references DeliveryOrder (DeliveryOrderId)
go

alter table Orders
   add constraint FK_ORDERS_PLACESORD_CUSTOMER foreign key (CustomerId)
      references Customer (CustomerId)
go

alter table Orders
   add constraint FK_ORDERS_PROCESSES_EMPLOYEE foreign key (EmployeeId)
      references Employee (EmployeeId)
go

alter table OrdersProduct
   add constraint FK_ORDERSPR_CONTAINSP_PRODUCT foreign key (ProductId)
      references Product (ProductId)
go

alter table OrdersProduct
   add constraint FK_ORDERSPR_CONTAINSP_ORDERS foreign key (OrderId)
      references Orders (OrderId)
         on delete cascade
go

alter table Product
   add constraint FK_PRODUCT_BELONGSTO_PRODUCTT foreign key (ProductTypeId)
      references ProductType (ProductTypeId)
go

alter table Product
   add constraint FK_PRODUCT_HASPROMOT_PROMOTIO foreign key (PromotionId)
      references Promotion (PromotionId)
go

alter table Receipt
   add constraint FK_RECEIPT_GENERATES_INVOICE foreign key (InvoiceId)
      references Invoice (InvoiceId)
         on delete cascade
go

alter table StoreOrderDetail
   add constraint FK_STOREORD_CONTAINSI_STOREORD foreign key (StoreOrderId)
      references StoreOrder (StoreOrderId)
         on delete cascade
go

alter table StoreOrderDetail
   add constraint FK_STOREORD_CONTAINSI_INGREDIE foreign key (IngredientId)
      references Ingredient (IngredientId)
go

alter table Transactions
   add constraint FK_TRANSACT_GENERATES_STOREORD foreign key (StoreOrderId)
      references StoreOrder (StoreOrderId)
         on delete cascade
go

alter table WorkLog
   add constraint FK_WORKLOG_LOGSWORK_EMPLOYEE foreign key (EmployeeId)
      references Employee (EmployeeId)
         on delete cascade
go

