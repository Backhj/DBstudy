SELECT gubun
      ,SUM(loan_jan_amt) as �հ�
FROM kor_loan_status
GROUP BY ROLLUP(gubun);
--member ������ ���ϸ����� �հ�� ��ü �Ѱ踦 ���Ͻÿ� 
SELECT mem_job
      ,SUM(mem_mileage) �հ�
FROM member
GROUP BY ROLLUP(mem_job);

SELECT period
      ,gubun
      ,SUM(loan_jan_amt) AS �հ�
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY ROLLUP(period, gubun); --period�� �Ұ�

SELECT gubun
      ,period
      ,sum(loan_jan_amt) �հ�
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY ROLLUP(gubun,period);

--employees ���̺��� ���� �� �μ��� �������� ��ü �������� ����Ͻÿ�
--grouping_id
SELECT department_id
      ,grouping(department_id)
      ,grouping_id(department_id) as �׷� -- �׷� rolluup�� ����� �κ�
      ,COUNT(*) as ������
FROM employees
GROUP BY ROLLUP(department_id);
--������ �̹� ������ commission_pct ��ŭ �߰����� �Ϸ��� �մϴ�.
--���ް�, �߰��ݾ�, �ջ�ݾ��� ����Ͻÿ�
-- NVL(����, ���氪) ������ null�� ��� ���氪���� ��ü
SELECT emp_name
     , salary ����, 
       salary * commission_pct as ��
     , salary +(salary * NVL(commission_pct,0)) as �ջ�ݾ�
FROM employees;

SELECT CASE WHEN department_id IS NULL AND grouping_id(department_id) = 0 THEN '�μ�����'
            WHEN department_id IS NULL AND grouping_id(department_id) = 1 THEN '�Ѱ�'
            ELSE TO_CHAR(department_id)
            END AS �μ�
      ,COUNT(*) as ������
FROM employees
GROUP BY ROLLUP(department_id);
--member ȸ���� ���������� ȸ���� ������ �ο����� ���ϸ��� �հ� �ݾ��� ����Ͻÿ�(�Ѱ赵)

SELECT NVL(mem_job,'�� ��')as ����
      ,COUNT(*) as ȸ����
      ,SUM(mem_mileage) as ���ϸ����հ�
FROM member
WHERE mem_add1 LIKE '%����%'
GROUP BY ROLLUP(mem_job);
--���� UNION (������), UNION ALL ��ü����, MINUS ������ INTERSECT ������
--��ȸ����� �÷����� Ÿ���� ������ �������밡��(������ �������� ����)
SELECT seq, goods
FROM exp_goods_asia
WHERE country ='�ѱ�';

SELECT seq, goods
FROM exp_goods_asia
WHERE country ='�Ϻ�'
UNION
SELECT 1, 'HI'
FROM dual;

SELECT mem_job
      ,SUM(mem_mileage) as �հ�
FROM member
GROUP BY mem_job
UNION
SELECT '�հ�'
      ,SUM(mem_mileage)
FROM member
ORDER BY 2 asc;

SELECT *
FROM member
WHERE mem_name ='Ź����';

SELECT *
FROM cart
WHERE cart_member='n001';
-- INNER JOIN(��������) (���������̶�� ��.)
SELECT member.mem_id
      ,member.meme_name
      ,cart.cart_member
      ,cart.cart_prod
      ,cart.cart_qty
FORM member, cart
WHERE member.mem_id = cart.cart_member
AND member.meme.mem_name;='Ź����' -- mem_id �� cart_member ���� �����Ҷ� ����

SELECT member.mem_id
      ,member.meme_name
      ,SUM(cart.cart_qty) ��ǰ���ż�
FROM member, cart
WHERE member.mem_id = cart.cart_member(4) -- outer join �ܺ�����
                                          -- null���� ���Խ��Ѿ� �Ҷ� (+) ���
AND member.meme.mem_name='Ź����'
GROUP BY member.mem_id
        ,member.mem_name;
        
SELECT member.mem_id
      ,member.mem_name
      ,cart.cart_qty ��ǰ���ż�
FROM member, cart
WHERE member.mem_id = cart.cart_member(+); -- outer join �ܺ�����
--������ �̸��� �μ����� ����Ͻÿ� 
SELECT employess.emp_name
      ,employess.department_id
      ,departments.department_name
FROM departments;
--������ �Ҷ��� ���� �� ���̺��� �ʿ��� �÷� ��ȸ select�� �ۼ�
--�� ������ �����Ͱ� �´��� Ȯ�� ��
--������ �̿��� select�� �ۼ�
SELECT employees.emp_name
      ,departments.department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

SELECT a.emp_name
      ,b.department_name
FROM employees a, departments b -- ���̺� ��Ī
WHERE a.department_id = b.department_id;

SELECT emp_name --�� ���̺� ���ʿ��� �ִ� �÷��� ���̺���� ���� �ʾƵ���
      ,department_name
      ,a.department_id -- �����̺� ������ �÷��� �ִٸ� ��������� ���������.
FROM employees a, departments b -- ���̺� ��Ī
WHERE a.department_id = b.department_id;

-- employees, jobs ���̺��� �̿��Ͽ� ������ ������ ����Ͻÿ�
SELECT a.employee_id
     , a.emp_name
     , a.salary 
     , b.job_title
FROM employees a, jobs b
WHERE a.job_id = b.job_id
ORDER BY 1;



