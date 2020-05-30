/*
Consider the database of the statement.
Create a SQL query and answer:
What is the sum of the salaries of all employees in the department called 'Research'?
*/


SELECT SUM(empregado.salario)
  FROM empregado
        JOIN departamento
        ON empregado.dno = departamento.dnumero
 WHERE departamento.dnome like '%Research';

/*
Consider the database of the statement. Create a SQL query and answer:
What are the names of all employees who are directly supervised by Franklin Wong?
*/

SELECT * 
  FROM empregado
        JOIN departamento 
        ON empregado.dno = departamento.dnumero
        AND empregado.superssn = departamento.gerssn
 WHERE departamento.gerssn 
 IN(
        SELECT empregado.ssn 
          FROM empregado 
         WHERE empregado.pnome 
         LIKE '%Franklin'
   );

/*
Consider the database of the statement.
Create a SQL query and answer:
How many employees have a dependent with the same first name ?
*/


SELECT empregado.pnome,
       dependente.nome_dependente, 
       COUNT(*)
  FROM empregado 
        JOIN dependente
        ON empregado.ssn = dependente.essn
GROUP BY 1, 2
HAVING COUNT(*) > 1;

    
/*
Consider the database of the statement.
Create a query in SQL and answer: What is the average salary in this company?
*/

SELECT AVG(empregado.salario)
FROM empregado;

/*
Consider the database of the statement. Create a SQL query and answer:
Who is the person who has the most allocation time on the 'Newbenefits' project?
*/

SELECT empregado.pnome, 
       projeto.pjnome, 
       trabalha_em.horas 
  FROM empregado
        JOIN projeto   
        ON empregado.dno = projeto.dnum

        JOIN trabalha_em
        ON projeto.pnumero = trabalha_em.pno
    AND empregado.ssn = trabalha_em.essn
  WHERE projeto.pjnome LIKE '%Newbenefits'
ORDER BY 3 DESC;


/*
Considere o banco de dados do enunciado.
Crie uma consulta em SQL e responda:
Qual seria o custo do projeto com folha salarial (soma de todos os salários),
caso a empresa desse 10% de aumento para todos os empregados que trabalham no projeto 'ProductX'?
*/


SELECT empregado.pnome, 
       empregado.salario, 
       projeto.pjnome,
       ROUND((cast(empregado.salario as DECIMAL)*110)/100)
  FROM empregado
        JOIN projeto
        ON empregado.dno = projeto.dnum

        JOIN trabalha_em
        ON projeto.pnumero = trabalha_em.pno
 AND empregado.ssn = trabalha_em.essn
 WHERE projeto.pjnome LIKE '%ProductX';


/*
Consider the database of the statement. Create a query in SQL and answer:
How many employees in department 5 work more than 10 hours a week on the project called "ProductX"?
*/

SELECT count(*)
  FROM empregado
        JOIN trabalha_em
        ON empregado.ssn = trabalha_em.essn

        JOIN projeto
        ON trabalha_em.pno = projeto.pnumero
 WHERE trabalha_em.horas > 10
   AND empregado.dno = 5
   AND projeto.pjnome LIKE '%ProductX';


/*
Consider the database of the statement. Create a SQL query and answer:
What is the name of the department with the lowest average salary among its employees?
*/

SELECT departamento.dnome, 
       AVG(empregado.salario)
  FROM empregado
    JOIN departamento
    ON empregado.dno = departamento.dnumero
GROUP BY 1
ORDER BY 2;