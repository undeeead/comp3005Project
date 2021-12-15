insert into author(id, fname, lname) values (1, 'William', 'Shakespeare');
insert into author(id, fname, lname) values (2, 'Barack', 'Obama');
insert into author(id, fname, lname) values (3, 'J.K.', 'Rowling');
insert into author(id, fname, lname) values (4, 'Ernest', 'Hemingway');

insert into publishers(id, companyName, adr, email, phoneNumber, bankAccount, percentageSales) values (1, 'AwesomeBooks', 'Calgary CA', 'awesome@books.com', 123456789, 123456789, 0.2);
insert into publishers(id, companyName, adr, email, phoneNumber, bankAccount, percentageSales) values (2, 'SecretBooks', 'Vancouver CA', 'secret@books.com', 543211234, 123412343, 0.15);
insert into publishers(id, companyName, adr, email, phoneNumber, bankAccount, percentageSales) values (3, 'TimHortons', 'Ontario CA', 'Tim@hortons.com', 987654321, 000000123, 0.4);

insert into genres(id, genreType) values (1, 'Non-Fiction');
insert into genres(id, genreType) values (2, 'Fiction');
insert into genres(id, genreType) values (3, 'Fantasy');

insert into usersInfo(id, fname, lname) values (1, 'Steve', 'Jobs');
insert into usersInfo(id, fname, lname) values (2, 'Elon', 'Musk');
insert into usersInfo(id, fname, lname) values (3, 'Larry', 'Page');
insert into usersInfo(id, fname, lname) values (4, 'Steve', 'Page');

insert into books(title, authorId, publisherId, numPages, cost, genreId) values('Life of Shakespeare', 1, 1, 500, 10.00, 1);
insert into books(title, authorId, publisherId, numPages, cost, genreId) values('Life as a President', 2, 2, 600, 12.00, 2);
insert into books(title, authorId, publisherId, numPages, cost, genreId) values('Life of Harry Potter', 3, 3, 400, 11.00, 3);
insert into books(title, authorId, publisherId, numPages, cost, genreId) values('Harry Potter: The master wizard', 3, 3, 200, 15.00, 3);
insert into books(title, authorId, publisherId, numPages, cost, genreId) values('The mastery of wizardry', 3, 3, 105, 1000.00, 3);
insert into books(title, authorId, publisherId, numPages, cost, genreId) values('Engineering Apple', 1, 1, 700, 14.00, 2);
insert into books(title, authorId, publisherId, numPages, cost, genreId) values('Apple Excellence', 1, 1, 701, 25.00, 2);
insert into books(title, authorId, publisherId, numPages, cost, genreId) values('Go to Market: iPhone', 1, 1, 102, 100.00, 2);


/*
    Items required below!
*/
/* Add books into bookStore if it doesn't exist already, with default value 0 */
insert into bookStoreStock(isbn, inStock) select b.isbn, 0
from bookStoreStock as bss
right join books as b on bss.isbn = b.isbn
where bss.isbn is null;

/* Add books into booksSold if it doesn't exist already, with default value 0 */
insert into booksSold(isbn, saleAmount) select b.isbn, 0
from booksSold as bs
right join books as b on bs.isbn = b.isbn
where bs.isbn is null;