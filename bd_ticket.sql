-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-12-2020 a las 12:59:15
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_ticket`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_ticket` (IN `_id_area` INT, IN `_id_rol` INT, IN `_id_usuario` INT)  BEGIN

select t.id_ticket , t.titulo,t.descripcion ,t_ticket.nombre_tipo, 
        e_ticket.nombre_estado, t.fecha_registro ,a.nombre_area,soporte.nombres nombre_soporteti
         from tickets t
         inner join tipo_ticket t_ticket
         on t_ticket.id_tipo = t.id_tipo
         inner join estado_ticket e_ticket
         on e_ticket.id_estado = t.id_estado 
         left join usuarios soporte
         on soporte.id_usuario = t.id_Soporte_ti
         left join areas a 
         on a.id_area = t.id_area
         where 
         ( ( t.id_area = _id_area and 
        ((_id_rol in (2)) or _id_usuario = t.id_Soporte_ti) ) or _id_rol = 1)
         order by t.id_ticket desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_ticket_por_cliente` (IN `_id_cliente` INT)  BEGIN

select t.id_ticket , t.titulo,t.descripcion ,t_ticket.nombre_tipo, 
        e_ticket.nombre_estado, t.fecha_registro,a.nombre_area,soporte.nombres nombre_soporteti
         from tickets t
         inner join tipo_ticket t_ticket
         on t_ticket.id_tipo = t.id_tipo
         inner join estado_ticket e_ticket
         on e_ticket.id_estado = t.id_estado 
         left join usuarios soporte
        on soporte.id_usuario = t.id_Soporte_ti
        left join areas a 
        on a.id_area = t.id_area
         where t.id_cliente = _id_cliente
         order by t.id_ticket desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_usuarios_by_area` (IN `_id_area` INT, IN `_id_rol` INT)  BEGIN

select u.*, e.nombre_empresa,rol.nombre_rol, area.nombre_area
            from usuarios u
            left join roles rol
            on rol.id_rol = u.id_rol
            left join areas area
            on area.id_area=u.id_area
            left join cliente_empresas e
            on e.id_empresa=u.id_empresa
            where u.email is not null and ( u.id_area = _id_area or _id_rol = 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_detalle` (IN `_id_ticket` INT, IN `_id_area` INT, IN `_id_rol` INT, IN `_id_usuario` INT)  BEGIN

select t.id_ticket ,t.id_estado,u.nombres,u.apellidos,t.id_cliente,t.id_Soporte_ti, t.titulo,t.descripcion ,t_ticket.nombre_tipo, 
        e_ticket.nombre_estado, t.fecha_registro, t.fecha_actualizacion,t.fecha_cierre ,
        p_ticket.nombre_prioridad , a.nombre_area, c_e.nombre_empresa , soporte.nombres nombre_soporte, soporte.apellidos apellidos_soporte
        from tickets t
        inner join tipo_ticket t_ticket
        on t_ticket.id_tipo = t.id_tipo
		
		inner join usuarios u 
         on u.id_usuario = t.id_cliente
		 
        inner join cliente_empresas c_e
        on c_e.id_empresa = t.id_empresa
        left join usuarios soporte
        on soporte.id_usuario = t.id_Soporte_ti
        inner join estado_ticket e_ticket
        on e_ticket.id_estado = t.id_estado
        inner join prioridad_ticket p_ticket
        on p_ticket.id_prioridad = t.id_prioridad
        left join areas a 
        on a.id_area = t.id_area
        where t.id_ticket = _id_ticket and ( ( t.id_area = _id_area and 
        ((_id_rol in (2)) or _id_usuario = t.id_Soporte_ti) ) or _id_rol = 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_detalle_por_cliente` (IN `_id_ticket` INT, IN `_id_cliente` INT)  BEGIN

select t.id_ticket ,t.id_estado,u.nombres,u.apellidos,t.id_cliente,t.id_Soporte_ti, t.titulo,t.descripcion ,t_ticket.nombre_tipo, 
    e_ticket.nombre_estado, t.fecha_registro, t.fecha_actualizacion,t.fecha_cierre ,
    p_ticket.nombre_prioridad , a.nombre_area, c_e.nombre_empresa , soporte.nombres nombre_soporte, soporte.apellidos apellidos_soporte
    from tickets t
    inner join tipo_ticket t_ticket
    on t_ticket.id_tipo = t.id_tipo
	
	inner join usuarios u 
    on u.id_usuario = t.id_cliente
		 
    inner join cliente_empresas c_e
    on c_e.id_empresa = t.id_empresa
    left join usuarios soporte
    on soporte.id_usuario = t.id_Soporte_ti
    inner join estado_ticket e_ticket
    on e_ticket.id_estado = t.id_estado
    inner join prioridad_ticket p_ticket
    on p_ticket.id_prioridad = t.id_prioridad
    left join areas a 
    on a.id_area = t.id_area
    where t.id_ticket = _id_ticket and id_cliente = _id_cliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_ticket` (IN `_titulo` VARCHAR(255), IN `_descripcion` VARCHAR(255), IN `_id_cliente` INT, IN `_id_empresa` INT, IN `_id_tipo` INT, IN `_id_estado` INT, IN `_id_prioridad` INT, IN `_id_Soporte_ti` INT, IN `_id_area` INT)  BEGIN
	insert into tickets (titulo,descripcion,id_cliente,id_empresa,id_tipo,id_estado,id_prioridad,id_Soporte_ti,id_area,fecha_registro,fecha_actualizacion,fecha_cierre)
        values(_titulo, _descripcion, _id_cliente, _id_empresa, _id_tipo, _id_estado, _id_prioridad, _id_Soporte_ti, _id_area,now(),now(),now());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_usuario` (IN `_email` VARCHAR(100), IN `_password` VARCHAR(100), IN `_nombres` VARCHAR(100), IN `_apellidos` VARCHAR(100), IN `_tipo_usuario` VARCHAR(100), IN `_id_rol` INT, IN `_id_area` INT, IN `_id_empresa` INT, IN `_estado_contrato` VARCHAR(100), IN `_registrado_por` VARCHAR(100), IN `_fecha_registro` DATE, IN `_actualizado_por` VARCHAR(100), IN `_fecha_actualizacion` DATE, IN `_fecha_ultimo_acceso` DATE)  BEGIN

	insert into usuarios (email , password , nombres , apellidos , tipo_usuario , id_rol , id_area , id_empresa, estado_contrato , registrado_por , fecha_registro , actualizado_por , fecha_actualizacion , fecha_ultimo_acceso) 
		values (_email, _password, _nombres, _apellidos, _tipo_usuario, _id_rol, _id_area, _id_empresa, _estado_contrato, _registrado_por, _fecha_registro, _actualizado_por, _fecha_actualizacion, _fecha_ultimo_acceso);
	
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areas`
--

CREATE TABLE `areas` (
  `id_area` int(11) NOT NULL,
  `nombre_area` varchar(100) DEFAULT NULL,
  `registrado_por` varchar(100) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `actualizado_por` varchar(100) DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `areas`
--

INSERT INTO `areas` (`id_area`, `nombre_area`, `registrado_por`, `fecha_registro`, `actualizado_por`, `fecha_actualizacion`) VALUES
(1, 'Soporte Tecnico', 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(2, 'Soporte Usuario', 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(3, 'Soporte Red', 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(4, 'Cliente', 'Admin', '2020-12-15', 'Admin', '2020-12-15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_empresas`
--

CREATE TABLE `cliente_empresas` (
  `id_empresa` int(11) NOT NULL,
  `nombre_empresa` varchar(100) DEFAULT NULL,
  `id_rubro` int(11) DEFAULT NULL,
  `registrado_por` varchar(100) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `actualizado_por` varchar(100) DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente_empresas`
--

INSERT INTO `cliente_empresas` (`id_empresa`, `nombre_empresa`, `id_rubro`, `registrado_por`, `fecha_registro`, `actualizado_por`, `fecha_actualizacion`) VALUES
(1, 'OP', 1, 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(2, 'Hermes', 1, 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(3, 'Mibanco', 2, 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(4, 'Movistar', 3, 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(5, 'Rimac', 4, 'Admin', '2020-12-15', 'Admin', '2020-12-15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `id_comentario` int(11) NOT NULL,
  `comentario` varchar(255) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_estado` int(11) DEFAULT NULL,
  `id_ticket` int(11) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `comentarios`
--

INSERT INTO `comentarios` (`id_comentario`, `comentario`, `id_usuario`, `id_estado`, `id_ticket`, `fecha_registro`) VALUES
(1, 'Se dio solucion al problema presentado', 8, 4, 1, '2020-12-16'),
(2, 'Se esta coordinando con el cliente.', 8, 3, 6, '2020-12-17'),
(3, 'Comentario.', 3, 7, 6, '2020-12-17'),
(4, 'coordinando con el cliente', 5, 3, 12, '2020-12-17'),
(5, 'resuelto', 5, 4, 12, '2020-12-17'),
(6, 'Comentario.', 2, 7, 16, '2020-12-17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_ticket`
--

CREATE TABLE `estado_ticket` (
  `id_estado` int(11) NOT NULL,
  `nombre_estado` varchar(30) DEFAULT NULL,
  `registrado_por` varchar(100) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `actualizado_por` varchar(100) DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estado_ticket`
--

INSERT INTO `estado_ticket` (`id_estado`, `nombre_estado`, `registrado_por`, `fecha_registro`, `actualizado_por`, `fecha_actualizacion`) VALUES
(1, 'Generado', 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(2, 'Pendiente', 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(3, 'En Proceso', 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(4, 'Cerrado', 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(5, 'Coordinado', 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(6, 'Investigando', 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(7, 'Escalado', 'Admin', '2020-12-15', 'Admin', '2020-12-15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prioridad_ticket`
--

CREATE TABLE `prioridad_ticket` (
  `id_prioridad` int(11) NOT NULL,
  `nombre_prioridad` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `prioridad_ticket`
--

INSERT INTO `prioridad_ticket` (`id_prioridad`, `nombre_prioridad`) VALUES
(1, 'Baja'),
(2, 'Media'),
(3, 'Alta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(100) DEFAULT NULL,
  `registrado_por` varchar(100) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `actualizado_por` varchar(100) DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre_rol`, `registrado_por`, `fecha_registro`, `actualizado_por`, `fecha_actualizacion`) VALUES
(1, 'Administrador', 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(2, 'Supervisor', 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(3, 'Soporte TI', 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(4, 'Cliente', 'Admin', '2020-12-15', 'Admin', '2020-12-15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rubro_empresas`
--

CREATE TABLE `rubro_empresas` (
  `id_rubro` int(11) NOT NULL,
  `nombre_rubro` varchar(100) DEFAULT NULL,
  `registrado_por` varchar(100) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `actualizado_por` varchar(100) DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `rubro_empresas`
--

INSERT INTO `rubro_empresas` (`id_rubro`, `nombre_rubro`, `registrado_por`, `fecha_registro`, `actualizado_por`, `fecha_actualizacion`) VALUES
(1, 'OP', 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(2, 'Seguridad', 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(3, 'Financiera', 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(4, 'Telefonia', 'Admin', '2020-12-15', 'Admin', '2020-12-15'),
(5, 'Seguros', 'Admin', '2020-12-15', 'Admin', '2020-12-15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tickets`
--

CREATE TABLE `tickets` (
  `id_ticket` int(11) NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `id_tipo` int(11) DEFAULT NULL,
  `id_estado` int(11) DEFAULT NULL,
  `id_prioridad` int(11) DEFAULT NULL,
  `id_Soporte_ti` int(11) DEFAULT NULL,
  `id_area` int(11) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  `fecha_cierre` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tickets`
--

INSERT INTO `tickets` (`id_ticket`, `titulo`, `descripcion`, `id_cliente`, `id_empresa`, `id_tipo`, `id_estado`, `id_prioridad`, `id_Soporte_ti`, `id_area`, `fecha_registro`, `fecha_actualizacion`, `fecha_cierre`) VALUES
(1, 'No es posible iniciar sesion', 'ingreso mi contraseña pero no inicia sesion.', 16, 1, 1, 4, 2, 8, 2, '2020-12-16', '2020-12-16', '2020-12-16'),
(2, 'La impresora no funciona', 'Se intenta prender la impresora pero no funciona.', 16, 1, 1, 1, 2, 5, 1, '2020-12-17', '2020-12-17', '2020-12-17'),
(3, 'La red esta lenta', 'Estimado tenemos lentitud en la red.', 16, 1, 1, 1, 1, 11, 3, '2020-12-17', '2020-12-17', '2020-12-17'),
(4, 'Pantalla azul en el monitor.', 'La PC prende pero se vee pantalla azul con letras blancas.', 14, 3, 1, 1, 1, 5, 1, '2020-12-17', '2020-12-17', '2020-12-17'),
(5, 'no abren los archivos', 'intento abrir los archivos word y excel pero solo me carga una web en ingles.', 14, 3, 1, 1, 1, 6, 1, '2020-12-17', '2020-12-17', '2020-12-17'),
(6, 'permisos de acceso', 'Solicito acceso a los compartidos de la red.', 15, 2, 2, 7, 3, 7, 1, '2020-12-17', '2020-12-17', '2020-12-17'),
(7, 'Instalacion de programa', 'Solicito instalar programa de Reniec en el area de contabilidad.', 15, 2, 2, 1, 2, 6, 1, '2020-12-17', '2020-12-17', '2020-12-17'),
(8, 'Problemas con la red', 'Se presenta intermitencia en la red de la Agencia.', 15, 2, 1, 1, 1, 12, 3, '2020-12-17', '2020-12-17', '2020-12-17'),
(9, 'Implementar nueva red', 'Estimado necesitamos habilitar una nueva red para el laboratorio de sistemas', 15, 2, 2, 1, 1, 11, 3, '2020-12-17', '2020-12-17', '2020-12-17'),
(10, 'Sin acceso al Correo', 'no puedo ingresar al correo corporativo, su apoyo porfavor.', 16, 3, 1, 1, 2, NULL, 2, '2020-12-17', '2020-12-17', '2020-12-17'),
(11, 'habilitar acceso', 'Estimado solicito habilitar acceso al compartido, correo, sistemas a nuestro nuevo Integrante.', 16, 3, 2, 1, 1, NULL, 2, '2020-12-17', '2020-12-17', '2020-12-17'),
(12, 'Instalacion de Impresora', 'Solicito instalacion de impresora en el area de Marketing', 17, 4, 2, 4, 2, 5, 1, '2020-12-17', '2020-12-17', '2020-12-17'),
(13, 'habilitar punto de red', 'Solicito habilitar punto de red en el area de QUA', 17, 4, 2, 1, 1, 13, 3, '2020-12-17', '2020-12-17', '2020-12-17'),
(14, 'PC se apaga', 'la pc se apaga en reiteradas ocaciones.', 17, 4, 1, 1, 1, 7, 1, '2020-12-17', '2020-12-17', '2020-12-17'),
(15, 'cable de red roto', 'Estimados solicito un cambio de cable de red.', 17, 4, 1, 1, 1, 6, 1, '2020-12-17', '2020-12-17', '2020-12-17'),
(16, 'PC tiene virus', 'La pc tiene virus, esta demasiado lenta, ademas se cierran los programas solos', 17, 4, 1, 7, 1, 12, 3, '2020-12-17', '2020-12-17', '2020-12-17'),
(17, 'asdfasd', 'asdasdasd', 16, 3, 1, 1, 1, NULL, 3, '2020-12-17', '2020-12-17', '2020-12-17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_ticket`
--

CREATE TABLE `tipo_ticket` (
  `id_tipo` int(11) NOT NULL,
  `nombre_tipo` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_ticket`
--

INSERT INTO `tipo_ticket` (`id_tipo`, `nombre_tipo`) VALUES
(1, 'Incidente'),
(2, 'Requerimiento');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `tipo_usuario` varchar(100) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL,
  `id_area` int(11) DEFAULT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `estado_contrato` varchar(100) DEFAULT NULL,
  `registrado_por` varchar(100) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `actualizado_por` varchar(100) DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  `fecha_ultimo_acceso` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `email`, `password`, `nombres`, `apellidos`, `tipo_usuario`, `id_rol`, `id_area`, `id_empresa`, `estado_contrato`, `registrado_por`, `fecha_registro`, `actualizado_por`, `fecha_actualizacion`, `fecha_ultimo_acceso`) VALUES
(1, 'admin@hot.com', '$2y$10$MY9OCwfigwokrHUw4JCAwe7/bHtPauZ9.YO0t8g2FsjzMShgiyTh2', 'Admin', 'General', 'Empleado', 1, 2, 1, 'Activo', 'admin@hot.com', '2020-12-15', 'admin@hot.com', '2020-12-15', '2020-12-15'),
(2, 'supsoportetec@hot.com', '$2y$10$CvPQlLcCncqs6/Dpwhoay.li6Fa32hpydpXMFdGgbRE0MF.lBN52G', 'Juliana', 'supsoportetec', 'Empleado', 2, 1, 1, 'Activado', 'supsoportetec@hot.com', '2020-12-16', 'supsoportetec@hot.com', '2020-12-16', '2020-12-16'),
(3, 'supsoporteusu@hot.com', '$2y$10$sAQtoGeFVeuCrxoQdvkVpOUQJb/sD6CzBD21Sn7KZNAiSynsS.cji', 'Davis', 'supsoporteusu', 'Empleado', 2, 2, 1, 'Activado', 'supsoporteusu@hot.com', '2020-12-16', 'supsoporteusu@hot.com', '2020-12-16', '2020-12-16'),
(4, 'supsoportered@hot.com', '$2y$10$oj/bwvjo0B5SSwyz6wFRl.gOq2u.osMzbTm7H9q4IJZVSn12YLLTG', 'Marlon', 'supsoportered', 'Empleado', 2, 3, 1, 'Activado', 'supsoportered@hot.com', '2020-12-16', 'supsoportered@hot.com', '2020-12-16', '2020-12-16'),
(5, 'adolfo@hot.com', '$2y$10$dx9uLXA52l4MTfkunjIO7.T6G56CC0CD5bP0NChgheQx2uVqRoy42', 'Adolfo', 'Abad', 'Empleado', 3, 1, 1, 'Activado', 'adolfo@hot.com', '2020-12-16', 'adolfo@hot.com', '2020-12-16', '2020-12-16'),
(6, 'agustin@hot.com', '$2y$10$eeng.LuTzjyiReQmZnA9kuAw9oOR3Gz4tEKvU8VLfzLyS.VcNGrSq', 'Agustin', 'Arca', 'Empleado', 3, 1, 1, 'Activado', 'agustin@hot.com', '2020-12-16', 'agustin@hot.com', '2020-12-16', '2020-12-16'),
(7, 'alan@hot.com', '$2y$10$pLW7VvNDg/qw4csP0ItFwO8XFwF8ITy6/lGws88Xw8JrZmLmEPtl6', 'Alan', 'Acebo', 'Empleado', 3, 1, 1, 'Activado', 'alan@hot.com', '2020-12-16', 'alan@hot.com', '2020-12-16', '2020-12-16'),
(8, 'bruno@hot.com', '$2y$10$Ax4WozI6soFRkiqbR0K.we5ohqdQKGE.In3hnUqbdcxGGduHgDQD.', 'Bruno', 'Diaz', 'Empleado', 3, 2, 1, 'Activado', 'bruno@hot.com', '2020-12-16', 'bruno@hot.com', '2020-12-16', '2020-12-16'),
(9, 'barney@hot.com', '$2y$10$S4bE0m8a5f6adrv2UL7KwuL1Q1FzFrWyPJtS.xV4g6U68Z8oA5zIe', 'Barney', 'Allsen', 'Empleado', 3, 2, 1, 'Activado', 'barney@hot.com', '2020-12-16', 'barney@hot.com', '2020-12-16', '2020-12-16'),
(10, 'bruce@hot.com', '$2y$10$isl4ICjZggCPC0BclxT5leO/idtidGMjE5R/J9bzlYsNA5ENtRUYm', 'Bruce', 'Wein', 'Empleado', 3, 2, 1, 'Activado', 'bruce@hot.com', '2020-12-16', 'bruce@hot.com', '2020-12-16', '2020-12-16'),
(11, 'carlos@hot.com', '$2y$10$MslcmOyMD8D0dAhEUiuS5uMksCmzc6XTtq43ywb3srdEOLXkCZpCa', 'Carlos', 'Cano', 'Empleado', 3, 3, 1, 'Activado', 'carlos@hot.com', '2020-12-16', 'carlos@hot.com', '2020-12-16', '2020-12-16'),
(12, 'camila@hot.com', '$2y$10$dvJl.qWIpheF3i.zrReXeOGWsP4OzVQgGHPY7hIBJJDQU/uQYToPu', 'Camila', 'Cardenas', 'Empleado', 3, 3, 1, 'Activado', 'camila@hot.com', '2020-12-16', 'camila@hot.com', '2020-12-16', '2020-12-16'),
(13, 'caleb@hot.com', '$2y$10$BgyaTI06byRRyiu/LaOJqun851ad4CbmQcXUS7WQkn34VqEMa3Ncu', 'Caleb', 'Castillo', 'Empleado', 3, 3, 1, 'Activado', 'caleb@hot.com', '2020-12-16', 'caleb@hot.com', '2020-12-16', '2020-12-16'),
(14, 'daniel@hot.com', '$2y$10$YVcPDqtDwl7eq3cFhuEk0ecu8GcSym0B8.g/mtTZgL/mnjhs4Qnca', 'Daniel', 'Miranda', 'Cliente', 4, 4, 3, 'Activado', 'daniel@hot.com', '2020-12-16', 'admin@hot.com', '2020-12-17', '2020-12-16'),
(15, 'dante@hot.com', '$2y$10$RjgJntwpyGtw2mF8.ZttM.htgSe4eYXockN6QS6Vh42QB3RnIFbcO', 'Dante', 'Alighieri', 'Cliente', 4, 4, 2, 'Activado', 'dante@hot.com', '2020-12-16', 'admin@hot.com', '2020-12-17', '2020-12-16'),
(16, 'dario@hot.com', '$2y$10$pxW2V3DN7yMT7vKIHTii7e7btkpajHdlQtmMFLKoZ9NxmOYk93ZVm', 'Dario', 'Chumpi', 'Cliente', 4, 4, 3, 'Activado', 'Dario@hot.com', '2020-12-16', 'admin@hot.com', '2020-12-17', '2020-12-16'),
(17, 'demetrio@hot.com', '$2y$10$iw5kTdhuUMX/jlD2ooKL0OsFSL6.nwzTLomf0lRiAH14AgxueXifu', 'Demetrio', 'Voris', 'Cliente', 4, 4, 4, 'Activado', 'demetrio@hot.com', '2020-12-16', 'admin@hot.com', '2020-12-18', '2020-12-16');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id_area`);

--
-- Indices de la tabla `cliente_empresas`
--
ALTER TABLE `cliente_empresas`
  ADD PRIMARY KEY (`id_empresa`),
  ADD KEY `id_rubro` (`id_rubro`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id_comentario`),
  ADD KEY `id_estado` (`id_estado`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_ticket` (`id_ticket`);

--
-- Indices de la tabla `estado_ticket`
--
ALTER TABLE `estado_ticket`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `prioridad_ticket`
--
ALTER TABLE `prioridad_ticket`
  ADD PRIMARY KEY (`id_prioridad`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `rubro_empresas`
--
ALTER TABLE `rubro_empresas`
  ADD PRIMARY KEY (`id_rubro`);

--
-- Indices de la tabla `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id_ticket`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_Soporte_ti` (`id_Soporte_ti`),
  ADD KEY `id_empresa` (`id_empresa`),
  ADD KEY `id_area` (`id_area`),
  ADD KEY `id_prioridad` (`id_prioridad`),
  ADD KEY `id_tipo` (`id_tipo`),
  ADD KEY `id_estado` (`id_estado`);

--
-- Indices de la tabla `tipo_ticket`
--
ALTER TABLE `tipo_ticket`
  ADD PRIMARY KEY (`id_tipo`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `id_area` (`id_area`),
  ADD KEY `id_empresa` (`id_empresa`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id_comentario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id_ticket` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente_empresas`
--
ALTER TABLE `cliente_empresas`
  ADD CONSTRAINT `cliente_empresas_ibfk_1` FOREIGN KEY (`id_rubro`) REFERENCES `rubro_empresas` (`id_rubro`);

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`id_estado`) REFERENCES `estado_ticket` (`id_estado`),
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `comentarios_ibfk_3` FOREIGN KEY (`id_ticket`) REFERENCES `tickets` (`id_ticket`);

--
-- Filtros para la tabla `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`id_Soporte_ti`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `tickets_ibfk_3` FOREIGN KEY (`id_empresa`) REFERENCES `cliente_empresas` (`id_empresa`),
  ADD CONSTRAINT `tickets_ibfk_4` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id_area`),
  ADD CONSTRAINT `tickets_ibfk_5` FOREIGN KEY (`id_prioridad`) REFERENCES `prioridad_ticket` (`id_prioridad`),
  ADD CONSTRAINT `tickets_ibfk_6` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_ticket` (`id_tipo`),
  ADD CONSTRAINT `tickets_ibfk_7` FOREIGN KEY (`id_estado`) REFERENCES `estado_ticket` (`id_estado`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`),
  ADD CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id_area`),
  ADD CONSTRAINT `usuarios_ibfk_3` FOREIGN KEY (`id_empresa`) REFERENCES `cliente_empresas` (`id_empresa`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
