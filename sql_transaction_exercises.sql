
--------- Task 1 ---------

CREATE TABLE book_inventory (
    book_id INT PRIMARY KEY, book_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL, price DECIMAL(10, 2) NOT NULL
);


INSERT INTO book_inventory (book_id, book_name, quantity, price) VALUES (1, 'Getting Over You', 50, 350);

INSERT INTO book_inventory (book_id, book_name, quantity, price) VALUES (2, '1M Lead', 30, 450);

INSERT INTO book_inventory (book_id, book_name, quantity, price) VALUES (3, 'Ego is the Enemy', 40, 400);


UPDATE book_inventory SET quantity = quantity - 15 WHERE book_id = 1;

SAVEPOINT quantity_update;


SELECT * FROM BOOK_INVENTORY;



--------- Task 2 ---------

CREATE TABLE staff (
    id NUMBER PRIMARY KEY, employee_name VARCHAR2(100) NOT NULL,
    salary NUMBER(10,2) NOT NULL
);

Select * From staff;

INSERT INTO staff (id, employee_name, salary) VALUES (1, 'Ashar Naveed', 45000);

UPDATE staff SET salary = salary + (salary * 0.12) WHERE id = 1;


SAVEPOINT salary_boost;

UPDATE staff SET salary = salary + (salary * 0.08) WHERE id = 1;

ROLLBACK TO SAVEPOINT salary_boost;

COMMIT;




--------- Task 3 ---------


CREATE TABLE vendors (
    id NUMBER PRIMARY KEY,
    vendor_name VARCHAR2(255) NOT NULL
);


CREATE TABLE supplies (
    supplier_id NUMBER PRIMARY KEY, vendor_id NUMBER REFERENCES vendors(id),
    item_name VARCHAR2(255) NOT NULL, quantity NUMBER NOT NULL
);

BEGIN

    INSERT INTO vendors (id, vendor_name) VALUES (1, 'Adil Khan');

    INSERT INTO supplies (supplier_id, vendor_id, item_name, quantity) VALUES (1, 1, 'Horror Book', 100);

    COMMIT;

EXCEPTION

    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

SELECT * FROM vendors;
SELECT * FROM supplies;


--------- Task 4 ---------


CREATE TABLE payment (
    id NUMBER PRIMARY KEY, vendor_id NUMBER REFERENCES vendors(id),
    amount INTEGER NOT NULL
);


SET AUTOCOMMIT ON;

INSERT INTO payment (id, vendor_id, amount) VALUES (1, 1, 5000);

SELECT * FROM payment WHERE id = 1;


SET AUTOCOMMIT OFF;



--------- Task 5 ---------


CREATE TABLE account_transactions (
    id NUMBER PRIMARY KEY, account_id NUMBER NOT NULL,
    transaction_type VARCHAR2(25) NOT NULL, amount INTEGER NOT NULL,
    balance INTEGER NOT NULL
);


INSERT INTO account_transactions (id, account_id, transaction_type, amount, balance)
VALUES (1, 1, 'DEPOSIT', 1000, 1000);


SAVEPOINT first_deposit;

INSERT INTO account_transactions (id, account_id, transaction_type, amount, balance)
VALUES (2, 1, 'WITHDRAW', 200, 800);


SAVEPOINT first_withdrawal;

INSERT INTO account_transactions (id, account_id, transaction_type, amount, balance)
VALUES (3, 1, 'DEPOSIT', 500, 1300);


SAVEPOINT second_deposit;

-- Roll back to old balance as i have take assumption that deposit transection fail
ROLLBACK TO SAVEPOINT first_withdrawal;

select * from ACCOUNT_TRANSACTIONS;


