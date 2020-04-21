GO
CREATE DATABASE SuperMark	
on primary
(
	NAME='SuperMark',
	FILENAME='D:\SQL作业\20200407\SuperMark.mdf',
	SIZE=6MB,
	FILEGROWTH=10%
)
LOG ON
(
	NAME='SuperMark_log',
	FILENAME='D:\SQL作业\20200407\SuperMark_log.ldf',
	SIZE=3MB,
	FILEGROWTH=10%
)
GO
USE SuperMark

------库存和存储
CREATE TABLE InventoryStatus  --商品库存表
(
  StatusId INT PRIMARY KEY CHECK(StatusId=1 OR StatusId=-1 OR StatusId=2 OR StatusId=-2) NOT NULL, --库存状态
  StatusDesc VARCHAR(50) NOT NULL --1正常，-1低于库存，2高于库存，-2清仓
)
CREATE TABLE ProductInventory  --商品存储表
(
  ProductId VARCHAR(50) PRIMARY KEY NOT NULL,  --商品ID
  TotalCount INT NOT NULL,--总数量
  MinCount INT NOT NULL, --最小库存
  MaxCount INT NOT NULL,--最大库存
  StatusId INT NOT NULL FOREIGN KEY (StatusId) REFERENCES InventoryStatus(StatusId)--库存状态
)
-------结账
CREATE TABLE SalesPerson --销售员表
(
 SalesPersonId INT PRIMARY KEY IDENTITY(10000,1) NOT NULL, --销售员ID: 10000
 SPName VARCHAR(50) NOT NULL ,--销售员名称
 LoginPwd VARCHAR(50) NOT NULL --密码
)
CREATE TABLE SalesList --打印流水表
(
  SerialNum VARCHAR(50) PRIMARY KEY NOT NULL ,--流水号系統生成
  TotalMoney NUMERIC(10, 2) NOT NULL,--购物总价
  RealReceive NUMERIC(10, 2) NOT NULL,--实际收款
  ReturnMoney NUMERIC(10, 2) NOT NULL,--找零
  SalesPersonId INT FOREIGN KEY (SalesPersonId) REFERENCES SalesPerson(SalesPersonId) , --销售员ID
  SaleDate SMALLDATETIME NOT NULL --时间
)
CREATE TABLE SalesListDetall  --流水表
(
  Id INT NOT NULL PRIMARY KEY IDENTITY(1000000,1),--（1000000,1）
  SerialNum VARCHAR(50) FOREIGN KEY (SerialNum) REFERENCES SalesList(SerialNum), --流水号
  ProductId VARCHAR(50) NOT NULL, --商品编号
  ProductName VARCHAR(50) NOT NULL, --商品名称
  UnitPrice NUMERIC(10, 2) NOT NULL,--商品单价
  Discount float, --折扣
  Quantity INT NOT NULL,--销售数量
  SubTotalMoney NUMERIC(10, 2) --小计金额
)
-------商品
CREATE TABLE ProductCategory --商品分类表
(
 CategoryId INT PRIMARY KEY IDENTITY(1,1),--商品分类ID1,1
 CategoryName VARCHAR(20) NOT NULL--商品分类
)
CREATE TABLE Products --商品价格表
(
 ProductId VARCHAR(50) PRIMARY KEY  NOT NULL,--商品编号商品条码
 ProductName VARCHAR(50) NOT NULL,--商品名称
 UnitPrice NUMERIC(5,2) NOT NULL,--单价
 Unit VARCHAR(50) NOT NULL,--计量单位
 Discount float ,--折扣
 CategoryId INT FOREIGN KEY (CategoryId) REFERENCES ProductCategory(CategoryId) NOT NULL--商品分类
)
CREATE TABLE ProductStorage--商品入库表
(
 StorageId INT NOT NULL PRIMARY KEY IDENTITY(100000,1),--IDENTITY(100000,1),
 ProductId VARCHAR(50) FOREIGN KEY (ProductId) REFERENCES Products(ProductId), --商品ID
 AddedCount INT NOT NULL,--入库数量
 CurrentTime SMALLDATETIME NOT NULL--入库时间
)


CREATE TABLE SMMembers -- 
(
 MemberId INT NOT NULL PRIMARY KEY IDENTITY(100200300,1),--会员卡号
 MemberName VARCHAR(50) NOT NULL,--会员姓名
 Points INT NOT NULL,--会员积分10元=1
 PhoneNumber VARCHAR(200) NOT NULL,--联系电话
 MemberAddress TEXT NOT NULL,--联系地址
 OpenTime DATETIME, --开户时间
 MemberStatus INT NOT NULL--会员卡状态1正，0冻，-1注销
)
CREATE TABLE LoginLogs --职员登录表
(
 LogId INT  PRIMARY KEY IDENTITY(1,1),--1,1
 LoginId INT NOT NULL,--登录者ID
 SPName VARCHAR(50) ,--登录人姓名
 ServerName VARCHAR(100),--登录服务器名
 LoginTime DATETIME NOT NULL,--登录时间
 ExitTime DATETIME --退出时间
)
CREATE TABLE SysAdmins --管理员表
(
 LoginId INT NOT NULL PRIMARY KEY IDENTITY(2000,1),--登录账号2000
 LoginPwd VARCHAR(20) ,--登录密码
 AdminName VARCHAR(20), --管理员名
 AdminStatus BIT ,--当前状态1启0禁
 Roleld INT --角色类型1超级2一般
)
CREATE TABLE ProductUnit  --
(
 Id INT NOT NULL PRIMARY KEY IDENTITY(1,1),--1,1
 Unit VARCHAR(20) NOT NULL --商品计量单位
)
 SELECT * FROM SalesPerson 
  SELECT * FROM ProductInventory
  SELECT * FROM Products






INSERT INTO SalesPerson VALUES
('赵玉田','123456'),('谢大脚','123456'),('刘大脑袋','123456')
INSERT INTO SMMembers 
SELECT '震雷削',0,13825138120,'陕西安康','2020-4-06',1UNION
SELECT '王航航',0,15029063866,'地球中国','2020-4-06',1UNION
SELECT '王二航',0,15029063865,'陕西渭南','2020-4-06',1UNION
SELECT '张三',0,15029063866,'陕西','2020-4-06',1UNION
SELECT '李四',0,15029063866,'陕西咸阳','2020-4-06',1
INSERT INTO SysAdmins
SELECT 123456,'姜子牙','False',2UNION
SELECT 123456,'李靖','True',2UNION
SELECT 123456,'雷震子','True',1UNION
SELECT 123456,'哪吒','True',1UNION
SELECT 123456,'木吒','False',1UNION
SELECT 123456,'金吒','True',1
INSERT INTO ProductUnit VALUES
('箱'),('个'),('瓶'),('盒'),('本'),('袋'),('只'),('条'),('桶'),('打'),('听'),('罐'),('张'),('块')
INSERT INTO ProductCategory VALUES
('饮料'),('副食'),('面食'),('肉类'),('米类'),('酒类'),('烟类'),('文具类'),('玩具类'),('日用品')
INSERT INTO Products
SELECT 6002504003331,'康师傅统一牛肉面','40.00','箱',0,3UNION
SELECT 6002504003332,'老坛酸菜牛肉面','45.00','箱',0,3UNION
SELECT 6002504003333,'雪花啤酒','60.00','箱',0,6UNION
SELECT 6002504003334,'燕京啤酒','61.00','箱',0,6UNION
SELECT 6002504003335,'可口可乐','6.00','瓶',0,1UNION
SELECT 6002504003336,'百世可乐','5.50','瓶',0,1UNION
SELECT 6002504003337,'统一鲜橙多','5.00','瓶',0,1UNION
SELECT 6002504003338,'法式小面包','8.00','袋',0,2UNION
SELECT 6002504003339,'黑人牙膏','6.80','盒',0,10UNION
SELECT 6002504003341,'平原小米','102.00','袋',0,5UNION
SELECT 6002504003342,'纯棉毛巾','9.90','条',0,10
--UPDATE Products SET ProductName=REPLACE(ProductName,'雪花','燕京')
INSERT INTO InventoryStatus VALUES
(-2,'已清仓'),(-1,'低于库存'),(1,'正常'),(2,'高于库存')
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
@pageCount int,--每页数量
@pageIndex int, --页码
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
--按照时间区间查询
IF(@check=2)
BEGIN
set @endTime=DATEADD(DAY,1,@startTime)
END
--同时按照时间区间查询
ELSE IF(@where<>'' AND (@check=2 OR @check=1 ))
BEGIN
SELECT * FROM LoginLogs WHERE 
LoginTime>=@startTime AND LoginTime<=@endTime
 AND ((CONVERT(nvarchar,LoginId) like '%'+@where+'%' or SPName like '%'+@where+'%' or  ServerName like '%'+@where+'%'))
END
--只按照条件查询
ELSE IF(@where<>'' AND @check=0)
BEGIN
SELECT * FROM LoginLogs WHERE 
((CONVERT(nvarchar,LoginId) like '%'+@where+'%' or SPName like '%'+@where+'%' or  ServerName like '%'+@where+'%'))
END
--查询时间之后的待条件
ELSE IF(@where<>'' AND @check=-1)
BEGIN
SELECT * FROM LoginLogs WHERE(CONVERT(nvarchar,LoginId) like '%'+@where+'%' or SPName like '%'+@where+'%' or  ServerName like '%'+@where+'%' ) 
AND LoginTime>=@startTime
END
--查询时间之后的不待条件
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