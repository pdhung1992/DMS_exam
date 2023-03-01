create table Customer(
	CustomerID int primary key,
	Name nvarchar(50),
	City nvarchar(50),
	Country nvarchar(50),
	Phone nvarchar(15),
	Email nvarchar(50)
);
create table CustomerAccount(
	AccountNumber char(9) primary key,
	CustomerID int not null foreign key references Customer(CustomerID),
	Balance money not null,
	MinAccount money
);
create table CustomerTransaction(
	TransactionID int primary key,
	AccountNumber char(9) foreign key references CustomerAccount(AccountNumber),
	TransactionDate smalldatetime,
	Amount money,
	DepositorWithdraw bit
);

select * from Customer;
select * from CustomerAccount;
select * from CustomerTransaction;

insert into Customer(CustomerID, Name, City, Country, Phone, Email)
	values
		(1,'Nguyen Van An', 'Hanoi', 'Vietnam', '0987654321', 'abc@gmail.com'),
		(2,'Tran Van Duc', 'Danang', 'Vietnam', '0942542642', 'xyz@gmail.com'),
		(3,'Do Thi Thu', 'Hanoi', 'Vietnam', '0988888888', 'jqk@gmail.com'),
		(4,'Pham Thi Trang', 'Hochiminh', 'Vietnam', '0867675199', 'trangp@gmail.com'),
		(5,'Nguyen Manh Duc', 'Cantho', 'Vietnam', '0888188288', 'duc@gmail.com')

insert into CustomerAccount(AccountNumber, CustomerID, Balance, MinAccount)
	values 
		(12345, 1, 1500000, 100),
		(23456, 2, 2000000, 100),
		(34567, 3, 2500000, 100),
		(45678, 4, 3000000, 100),
		(56789, 5, 3500000, 100)

insert into CustomerTransaction(TransactionID, AccountNumber, TransactionDate, Amount, DepositorWithdraw)
	values
		(1, 12345, '2023-03-01 15:00', 500000, 0),
		(2, 23456, '2023-03-01 14:00', 200000,1),
		(3, 34567, '2023-03-01 14:30', 100000,1),
		(4, 45678, '2023-02-28 13:30', 200000, 0),
		(5, 56789, '2023-02-28 10:00', 100000, 1)

--q4
select * from Customer where City = 'Hanoi';

--q5
select C.Name, C.Phone, C.Email, A.AccountNumber, A.Balance from CustomerAccount A 
	inner join Customer C on A.CustomerID = C.CustomerID;

--q6
alter table CustomerTransaction
	add check (Amount > 0 and Amount < 1000000);

--q7
create view vCustomerTransactions as
	select C.Name, A.AccountNumber, T.TransactionDate, T.Amount, T.DepositorWithdraw from CustomerTransaction T
		inner join CustomerAccount A on T.AccountNumber = A.AccountNumber
		inner join Customer C on A.CustomerID = C.CustomerID;
select * from vCustomerTransactions;