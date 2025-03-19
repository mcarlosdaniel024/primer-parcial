-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-03-2025 a las 21:37:28
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `parqueadero`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_factura` (IN `p_id_vehiculo` INT, IN `p_valor_parqueo` DECIMAL(10,2), IN `p_valor_lavado` DECIMAL(10,2))   BEGIN
    DECLARE total_final DECIMAL(10,2);
    SET total_final = p_valor_parqueo + p_valor_lavado;
    
    INSERT INTO factura (id_vehiculo, valor_parqueo, valor_lavado, total)
    VALUES (p_id_vehiculo, p_valor_parqueo, p_valor_lavado, total_final);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `liberar_puesto` (IN `p_id_vehiculo` INT)   BEGIN
    UPDATE puesto
    SET ocupado = 0, id_vehiculo = NULL
    WHERE id_vehiculo = p_id_vehiculo;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `id` int(11) NOT NULL,
  `id_vehiculo` int(11) NOT NULL,
  `rayones` tinyint(1) DEFAULT 0,
  `pinchado` tinyint(1) DEFAULT 0,
  `observacion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado`
--

INSERT INTO `estado` (`id`, `id_vehiculo`, `rayones`, `pinchado`, `observacion`) VALUES
(1, 1, 0, 0, NULL),
(2, 2, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id` int(11) NOT NULL,
  `id_vehiculo` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `valor_parqueo` decimal(10,2) DEFAULT NULL,
  `valor_lavado` decimal(10,2) DEFAULT 0.00,
  `total` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`id`, `id_vehiculo`, `fecha`, `valor_parqueo`, `valor_lavado`, `total`) VALUES
(1, 1, '2025-03-19 20:33:20', 5000.00, 6000.00, 11000.00),
(2, 2, '2025-03-19 20:33:20', 5000.00, 0.00, 5000.00);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `historial_factura`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `historial_factura` (
`id` int(11)
,`nombre` varchar(100)
,`placa` varchar(20)
,`valor_parqueo` decimal(10,2)
,`valor_lavado` decimal(10,2)
,`total` decimal(10,2)
,`fecha` timestamp
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lavado`
--

CREATE TABLE `lavado` (
  `id` int(11) NOT NULL,
  `id_vehiculo` int(11) NOT NULL,
  `servicio` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `lavado`
--

INSERT INTO `lavado` (`id`, `id_vehiculo`, `servicio`) VALUES
(1, 1, 1),
(2, 2, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puesto`
--

CREATE TABLE `puesto` (
  `id` int(11) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `ocupado` tinyint(1) DEFAULT 0,
  `id_vehiculo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `puesto`
--

INSERT INTO `puesto` (`id`, `numero`, `ocupado`, `id_vehiculo`) VALUES
(1, '1', 0, 1),
(2, '2', 0, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `cedula` varchar(20) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `cedula`, `telefono`, `correo`) VALUES
(1, 'carlos', '93t217', '54321', 'carlos@gmail.com'),
(2, 'daniel', '871833', '82711', 'daniel@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo`
--

CREATE TABLE `vehiculo` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `placa` varchar(20) NOT NULL,
  `tipo` varchar(20) DEFAULT NULL,
  `entrada` datetime NOT NULL,
  `salida` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vehiculo`
--

INSERT INTO `vehiculo` (`id`, `id_usuario`, `placa`, `tipo`, `entrada`, `salida`) VALUES
(1, 2, 'bas-30d', 'moto', '2025-03-19 21:31:02', '2025-03-29 15:31:02'),
(2, 1, 'sql-29c', 'moto', '2025-03-19 21:31:02', '2025-03-31 15:31:02');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vehiculos_dentro`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vehiculos_dentro` (
`id` int(11)
,`nombre` varchar(100)
,`placa` varchar(20)
,`tipo` varchar(20)
,`entrada` datetime
,`puesto` varchar(10)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vehiculos_sanos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vehiculos_sanos` (
`propietario` varchar(100)
,`placa` varchar(20)
,`tipo` varchar(20)
,`fecha_ingreso` datetime
);

-- --------------------------------------------------------

--
-- Estructura para la vista `historial_factura`
--
DROP TABLE IF EXISTS `historial_factura`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `historial_factura`  AS SELECT `f`.`id` AS `id`, `u`.`nombre` AS `nombre`, `v`.`placa` AS `placa`, `f`.`valor_parqueo` AS `valor_parqueo`, `f`.`valor_lavado` AS `valor_lavado`, `f`.`total` AS `total`, `f`.`fecha` AS `fecha` FROM ((`factura` `f` join `vehiculo` `v` on(`f`.`id_vehiculo` = `v`.`id`)) join `usuario` `u` on(`v`.`id_usuario` = `u`.`id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vehiculos_dentro`
--
DROP TABLE IF EXISTS `vehiculos_dentro`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vehiculos_dentro`  AS SELECT `v`.`id` AS `id`, `u`.`nombre` AS `nombre`, `v`.`placa` AS `placa`, `v`.`tipo` AS `tipo`, `v`.`entrada` AS `entrada`, `p`.`numero` AS `puesto` FROM ((`vehiculo` `v` join `usuario` `u` on(`v`.`id_usuario` = `u`.`id`)) left join `puesto` `p` on(`v`.`id` = `p`.`id_vehiculo`)) WHERE `v`.`salida` is null ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vehiculos_sanos`
--
DROP TABLE IF EXISTS `vehiculos_sanos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vehiculos_sanos`  AS SELECT `u`.`nombre` AS `propietario`, `v`.`placa` AS `placa`, `v`.`tipo` AS `tipo`, `v`.`entrada` AS `fecha_ingreso` FROM ((`estado` `e` join `vehiculo` `v` on(`e`.`id_vehiculo` = `v`.`id`)) join `usuario` `u` on(`v`.`id_usuario` = `u`.`id`)) WHERE `e`.`rayones` = 0 AND `e`.`pinchado` = 0 AND (`e`.`observacion` is null OR `e`.`observacion` = '') ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_vehiculo` (`id_vehiculo`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_vehiculo` (`id_vehiculo`);

--
-- Indices de la tabla `lavado`
--
ALTER TABLE `lavado`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_vehiculo` (`id_vehiculo`);

--
-- Indices de la tabla `puesto`
--
ALTER TABLE `puesto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero` (`numero`),
  ADD KEY `id_vehiculo` (`id_vehiculo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cedula` (`cedula`);

--
-- Indices de la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `placa` (`placa`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `estado`
--
ALTER TABLE `estado`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `lavado`
--
ALTER TABLE `lavado`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `puesto`
--
ALTER TABLE `puesto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `estado`
--
ALTER TABLE `estado`
  ADD CONSTRAINT `estado_ibfk_1` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`);

--
-- Filtros para la tabla `lavado`
--
ALTER TABLE `lavado`
  ADD CONSTRAINT `lavado_ibfk_1` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`);

--
-- Filtros para la tabla `puesto`
--
ALTER TABLE `puesto`
  ADD CONSTRAINT `puesto_ibfk_1` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id`);

--
-- Filtros para la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  ADD CONSTRAINT `vehiculo_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
