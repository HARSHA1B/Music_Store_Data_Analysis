select * from books;
select * from branch;
select * from employees;
select * from issue_status;
select * from members;
select * from return_status;

--PROJECT TASK--
-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
INSERT INTO books VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

-- Task 2: Update an Existing Member's Address
UPDATE members
SET member_address = '125 Main St'
WHERE member_id= 'C101'
SELECT * FROM members;

-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
DELETE FROM issue_status
WHERE issued_id = 'IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT issued_emp_id, issued_book_name from issue_status where issued_emp_id ='E101';

-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT employees.emp_id
from employees 
join issue_status on employees.emp_id=issue_status.issued_emp_id
group by employees.emp_id having count ( issue_status.issued_book_name )>1;


SELECT 
    ist.issued_emp_id,
     e.emp_name
    
FROM issue_status as ist
JOIN
employees as e
ON e.emp_id = ist.issued_emp_id
GROUP BY 1, 2
HAVING COUNT(ist.issued_id) > 1;

-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results -
--each book and total book_issued_cnt**
CREATE TABLE total_book_count as
SELECT issued_book_name,count(issued_book_name) as "total_book_issued" 
FROM issue_status 
GROUP BY issued_book_name;

-- Task 7. Retrieve All Books in a Specific Category:
SELECT category, COUNT(category) AS "count_books" 
FROM books
GROUP BY category ;

-- Task 8: Find Total Rental Income by Category:
SELECT category , SUM(rental_price) AS "total"
FROM books 
GROUP BY category;

-- List Members Who Registered in the Last 180 Days:
SELECT * FROM  members
WHERE reg_date>= current_date - interval '180 days'; 

-- task 10 List Employees with Their Branch Manager's Name and their branch;
SELECT employees.emp_id, branch.manager_id 
FROM employees JOIN branch ON employees.branch_id=branch.branch_id;


-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:
CREATE TABLE rental_price_greater as
SELECT * FROM books
WHERE rental_price>7;

-- Task 12: Retrieve the List of Books Not Yet Returned;
SELECT DISTINCT issue_status.issued_book_name
FROM ssue_status LEFT JOIN return_status on issue_status.issued_id=return_status.issued_id
WHERE return_status.return_id IS NULL;


