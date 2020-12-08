-- FASE 2:ESCUELA INFANTIL. GESTOR: ORACLE

-- CREAR TABLA PERSONAL
-- RESTRICCIONES:
-- -> El NIF de una persona puede tener uno de los siguientes formatos: 8 números y una letra, 
-- o bien una letra, siete dígitos y otra letra (en este caso, la primera letra solo podrá ser una K, L,M, X, Y ó Z).
-- -> Los títulos del personal se almacenarán con la primera letra en mayúsculas.
-- -> El personal siempre se incorpora el primer lunes de un mes.
CREATE TABLE personal 
(
    nif                     VARCHAR2(9),
    nombre                  VARCHAR2(15),
    apellido1               VARCHAR2(15),
    apellido2               VARCHAR2(15),
    domicilio               VARCHAR2(70),
    titulo                  VARCHAR2(70),
    fecha_incorporacion     DATE,
    aula_trabajo            VARCHAR2(3),
    CONSTRAINT pk_personal PRIMARY KEY (nif),
    CONSTRAINT formatonif_personal CHECK (REGEXP_LIKE (nif, '^[0-9]{8}[A-Za-z]{1}$') OR (REGEXP_LIKE (nif, '^[Kk,Ll,Mm,Xx,Yy,Zz]{1}[0-9]{7}[A-Za-z]{1}$'))),
    CONSTRAINT titulo_p_letra_may CHECK (titulo = (INITCAP(titulo))),
    CONSTRAINT incorp_lunes_ok CHECK ((TO_CHAR (fecha_incorporacion, 'D') = 2 ) AND (TO_NUMBER(TO_CHAR(TO_DATE(fecha_incorporacion,'DD/MM/YYYY'),'W')) = 1 ))
);

-- DATOS VALIDOS: 8 REGISTROS
INSERT INTO personal (nif,nombre,apellido1,apellido2,domicilio,titulo,fecha_incorporacion,aula_trabajo) VALUES ('20032114B','Cristina','Sánchez','García','c/Laguna,7 41720 Sevilla','Tecnico Superior Educacion Infantil','04/09/2017','I4B');
INSERT INTO personal (nif,nombre,apellido1,apellido2,domicilio,titulo,fecha_incorporacion,aula_trabajo) VALUES ('47758861X','Yolanda','García','Luna','c/San Andres,10 41710 Sevilla','Licenciatura Educacion Infantil','06/11/2017','I3A');
INSERT INTO personal (nif,nombre,apellido1,apellido2,domicilio,titulo,fecha_incorporacion,aula_trabajo) VALUES ('M4006005F','María','Gavira','Rodriguez','c/Redondo,14 41700 Sevilla','Tecnico Superior Educacion Infantil','04/09/2017','I5A');
INSERT INTO personal (nif,nombre,apellido1,apellido2,domicilio,titulo,fecha_incorporacion,aula_trabajo) VALUES ('X4785594D','Ana María','De Los Santos','Torres','Av. Utrera,63,41720,Sevilla','Licenciatura Pedagogia Infantil','06/11/2017','I3A');
INSERT INTO personal (nif,nombre,apellido1,apellido2,domicilio,titulo,fecha_incorporacion,aula_trabajo) VALUES ('25847514H','Mario','Dominguez','Parejo','c/Muñoz Seca,37 41720 Sevilla','Tecnico Superior Educacion Infantil','04/09/2017','I5B');
INSERT INTO personal (nif,nombre,apellido1,apellido2,domicilio,titulo,fecha_incorporacion,aula_trabajo) VALUES ('Y8777965X','Sonia','Ramos','Mendez','c/Arenal,13 41710 Sevilla','Tecnico Superior Educacion Infantil','04/09/2017','I4A');
INSERT INTO personal (nif,nombre,apellido1,apellido2,domicilio,titulo,fecha_incorporacion,aula_trabajo) VALUES ('Z4771233R','Miriam','Romero','Rubio','c/Blas Infante,3 41720 Sevilla','Certificacion Acreditativa Funcion Directiva','04/09/2017','I4A');
INSERT INTO personal (nif,nombre,apellido1,apellido2,domicilio,titulo,fecha_incorporacion,aula_trabajo) VALUES ('20047811X','Isabel','Duran','Zamorano','c/Quevedo,7 41720 Sevilla','Tecnico Superior Asistencia Direccion','04/09/2017','I3A');

--CREAR TABLA AULAS

CREATE TABLE aulas 
(
    denominacion            VARCHAR2(3),
    nif_profe_responsable   VARCHAR2(9),
    superficie              NUMBER(3),
    capacidad               NUMBER(3),
    CONSTRAINT pk_aulas PRIMARY KEY (denominacion),
    CONSTRAINT fk_nif_profe_resp FOREIGN KEY (nif_profe_responsable) REFERENCES personal
);

--INSERTAR DATOS VALIDOS: 5 REGISTROS

INSERT INTO aulas (denominacion,nif_profe_responsable,superficie,capacidad) VALUES ('I3A','X4785594D',25,20);
INSERT INTO aulas (denominacion,nif_profe_responsable,superficie,capacidad) VALUES ('I4A','Y8777965X',30,25);
INSERT INTO aulas (denominacion,nif_profe_responsable,superficie,capacidad) VALUES ('I4B','20032114B',30,25);
INSERT INTO aulas (denominacion,nif_profe_responsable,superficie,capacidad) VALUES ('I5A','M4006005F',30,25);
INSERT INTO aulas (denominacion,nif_profe_responsable,superficie,capacidad) VALUES ('I5B','25847514H',30,25);

-- Una vez creada la tabla y cargado los datos de aulas tenemos que crear la restricción de clave extranjera en la tabla personal
ALTER TABLE personal ADD CONSTRAINT fk_aula_trabajo FOREIGN KEY (aula_trabajo) REFERENCES aulas;

-- CREAR TABLA MATERIALES
-- RESTRICCIONES:
-- -> El código de un material comienza por una letra que podrá ser L, V o T, después un espacio en blanco y después cuatro dígitos y tres letras.

CREATE TABLE materiales 
(
    cod_material            VARCHAR2(9),
    titulo                  VARCHAR2(30),
    formato                 VARCHAR2(30),
    comentarios             VARCHAR2(70),
    CONSTRAINT pk_materiales PRIMARY KEY (cod_material),
    CONSTRAINT cod_mat_oK CHECK (REGEXP_LIKE(cod_material, '^[L,V,T]{1}\s[0-9]{4}[A-Za-z]{3}$'))
);

--DATOS VÁLIDOS:8 REGISTROS

INSERT INTO materiales (cod_material,titulo,formato,comentarios) VALUES ('L 1111ABC','Nacho va al colegio','Cuento en papel','Cuento pequeño con páginas gruesas, recomendable para los pequeños.');
INSERT INTO materiales (cod_material,titulo,formato,comentarios) VALUES ('V 2222CBA','Un día en el cole','Cuento en papel y cartón','Cuento interactivo, con lengüetas y piezas móviles.');
INSERT INTO materiales (cod_material,titulo,formato,comentarios) VALUES ('T 3333DEF','New fish on the Reff','Cuento interactivo','Cuento digital interactivo, ideal para trabajar el inglés.');
INSERT INTO materiales (cod_material,titulo,formato,comentarios) VALUES ('L 1234DIF','Erase una vez el cuerpo humano','Dvd digital','DVD para el aprendizaje del cuerpo humano.');
INSERT INTO materiales (cod_material,titulo,formato,comentarios) VALUES ('V 3210FAM','Cantajuego Vol 1','Dvd digital','Dvd para aprender cantando, volumen 1.');
INSERT INTO materiales (cod_material,titulo,formato,comentarios) VALUES ('T 4567COL','Cantajuego Vol 2','Dvd digital','Dvd para aprender cantando, volumen 1.');
INSERT INTO materiales (cod_material,titulo,formato,comentarios) VALUES ('L 6543SEL','Paracaidas','Juguete didáctico','Herramienta para jugar haciendo deporte y mejorar el trabajo en grupo.');
INSERT INTO materiales (cod_material,titulo,formato,comentarios) VALUES ('T 0021MAR','Karaoke infantil','Juguete didáctico','Karaoke para aprender cantando en inglés.');

-- CREAR TABLA EJEMPLARES
-- RESTRICCIONES:
---> El estado de un ejemplar del material puede estar en blanco o tener uno de los siguientes valores: Perfecto, Ligeramente Deteriorado, Deteriorado o A Sustituir.

CREATE TABLE ejemplares 
(
    num_ejemplar        VARCHAR2(6),
    cod_material        VARCHAR2(9),
    denominacion_aula   VARCHAR2(3),
    estado              VARCHAR2(30),
    CONSTRAINT fk_materiales FOREIGN KEY (cod_material) REFERENCES materiales,
    CONSTRAINT pk_ejemplares PRIMARY KEY (num_ejemplar,cod_material),
    CONSTRAINT fk_aulas FOREIGN KEY (denominacion_aula) REFERENCES aulas,
    CONSTRAINT estado_ok CHECK((estado IS NULL) OR (estado IN ('Perfecto','Ligeramente Deteriorado','Deteriorado','A Sustituir')))
);

-- DATOS VÁLIDOS:  16 REGISTROS 

INSERT INTO ejemplares (num_ejemplar,cod_material,denominacion_aula,estado) VALUES ('1111','L 1111ABC','I3A','Perfecto');
INSERT INTO ejemplares (num_ejemplar,cod_material,denominacion_aula,estado) VALUES ('2222','L 1111ABC','I4A','Ligeramente Deteriorado');
INSERT INTO ejemplares (num_ejemplar,cod_material,denominacion_aula,estado) VALUES ('3333','V 2222CBA','I3A','Perfecto');
INSERT INTO ejemplares (num_ejemplar,cod_material,denominacion_aula,estado) VALUES ('4444','T 3333DEF','I5A','Perfecto');
INSERT INTO ejemplares (num_ejemplar,cod_material,denominacion_aula,estado) VALUES ('5555','V 3210FAM','I3A','Perfecto');
INSERT INTO ejemplares (num_ejemplar,cod_material,denominacion_aula,estado) VALUES ('6666','V 3210FAM','I4A','Perfecto');
INSERT INTO ejemplares (num_ejemplar,cod_material,denominacion_aula,estado) VALUES ('7777','T 4567COL','I5A','Ligeramente Deteriorado');
INSERT INTO ejemplares (num_ejemplar,cod_material,denominacion_aula,estado) VALUES ('8888','L 6543SEL','I5A','Deteriorado');
INSERT INTO ejemplares (num_ejemplar,cod_material,denominacion_aula,estado) VALUES ('9999','L 6543SEL','I5B','A Sustituir');
INSERT INTO ejemplares (num_ejemplar,cod_material,denominacion_aula,estado) VALUES ('1010','L 6543SEL','I4A','Ligeramente Deteriorado');
INSERT INTO ejemplares (num_ejemplar,cod_material,denominacion_aula,estado) VALUES ('1212','L 6543SEL','I4B','Ligeramente Deteriorado');
INSERT INTO ejemplares (num_ejemplar,cod_material,denominacion_aula,estado) VALUES ('1313','T 0021MAR','I5A','Perfecto');
INSERT INTO ejemplares (num_ejemplar,cod_material,denominacion_aula,estado) VALUES ('1414','T 0021MAR','I5B','Perfecto');
INSERT INTO ejemplares (num_ejemplar,cod_material,denominacion_aula,estado) VALUES ('1515','L 1234DIF','I3A','Ligeramente Deteriorado');
INSERT INTO ejemplares (num_ejemplar,cod_material,denominacion_aula,estado) VALUES ('1616','T 3333DEF','I5B','Perfecto');
INSERT INTO ejemplares (num_ejemplar,cod_material,denominacion_aula,estado) VALUES ('1717','V 2222CBA','I4A','Perfecto');


-- CREAR TABLA NIÑOS

-- RESTRICCIONES:
---> La tarifa base de un niño es por defecto de 2.80€ por hora.
CREATE TABLE ninos 
(
    codigo                  VARCHAR2(5),
    nombre                  VARCHAR2(15),
    apellido1               VARCHAR2(15),
    apellido2               VARCHAR2(15),
    fecha_nacimiento        DATE,
    tarifa_base             NUMBER(4,2) DEFAULT 2.80,
    domicilio_habitual      VARCHAR2(30),
    fecha_incorporacion     DATE,
    fecha_baja_definitiva   DATE,
    denominac_aula          VARCHAR2(3),
    CONSTRAINT pk_ninos PRIMARY KEY (codigo),
    CONSTRAINT fk_denominac_aulas FOREIGN KEY (denominac_aula) REFERENCES aulas
);


--DATOS VÁLIDOS: 20 REGISTROS 
-- NOTA: La fecha de baja definitiva va estar en blanco porque no sabemos realmente cuando se va dar de baja el niño/a.

--INFANTIL DE 5 AÑOS A
INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('A5000','Juan José','Benítez','Zamora','02/02/2015','c/San Carlos,20','11/09/2017','I5A');

INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('A5001','Lidia','Durán','Fernandez','01/04/2015','c/Managua,13','11/09/2017','I5A');

INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('A5002','Rocío','Castillo','Pérez','14/11/2015','Av. Utrera,5','11/09/2017','I5A');

INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('A5003','Manuel','Palacios','Ayala','04/10/2015','c/Huelva,4','11/09/2017','I5A');

--INFANTIL DE 5 AÑOS B
INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('B5000','Alberto','Álvarez','Ruiz','02/03/2015','c/Buenos Aires,15','12/09/2017','I5B');

INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('B5001','Ángela','Álvarez','Ruiz','02/03/2015','c/Buenos Aires,15','12/09/2017','I5B');

INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('B5002','Javier','Peña','Bernal','12/07/2015','Av. Sevilla,21','11/09/2017','I5B');

INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('B5003','Mónica','Gómez','Vázquez','04/10/2015','c/Estévez,9','11/09/2017','I5B');

--INFANTIL DE 4 AÑOS A
INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('A4000','Blanca','Núñez','Bejines','29/05/2016','c/Romero Galán,4','03/09/2018','I4A');

INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('A4001','Daniel','Carvajal','Puente','10/04/2016','c/San Fernando,3','03/09/2018','I4A');

INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('A4002','Elena','Campos','Ponce','25/06/2016','c/Cervantes,7','05/09/2018','I4A');

INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('A4003','Rosario','Castillo','García','02/12/2016','Av. Utrera,30','03/09/2018','I4A');

-- INFANTIL DE 4 AÑOS B
INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('B4000','Nuria','Cruz','Rodríguez','24/10/2016','c/Real,23','05/09/2018','I4B');

INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('B4001','Ana Rosa','Ramos','Valle','19/04/2016','c/Jaime Balmes,17','04/09/2018','I4B');

INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('B4002','Diego','Olivares','Morilla','10/03/2016','c/Muñoz Seca,11','03/09/2018','I4B');

INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('B4003','Leire','García','Mendez','15/05/2016','Av. Sevilla,4','03/09/2018','I4B');

-- INFANTIL DE 3 AÑOS

INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('A3000','Lucía','Palacios','Ayala','11/02/2017','c/Huelva,4','09/09/2019','I3A');

INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('A3001','Ana Elisa','Gonzalez','Barrera','14/08/2017','c/Juventud,5','10/09/2019','I3A');

INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('A3002','Jesús','García','Lobato','06/04/2017','Av. Sevilla,8','09/09/2019','I3A');

INSERT INTO 
ninos (codigo,nombre,apellido1,apellido2,fecha_nacimiento,domicilio_habitual,fecha_incorporacion,denominac_aula)
VALUES ('A3003','Javier','Bravo','Herrera','03/11/2017','c/Consolación,3','09/09/2019','I3A');


-- CREAR TABLA RESPONSABLES

-- RESTRICCIONES:
-- -> El número de cuenta del responsable sigue el formato IBAN que consta de dos letras y veintidos dígitos, 
-- formando 6 grupos de cuatro caracteres separados por espacios. (Ej.: ES76 0019 0023 0120 0003 6857).
-- -> El NIF de una persona puede tener uno de los siguientes formatos: 8 números y una letra, 
-- o bien una letra, siete dígitos y otra letra (en este caso, la primera letra solo podrá ser una K, L,M, X, Y ó Z).

CREATE TABLE responsables
(
    nif                 VARCHAR2(9),
    nombre              VARCHAR2(15),
    apellido1           VARCHAR2(15),
    apellido2           VARCHAR2(15),
    ocupacion           VARCHAR2(20),
    cuenta_bancaria     VARCHAR2(29),
    CONSTRAINT pk_responsables PRIMARY KEY (nif),
    CONSTRAINT formatonif_responsable CHECK (REGEXP_LIKE (nif, '^[0-9]{8}[A-Za-z]{1}$') OR (REGEXP_LIKE (nif, '^[Kk,Ll,Mm,Xx,Yy,Zz]{1}[0-9]{7}[A-Za-z]{1}$'))),
    CONSTRAINT formato_num_cuenta CHECK (REGEXP_LIKE(cuenta_bancaria, '^[A-Za-z]{2}[0-9]{2}\s[0-9]{4}\s[0-9]{4}\s[0-9]{4}\s[0-9]{4}\s[0-9]{4}$'))
);

-- DATOS VÁLIDOS: REGISTROS 26
-- RESPONSABLES DE LAS CLASES DE 5 AÑOS
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('41255644C','Juan Manuel','Benítez','Hernández','Electricista','ES30 0018 0023 0005 0015 6547');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('47887454B','Adela','García','Fernandez','Profesora','ES30 0021 0124 0006 0015 6747');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('47888799N','Amanda','Gordillo','Pérez','Comercial','ES40 0021 0123 0025 0015 4785');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('47845789X','José','Castillo','Bernal','Informático','ES70 0021 0235 0045 0015 4711');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('41112399E','Laura','Ayala','Carvajal','Monitora escolar','ES20 0021 0178 0047 0015 1203');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('47458759P','Antonio','Álvarez','Ortiz','Taxista','ES35 0021 0456 0078 0015 1002');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('20065888U','Belén','Ruiz','Márquez','Farmacéutica','ES30 0022 0478 0045 0015 4847');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('20115475R','Alicia','Bernal','De la Cruz','Ingeniera Naval','ES74 0023 0456 0041 0015 9858');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('41820035O','Mª Paz','Vázquez','Daudi','Cocinera','ES75 0025 0114 0069 0015 7452');

--RESPONSABLES DE LAS CLASES DE 4 AÑOS
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('20011122Q','Rafael','Núñez','Herbas','Profesor','ES30 0022 0152 0032 0247 6969');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('74200654V','Milagros','Puente','Triguero','Hostelera','ES47 0021 0220 0021 0247 3032');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('Y4005598D','Juan Luís','Carvajal','García','Administrativo','ES36 0023 0025 0069 0247 4788');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('47789222B','Alejandro','Campos','Torres','Fotógrafo','ES89 0024 0220 0074 0247 9898');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('42556648E','Juan Pedro','Castillo','García','Comercial','ES24 0024 0458 0055 0247 4178');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('25884774G','Nora','Rodríguez','Ramirez','Dependienta','ES25 0026 0166 0066 0247 9564');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('20045444H','Ramón','Ramos','Cerezuela','Optometrista','ES76 0024 0125 0022 0247 7002');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('20114244J','Ana','Morilla','Morilla','Pensionista','ES85 0025 0458 0010 0247 4403');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('43665854O','Inés','Mendez','García','Modista','ES59 0027 0556 0002 0247 1402');

--RESPONSABLES DE LA CLASE DE 3 AÑOS
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('K4747894D','Fernando','Palacios','Bejines','Profesor','ES24 0021 0065 0047 1400 3999');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('49656002W','Raquel','Palacios','Ayala','Auxiliar enfermería','ES41 0024 0124 0074 1400 7458');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('40021520I','José María','Gonzalez','Millan','Médico familiar','ES20 0026 0154 0014 1400 1203');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('47002544F','Lorena','Barrera','Robles','Cirujana','ES30 0027 0785 0047 1400 2005');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('26603366E','Miguel','García','García','Banquero','ES78 0028 0456 0030 1400 1102');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('41002228X','Esperanza','Lobato','Rey','Peluquera ','ES79 0026 0032 0060 1400 6847');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('X2000324D','Fco Javier','Bravo','Cervantes','Mecánico','ES56 0024 0021 0090 1400 7778');
INSERT INTO responsables (nif,nombre,apellido1,apellido2,ocupacion,cuenta_bancaria) VALUES ('Z4445594A','Ana Isabel','Herrera','Martín','Abogada','ES31 0027 0031 0070 1400 6695');

-- CREAR TABLA RELACIONES
CREATE TABLE relaciones 
(
    codigo              VARCHAR2(5),
    nif                 VARCHAR2(9),
    relacion            VARCHAR2(15),
    CONSTRAINT fk_responsables FOREIGN KEY (nif) REFERENCES responsables,
    CONSTRAINT fk_ninos FOREIGN KEY (codigo) REFERENCES ninos,
    CONSTRAINT pk_relaciones PRIMARY KEY (codigo,nif),
    CONSTRAINT formatonif_ok CHECK (REGEXP_LIKE (nif, '^[0-9]{8}[A-Za-z]{1}$') OR (REGEXP_LIKE (nif, '^[Kk,Ll,Mm,Xx,Yy,Zz]{1}[0-9]{7}[A-Za-z]{1}$')))
);

-- DATOS VÁLIDOS REGISTROS 32

--5 AÑOS
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A5000','41255644C','Padre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A5001','47887454B','Madre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A5002','47888799N','Madre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A5002','47845789X','Padre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A5003','41112399E','Madre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A5003','K4747894D','Padre');

INSERT INTO relaciones (codigo,nif,relacion) VALUES ('B5000','47458759P','Padre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('B5000','20065888U','Madre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('B5001','47458759P','Madre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('B5001','20065888U','Madre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('B5002','20115475R','Madre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('B5003','41820035O','Madre');

--4 AÑOS
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A4000','20011122Q','Padre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A4001','Y4005598D','Padre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A4001','74200654V','Madre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A4002','47789222B','Padre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A4003','42556648E','Padre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A4003','47887454B','Prima');

INSERT INTO relaciones (codigo,nif,relacion) VALUES ('B4000','25884774G','Madre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('B4001','20045444H','Padre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('B4002','20114244J','Abuela');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('B4003','43665854O','Madre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('B4003','26603366E','Tío');

--3 AÑOS

INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A3000','K4747894D','Padre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A3000','49656002W','Hermana mayor');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A3000','41112399E','Madre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A3001','40021520I','Tío');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A3001','47002544F','Madre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A3002','26603366E','Padre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A3002','41002228X','Madre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A3003','X2000324D','Padre');
INSERT INTO relaciones (codigo,nif,relacion) VALUES ('A3003','Z4445594A','Madre');

-- CREAR TABLA RECIBOS
-- NOTA: El tipo boolean en Oracle no está soportado por lo que hemos usado un tipo fijo de texto 'char' para indicar SI o NO en el pago del recibo. Por defecto se genera un NO.

CREATE TABLE recibos 
(
    num_recibo              VARCHAR2(10),
    year                    NUMBER(4),
    codigo_nino             VARCHAR2(5),
    mes                     NUMBER(2),
    pagado                  CHAR(2) DEFAULT 'NO',
    CONSTRAINT pk_recibos PRIMARY KEY (num_recibo,year),
    CONSTRAINT fk_ninos_rec FOREIGN KEY (codigo_nino) REFERENCES ninos,
    CONSTRAINT pagado_si_no CHECK (pagado IN ('SI','NO'))
);

-- DATOS VÁLIDOS REGISTROS 26

INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0001',2019,'A5000',12,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0002',2019,'A5002',12,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0003',2019,'B5000',12,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0004',2019,'B5002',12,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0005',2019,'A4000',12,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0006',2019,'A4001',12,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0007',2019,'A4002',12,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0008',2019,'A4003',12,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0009',2019,'B4001',12,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0010',2019,'B4002',12,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0011',2020,'B4003',01,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0012',2020,'A3000',01,'NO');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0013',2020,'A3001',01,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0014',2020,'A3002',01,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0015',2020,'A3003',01,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0016',2020,'A5001',01,'NO');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0017',2020,'A5003',01,'NO');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0018',2020,'B5001',01,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0019',2020,'B5003',01,'NO');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0020',2020,'A4001',01,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0021',2020,'A4002',01,'NO');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0022',2020,'B4000',01,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0023',2020,'B4001',01,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0024',2020,'B4002',01,'NO');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0025',2020,'A4003',01,'SI');
INSERT INTO recibos (num_recibo,year,codigo_nino,mes,pagado) VALUES ('0026',2020,'A5002',01,'SI');

--CREAR TABLA COMPLEMENTOS 
-- NOTA: Los complementos van a ser: servicio_comedor,visita_granja_escuela,clase_de_danza,inglés_integrado
-- RESTRICCIONES:
-- -> El código de un complemento está compuesto por una letra y dos o tres dígitos.
CREATE TABLE complementos 
(
    codigo              VARCHAR2(4),
    descripcion         VARCHAR2(200),
    importe             NUMBER(5,2),
    tipo                VARCHAR2(20),
    CONSTRAINT pk_complementos PRIMARY KEY (codigo),
    CONSTRAINT codigo_comp_ok CHECK ((REGEXP_LIKE(codigo, '^[A-Za-z]{1}[0-9]{2}$')) OR (REGEXP_LIKE(codigo, '^[A-Za-z]{1}[0-9]{3}$')))
);

--DATOS VÁLIDOS REGISTROS 4

INSERT INTO complementos (codigo,descripcion,importe,tipo) 
VALUES ('V01','Visita guiada a entornos naturales para fomentar el contacto con la naturaleza, el cuidado del medio ambiente, el respeto a los animales y la convivencia en grupo.',30.00,'Excursión');
INSERT INTO complementos (codigo,descripcion,importe,tipo) 
VALUES ('C002','Servicio de comedor que incluye desayuno, media mañana,almuerzo y merienda',50.00,'Servicio de comedor');
INSERT INTO complementos (codigo,descripcion,importe,tipo) 
VALUES ('I003','Inglés integrado en la educacion impartida',20.00,'Clases de inglés');
INSERT INTO complementos (codigo,descripcion,importe,tipo) 
VALUES ('D04','Clases de danza didáctica para despertar la creatividad, espontaneidad y la expresividad de los niños.',15.00,'Clases de danza');

--CREAR TABLA DETALLE RECIBOS

CREATE TABLE detalle_recibos
(
    year_recibo_detalles    NUMBER(4),
    num_recibo_detalles     VARCHAR2(10),
    codigo_complemento      VARCHAR2(10),
    CONSTRAINT fk_compuesta_recibos FOREIGN KEY (year_recibo_detalles,num_recibo_detalles) REFERENCES recibos(year,num_recibo),
    CONSTRAINT fk_complementos FOREIGN KEY (codigo_complemento) REFERENCES complementos,
    CONSTRAINT pk_detalle_recibos PRIMARY KEY (year_recibo_detalles,num_recibo_detalles,codigo_complemento)
);

--DATOS VÁLIDOS REGISTROS 18

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2019,'0001','C002');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2019,'0002','C002');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2019,'0002','I003');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2019,'0003','I003');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2019,'0005','D04');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2019,'0006','D04');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2019,'0007','C002');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2019,'0010','I003');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2020,'0012','C002');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2020,'0015','C002');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2020,'0017','C002');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2020,'0021','I003');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2019,'0008','V01');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2020,'0026','V01');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2019,'0009','V01');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2020,'0025','D04');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2020,'0022','V01');

INSERT INTO detalle_recibos (year_recibo_detalles,num_recibo_detalles,codigo_complemento) 
VALUES (2019,'0004','V01');



-- CREAR TABLA HORARIOS

-- RESTRICCIONES:
-- -> La guardería está abierta de lunes a viernes de 7 a 21 horas.
-- NOTA: Oracle hasta el momento no soporta un tipo 'hora' o 'time' de forma individualizada, si no que, en su defecto proporciona 'date' y 'datestamp', los cuales
-- necesitan la fecha para introducir registros. Por lo que en este caso he usado VARCHAR2 para delimitar las horas.
-- NOTA2: Hora de entrada se va guardar como clave primaria para permitir un turno partido en el horario.
CREATE TABLE horarios 
(
    dia_semana                  VARCHAR2(10),
    codigo_nino                 VARCHAR2(5),
    hora_entrada                VARCHAR2(5),
    hora_salida                 VARCHAR2(5),
    CONSTRAINT fk_ninos_cod FOREIGN KEY (codigo_nino) REFERENCES ninos,
    CONSTRAINT pk_horarios PRIMARY KEY (dia_semana,codigo_nino,hora_entrada),
    CONSTRAINT dia_semana_ok CHECK (dia_semana IN ('Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo')),
    CONSTRAINT horas_ok CHECK (hora_entrada >= '07:00' and hora_salida <= '21:00')
);

--DATOS VÁLIDOS REGISTROS 42

INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Lunes','A5000','10:00','15:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Lunes','A5000','17:00','19:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Martes','A5000','10:00','15:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Martes','A5000','17:00','19:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Jueves','B5000','07:30','13:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Jueves','B5000','17:00','19:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Viernes','B5000','07:30','13:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Viernes','B5000','17:30','19:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Lunes','A3002','08:30','15:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Martes','A3002','08:30','15:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Lunes','A3003','10:00','16:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Miércoles','B4003','17:00','19:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Jueves','B4003','17:00','19:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Miércoles','B4002','16:30','20:30');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Jueves','B4002','08:30','15:30');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Jueves','B4002','18:00','20:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Viernes','B4000','08:00','15:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Viernes','A4003','08:00','15:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Lunes','A5003','08:00','12:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Lunes','A5002','08:00','12:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Martes','A5003','08:00','12:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Lunes','A5002','16:00','18:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Miércoles','A5001','08:00','12:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Martes','B5001','12:00','15:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Martes','B5001','19:00','21:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Martes','B5002','09:00','15:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Martes','B5002','19:00','21:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Viernes','B5003','12:00','15:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Viernes','A4000','09:00','15:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Martes','A4000','09:00','15:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Viernes','A4001','09:00','15:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Viernes','A4001','16:00','17:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Viernes','A4002','09:00','15:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Miércoles','A4003','09:00','15:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Miércoles','B4001','09:00','15:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Jueves','B4001','09:00','15:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Jueves','A3000','07:00','13:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Jueves','A3000','16:00','19:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Jueves','A3001','07:00','13:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Miércoles','A3001','07:00','13:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Miércoles','A3001','16:00','17:00');
INSERT INTO horarios (dia_semana,codigo_nino,hora_entrada,hora_salida) VALUES ('Miércoles','A4000','09:00','15:00');

-- CREAR TABLA AUSENCIAS
-- NOTA: Se ha optado por TIMESTAMP que recoje la fecha de ausencia del niño/a además de las horas.
CREATE TABLE ausencias 
(
    cod_nino                VARCHAR2(5),
    fecha_inicio            TIMESTAMP,
    fecha_fin               TIMESTAMP,
    motivo                  VARCHAR2(100),
    CONSTRAINT fk_nino_aus FOREIGN KEY (cod_nino) REFERENCES ninos,
    CONSTRAINT pk_ausencias PRIMARY KEY (cod_nino,fecha_inicio)
);

-- DATOS VÁLIDOS REGISTROS 16

INSERT INTO ausencias (cod_nino,fecha_inicio,fecha_fin,motivo) VALUES ('A5000','06/01/20 10:00','06/01/20 11:00','Visita al médico');
INSERT INTO ausencias (cod_nino,fecha_inicio,fecha_fin,motivo) VALUES ('A3002','06/01/20','07/01/20','Enfermedad');
INSERT INTO ausencias (cod_nino,fecha_inicio,fecha_fin,motivo) VALUES ('B4002','09/01/20 08:30:00','09/01/20 15:30:00','Personal');
INSERT INTO ausencias (cod_nino,fecha_inicio,fecha_fin,motivo) VALUES ('A5001','08/01/20','08/01/20','Enfermedad');
INSERT INTO ausencias (cod_nino,fecha_inicio,fecha_fin,motivo) VALUES ('A5003','13/01/20','14/01/20','Enfermedad');
INSERT INTO ausencias (cod_nino,fecha_inicio,fecha_fin,motivo) VALUES ('A4001','24/01/20 09:00:00','24/01/20 15:00:00','Visita al médico');
INSERT INTO ausencias (cod_nino,fecha_inicio,fecha_fin,motivo) VALUES ('B5002','14/01/20 19:00:00','14/01/20 21:00:00','Enfermedad');
INSERT INTO ausencias (cod_nino,fecha_inicio,fecha_fin,motivo) VALUES ('A3001','22/01/20','22/01/20','Personal');
INSERT INTO ausencias (cod_nino,fecha_inicio,fecha_fin,motivo) VALUES ('B5003','17/01/20','17/01/20','Visita al dentista');
INSERT INTO ausencias (cod_nino,fecha_inicio,fecha_fin,motivo) VALUES ('A4003','15/01/20','17/01/20','Varicela');
INSERT INTO ausencias (cod_nino,fecha_inicio,fecha_fin,motivo) VALUES ('B4001','15/01/20','17/01/20','Varicela');
INSERT INTO ausencias (cod_nino,fecha_inicio,fecha_fin,motivo) VALUES ('A5002','06/01/20','07/01/20','Visita al médico');
INSERT INTO ausencias (cod_nino,fecha_inicio,fecha_fin,motivo) VALUES ('A4000','07/01/20','08/01/20','Enfermedad');
INSERT INTO ausencias (cod_nino,fecha_inicio,fecha_fin,motivo) VALUES ('A3003','06/01/20 10:00:00','06/01/20 12:00:00','Visita al médico');
INSERT INTO ausencias (cod_nino,fecha_inicio,fecha_fin,motivo) VALUES ('A3000','16/01/20 07:00:00','16/01/20 13:00:00','Visita al médico');
INSERT INTO ausencias (cod_nino,fecha_inicio,fecha_fin,motivo) VALUES ('B5000','16/01/20','17/01/20','Enfermedad');
