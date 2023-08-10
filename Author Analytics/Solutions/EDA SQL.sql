use author;
-- Q1
select a.au_id, a.au_lname, a.au_fname, p.pub_id, p.city, s.ord_date, s.qty from authors a 
join titleauthor ta on
ta.au_id = a.au_id
join titles t on
t.title_id = ta.title_id
join publishers p on
p.pub_id = t.pub_id
join sales s on
s.title_id=t.title_id;

-- Q2
SELECT
	p.city,
    p.state,
    p.country,
    a.contract,
    COUNT(DISTINCT a.au_id) AS author_count
FROM
    authors a
JOIN
    titleauthor ta ON a.au_id = ta.au_id
JOIN
    titles t ON ta.title_id = t.title_id
JOIN
    publishers p ON t.pub_id = p.pub_id
GROUP BY
	p.city,
    p.state,
    p.country,
    a.contract;




-- Q3
select a.au_fname,t.title,t.type,t.price,t.ytd_sales from authors a 
join titleauthor ta on 
ta.au_id = a.au_id
join titles t on
t.title_id = ta.title_id;


-- Q4
SELECT
    p.country,
    COUNT(s.title_id) AS total_books_sold,
    SUM(t.ytd_sales * t.price) AS total_sale_amount
FROM
    publishers p
LEFT JOIN 
	titles t ON p.pub_id = t.pub_id
LEFT JOIN 
	titleauthor ta on t.title_id=ta.title_id
LEFT JOIN
    authors a on a.au_id = ta.au_id
LEFT JOIN
    sales s ON t.title_id = s.title_id
GROUP BY
    p.country
ORDER BY
    total_sale_amount DESC;


-- Q5
SELECT
    p.pub_name,
    COUNT(DISTINCT t.title_id) AS total_titles_sold,
	SUM(t.ytd_sales * t.price) as sales_revenue
FROM
    publishers p
LEFT JOIN
    titles t ON p.pub_id = t.pub_id
LEFT JOIN
    sales s ON t.title_id = s.title_id
GROUP BY
    p.pub_name
ORDER BY
    total_titles_sold DESC;

-- Q7

SELECT
    t.type,
    COUNT(DISTINCT t.title_id) AS total_titles_published,
    SUM(t.ytd_sales * t.price) AS total_sales_amount
FROM
    titles t
LEFT JOIN
    sales s ON t.title_id = s.title_id
GROUP BY
    t.type
ORDER BY
    total_sales_amount DESC;

-- Q8
SELECT
    t.title_id,
    t.title,
    SUM(t.ytd_sales * t.price) AS total_sales_amount
FROM
    titles t
LEFT JOIN
    sales s ON t.title_id = s.title_id
GROUP BY
    t.title_id, t.title
ORDER BY
    total_sales_amount DESC;

-- Q9
SELECT
    t.title_id,
    t.title,
    t.price,
    COUNT(*) AS total_sales,
    SUM(t.ytd_sales * t.price) AS total_sales_amount
FROM
    titles t
LEFT JOIN
    sales s ON t.title_id = s.title_id
GROUP BY
    t.title_id, t.title, t.price
HAVING
    COUNT(*) > 0
ORDER BY
    total_sales_amount DESC;

-- Q10
SELECT
    DATE_FORMAT(ord_date, '%Y-%m') AS sales_month,
    COUNT(*) AS total_sales
FROM
    sales
GROUP BY
    sales_month
ORDER BY
    sales_month;

-- 11
SELECT
    t.title_id,
    t.title,
    t.type,
    t.price,
    s.stor_id,
    SUM(t.ytd_sales * t.price) AS total_sales_amount
FROM
    titles t
INNER JOIN
    sales s ON t.title_id = s.title_id
GROUP BY
    t.title_id, t.title, t.type, t.price, s.stor_id
ORDER BY
    total_sales_amount DESC;

-- Q12
SELECT
    s.stor_id,
    s.payterms,
    COUNT(*) AS total_purchases,
    SUM(t.ytd_sales * t.price) AS total_sales_amount
FROM
    sales s
    join titles t on 
    t.title_id = s.title_id
GROUP BY
    s.stor_id, s.payterms
ORDER BY
    s.stor_id, total_sales_amount DESC;
-- Q13 - same as previous q, make self analysis.

-- Q14
SELECT
    st.stor_id,
    st.stor_name,
    st.city,
    st.state,
    COUNT(*) AS total_sales,
    SUM(t.ytd_sales * t.price) AS total_sales_amount
FROM
    stores st
LEFT JOIN
    sales s ON st.stor_id = s.stor_id
    join titles t on 
    t.title_id = s.title_id
GROUP BY
    st.stor_id, st.stor_name, st.city, st.state
ORDER BY
    total_sales_amount DESC;

-- Q15
SELECT
    s.stor_id,
    d.discounttype,
    d.discount,
    COUNT(*) AS total_sales,
    SUM(t.ytd_sales * t.price) AS total_sales_amount
FROM
    sales s
LEFT JOIN
    discounts d ON s.stor_id = d.stor_id
join titles t on 
    t.title_id = s.title_id
GROUP BY
    s.stor_id, d.discounttype,d.discount
ORDER BY
    s.stor_id, total_sales_amount DESC;
