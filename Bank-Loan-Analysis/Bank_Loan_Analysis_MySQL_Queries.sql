-- =========================================================
-- BANK LOAN ANALYSIS | MYSQL QUERIES
-- =========================================================
-- Project: Bank Loan Analysis
-- Database Table: bank_loan_data
-- SQL Platform: MySQL / MySQL Workbench
-- =========================================================

-- =========================================================
-- PART A: BANK LOAN REPORT | SUMMARY
-- =========================================================

-- 1. Total Loan Applications
SELECT COUNT(id) AS Total_Applications
FROM bank_loan_data;

-- 2. MTD Loan Applications
SELECT COUNT(id) AS Total_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- 3. PMTD Loan Applications
SELECT COUNT(id) AS Total_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

-- 4. Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data;

-- 5. MTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- 6. PMTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

-- 7. Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected
FROM bank_loan_data;

-- 8. MTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- 9. PMTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

-- 10. Average Interest Rate
SELECT AVG(int_rate) * 100 AS Avg_Int_Rate
FROM bank_loan_data;

-- 11. MTD Average Interest Rate
SELECT AVG(int_rate) * 100 AS MTD_Avg_Int_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- 12. PMTD Average Interest Rate
SELECT AVG(int_rate) * 100 AS PMTD_Avg_Int_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

-- 13. Average DTI
SELECT AVG(dti) * 100 AS Avg_DTI
FROM bank_loan_data;

-- 14. MTD Average DTI
SELECT AVG(dti) * 100 AS MTD_Avg_DTI
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- 15. PMTD Average DTI
SELECT AVG(dti) * 100 AS PMTD_Avg_DTI
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

-- =========================================================
-- GOOD LOAN ISSUED
-- =========================================================

-- 16. Good Loan Percentage
SELECT
    (COUNT(CASE
        WHEN loan_status IN ('Fully Paid', 'Current') THEN id
    END) * 100.0) / COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data;

-- 17. Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- 18. Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- 19. Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_Amount_Received
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- =========================================================
-- BAD LOAN ISSUED
-- =========================================================

-- 20. Bad Loan Percentage
SELECT
    (COUNT(CASE
        WHEN loan_status = 'Charged Off' THEN id
    END) * 100.0) / COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;

-- 21. Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- 22. Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- 23. Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_Amount_Received
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- =========================================================
-- LOAN STATUS
-- =========================================================

-- 24. Loan Status Summary
SELECT
    loan_status,
    COUNT(id) AS Loan_Count,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate) * 100 AS Interest_Rate,
    AVG(dti) * 100 AS DTI
FROM bank_loan_data
GROUP BY loan_status;

-- 25. MTD Loan Status Summary
SELECT
    loan_status,
    SUM(total_payment) AS MTD_Total_Amount_Received,
    SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status;

-- =========================================================
-- PART B: BANK LOAN REPORT | OVERVIEW
-- =========================================================

-- 26. Monthly Trends by Issue Date
-- MySQL equivalent of SQL Server DATENAME(MONTH, issue_date) is MONTHNAME(issue_date).
SELECT
    MONTH(issue_date) AS Month_Number,
    MONTHNAME(issue_date) AS Month_Name,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);

-- 27. State Analysis
SELECT
    address_state AS State,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state;

-- 28. Loan Term Analysis
SELECT
    term AS Term,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term;

-- 29. Employee Length Analysis
SELECT
    emp_length AS Employee_Length,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;

-- 30. Loan Purpose Analysis
SELECT
    purpose AS Purpose,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose;

-- 31. Home Ownership Analysis
SELECT
    home_ownership AS Home_Ownership,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership;

-- =========================================================
-- FILTER EXAMPLE
-- =========================================================

-- 32. Loan Purpose Analysis for Grade A Loans
SELECT
    purpose AS Purpose,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose;

-- =========================================================
-- END OF BANK LOAN ANALYSIS QUERIES
-- =========================================================
