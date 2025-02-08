/* =====================================================

-- Proyecto Integrador Etapa 3. Bases de datos

Equipo 12:

-- Ávila Arelio Mariana

-- García Ramírez Alison

-- Hernández Torres Jair 

-- Mendoza Navarro Salma Patricia

-- Salazar Martínez Lissete Abigail

*/


-- =======================================================

-- Cambiamos el prompt para que muestre la base de datos en uso y mysql>
-- prompt \d mysql>

-- Verificamos que tengamos la base
SHOW DATABASES;


-- Habilitamos la base de datos vida_segura 
USE vida_segura;


/* CONSULTAS PARA LA TOMA DE DECISIONES */

/*
1.Queremos saber las enfermedades, sus tipos y los productos actuariales relacionados.
*/
SELECT e.nombre AS enfermedad, te.nombre AS tipo_enfermedad, json_arrayagg(pa.nombre) AS producto_actuarial
FROM enfermedad e
JOIN tipo_enfermedad te ON e.id_tipo_enf = te.id_tipo_enf
JOIN enf_prod ep ON e.id_enfermedad = ep.id_enfermedad
JOIN producto_actuarial pa ON ep.id_producto = pa.id_producto
GROUP BY e.nombre;

/*2.
¿Cuáles son las enfermedades que provocan mayores muertes?.
Es importante para determinar qué tipo de seguros se deben ofrecer. */

SELECT e.nombre AS 'Causa De Muerte:', LPAD(COUNT(m.id_persona), 
(SELECT MAX(LENGTH(COUNT(m.id_persona))) FROM mortalidad m2) + 6, ' ') AS 'Defunciones:'
FROM mortalidad m
JOIN enfermedad e ON m.id_enfermedad = e.id_enfermedad  
GROUP BY e.nombre
ORDER BY COUNT(m.id_persona) DESC;

/*
3. Dada la consulta anterior, una vez se conoce qué enfermedades causan más muertes, 
queremos conocer quiénes padecen dichas enfermedades y así saber qué seguros ofrecerles.
*/

SELECT p.nombre1, p.apellido_p, p.apellido_m, e.nombre AS enfermedad
FROM persona p
JOIN mortalidad m ON p.id_persona = m.id_persona
JOIN enfermedad e ON m.id_enfermedad = e.id_enfermedad
WHERE e.id_enfermedad IN (
    SELECT id_enfermedad
    FROM mortalidad
    GROUP BY id_enfermedad
    HAVING COUNT(id_persona) = (
        SELECT MAX(conteo)
        FROM (
            SELECT id_enfermedad, COUNT(id_persona) AS conteo
            FROM mortalidad
            GROUP BY id_enfermedad
        ) AS sub
    )
);

/*
4. Queremos conocer el número de fallecimientos por país. ¿Qué país tiene una alta mortalidad?.
*/

SELECT pa.nombre AS pais, COUNT(m.id_persona) AS total_mortalidad
FROM pais pa
JOIN ciudad c ON pa.id_pais = c.id_pais
JOIN mortalidad m ON c.id_ciudad = m.id_lugar_fallecimiento
GROUP BY pa.nombre
ORDER BY total_mortalidad DESC;

/*
5. En general, queremos mostrar las personas, qué enfemedad padecen, el tipo de enfermedad y los posibles 
productos actuariales que se les pueden ofrecer (el cual dependerá de las necesidades del cliente).
*/

SELECT 
    p.nombre1 AS nombre,
    p.apellido_p AS apellido_paterno,
    p.apellido_m AS apellido_materno,
    e.nombre AS enfermedad,
    te.nombre AS tipo_enfermedad,
    pa.nombre AS producto_actuarial
FROM 
    persona p
JOIN mortalidad m ON p.id_persona = m.id_persona
JOIN enfermedad e ON m.id_enfermedad = e.id_enfermedad
JOIN tipo_enfermedad te ON e.id_tipo_enf = te.id_tipo_enf
JOIN enf_prod ep ON e.id_enfermedad = ep.id_enfermedad
JOIN producto_actuarial pa ON ep.id_producto = pa.id_producto;

/*6.
Conocer qué enfermedades causan más muertes en cada país.
Importante para diseñar planes personalizados para enfermedades más prevalentes o riesgos 
específicos en cada país o región.
*/

SELECT 
    pa.nombre AS pais,
    e.nombre AS enfermedad,
    COUNT(m.id_persona) AS total_muertes
FROM 
    pais pa
JOIN ciudad c ON pa.id_pais = c.id_pais
JOIN mortalidad m ON c.id_ciudad = m.id_lugar_fallecimiento
JOIN enfermedad e ON m.id_enfermedad = e.id_enfermedad
GROUP BY pa.id_pais, e.id_enfermedad
HAVING COUNT(m.id_persona) = (
    SELECT MAX(conteo)
    FROM (
        SELECT e2.id_enfermedad, COUNT(m2.id_persona) AS conteo
        FROM ciudad c2
        JOIN mortalidad m2 ON c2.id_ciudad = m2.id_lugar_fallecimiento
        JOIN enfermedad e2 ON m2.id_enfermedad = e2.id_enfermedad
        WHERE c2.id_pais = pa.id_pais
        GROUP BY e2.id_enfermedad
    ) AS sub2
)
ORDER BY pa.nombre, total_muertes DESC;

/*7.
¿Cómo es la tendencia de muertes en genero y en edad?
Es importante conocer esto para determinar hacia que grupo deben ser dirigidos los seguros. */


SELECT LPAD(p.sexo,4,' ') AS 'Genero:',    /*Aqui estamos dividiendo a la poblacion en distintos grupos de acuerdo a la etapa de vida en la que se encuentren */
    CASE
        WHEN TIMESTAMPDIFF(YEAR, p.fecha_nac, m.fecha_fallecimiento) BETWEEN 0 AND 18 THEN '0-18'  /* Grupo de primeros años a adolesencia*/ 
        WHEN TIMESTAMPDIFF(YEAR, p.fecha_nac, m.fecha_fallecimiento) BETWEEN 19 AND 35 THEN '19-35' /* Grupo de jovenes adultos */
        WHEN TIMESTAMPDIFF(YEAR, p.fecha_nac, m.fecha_fallecimiento) BETWEEN 36 AND 50 THEN '36-50' /* Grupo de Adultos */
        WHEN TIMESTAMPDIFF(YEAR, p.fecha_nac, m.fecha_fallecimiento) BETWEEN 51 AND 65 THEN '51-65' /* Grupo de Adultos Mayores */
        ELSE '66+' /* Grupo de personas de la tercera Edad */
    END AS Rangos_De_Edad,
    LPAD(COUNT(m.id_persona),11,' ') AS 'Defunciones Totales:'
FROM mortalidad m
JOIN persona p ON m.id_persona = p.id_persona
GROUP BY p.sexo, Rangos_De_Edad
ORDER BY p.sexo, Rangos_De_Edad;



/*
8.
¿Cómo es la tendencia natal por regiones?
Importante para determinar en qué regiones ofrecer productos de Protección/asistencia reproductiva. 
*/

SELECT c.nombre AS 'Región:',  lpad(FORMAT(AVG(n.tasa_natalidad),2),length('tasa_natalidad_promedio'),' ') AS 'Promedio Tasa Natalidad:' 
FROM natalidad n
JOIN ciudad c ON n.id_lugar = c.id_ciudad  
GROUP BY c.nombre
ORDER BY AVG(n.tasa_natalidad) DESC;  

/*
9.
¿Cuál es la probalidad de fallecimiento más alta en los menores de 40 años?
Importante para identificar las principales causas de muertes prematura y 
para la creación de productos actuariales especificos para jovenes
*/

SELECT causa, LPAD(CONCAT(ROUND(probabilidad_fallecimiento * 100,2),'%'), LENGTH('Probabilidad de fallecimiento'), ' ') AS 'Probabilidad de fallecimiento'
FROM (
SELECT causa, COUNT(*)/(SELECT COUNT(*) FROM mortalidad WHERE edad_fallecimiento < 40) AS probabilidad_fallecimiento
FROM mortalidad
WHERE edad_fallecimiento < 40
GROUP BY causa
) AS R
WHERE probabilidad_fallecimiento = (
SELECT MAX(probabilidad_fallecimiento) 
FROM (
SELECT COUNT(*) / (SELECT COUNT(*) FROM mortalidad WHERE edad_fallecimiento < 40) AS probabilidad_fallecimiento
FROM mortalidad
WHERE edad_fallecimiento < 40
GROUP BY causa
) AS M
);

/*
10.
¿Qué productos actuariales tiene mayor cobertura (tomando de referencia el promedio)?
Importante para identificar áreas de mejora en los productos actuariales
*/

SELECT tipo_producto, LPAD(CONCAT(ROUND(porcentaje_cubierto * 100,2),'%'), LENGTH('Porcentaje cubierto'), ' ') AS 'Porcentaje cubierto'
FROM (
SELECT pa.nombre AS tipo_producto, COUNT(DISTINCT e.nombre)/(SELECT COUNT(*) FROM enfermedad) AS porcentaje_cubierto
FROM producto_actuarial pa
JOIN enf_prod ep ON pa.id_producto = ep.id_producto
JOIN enfermedad e ON ep.id_enfermedad = e.id_enfermedad
GROUP BY pa.nombre
) AS Rx
WHERE porcentaje_cubierto > (
SELECT AVG(porcentaje_cubierto)
FROM (
SELECT COUNT(DISTINCT e.nombre)/(SELECT COUNT(*) FROM enfermedad) AS porcentaje_cubierto
FROM producto_actuarial pa
JOIN enf_prod ep ON pa.id_producto = ep.id_producto
JOIN enfermedad e ON ep.id_enfermedad = e.id_enfermedad
GROUP BY pa.nombre
) AS M
)
ORDER BY 2 DESC;


/* TRIGGER 
Este trigger fue diseñado para detener una inserción de datos en la tabla producto_actuarial si
es que el producto ya existe.
Este trigger es importante ya que no ayuda a mantener la integridad de la tabla.
*/ 
DROP TRIGGER IF EXISTS pa_BI_trigger;
Delimiter //
CREATE TRIGGER pa_BI_trigger
BEFORE INSERT ON producto_actuarial
FOR EACH ROW
BEGIN 
	DECLARE aux INT;
	SET aux=(SELECT COUNT(*) FROM producto_actuarial WHERE nombre=NEW.nombre);
	IF aux>0
		-- Vamos a forzar un error para que no se inserten los datos nuevos
		THEN SET New.nombre=NULL; 
	END IF;	
End;
//
Delimiter ;


/* FUNCION 
Función que recibe como parametro el nombre de un pais y regresa un pequeño informe respecto al
numero de asegurados, que tiene la compañia, originarios de dicho pais. Esta función nos facilita la creacion
de informes que nos permiten considerar o permanecer atentos ante algunas condiciones o enfermedades a las que 
son más suceptibles nuestros asegurados.
*/
DROP FUNCTION IF EXISTS estadisticas_pais;
Delimiter //
CREATE FUNCTION estadisticas_pais (ps varchar(30))
RETURNS text
READS SQL DATA DETERMINISTIC
BEGIN
	DECLARE Res text;
	SELECT concat_ws(' ', 'En', p.nombre, 'tenemos',COUNT(pe.id_persona), 'asegurad@s')
	INTO Res
	FROM ciudad c
	RIGHT JOIN persona pe ON pe.id_lugar_residencia=c.id_ciudad
	JOIN pais p USING(id_pais)
	GROUP BY p.nombre
	HAVING p.nombre=ps;
	RETURN Res;
END;
//
Delimiter ;

select estadisticas_pais('Mexico') AS Estadistica;


/* PROCEDIMIENTO ALMACENADO 

Procedimiento almacenado que recibe como parametro el nombre de una ciudad y que de resultado obtenga 
las enfermedades presentes en dicha ciudad y la cantidad de personas que tienen dicha enfermedad.
Es importante tener un procedimiento de este estilo, pues facilita la obtencion de como se distribuyen 
las enfermedades en las distintas regiones, lo cual a su vez es de interés pues ayudaría a conocer qué
tipo de servicios y seguros se deben ofrecer en dichas regiones y/o promociones, etcetera. */

DROP PROCEDURE IF EXISTS ObtenerEnfermedadesPorCiudad;

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS ObtenerEnfermedadesPorCiudad(IN ciudad_nombre VARCHAR(50))
BEGIN
    
    DECLARE ciudad_count INT;
    
    /* En las primeras 4 lineas estamos haciendo que el procedimiento detecte a las ciudad ingresada, 
    sin hacer distincion entre mayusculas y minusculas, importante pues SQL si lo diferencia y podría
    causar errores de interpretación */

    SELECT COUNT(*) INTO ciudad_count
    FROM ciudad
    WHERE LOWER(nombre) = LOWER(ciudad_nombre);
    
    /* En esta parte del codigo, si en efecto la ciudad ingresada NO EXISTE (y no es mal interpretación ortográfica) 
       en la base de datos se manda una advertencia para notificarlo */

    IF ciudad_count = 0 
    THEN SELECT 'La ciudad no existe' AS 'Alerta';
    ELSE
        
        SELECT 
            e.nombre AS 'Enfermedad:',
            COUNT(m.id_persona) AS 'Personas Enfermas:'
        FROM enfermedad e
        INNER JOIN tipo_enfermedad te ON e.id_tipo_enf = te.id_tipo_enf
        INNER JOIN mortalidad m ON e.id_enfermedad = m.id_enfermedad
        INNER JOIN persona p ON m.id_persona = p.id_persona
        INNER JOIN ciudad c ON p.id_lugar_residencia = c.id_ciudad
        WHERE LOWER(c.nombre) = LOWER(ciudad_nombre)
        GROUP BY e.nombre;
    END IF;
END //

DELIMITER ;

        

CALL ObtenerEnfermedadesPorCiudad('Istanbul');


