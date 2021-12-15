/*
    Section 1:
    Order new books when in stock books is less than 10
*/
UPDATE bookStoreStock set inStock = inStock + 10 WHERE inStock <= 10;

/*
    Section 2:
    Verify if the user exists in the system.
    If we verify a single user unique user exists,
    then we can move to the next section
*/
select(select Count(*) from usersInfo where id=10) = 1; /* False */
select(select Count(*) from usersInfo where id=1) = 1; /* True */
select(select Count(*) from usersInfo where fname = 'Steve') = 1; /* False */


/* 
    Section 3:
    Insert books into your shopping cart.
    If you decide to run a manual insert, 
    please insert and update at the same time.
*/
insert into shoppingCart(userId, isbn) values(1, 1);
UPDATE bookStoreStock set inStock = inStock - 1 WHERE isbn = 1;
insert into shoppingCart(userId, isbn) values(1, 1);
UPDATE bookStoreStock set inStock = inStock - 1 WHERE isbn = 1;
insert into shoppingCart(userId, isbn) values(1, 2);
UPDATE bookStoreStock set inStock = inStock - 1 WHERE isbn = 2;

/*
    Section 4 - (Optional):
    Remove extra book from shopping cart and increment bookStoreStock 
*/
DELETE FROM shoppingCart
WHERE id IN (
        SELECT id
        FROM shoppingCart
        where userId = 1 and isbn = 1
        ORDER BY isbn limit 1
);
UPDATE bookStoreStock set inStock = inStock + 1 WHERE isbn = 1;

/*  
    Section 5: 
    Check to see if the user has a billing/shipping address, 
    if not update the shipping/billing address.

    If billing/shipping address is true, then we can move to the next section
*/
select (select billingAddress from usersInfo where id = 1) is not null; /* False */
update usersInfo set billingAddress = 'Calgary' where id = 1;
select (select shippingAddress from usersInfo where id = 1) is not null; /* False */
update usersInfo set shippingAddress = 'Calgary' where id = 1;
select (select billingAddress from usersInfo where id = 1) is not null; /* True */
select (select shippingAddress from usersInfo where id = 1) is not null; /* True */

/*
    Section 6:
    Place the order once the user has a billing/shipping address is on file.
    Create the order with a tracking number, update books sold and clear the shopping cart
*/
insert into orders(idBuyer, trackingNum) values (1, floor(random()*(999999-10000+1))+10000);
/* Add purchased books to booksSold - currently doesnt allow for multiple books, only 1*/ 
update booksSold set saleAmount = saleAmount + 1 where isbn in (select isbn from shoppingCart where userId = 1);
/* Clear the shopping cart since we purchased it*/
Delete from shoppingCart where userId = 1;

/*
    Section 7:
    Query the tracking number
*/
/* Query tracking number by userId */
select trackingNum from orders where idBuyer = 1;
/* or by order number */
select trackingNum from orders where orderId = 1;
/* or by full name */
select trackingNum from orders as o
left join usersInfo as u on o.idBuyer = u.id
where u.fname = 'Steve' and u.lname = 'Jobs';
/* or Steve in Calgary */
select trackingNum from orders as o
left join usersInfo as u on o.idBuyer = u.id
where u.fname = 'Steve' and u.billingAddress='Calgary';

/*
    Section 8:
    Query the possible metric categories that a publisher may want
*/
/* Sales vs expenditures for a specific publisher */
select sum(bs.saleAmount) as total_books_sold, sum(bs.saleAmount * b.cost) as Gross_income, sum(bs.saleAmount * b.cost) * p.percentageSales as net_income
from booksSold as bs
left join books as b on bs.isbn = b.isbn
left join genres as g on b.genreId = g.id
left join publishers as p on b.publisherId = p.id
where p.companyName like 'Awesome%'
group by p.percentageSales;

/* Sales per Genre by Publisher */
select count(g.genreType) as Sales_per_Genre, g.genreType
from booksSold as bs
left join books as b on bs.isbn = b.isbn
left join genres as g on b.genreId = g.id
left join publishers as p on b.publisherId = p.id
where p.companyName like 'Awesome%'
group by g.genreType;

/* Sales by genre ending in Fiction of all publishers */
select sum(saleAmount), p.companyName
from booksSold as bs
left join books as b on bs.isbn = b.isbn
left join genres as g on b.genreId = g.id
left join publishers as p on b.publisherId = p.id
where g.genreType like '%Fiction'
group by p.companyName
order by sum(saleAmount) desc, p.companyName desc;

/* Sales by genre of all publishers */
select sum(saleAmount), p.companyName
from booksSold as bs
left join books as b on bs.isbn = b.isbn
left join genres as g on b.genreId = g.id
left join publishers as p on b.publisherId = p.id
where g.genreType = 'Non-Fiction'
group by p.companyName
order by sum(saleAmount) desc, p.companyName desc;

/* Sales by genre and publisher*/
select saleAmount 
from booksSold as bs
left join books as b on bs.isbn = b.isbn
left join genres as g on b.genreId = g.id
left join publishers as p on b.publisherId = p.id
where g.genreType = 'Non-Fiction' and p.companyName LIKE 'Awesome%';

/* Sales per author of all publishing companies */
select sum(bs.saleAmount), a.fname, a.lname
from booksSold as bs
left join books as b on bs.isbn = b.isbn
left join genres as g on b.genreId = g.id
left join publishers as p on b.publisherId = p.id
left join author as a on b.authorId = a.id
group by b.authorId, a.fname, a.lname;

/* Sales per author of a specific publishing companies */
select sum(bs.saleAmount), a.fname, a.lname
from booksSold as bs
left join books as b on bs.isbn = b.isbn
left join genres as g on b.genreId = g.id
left join publishers as p on b.publisherId = p.id
left join author as a on b.authorId = a.id
where p.companyName like 'Awesome%'
group by b.authorId, a.fname, a.lname;

/*
    Section Bonus:
*/
/* Query all tracking numbers for a specific user by first/last name */
select trackingNum
from orders 
where idBuyer = (select id from usersInfo as ui where ui.fname = 'Steve' and ui.lname='Jobs');

/* Query all tracking numbers for a specific user by user id */
select trackingNum
from orders
where idBuyer = 1;

/* Query books with similar author first name */
select b.title, a.fname, a.lname
from books as b
left join author as a on b.authorId = a.id
where a.fname like '%William%';

/* Query Books with similar search term */
select b.title, a.fname, a.lname
from books as b
left join author as a on b.authorId = a.id
where b.title like '%of%';

/* Book Store Query Genre's Sold */
select sum(saleAmount), g.genreType
from booksSold as bs
left join books as b on bs.isbn = b.isbn
left join genres as g on b.genreId = g.id
group by g.genreType
order by sum(saleAmount) desc, g.genreType desc;

/* Book Store Query Total Books sold by author in order */
select sum(saleAmount), a.fname, a.lname
from booksSold as bs
left join books as b on bs.isbn = b.isbn
left join author as a on b.authorId = a.id
group by a.fname, a.lname
order by sum(saleAmount) desc, a.fname asc, a.lname asc;

/* Book Store Query top 10 all time author sellers */
select sum(saleAmount), a.fname, a.lname
from booksSold as bs
left join books as b on bs.isbn = b.isbn
left join author as a on b.authorId = a.id
group by a.fname, a.lname
order by sum(saleAmount) desc, a.fname asc, a.lname asc
limit 10;

/* Book Store Query top books of all time*/
select sum(saleAmount), b.title, a.fname, a.lname
from booksSold as bs
left join books as b on bs.isbn = b.isbn
left join author as a on b.authorId = a.id
group by b.title, a.fname, a.lname
order by sum(saleAmount) desc, b.title asc, a.fname asc, a.lname asc
limit 10;