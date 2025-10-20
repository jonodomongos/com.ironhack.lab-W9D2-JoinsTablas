-- Creamos la BD
CREATE DATABASE IF NOT EXISTS empresa
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_spanish_ci;

USE empresa;

-- Creamos la tabla departamento
CREATE TABLE departamento (
  dept_id INT NULL,
  nombre  VARCHAR(50) NULL,
  sede    VARCHAR(50) NULL
);

-- Creamos la tabla empleado
CREATE TABLE empleado (
  emp_id  INT NULL,
  nombre  VARCHAR(50) NULL,
  dept_id INT NULL,
  email   VARCHAR(100) NULL
);

-- Creamos la tabla proyecto
CREATE TABLE proyecto (
  proj_id      INT NULL,
  titulo       VARCHAR(100) NULL,
  dept_id      INT NULL,
  lider_emp_id INT NULL
);

-- Rellanamos datos tabla departamentos 
INSERT INTO departamento (dept_id, nombre, sede) VALUES
(1,   'Ingeniería', 'Madrid'),
(2,   'Ventas',     'Barcelona'),
(3,   'Soporte',    NULL),
(NULL,'Sin Depto',  'Remoto'),
(4,   NULL,         'Valencia');

SELECT * FROM departamento;

-- Rellanamos datos tabla empleados 
INSERT INTO empleado (emp_id, nombre, dept_id, email) VALUES
(10,  'Ana',   1,   'ana@empresa.com'),
(11,  'Bruno', 2,   NULL),
(12,  'Carla', NULL,'carla@empresa.com'),
(13,  NULL,    3,   'sin_nombre@empresa.com'),
(NULL,'Diego', 99,  'diego@empresa.com');

SELECT * FROM empleado;

-- Rellanamos datos tabla proyecto 
INSERT INTO proyecto (proj_id, titulo, dept_id, lider_emp_id) VALUES
(100, 'ERP',        1,   10),
(101, 'CRM',        2,   11),
(102, 'Helpdesk',   3,   NULL),
(103, NULL,         2,   99),
(NULL,'AI PoC',     NULL,12);

SELECT * FROM proyecto;

-- JOINS:
-- 1. INNER JOIN (empleado ↔ departamento)
--    Solo devuelve filas donde e.dept_id = d.dept_id (no incluye NULL ni desajustes)
SELECT
  e.emp_id, e.nombre AS empleado, e.dept_id,
  d.nombre AS depto, d.sede
FROM empleado e
INNER JOIN departamento d
  ON e.dept_id = d.dept_id
ORDER BY e.emp_id;

-- 2. LEFT JOIN (empleado ↔ departamento)
--    Devuelve TODOS los empleados, y el depto si existe; si no, NULLs del lado derecho.
SELECT
  e.emp_id, e.nombre AS empleado, e.dept_id,
  d.nombre AS depto, d.sede
FROM empleado e
LEFT JOIN departamento d
  ON e.dept_id = d.dept_id
ORDER BY e.emp_id;

-- 3. RIGHT JOIN (empleado ↔ departamento)
--    Devuelve TODOS los departamentos, y el empleado si existe; si no, NULLs del lado izquierdo.
SELECT
  e.emp_id, e.nombre AS empleado, e.dept_id,
  d.dept_id AS dept_id_d, d.nombre AS depto, d.sede
FROM empleado e
RIGHT JOIN departamento d
  ON e.dept_id = d.dept_id
ORDER BY d.dept_id IS NULL, d.dept_id;  -- muestra también el depto con dept_id NULL

-- 4. JOIN de 3 tablas:
--    proyecto ↔ departamento ↔ empleado(líder)
--    Usamos LEFT JOIN para ver también proyectos “huérfanos” (sin depto o sin líder).
SELECT
  p.proj_id, p.titulo,
  d.dept_id AS depto_id, d.nombre AS depto,
  e.emp_id  AS lider_id, e.nombre AS lider
FROM proyecto p
LEFT JOIN departamento d
  ON p.dept_id = d.dept_id
LEFT JOIN empleado e
  ON p.lider_emp_id = e.emp_id
ORDER BY p.proj_id IS NULL, p.proj_id;