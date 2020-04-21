GO
CREATE DATABASE SuperMark	
on primary
(
	NAME='SuperMark',
	FILENAME='D:\SQL��ҵ\20200407\SuperMark.mdf',
	SIZE=6MB,
	FILEGROWTH=10%
)
LOG ON
(
	NAME='SuperMark_log',
	FILENAME='D:\SQL��ҵ\20200407\SuperMark_log.ldf',
	SIZE=3MB,
	FILEGROWTH=10%
)
GO
USE SuperMark

------���ʹ洢
CREATE TABLE InventoryStatus  --��Ʒ����
(
  StatusId INT PRIMARY KEY CHECK(StatusId=1 OR StatusId=-1 OR StatusId=2 OR StatusId=-2) NOT NULL, --���״̬
  StatusDesc VARCHAR(50) NOT NULL --1������-1���ڿ�棬2���ڿ�棬-2���
)
CREATE TABLE ProductInventory  --��Ʒ�洢��
(
  ProductId VARCHAR(50) PRIMARY KEY NOT NULL,  --��ƷID
  TotalCount INT NOT NULL,--������
  MinCount INT NOT NULL, --��С���
  MaxCount INT NOT NULL,--�����
  StatusId INT NOT NULL FOREIGN KEY (StatusId) REFERENCES InventoryStatus(StatusId)--���״̬
)
-------����
CREATE TABLE SalesPerson --����Ա��
(
 SalesPersonId INT PRIMARY KEY IDENTITY(10000,1) NOT NULL, --����ԱID: 10000
 SPName VARCHAR(50) NOT NULL ,--����Ա����
 LoginPwd VARCHAR(50) NOT NULL --����
)
CREATE TABLE SalesList --��ӡ��ˮ��
(
  SerialNum VARCHAR(50) PRIMARY KEY NOT NULL ,--��ˮ��ϵ�y����
  TotalMoney NUMERIC(10, 2) NOT NULL,--�����ܼ�
  RealReceive NUMERIC(10, 2) NOT NULL,--ʵ���տ�
  ReturnMoney NUMERIC(10, 2) NOT NULL,--����
  SalesPersonId INT FOREIGN KEY (SalesPersonId) REFERENCES SalesPerson(SalesPersonId) , --����ԱID
  SaleDate SMALLDATETIME NOT NULL --ʱ��
)
CREATE TABLE SalesListDetall  --��ˮ��
(
  Id INT NOT NULL PRIMARY KEY IDENTITY(1000000,1),--��1000000,1��
  SerialNum VARCHAR(50) FOREIGN KEY (SerialNum) REFERENCES SalesList(SerialNum), --��ˮ��
  ProductId VARCHAR(50) NOT NULL, --��Ʒ���
  ProductName VARCHAR(50) NOT NULL, --��Ʒ����
  UnitPrice NUMERIC(10, 2) NOT NULL,--��Ʒ����
  Discount float, --�ۿ�
  Quantity INT NOT NULL,--��������
  SubTotalMoney NUMERIC(10, 2) --С�ƽ��
)
-------��Ʒ
CREATE TABLE ProductCategory --��Ʒ�����
(
 CategoryId INT PRIMARY KEY IDENTITY(1,1),--��Ʒ����ID1,1
 CategoryName VARCHAR(20) NOT NULL--��Ʒ����
)
CREATE TABLE Products --��Ʒ�۸��
(
 ProductId VARCHAR(50) PRIMARY KEY  NOT NULL,--��Ʒ�����Ʒ����
 ProductName VARCHAR(50) NOT NULL,--��Ʒ����
 UnitPrice NUMERIC(5,2) NOT NULL,--����
 Unit VARCHAR(50) NOT NULL,--������λ
 Discount float ,--�ۿ�
 CategoryId INT FOREIGN KEY (CategoryId) REFERENCES ProductCategory(CategoryId) NOT NULL--��Ʒ����
)
CREATE TABLE ProductStorage--��Ʒ����
(
 StorageId INT NOT NULL PRIMARY KEY IDENTITY(100000,1),--IDENTITY(100000,1),
 ProductId VARCHAR(50) FOREIGN KEY (ProductId) REFERENCES Products(ProductId), --��ƷID
 AddedCount INT NOT NULL,--�������
 CurrentTime SMALLDATETIME NOT NULL--���ʱ��
)


CREATE TABLE SMMembers -- 
(
 MemberId INT NOT NULL PRIMARY KEY IDENTITY(100200300,1),--��Ա����
 MemberName VARCHAR(50) NOT NULL,--��Ա����
 Points INT NOT NULL,--��Ա����10Ԫ=1
 PhoneNumber VARCHAR(200) NOT NULL,--��ϵ�绰
 MemberAddress TEXT NOT NULL,--��ϵ��ַ
 OpenTime DATETIME, --����ʱ��
 MemberStatus INT NOT NULL--��Ա��״̬1����0����-1ע��
)
CREATE TABLE LoginLogs --ְԱ��¼��
(
 LogId INT  PRIMARY KEY IDENTITY(1,1),--1,1
 LoginId INT NOT NULL,--��¼��ID
 SPName VARCHAR(50) ,--��¼������
 ServerName VARCHAR(100),--��¼��������
 LoginTime DATETIME NOT NULL,--��¼ʱ��
 ExitTime DATETIME --�˳�ʱ��
)
CREATE TABLE SysAdmins --����Ա��
(
 LoginId INT NOT NULL PRIMARY KEY IDENTITY(2000,1),--��¼�˺�2000
 LoginPwd VARCHAR(20) ,--��¼����
 AdminName VARCHAR(20), --����Ա��
 AdminStatus BIT ,--��ǰ״̬1��0��
 Roleld INT --��ɫ����1����2һ��
)
CREATE TABLE ProductUnit  --
(
 Id INT NOT NULL PRIMARY KEY IDENTITY(1,1),--1,1
 Unit VARCHAR(20) NOT NULL --��Ʒ������λ
)
 SELECT * FROM SalesPerson 
  SELECT * FROM ProductInventory
  SELECT * FROM Products






INSERT INTO SalesPerson VALUES
('������','123456'),('л���','123456'),('�����Դ�','123456')
INSERT INTO SMMembers 
SELECT '������',0,13825138120,'��������','2020-4-06',1UNION
SELECT '������',0,15029063866,'�����й�','2020-4-06',1UNION
SELECT '������',0,15029063865,'����μ��','2020-4-06',1UNION
SELECT '����',0,15029063866,'����','2020-4-06',1UNION
SELECT '����',0,15029063866,'��������','2020-4-06',1
INSERT INTO SysAdmins
SELECT 123456,'������','False',2UNION
SELECT 123456,'�','True',2UNION
SELECT 123456,'������','True',1UNION
SELECT 123456,'��߸','True',1UNION
SELECT 123456,'ľ߸','False',1UNION
SELECT 123456,'��߸','True',1
INSERT INTO ProductUnit VALUES
('��'),('��'),('ƿ'),('��'),('��'),('��'),('ֻ'),('��'),('Ͱ'),('��'),('��'),('��'),('��'),('��')
INSERT INTO ProductCategory VALUES
('����'),('��ʳ'),('��ʳ'),('����'),('����'),('����'),('����'),('�ľ���'),('�����'),('����Ʒ')
INSERT INTO Products
SELECT 6002504003331,'��ʦ��ͳһţ����','40.00','��',0,3UNION
SELECT 6002504003332,'��̳���ţ����','45.00','��',0,3UNION
SELECT 6002504003333,'ѩ��ơ��','60.00','��',0,6UNION
SELECT 6002504003334,'�ྩơ��','61.00','��',0,6UNION
SELECT 6002504003335,'�ɿڿ���','6.00','ƿ',0,1UNION
SELECT 6002504003336,'��������','5.50','ƿ',0,1UNION
SELECT 6002504003337,'ͳһ�ʳȶ�','5.00','ƿ',0,1UNION
SELECT 6002504003338,'��ʽС���','8.00','��',0,2UNION
SELECT 6002504003339,'��������','6.80','��',0,10UNION
SELECT 6002504003341,'ƽԭС��','102.00','��',0,5UNION
SELECT 6002504003342,'����ë��','9.90','��',0,10
--UPDATE Products SET ProductName=REPLACE(ProductName,'ѩ��','�ྩ')
INSERT INTO InventoryStatus VALUES
(-2,'�����'),(-1,'���ڿ��'),(1,'����'),(2,'���ڿ��')
INSERT INTO ProductInventory
SELECT 6002504003331,240,300,500,1UNION
SELECT 6002504003332,240,300,500,1UNION
SELECT 6002504003333,800,200,1000,1UNION
SELECT 6002504003334,790,200,1000,1UNION
SELECT 6002504003335,180,200,500,1UNION
SELECT 6002504003336,180,200,500,1UNION
SELECT 6002504003337,300,200,500,1UNION
SELECT 6002504003338,100,200,400,1UNION
SELECT 6002504003339,100,150,300,1UNION
SELECT 6002504003341,160,100,200,1UNION
SELECT 6002504003342,100,150,250,1


CREATE  PROC SelesLogeIn
@LoginId INT,
@LoginPwd NVARCHAR(50)
AS
SELECT * FROM SalesPerson WHERE SalesPersonId=@LoginId AND LoginPwd=@LoginPwd



CREATE  PROC WriteLog
@LoginId INT,
@SPName NVARCHAR(50),
@ServerName NVARCHAR(50)
AS
INSERT INTO LoginLogs(LoginId,SPName, ServerName,LoginTime)
 VALUES(@LoginId,@SPName,@ServerName,GETDATE())

CREATE  PROC  ExitSysWriteLog
@LogId INT
AS
UPDATE LoginLogs SET ExitTime=GETDATE() WHERE LogId=@LogId


CREATE  PROC GetSysTime
AS
SELECT GETDATE()


CREATE  PROC GetProductWithId
@ProductId NVARCHAR(50)
AS
SELECT * FROM Products INNER JOIN ProductCategory ON Products.CategoryId=ProductCategory.CategoryId
WHERE ProductId=@ProductId

exec GetProductWithId '6002504003331'

CREATE  PROC AddSalesListDetail
@SerialNum NVARCHAR(50),
@ProductId NVARCHAR(50),
@ProductName NVARCHAR(50),
@UnitPrice NUMERIC(10,2),
@Discount FLOAT,
@Quantity INT,
@SubTotalMoney NUMERIC(10,2)
AS
INSERT INTO SalesListDetall(SerialNum,ProductId,ProductName,UnitPrice,Discount,Quantity,SubTotalMoney)
 VALUES(@SerialNum,@ProductId,@ProductName,@UnitPrice,@Discount,@Quantity,@SubTotalMoney)

 CREATE  PROC AddSalesList
 @SerialNum NVARCHAR(50),
@TotalMoney NUMERIC(10,2),
@RealReceive NUMERIC(10,2),
@ReturnMoney NUMERIC(10,2),
@SalesPersonId INT
AS
INSERT INTO SalesList(SerialNum,TotalMoney,RealReceive,ReturnMoney,SalesPersonId,SaleDate)
 VALUES(@SerialNum,@TotalMoney,@RealReceive,@ReturnMoney,@SalesPersonId,GETDATE())

CREATE  PROC RefreshMemberPint
@Points INT,
@memberId INT
AS
UPDATE SMMembers SET Points=Points+@Points WHERE MemberId=@memberId

CREATE  PROC GetMemberById
@MemberId INT
AS
SELECT * FROM SMMembers WHERE MemberId=@MemberId
    exec  GetMemberById      '100200302'


CREATE  PROC  InventoryOut
@ProductId VARCHAR(50),
@TotalCount int
AS
UPDATE ProductInventory SET TotalCount-=@TotalCount WHERE ProductId=@ProductId
 DECLARE @Count INT,@MinCount INT
 SELECT @Count=TotalCount,@MinCount=MinCount
 FROM ProductInventory WHERE ProductId=@ProductId
 IF(@Count<@MinCount AND @Count<>0)
 BEGIN
    UPDATE ProductInventory SET 
    StatusId=-1 WHERE
    ProductId=@ProductId
 END
 ELSE IF(@Count=0)
 BEGIN
    UPDATE ProductInventory SET 
    StatusId=-2 WHERE
    ProductId=@ProductId
 END


 TRUNCATE TABLE [dbo].[SalesList]

CREATE  PROC SysAdminLogin
@logId INT,
@logPwd NVARCHAR(50)
AS
SELECT * FROM SysAdmins WHERE
LoginId=@logId AND LoginPwd=@logPwd

CREATE  PROC UpdateSysPwd
@logId INT,
@logPwd NVARCHAR(50)
AS
UPDATE SysAdmins SET LoginPwd=@logPwd
where LoginId=@logId



CREATE  PROC GetProductCategory
AS
select * from ProductCategory order by CategoryId




CREATE  PROC GetProductUnit
 AS
 select * from ProductUnit order by Id



CREATE  PROC InsertProduct
  @ProductId NVARCHAR(50),
  @ProductName NVARCHAR(50),
  @UnitPrice NUMERIC(10,2),
  @Unit NVARCHAR(10),
  @discount float,
  @categoryId int
  AS
 INSERT INTO Products VALUES(@ProductId,@ProductName,@UnitPrice,@Unit,@discount,@categoryId)




CREATE  PROC InsertInventory
 @ProductId NVARCHAR(50),
 @MinCount int,
 @MaxCount int
 AS
 INSERT INTO ProductInventory VALUES(@ProductId,0,@MinCount,@MaxCount,1)




CREATE  PROC GetAllProduct
 AS
 select * from Products



CREATE  PROC  InventoryIn
  @productId NVARCHAR(50),
  @count int
  AS
  UPDATE ProductInventory  SET TotalCount=@count
  where ProductId = @productId 


GO
CREATE  PROC [dbo].[GetMemberById]
@MemberId INT,
@PhoneNumber nvarchar(50)
AS
SELECT * FROM SMMembers WHERE MemberId=@MemberId OR PhoneNumber=@PhoneNumber
GO

CREATE  PROC AddMember
@memberName nvarchar(50),
@phoneNumber nvarchar(50),
@memberAddress text
AS
INSERT INTO SMMembers values(@memberName,0,@phoneNumber,@memberAddress,getdate(),1)
select @@IDENTITY


CREATE  PROC GetTableCount
@TableName  nvarchar(20)
AS
DECLARE @sql nvarchar(200)
select @sql='select Count(*) FROM'+@TableName
EXEC(@sql)

EXEC GetTableCount '[LoginLogs]'

CREATE  PROC GetLoginLogs
AS
select * from LoginLogs


CREATE  PROC GetLoginLogsByPage
@pageCount int,--ÿҳ����
@pageIndex int, --ҳ��
@sortType int
AS
IF(@sortType=1)
BEGIN
select TOP (@pageCount)* From  LoginLogs WHERE LogId not IN (select TOP((@pageIndex-1)*@pageCount) LogId
FROM LoginLogs ORDER BY LogId) ORDER BY LogId ASC
END
ELSE IF(@sortType=0)
BEGIN
select TOP (@pageCount)* From  LoginLogs WHERE LogId not IN (select TOP((@pageIndex-1)*@pageCount) LogId
FROM LoginLogs ORDER BY LogId) ORDER BY LogId DESC
END

EXEC [dbo].[GetLoginLogsByPage] 10,2,0

exec GetLoginLogBy '2020/4/14 0:00:00','2020/4/14 0:00:00','',-1


DECLARE @TIME DATETIME
SET @TIME='2008-12-12 17:12:12'
SELECT @TIME



CREATE  PROC GetLoginLogBy
@startTime DATETIME,
@endTime DATETIME,
@where varchar(50),
@check INT
AS
--����ʱ�������ѯ
IF(@check=2)
BEGIN
set @endTime=DATEADD(DAY,1,@startTime)
END
--ͬʱ����ʱ�������ѯ
ELSE IF(@where<>'' AND (@check=2 OR @check=1 ))
BEGIN
SELECT * FROM LoginLogs WHERE 
LoginTime>=@startTime AND LoginTime<=@endTime
 AND ((CONVERT(nvarchar,LoginId) like '%'+@where+'%' or SPName like '%'+@where+'%' or  ServerName like '%'+@where+'%'))
END
--ֻ����������ѯ
ELSE IF(@where<>'' AND @check=0)
BEGIN
SELECT * FROM LoginLogs WHERE 
((CONVERT(nvarchar,LoginId) like '%'+@where+'%' or SPName like '%'+@where+'%' or  ServerName like '%'+@where+'%'))
END
--��ѯʱ��֮��Ĵ�����
ELSE IF(@where<>'' AND @check=-1)
BEGIN
SELECT * FROM LoginLogs WHERE(CONVERT(nvarchar,LoginId) like '%'+@where+'%' or SPName like '%'+@where+'%' or  ServerName like '%'+@where+'%' ) 
AND LoginTime>=@startTime
END
--��ѯʱ��֮��Ĳ�������
ELSE IF(@where='' AND @check=-1)
BEGIN
SELECT * FROM LoginLogs WHERE 
LoginTime>=@startTime
END


SELECT * FROM LoginLogs WHERE LoginTime>='2020-04-14 00:00:00.00'



CREATE PROC GetAllTables
@tableName NVARCHAR(20)
AS
DECLARE @sqlStr NVARCHAR(400)
SET @sqlStr='SELECT * FROM '+@tableName
EXEC(@sqlStr)

exec GetAllTables 'SysAdmins' 


CREATE PROC InsertAdmin
@adminName NVARCHAR(50),
@loginPwd NVARCHAR(50),
@roleId INT
AS
INSERT INTO SysAdmins VALUES(@loginPwd,@adminName,1,@roleId)
SELECT @@IDENTITY




CREATE PROC SetSysAdmStatus
@role BIT,
@id INT
AS
UPDATE [dbo].[SysAdmins] SET AdminStatus=@role WHERE LoginId=@id


CREATE PROC UpdateAdmin
@adminName NVARCHAR(50),
@loginPwd NVARCHAR(50),
@roleId INT,
@loginId INT
AS
UPDATE [dbo].[SysAdmins] SET LoginPwd=@loginPwd,AdminName=@adminName,Roleld=@roleId WHERE LoginId=@loginId



CREATE PROC InsertSales
@spName NVARCHAR(50),
@loginPwd NVARCHAR(50)
AS
INSERT INTO [dbo].[SalesPerson] VALUES(@spName,@loginPwd)
SELECT @@IDENTITY


CREATE PROC UpdateSaleInfor
@saleName NVARCHAR(50),
@loginPwd NVARCHAR(50),
@loginId int
AS
UPdate[dbo].[SalesPerson] SET SPName=@saleName,LoginPwd=@loginPwd 
WHERE SalesPersonId=@loginId



CREATE PROC GetAllProducts
as
SELECT Products.ProductId,ProductName,UnitPrice,Unit,Discount,Products.CategoryId,ProductCategory.CategoryName,ProductInventory.TotalCount FROM Products INNER JOIN ProductCategory ON ProductCategory.CategoryId=Products.CategoryId INNER JOIN ProductInventory ON ProductInventory.ProductId=Products.ProductId
EXEC GetAllProducts

CREATE PROC GetProductsByWhere
@category INT,
@where NVARCHAR(50)
AS
IF (@category=0 AND @where<>'')
BEGIN
  SELECT Products.ProductId,ProductName,UnitPrice,Unit,Discount,Products.CategoryId,ProductCategory.CategoryName,ProductInventory.TotalCount FROM Products INNER JOIN ProductCategory ON ProductCategory.CategoryId=Products.CategoryId INNER JOIN ProductInventory ON ProductInventory.ProductId=Products.ProductId WHERE Products.ProductId LIKE '%'+@WHERE+'%' OR ProductName like '%'+@WHERE+'%'
END
ELSE IF(@where<>''AND @category<>0)
BEGIN
  SELECT Products.ProductId,ProductName,UnitPrice,Unit,Discount,Products.CategoryId,ProductCategory.CategoryName,ProductInventory.TotalCount FROM Products INNER JOIN ProductCategory ON ProductCategory.CategoryId=Products.CategoryId INNER JOIN ProductInventory ON ProductInventory.ProductId=Products.ProductId WHERE (Products.ProductId LIKE '%'+@WHERE+'%' OR ProductName like '%'+@WHERE+'%') AND Products.CategoryId=@category 
END
ELSE IF(@where='' AND @category<>0)
BEGIN
  SELECT Products.ProductId,ProductName,UnitPrice,Unit,Discount,Products.CategoryId,ProductCategory.CategoryName,ProductInventory.TotalCount FROM Products INNER JOIN ProductCategory ON ProductCategory.CategoryId=Products.CategoryId INNER JOIN ProductInventory ON ProductInventory.ProductId=Products.ProductId WHERE Products.CategoryId=@category 
END

CREATE PROC SetProductDiscount
@discount Float,
@productId NVARCHAR(50)
AS
UPDATE Products SET Discount=@discount WHERE ProductId=@productId


CREATE PROC SetProductInfor
@productName NVARCHAR(50),
@unitPrice NUMERIC(20,2),
@categoryId int,
@unit nvarchar(10),
@productId NVARCHAR(50)
AS
UPDATE Products SET ProductName=@productName,UnitPrice=@unitPrice,CategoryId=@categoryId,Unit=@unit WHERE ProductId=@productId