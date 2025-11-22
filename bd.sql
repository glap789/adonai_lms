-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-11-2025 a las 22:50:43
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
-- Base de datos: `sisgestionscolarlaravel`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `activity_log`
--

CREATE TABLE `activity_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `log_name` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `subject_type` varchar(255) DEFAULT NULL,
  `subject_id` bigint(20) UNSIGNED DEFAULT NULL,
  `causer_type` varchar(255) DEFAULT NULL,
  `causer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`properties`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administradores`
--

CREATE TABLE `administradores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `persona_id` bigint(20) UNSIGNED NOT NULL,
  `cargo` enum('Director','Subdirector','Secretario','Administrativo') NOT NULL,
  `area` varchar(100) DEFAULT NULL,
  `fecha_asignacion` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencias`
--

CREATE TABLE `asistencias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `estudiante_id` bigint(20) UNSIGNED NOT NULL,
  `curso_id` bigint(20) UNSIGNED NOT NULL,
  `docente_id` bigint(20) UNSIGNED DEFAULT NULL,
  `fecha` date NOT NULL,
  `estado` enum('Presente','Ausente','Tardanza','Justificado') NOT NULL,
  `observaciones` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `asistencias`
--

INSERT INTO `asistencias` (`id`, `estudiante_id`, `curso_id`, `docente_id`, `fecha`, `estado`, `observaciones`, `created_at`, `updated_at`) VALUES
(2, 3, 3, 3, '2025-11-13', 'Presente', 'Registro masivo', '2025-11-13 21:49:12', '2025-11-13 23:22:06'),
(3, 1, 2, 2, '2025-11-13', 'Presente', 'Registro masivo', '2025-11-13 22:56:35', '2025-11-13 22:56:35'),
(4, 2, 2, 2, '2025-11-13', 'Presente', 'Registro masivo', '2025-11-13 22:56:35', '2025-11-18 04:11:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `blogs`
--

CREATE TABLE `blogs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `categoria` varchar(255) NOT NULL,
  `portada` varchar(255) DEFAULT NULL,
  `fecha` date NOT NULL,
  `autor` varchar(255) DEFAULT NULL,
  `descripcion_corta` text NOT NULL,
  `contenido` longtext NOT NULL,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`tags`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-jesus@gmail.com|127.0.0.1', 'i:1;', 1763736444),
('laravel-cache-jesus@gmail.com|127.0.0.1:timer', 'i:1763736444;', 1763736444);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comportamientos`
--

CREATE TABLE `comportamientos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `estudiante_id` bigint(20) UNSIGNED NOT NULL,
  `docente_id` bigint(20) UNSIGNED DEFAULT NULL,
  `fecha` date NOT NULL,
  `descripcion` text NOT NULL,
  `tipo` enum('Positivo','Negativo','Neutro') NOT NULL DEFAULT 'Neutro',
  `sancion` varchar(255) DEFAULT NULL,
  `notificado_tutor` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_notificacion` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `comportamientos`
--

INSERT INTO `comportamientos` (`id`, `estudiante_id`, `docente_id`, `fecha`, `descripcion`, `tipo`, `sancion`, `notificado_tutor`, `fecha_notificacion`, `created_at`, `updated_at`) VALUES
(1, 2, 2, '2025-11-13', 'hello helloo', 'Positivo', NULL, 1, '2025-11-14 16:36:25', '2025-11-14 01:29:45', '2025-11-18 05:03:11'),
(3, 3, 3, '2025-11-13', 'Mal estudiante', 'Negativo', '3 dias', 1, '2025-11-14 04:31:15', '2025-11-14 04:31:00', '2025-11-14 04:31:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `divisa` varchar(10) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `web` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `clave` varchar(100) NOT NULL DEFAULT 'GLOBAL_SETTINGS',
  `valor` text DEFAULT NULL,
  `tipo` enum('Texto','Numero','Fecha','Boolean','JSON') NOT NULL DEFAULT 'Texto',
  `categoria` enum('Academico','Calificacion','General','Seguridad','Notificaciones') NOT NULL DEFAULT 'General',
  `editable` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `nombre`, `descripcion`, `direccion`, `telefono`, `divisa`, `email`, `web`, `logo`, `clave`, `valor`, `tipo`, `categoria`, `editable`, `created_at`, `updated_at`) VALUES
(1, 'Laravel', 'Configuración global del sistema', NULL, NULL, 'PEN', NULL, NULL, NULL, 'GLOBAL_SETTINGS', NULL, 'Texto', 'General', 1, '2025-10-28 05:01:58', '2025-11-13 20:24:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nivel_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `codigo` varchar(20) DEFAULT NULL,
  `horas_semanales` int(11) NOT NULL DEFAULT 2,
  `area_curricular` varchar(100) DEFAULT NULL,
  `estado` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id`, `nivel_id`, `nombre`, `codigo`, `horas_semanales`, `area_curricular`, `estado`, `created_at`, `updated_at`) VALUES
(2, 2, 'Matematicas', 'MAT-2', 5, 'Matematic', 'Activo', '2025-10-28 19:42:28', '2025-11-14 05:26:01'),
(3, 2, 'Quimica', 'QUIM-02', 5, 'Ciencias', 'Activo', '2025-11-13 20:34:07', '2025-11-18 04:10:26'),
(4, 2, 'Fisica', 'Fisica-2', 8, 'Ciencias', 'Activo', '2025-11-14 05:43:26', '2025-11-14 16:42:04'),
(5, 1, 'Artes', 'Art-2', 2, 'Pintura', 'Activo', '2025-11-14 16:42:43', '2025-11-14 16:42:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docentes`
--

CREATE TABLE `docentes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `persona_id` bigint(20) UNSIGNED NOT NULL,
  `codigo_docente` varchar(50) NOT NULL,
  `especialidad` varchar(100) DEFAULT NULL,
  `fecha_contratacion` date NOT NULL,
  `tipo_contrato` enum('Nombrado','Contratado','Temporal') NOT NULL DEFAULT 'Contratado',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `docentes`
--

INSERT INTO `docentes` (`id`, `persona_id`, `codigo_docente`, `especialidad`, `fecha_contratacion`, `tipo_contrato`, `created_at`, `updated_at`) VALUES
(1, 1, '1', 'Matematica', '2025-10-05', 'Contratado', '2025-10-28 19:18:23', '2025-10-28 19:18:23'),
(2, 2, '2', 'comunicacion', '2025-10-05', 'Nombrado', '2025-10-28 19:19:42', '2025-10-28 19:19:42'),
(3, 7, '5', 'Quimica', '2022-01-13', 'Contratado', '2025-11-13 20:31:15', '2025-11-13 20:31:15'),
(4, 12, '10', 'Comunicacion', '2025-11-02', 'Temporal', '2025-11-20 17:43:04', '2025-11-20 17:43:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docente_curso`
--

CREATE TABLE `docente_curso` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `docente_id` bigint(20) UNSIGNED NOT NULL,
  `curso_id` bigint(20) UNSIGNED NOT NULL,
  `grado_id` bigint(20) UNSIGNED NOT NULL,
  `gestion_id` bigint(20) UNSIGNED NOT NULL,
  `es_tutor_aula` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `docente_curso`
--

INSERT INTO `docente_curso` (`id`, `docente_id`, `curso_id`, `grado_id`, `gestion_id`, `es_tutor_aula`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 1, 6, 0, '2025-11-12 15:45:50', '2025-11-12 15:45:50'),
(2, 2, 2, 1, 6, 0, '2025-11-12 16:09:54', '2025-11-12 16:09:54'),
(3, 3, 5, 1, 7, 0, '2025-11-13 20:34:34', '2025-11-18 04:03:32'),
(4, 3, 4, 1, 7, 0, '2025-11-14 05:43:52', '2025-11-14 05:43:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiantes`
--

CREATE TABLE `estudiantes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `persona_id` bigint(20) UNSIGNED NOT NULL,
  `grado_id` bigint(20) UNSIGNED DEFAULT NULL,
  `codigo_estudiante` varchar(50) NOT NULL,
  `año_ingreso` year(4) NOT NULL,
  `condicion` enum('Regular','Irregular','Retirado') DEFAULT 'Regular',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `estudiantes`
--

INSERT INTO `estudiantes` (`id`, `persona_id`, `grado_id`, `codigo_estudiante`, `año_ingreso`, `condicion`, `created_at`, `updated_at`) VALUES
(1, 4, 1, '1', '2011', 'Regular', '2025-11-11 22:30:12', '2025-11-20 03:58:20'),
(2, 5, 1, '56', '2022', 'Regular', '2025-11-12 15:59:36', '2025-11-12 15:59:36'),
(3, 8, 1, '2', '2025', 'Regular', '2025-11-13 20:33:22', '2025-11-13 20:33:22'),
(4, 10, 1, '4', '2025', 'Regular', '2025-11-17 16:23:37', '2025-11-17 16:23:37'),
(6, 16, NULL, '7', '2025', 'Regular', '2025-11-21 02:07:49', '2025-11-21 02:07:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gestions`
--

CREATE TABLE `gestions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `año` year(4) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `estado` enum('Activo','Finalizado','Planificado') NOT NULL DEFAULT 'Planificado',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `gestions`
--

INSERT INTO `gestions` (`id`, `año`, `nombre`, `fecha_inicio`, `fecha_fin`, `estado`, `created_at`, `updated_at`) VALUES
(5, '2025', 'ddddd', '2025-10-05', '2025-11-01', 'Planificado', '2025-10-28 20:09:26', '2025-10-28 20:09:26'),
(6, '2026', 'Buenas gestion', '2025-11-02', '2025-11-29', 'Activo', '2025-11-09 23:18:37', '2025-11-09 23:18:37'),
(7, '2027', 'Año de la prosperidad', '2027-01-14', '2027-12-14', 'Activo', '2025-11-13 20:27:03', '2025-11-13 20:27:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grados`
--

CREATE TABLE `grados` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nivel_id` bigint(20) UNSIGNED NOT NULL,
  `turno_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `seccion` varchar(10) DEFAULT NULL,
  `capacidad_maxima` int(11) NOT NULL DEFAULT 30,
  `estado` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `grados`
--

INSERT INTO `grados` (`id`, `nivel_id`, `turno_id`, `nombre`, `seccion`, `capacidad_maxima`, `estado`, `created_at`, `updated_at`) VALUES
(1, 2, 1, '2 grado', 'A', 30, 'Activo', '2025-10-28 19:44:20', '2025-10-28 19:44:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE `horarios` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `gestion_id` bigint(20) UNSIGNED NOT NULL,
  `curso_id` bigint(20) UNSIGNED NOT NULL,
  `grado_id` bigint(20) UNSIGNED NOT NULL,
  `docente_id` bigint(20) UNSIGNED DEFAULT NULL,
  `dia_semana` enum('Lunes','Martes','Miércoles','Jueves','Viernes','Sábado') NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `aula` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `horarios`
--

INSERT INTO `horarios` (`id`, `gestion_id`, `curso_id`, `grado_id`, `docente_id`, `dia_semana`, `hora_inicio`, `hora_fin`, `aula`, `created_at`, `updated_at`) VALUES
(1, 6, 2, 1, 1, 'Lunes', '10:39:00', '11:39:00', 'A-2', '2025-11-12 15:39:05', '2025-11-12 15:39:05'),
(2, 7, 5, 1, 3, 'Martes', '07:53:00', '13:56:00', 'A-8', '2025-11-18 15:54:09', '2025-11-18 15:54:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `matriculas`
--

CREATE TABLE `matriculas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `estudiante_id` bigint(20) UNSIGNED NOT NULL,
  `curso_id` bigint(20) UNSIGNED NOT NULL,
  `grado_id` bigint(20) UNSIGNED NOT NULL,
  `gestion_id` bigint(20) UNSIGNED NOT NULL,
  `estado` enum('Matriculado','Retirado','Aprobado','Desaprobado') NOT NULL DEFAULT 'Matriculado',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `matriculas`
--

INSERT INTO `matriculas` (`id`, `estudiante_id`, `curso_id`, `grado_id`, `gestion_id`, `estado`, `created_at`, `updated_at`) VALUES
(2, 2, 2, 1, 6, 'Matriculado', '2025-11-12 16:10:55', '2025-11-12 16:10:55'),
(3, 3, 3, 1, 7, 'Matriculado', '2025-11-13 20:34:58', '2025-11-13 20:34:58'),
(4, 4, 2, 1, 7, 'Matriculado', '2025-11-17 16:24:32', '2025-11-17 16:24:32'),
(7, 3, 5, 1, 7, 'Matriculado', '2025-11-18 04:05:17', '2025-11-18 04:05:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `remitente_id` bigint(20) UNSIGNED NOT NULL,
  `estudiante_id` bigint(20) UNSIGNED DEFAULT NULL,
  `asunto` varchar(255) NOT NULL,
  `contenido` text NOT NULL,
  `prioridad` enum('Baja','Normal','Alta','Urgente') NOT NULL DEFAULT 'Normal',
  `tipo` enum('Individual','Grupal') NOT NULL DEFAULT 'Individual',
  `archivos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`archivos`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `mensajes`
--

INSERT INTO `mensajes` (`id`, `remitente_id`, `estudiante_id`, `asunto`, `contenido`, `prioridad`, `tipo`, `archivos`, `created_at`, `updated_at`) VALUES
(1, 4, 3, 'como esta', 'lkmgbcffk', 'Normal', 'Individual', NULL, '2025-11-16 06:50:59', '2025-11-16 06:50:59'),
(2, 5, 3, 'RE: como esta', 'buen estudiante', 'Normal', 'Individual', NULL, '2025-11-16 07:15:13', '2025-11-16 07:15:13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensaje_destinatarios`
--

CREATE TABLE `mensaje_destinatarios` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mensaje_id` bigint(20) UNSIGNED NOT NULL,
  `destinatario_id` bigint(20) UNSIGNED NOT NULL,
  `leido` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_lectura` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `mensaje_destinatarios`
--

INSERT INTO `mensaje_destinatarios` (`id`, `mensaje_id`, `destinatario_id`, `leido`, `fecha_lectura`, `created_at`, `updated_at`) VALUES
(1, 1, 5, 1, '2025-11-16 07:14:46', '2025-11-16 06:50:59', '2025-11-16 07:14:46'),
(2, 2, 4, 1, '2025-11-16 07:16:00', '2025-11-16 07:15:13', '2025-11-16 07:16:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_10_23_223038_create_roles_permissions_tables', 1),
(5, '2025_10_23_223044_create_academic_base_tables', 1),
(6, '2025_10_23_223052_create_personas_and_roles_specific_tables', 1),
(7, '2025_10_23_223100_create_academic_structure_dependencies_tables', 1),
(8, '2025_10_23_223108_create_academic_processes_tables', 1),
(9, '2025_10_23_223114_create_registro_tables', 1),
(10, '2025_10_23_223122_create_system_tables', 1),
(11, '2025_11_14_000053_remove_creditos_from_cursos_table', 2),
(13, '2025_11_16_081911_create_talleres_table', 3),
(15, '2025_11_19_114334_update_talleres_table_structure', 4),
(16, '2025_11_19_193227_create_blogs_table', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nivels`
--

CREATE TABLE `nivels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `orden` int(11) NOT NULL DEFAULT 0,
  `estado` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `nivels`
--

INSERT INTO `nivels` (`id`, `nombre`, `descripcion`, `orden`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'Inicial', NULL, 0, 'Activo', '2025-10-28 19:16:24', '2025-10-28 19:16:24'),
(2, 'Segundaria', NULL, 0, 'Activo', '2025-10-28 19:16:42', '2025-10-28 19:16:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas`
--

CREATE TABLE `notas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `matricula_id` bigint(20) UNSIGNED NOT NULL,
  `periodo_id` bigint(20) UNSIGNED NOT NULL,
  `docente_id` bigint(20) UNSIGNED NOT NULL,
  `nota_practica` decimal(5,2) DEFAULT NULL,
  `nota_teoria` decimal(5,2) DEFAULT NULL,
  `nota_final` decimal(5,2) NOT NULL,
  `tipo_evaluacion` enum('Parcial','Final','Práctica','Oral','Trabajo') NOT NULL DEFAULT 'Parcial',
  `descripcion` text DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `fecha_evaluacion` date DEFAULT NULL,
  `visible_tutor` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_publicacion` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notas`
--

INSERT INTO `notas` (`id`, `matricula_id`, `periodo_id`, `docente_id`, `nota_practica`, `nota_teoria`, `nota_final`, `tipo_evaluacion`, `descripcion`, `observaciones`, `fecha_evaluacion`, `visible_tutor`, `fecha_publicacion`, `created_at`, `updated_at`) VALUES
(2, 3, 5, 3, 20.00, 20.00, 18.00, 'Final', 'examen', 'examen', '2025-11-13', 1, '2025-11-13 21:42:30', '2025-11-13 21:41:42', '2025-11-13 21:42:30'),
(3, 2, 5, 2, 12.00, 14.00, 14.00, 'Práctica', 'exaem', 'nansdfkfc', '2025-11-13', 1, '2025-11-13 23:46:55', '2025-11-13 23:46:55', '2025-11-13 23:46:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `tipo` enum('Nota Nueva','Asistencia','Comportamiento','Mensaje','Comunicado','Sistema') NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `referencia_id` bigint(20) UNSIGNED DEFAULT NULL,
  `referencia_tabla` varchar(50) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `leido` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_lectura` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `periodos`
--

CREATE TABLE `periodos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `gestion_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `numero` int(11) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `estado` enum('Activo','Finalizado','Planificado') NOT NULL DEFAULT 'Planificado',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `periodos`
--

INSERT INTO `periodos` (`id`, `gestion_id`, `nombre`, `numero`, `fecha_inicio`, `fecha_fin`, `estado`, `created_at`, `updated_at`) VALUES
(4, 6, '1Bimetre', 1, '2025-11-02', '2025-11-07', 'Activo', '2025-11-09 23:41:00', '2025-11-09 23:41:00'),
(5, 7, 'Primer Bimestre', 1, '2027-01-13', '2027-04-12', 'Activo', '2025-11-13 20:27:51', '2025-11-13 20:27:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `display_name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `module` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `description`, `module`, `created_at`, `updated_at`) VALUES
(1, 'Resgitar notas', 'Registar nortas', 'el profesor podra registar notas', 'Registros', '2025-11-09 03:42:33', '2025-11-09 03:42:33'),
(2, 'dashboard.view', 'Ver Dashboard', 'Acceso al panel principal', 'dashboard', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(3, 'configuracion.view', 'Ver Configuración', 'Acceso a configuración del sistema', 'configuracion', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(4, 'gestiones.view', 'Ver Gestiones', 'Ver listado de gestiones', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(5, 'gestiones.create', 'Crear Gestiones', 'Crear nuevas gestiones', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(6, 'gestiones.edit', 'Editar Gestiones', 'Editar gestiones existentes', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(7, 'gestiones.delete', 'Eliminar Gestiones', 'Eliminar gestiones', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(8, 'periodos.view', 'Ver Períodos', 'Ver listado de períodos', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(9, 'periodos.create', 'Crear Períodos', 'Crear nuevos períodos', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(10, 'periodos.edit', 'Editar Períodos', 'Editar períodos existentes', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(11, 'periodos.delete', 'Eliminar Períodos', 'Eliminar períodos', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(12, 'niveles.view', 'Ver Niveles', 'Ver listado de niveles', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(13, 'niveles.create', 'Crear Niveles', 'Crear nuevos niveles', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(14, 'turnos.view', 'Ver Turnos', 'Ver listado de turnos', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(15, 'horarios.view', 'Ver Horarios', 'Ver listado de horarios', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(16, 'docentes.view', 'Ver Docentes', 'Ver listado de docentes', 'personal', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(17, 'docentes.create', 'Crear Docentes', 'Registrar nuevos docentes', 'personal', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(18, 'docentes.edit', 'Editar Docentes', 'Editar datos de docentes', 'personal', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(19, 'docentes.delete', 'Eliminar Docentes', 'Eliminar docentes', 'personal', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(20, 'tutores.view', 'Ver Tutores', 'Ver listado de tutores', 'personal', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(21, 'estudiantes.view', 'Ver Estudiantes', 'Ver listado de estudiantes', 'estudiantes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(22, 'estudiantes.create', 'Crear Estudiantes', 'Registrar nuevos estudiantes', 'estudiantes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(23, 'estudiantes.edit', 'Editar Estudiantes', 'Editar datos de estudiantes', 'estudiantes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(24, 'estudiantes.delete', 'Eliminar Estudiantes', 'Eliminar estudiantes', 'estudiantes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(25, 'cursos.view', 'Ver Cursos', 'Ver listado de cursos', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(26, 'cursos.create', 'Crear Cursos', 'Crear nuevos cursos', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(27, 'cursos.edit', 'Editar Cursos', 'Editar cursos existentes', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(28, 'cursos.delete', 'Eliminar Cursos', 'Eliminar cursos', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(29, 'grados.view', 'Ver Grados', 'Ver listado de grados', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(30, 'grados.create', 'Crear Grados', 'Crear nuevos grados', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(31, 'grados.edit', 'Editar Grados', 'Editar grados existentes', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(32, 'grados.delete', 'Eliminar Grados', 'Eliminar grados', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(33, 'asignacion-docentes.view', 'Ver Asignación Docentes', 'Ver asignaciones de docentes a cursos', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(34, 'asignacion-docentes.create', 'Crear Asignación Docentes', 'Asignar docentes a cursos', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(35, 'asignacion-docentes.delete', 'Eliminar Asignación Docentes', 'Eliminar asignaciones de docentes', 'academico', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(36, 'matriculas.view', 'Ver Matrículas', 'Ver listado de matrículas', 'estudiantes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(37, 'matriculas.create', 'Crear Matrículas', 'Matricular estudiantes', 'estudiantes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(38, 'matriculas.edit', 'Editar Matrículas', 'Editar matrículas existentes', 'estudiantes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(39, 'matriculas.delete', 'Eliminar Matrículas', 'Eliminar matrículas', 'estudiantes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(40, 'tutor-estudiante.view', 'Ver Tutor-Estudiante', 'Ver relaciones tutor-estudiante', 'estudiantes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(41, 'tutor-estudiante.create', 'Asignar Tutor-Estudiante', 'Asignar tutores a estudiantes', 'estudiantes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(42, 'asistencias.view', 'Ver Asistencias', 'Ver registro de asistencias', 'docentes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(43, 'asistencias.create', 'Registrar Asistencias', 'Registrar asistencias de estudiantes', 'docentes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(44, 'asistencias.edit', 'Editar Asistencias', 'Editar registros de asistencias', 'docentes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(45, 'notas.view', 'Ver Notas', 'Ver calificaciones de estudiantes', 'docentes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(46, 'notas.create', 'Registrar Notas', 'Registrar calificaciones', 'docentes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(47, 'notas.edit', 'Editar Notas', 'Editar calificaciones', 'docentes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(48, 'comportamientos.view', 'Ver Comportamientos', 'Ver evaluaciones de comportamiento', 'docentes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(49, 'comportamientos.create', 'Registrar Comportamientos', 'Registrar evaluaciones de comportamiento', 'docentes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(50, 'comportamientos.edit', 'Editar Comportamientos', 'Editar evaluaciones de comportamiento', 'docentes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(51, 'reportes.view', 'Ver Reportes', 'Acceso a módulo de reportes', 'reportes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(52, 'reportes.generate', 'Generar Reportes', 'Generar reportes del sistema', 'reportes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(53, 'administradores.view', 'Ver Administradores', 'Ver listado de administradores', 'administracion', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(54, 'administradores.create', 'Crear Administradores', 'Registrar nuevos administradores', 'administracion', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(55, 'permisos.view', 'Ver Permisos', 'Ver listado de permisos', 'administracion', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(56, 'permisos.create', 'Crear Permisos', 'Crear nuevos permisos', 'administracion', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(57, 'permisos.edit', 'Editar Permisos', 'Editar permisos existentes', 'administracion', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(58, 'permisos.delete', 'Eliminar Permisos', 'Eliminar permisos', 'administracion', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(59, 'roles.view', 'Ver Roles', 'Ver listado de roles', 'administracion', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(60, 'roles.create', 'Crear Roles', 'Crear nuevos roles', 'administracion', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(61, 'roles.edit', 'Editar Roles', 'Editar roles existentes', 'administracion', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(62, 'roles.delete', 'Eliminar Roles', 'Eliminar roles', 'administracion', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(63, 'usuarios.view', 'Ver Usuarios', 'Ver listado de usuarios', 'administracion', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(64, 'usuarios.create', 'Crear Usuarios', 'Crear nuevos usuarios', 'administracion', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(65, 'usuarios.edit', 'Editar Usuarios', 'Editar usuarios existentes', 'administracion', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(66, 'usuarios.delete', 'Eliminar Usuarios', 'Eliminar usuarios', 'administracion', '2025-11-09 04:59:05', '2025-11-09 04:59:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permission_role`
--

CREATE TABLE `permission_role` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permission_role`
--

INSERT INTO `permission_role` (`id`, `permission_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-11-09 03:42:33', '2025-11-09 03:42:33'),
(2, 1, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(3, 2, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(4, 3, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(5, 4, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(6, 5, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(7, 6, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(8, 7, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(9, 8, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(10, 9, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(11, 10, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(12, 11, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(13, 12, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(14, 13, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(15, 14, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(16, 15, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(17, 16, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(18, 17, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(19, 18, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(20, 19, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(21, 20, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(22, 21, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(23, 22, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(24, 23, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(25, 24, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(26, 25, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(27, 26, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(28, 27, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(29, 28, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(30, 29, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(31, 30, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(32, 31, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(33, 32, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(34, 33, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(35, 34, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(36, 35, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(37, 36, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(38, 37, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(39, 38, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(40, 39, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(41, 40, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(42, 41, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(43, 42, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(44, 43, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(45, 44, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(46, 45, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(47, 46, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(48, 47, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(49, 48, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(50, 49, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(51, 50, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(52, 51, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(53, 52, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(54, 53, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(55, 54, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(56, 55, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(57, 56, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(58, 57, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(59, 58, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(60, 59, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(61, 60, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(62, 61, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(63, 62, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(64, 63, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(65, 64, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(66, 65, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(67, 66, 2, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(68, 43, 3, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(69, 44, 3, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(70, 42, 3, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(71, 49, 3, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(72, 50, 3, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(73, 48, 3, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(74, 2, 3, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(75, 21, 3, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(76, 46, 3, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(77, 47, 3, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(78, 45, 3, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(79, 51, 3, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(80, 42, 4, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(81, 2, 4, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(82, 21, 4, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(83, 45, 4, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(84, 51, 4, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(85, 40, 4, '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(89, 52, 3, '2025-11-12 03:49:08', '2025-11-12 03:49:08'),
(90, 1, 3, '2025-11-13 21:36:01', '2025-11-13 21:36:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE `personas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `dni` varchar(20) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `genero` enum('M','F','Otro') NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `telefono_emergencia` varchar(20) DEFAULT NULL,
  `foto_perfil` varchar(255) DEFAULT NULL,
  `estado` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`id`, `user_id`, `dni`, `nombres`, `apellidos`, `fecha_nacimiento`, `genero`, `direccion`, `telefono`, `telefono_emergencia`, `foto_perfil`, `estado`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, '60833984', 'Daniel', 'Solano Ramos', '2025-10-05', 'M', NULL, NULL, NULL, 'personas/persona_1763675665.jpg', 'Activo', '2025-10-28 19:18:23', '2025-11-20 21:54:25', NULL),
(2, 1, '60843986', 'Jeonel', 'Villanueva puelles', '2025-10-05', 'M', 'Villa florencia', '968959417', NULL, 'personas/persona_1763671832.jpg', 'Activo', '2025-10-28 19:19:42', '2025-11-20 20:50:32', NULL),
(3, NULL, '12345678', 'Oscar', 'Sanchez Timana', '2025-10-05', 'M', 'Piura', '920392687', '920483748', NULL, 'Activo', '2025-10-28 19:20:15', '2025-11-21 13:16:21', NULL),
(4, NULL, '10643001', 'Jhonel', 'Villanueva Puelles', '2006-09-28', 'M', 'Villa Florencia', '910491787', '910491787', NULL, 'Inactivo', '2025-11-11 22:30:12', '2025-11-20 03:58:33', NULL),
(5, NULL, '60833885', 'Jesus', 'Sanchez Chunga', '2025-11-02', 'M', 'Piura', '920491784', '920491784', NULL, 'Activo', '2025-11-12 15:59:36', '2025-11-12 15:59:36', NULL),
(6, 4, '61833984', 'Efrain', 'Solano Homero', '2019-07-10', 'M', 'Piura', '926494631', '926494631', NULL, 'Activo', '2025-11-12 16:04:53', '2025-11-12 16:06:35', NULL),
(7, 5, '60833794', 'Miguel Ange', 'Maza Solano', '2006-09-02', 'M', 'Piura', '920491767', '920491767', 'personas/persona_1763671883.jpg', 'Activo', '2025-11-13 20:31:15', '2025-11-20 20:51:23', NULL),
(8, NULL, '20854983', 'David', 'Maza Solano', '2016-01-13', 'M', 'Piura', '910491797', '910491787', NULL, 'Activo', '2025-11-13 20:33:22', '2025-11-13 20:33:22', NULL),
(9, NULL, '39594983', 'merly', 'sullon castro', '2025-11-02', 'F', 'piura', '9203493294', '920493484', NULL, 'Activo', '2025-11-14 18:24:07', '2025-11-16 04:26:00', '2025-11-16 04:26:00'),
(10, NULL, '58930283', 'Enoc', 'Solano Maza', '2024-07-18', 'M', 'Chulucanas', '910574474', '910574474', NULL, 'Activo', '2025-11-17 16:23:37', '2025-11-17 16:23:37', NULL),
(11, NULL, '69487683', 'dayaana', 'siancas camacho', '2025-11-03', 'M', 'sullana', '910491787', '920492787', NULL, 'Activo', '2025-11-20 03:59:31', '2025-11-21 02:08:27', '2025-11-21 02:08:27'),
(12, 6, '69284787', 'Edwin grabiel', 'ramos Maza', '2025-11-02', 'M', 'sullana', '930485796', '930485796', 'personas/persona_1763660584.png', 'Activo', '2025-11-20 17:43:04', '2025-11-21 13:11:03', NULL),
(13, NULL, '69394038', 'dgmdlhg', 'fdgfhjsxsx', '2025-11-02', 'M', 'rifkfkf', '948383484', '948383484', NULL, 'Activo', '2025-11-20 21:58:11', '2025-11-20 22:00:06', '2025-11-20 22:00:06'),
(14, NULL, '60849504', 'Ariana', 'Benavides', '2025-11-02', 'F', 'lima', '930495852', '930495852', NULL, 'Activo', '2025-11-20 22:19:07', '2025-11-20 22:19:44', '2025-11-20 22:19:44'),
(15, NULL, '78398459', 'juan', 'Tipismana Becerra', '2020-01-30', 'M', 'España', '940387273', '940387273', 'personas/persona_1763684653.jpg', 'Activo', '2025-11-21 00:24:13', '2025-11-21 00:39:33', '2025-11-21 00:39:33'),
(16, NULL, '69384765', 'Jesus manuel', 'sanchez chunga', '2025-11-07', 'M', 'Sechura', '943767565', '943767565', 'personas/persona_1763690869.jpg', 'Activo', '2025-11-21 02:07:49', '2025-11-21 02:07:49', NULL),
(17, NULL, '59405986', 'smfkgñgn', 'solasndp gasjvev', '2025-11-09', 'M', 'piura', '910393787', '910393787', NULL, 'Activo', '2025-11-21 04:10:47', '2025-11-21 04:13:27', '2025-11-21 04:13:27'),
(18, NULL, '369835764', 'dvfbgn', 'csofvdfvnv', '2025-10-27', 'M', 'sulalanass', '910394787', '910394787', NULL, 'Activo', '2025-11-21 04:12:19', '2025-11-21 04:13:37', '2025-11-21 04:13:37');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes`
--

CREATE TABLE `reportes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `estudiante_id` bigint(20) UNSIGNED NOT NULL,
  `docente_id` bigint(20) UNSIGNED NOT NULL,
  `periodo_id` bigint(20) UNSIGNED NOT NULL,
  `gestion_id` bigint(20) UNSIGNED NOT NULL,
  `tipo` enum('Bimestral','Trimestral','Anual') NOT NULL,
  `promedio_general` decimal(5,2) DEFAULT NULL,
  `porcentaje_asistencia` decimal(5,2) DEFAULT NULL,
  `comentario_final` text DEFAULT NULL,
  `archivo_pdf` varchar(255) DEFAULT NULL,
  `visible_tutor` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_generacion` timestamp NULL DEFAULT NULL,
  `fecha_publicacion` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `reportes`
--

INSERT INTO `reportes` (`id`, `estudiante_id`, `docente_id`, `periodo_id`, `gestion_id`, `tipo`, `promedio_general`, `porcentaje_asistencia`, `comentario_final`, `archivo_pdf`, `visible_tutor`, `fecha_generacion`, `fecha_publicacion`, `created_at`, `updated_at`) VALUES
(1, 2, 2, 4, 7, 'Trimestral', 16.00, 0.00, 'bueno', 'reportes/reporte_1763065110_2.pdf', 1, '2025-11-13 20:18:30', '2025-11-13 20:18:30', '2025-11-13 20:18:30', '2025-11-18 04:39:20'),
(3, 3, 3, 4, 7, 'Bimestral', 12.00, 89.00, 'hola', 'reportes/reporte_1763082898_GLAB-S08-SMONTOYA-2024-02_Requ.Parte 3_Detalle.CUS (1).docx (2).pdf', 1, '2025-11-14 01:14:58', NULL, '2025-11-14 01:14:58', '2025-11-14 01:15:54'),
(4, 4, 2, 5, 7, 'Trimestral', 14.00, NULL, 'hjkk', 'reportes/reporte_1763440735_GLAB-S12-LDIAZ-2025-02_Implementacion.pdf', 1, '2025-11-18 04:38:55', NULL, '2025-11-18 04:38:55', '2025-11-18 04:38:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Administrador', 'Administrador', 'administrador', '2025-11-09 03:41:34', '2025-11-09 03:41:34'),
(2, 'admin', 'Administrador', 'Acceso total al sistema', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(3, 'docente', 'Docente', 'Acceso para docentes', '2025-11-09 04:59:05', '2025-11-09 04:59:05'),
(4, 'tutor', 'Tutor', 'Acceso para tutores', '2025-11-09 04:59:05', '2025-11-09 04:59:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_user`
--

CREATE TABLE `role_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `role_user`
--

INSERT INTO `role_user` (`id`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 2, 1, '2025-11-09 05:06:04', '2025-11-09 05:06:04'),
(2, 3, 4, '2025-11-09 05:08:44', '2025-11-09 05:08:44'),
(3, 1, 3, '2025-11-09 06:05:36', '2025-11-09 06:05:36'),
(4, 4, 4, '2025-11-12 16:06:35', '2025-11-12 16:06:35'),
(5, 5, 3, '2025-11-13 20:38:59', '2025-11-13 20:38:59'),
(6, 6, 3, '2025-11-21 04:30:54', '2025-11-21 04:30:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('EMPyGyN2Zi70DzVK8upp5KYQCDNFk8M8bAI5kYWz', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiZktFb2c5UGdaZDRLRHJLSm5FNXI4T3BGTU5LRHp6NWtMQXNER29qSyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7czo0OiJhdXRoIjthOjE6e3M6MjE6InBhc3N3b3JkX2NvbmZpcm1lZF9hdCI7aToxNzYzNzMzMDA3O319', 1763733153),
('guqL7yZOwELyiPXp4OKzwETAjiiGqMsr7J25Jdzq', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoia1pYV0JiaWJQUlQ3TVVYUnJuZ1hQRzVMaFVUMURpVTh6b1ZFVlZEYSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7czo0OiJhdXRoIjthOjE6e3M6MjE6InBhc3N3b3JkX2NvbmZpcm1lZF9hdCI7aToxNzYzNzMyODU4O319', 1763732897),
('MhN6HpliPuWe49o9AqTfmkVmjCbOzb3vQPKIqPTn', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiWmRxbFpHR0w5NnM0TEJiekFURzR2UHdmVlQxR25wVXFpTjJXSWhDTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi90YWxsZXJlcyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7czo0OiJhdXRoIjthOjE6e3M6MjE6InBhc3N3b3JkX2NvbmZpcm1lZF9hdCI7aToxNzYzNzYxNzI1O319', 1763761746),
('PzSJIRWv3GohBXO1ef5p8qqIClaB97m2iEEZHeM8', 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'YTo4OntzOjY6Il90b2tlbiI7czo0MDoiYmcxUWVYeWpzcW1sd2F2R052UFhCWmlQMGpMRkJTQ2VZTmhLbGtFSyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyNjoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL2hvbWUiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozNzoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL3R1dG9yL2Rhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjI6e2k6MDtzOjc6Im1lbnNhamUiO2k6MTtzOjU6Imljb25vIjt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTozO3M6NDoiYXV0aCI7YToxOntzOjIxOiJwYXNzd29yZF9jb25maXJtZWRfYXQiO2k6MTc2MzczMzE2Mzt9czo3OiJtZW5zYWplIjtzOjM0OiJObyB0aWVuZXMgcGVyZmlsIGRlIHR1dG9yIGFzaWduYWRvIjtzOjU6Imljb25vIjtzOjU6ImVycm9yIjt9', 1763733804),
('QPtVaGIhUjjXrbhqthHsQgNeMA02xDu6GgkD0FaO', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiQWhwa1F4Z0dRd1JZbk1FVDZOT1pqaElIVDZnSHJkeDhzT29WVTZvUyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9kYXNoYm9hcmQiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO3M6NDoiYXV0aCI7YToxOntzOjIxOiJwYXNzd29yZF9jb25maXJtZWRfYXQiO2k6MTc2MzczODQ2MTt9fQ==', 1763739920),
('S7iIINi3zIlDf7yT3NmUHoWi6kXU18CP0QXJqDrz', 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoicm1NOEs2NzVxZ25SRGdKaUw4bm9jcWpMREpkR2xhd1VaUTMwdlk3OCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjI6e2k6MDtzOjc6Im1lbnNhamUiO2k6MTtzOjU6Imljb25vIjt9fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM3OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvdHV0b3IvZGFzaGJvYXJkIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MztzOjQ6ImF1dGgiO2E6MTp7czoyMToicGFzc3dvcmRfY29uZmlybWVkX2F0IjtpOjE3NjM3MzEwMTA7fXM6NzoibWVuc2FqZSI7czozNDoiTm8gdGllbmVzIHBlcmZpbCBkZSB0dXRvciBhc2lnbmFkbyI7czo1OiJpY29ubyI7czo1OiJlcnJvciI7fQ==', 1763731614),
('UtAmv1VAErOvxgGgJySF4sfC6g6UwkRKYjSaD458', 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiOVE1Mmp6TjVOdTdMdmFUbmtaTUdLZFAxTTVVS1piM3lXemxNZmtqUyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9ob21lIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MztzOjQ6ImF1dGgiO2E6MTp7czoyMToicGFzc3dvcmRfY29uZmlybWVkX2F0IjtpOjE3NjM3MzI5Mjc7fX0=', 1763732946);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `talleres`
--

CREATE TABLE `talleres` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `instructor` varchar(255) NOT NULL,
  `duracion_inicio` date DEFAULT NULL,
  `duracion_fin` date DEFAULT NULL,
  `costo` decimal(8,2) DEFAULT NULL,
  `cupos_maximos` int(11) NOT NULL DEFAULT 20,
  `imagen` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `horario_inicio` time DEFAULT NULL,
  `horario_fin` time DEFAULT NULL,
  `categoria` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `talleres`
--

INSERT INTO `talleres` (`id`, `nombre`, `descripcion`, `instructor`, `duracion_inicio`, `duracion_fin`, `costo`, `cupos_maximos`, `imagen`, `activo`, `created_at`, `updated_at`, `horario_inicio`, `horario_fin`, `categoria`) VALUES
(1, 'Educacion Fsica', 'campo', 'David', NULL, NULL, 20.00, 20, 'talleres/cA7bUMfawBPwf65O1PXNZUQXbVmqOlS7PURjIYnF.jpg', 1, '2025-11-19 15:43:03', '2025-11-19 15:43:21', NULL, NULL, NULL),
(2, 'Goku', 'Goku black', 'Daniel', NULL, NULL, 12.00, 21, 'talleres/e0Sn2ReBQnYwYeg6hMmGtVePdjowlDH1Q0xOTbOl.jpg', 1, '2025-11-19 15:47:41', '2025-11-19 15:47:41', NULL, NULL, NULL),
(4, 'gfgfg', 'hghgh', 'gjhjh', NULL, NULL, 8989.00, 89, 'talleres/qOOTYs3Zd5DYwqjYgGnsO72okqg7QQRBps3ZYnmo.jpg', 1, '2025-11-19 15:53:05', '2025-11-19 15:55:25', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tallers`
--

CREATE TABLE `tallers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `instructor` varchar(255) NOT NULL,
  `duracion` varchar(255) NOT NULL,
  `horario` varchar(255) DEFAULT NULL,
  `costo` decimal(8,2) DEFAULT NULL,
  `cupos_maximos` int(11) NOT NULL DEFAULT 20,
  `imagen` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turnos`
--

CREATE TABLE `turnos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo',
  `descripcion` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `turnos`
--

INSERT INTO `turnos` (`id`, `nombre`, `hora_inicio`, `hora_fin`, `estado`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'Mañana', '15:16:00', '18:16:00', 'activo', NULL, '2025-10-28 19:17:04', '2025-11-13 20:28:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tutores`
--

CREATE TABLE `tutores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `persona_id` bigint(20) UNSIGNED NOT NULL,
  `codigo_tutor` varchar(50) DEFAULT NULL,
  `ocupacion` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tutores`
--

INSERT INTO `tutores` (`id`, `persona_id`, `codigo_tutor`, `ocupacion`, `created_at`, `updated_at`) VALUES
(1, 3, '3', 'papa', '2025-10-28 19:20:15', '2025-11-19 16:33:23'),
(2, 6, '2', 'Padre', '2025-11-12 16:04:53', '2025-11-12 16:04:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tutor_estudiante`
--

CREATE TABLE `tutor_estudiante` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tutor_id` bigint(20) UNSIGNED NOT NULL,
  `estudiante_id` bigint(20) UNSIGNED NOT NULL,
  `relacion_familiar` enum('Padre','Madre','Tutor Legal','Abuelo/a','Tío/a','Hermano/a','Otro') NOT NULL,
  `tipo` enum('Principal','Secundario') NOT NULL DEFAULT 'Principal',
  `autorizacion_recojo` tinyint(1) NOT NULL DEFAULT 1,
  `estado` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tutor_estudiante`
--

INSERT INTO `tutor_estudiante` (`id`, `tutor_id`, `estudiante_id`, `relacion_familiar`, `tipo`, `autorizacion_recojo`, `estado`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Padre', 'Principal', 1, 'Activo', '2025-11-12 15:44:38', '2025-11-12 15:44:38'),
(2, 2, 3, 'Padre', 'Principal', 1, 'Activo', '2025-11-13 20:36:14', '2025-11-13 20:36:14'),
(3, 2, 4, 'Padre', 'Principal', 1, 'Activo', '2025-11-17 16:25:40', '2025-11-17 16:25:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'david', 'david@gmail.com', NULL, '$2y$12$R9Hymu3PIEgJ7fd6NO53iuU8goAuTGXfkPPC1I8cfHP9NjetaqCOS', NULL, '2025-10-28 03:20:36', '2025-10-28 03:20:36'),
(2, 'daniel', 'daniel@gmail.com', '2025-10-28 03:53:09', '$2y$12$6avkDOWXKOKtMzMTUUtNt.8Appk6D4eqJR4RB6fKdDf.5OMcVS0ne', NULL, '2025-10-28 03:53:09', '2025-10-28 03:53:09'),
(3, 'samuel', 'samuel@gmail.com', '2025-11-09 05:08:44', '$2y$12$425cgsSYSermqV4QSNHuZe3NItPCyS4bdpJeprKkkVOBW//gHsigm', NULL, '2025-11-09 05:08:44', '2025-11-21 13:16:21'),
(4, 'Efraín', 'efrain@gmail.com', NULL, '$2y$12$i9OPUrBm2GFJtSYsXsj9i.0CX8aEtwCCjjyO62orXDSaEb8h4n9X.', NULL, '2025-11-12 16:06:35', '2025-11-12 16:06:35'),
(5, 'Miguel', 'miguel@gmail.com', '2025-11-19 17:02:20', '$2y$12$6mDE6WMlSNNgLVwqtxFJXOmMby36pq4HMS/JvRsgFzlTQzVZWYRM.', NULL, '2025-11-13 20:38:58', '2025-11-19 17:02:20'),
(6, 'edwin', 'edwin@gmail.com', NULL, '$2y$12$xijAjylAA7fn54SZoJsm7.45swVwPycX8zcJnsyW/.nIIDJ2qDGNK', NULL, '2025-11-21 04:30:54', '2025-11-21 04:32:33');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `administradores`
--
ALTER TABLE `administradores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `administradores_persona_id_foreign` (`persona_id`);

--
-- Indices de la tabla `asistencias`
--
ALTER TABLE `asistencias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asistencias_estudiante_id_foreign` (`estudiante_id`),
  ADD KEY `asistencias_curso_id_foreign` (`curso_id`),
  ADD KEY `asistencias_docente_id_foreign` (`docente_id`);

--
-- Indices de la tabla `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `comportamientos`
--
ALTER TABLE `comportamientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comportamientos_estudiante_id_foreign` (`estudiante_id`),
  ADD KEY `comportamientos_docente_id_foreign` (`docente_id`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `configuracion_clave_unique` (`clave`);

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cursos_codigo_unique` (`codigo`),
  ADD KEY `cursos_nivel_id_foreign` (`nivel_id`);

--
-- Indices de la tabla `docentes`
--
ALTER TABLE `docentes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `docentes_codigo_docente_unique` (`codigo_docente`),
  ADD KEY `docentes_persona_id_foreign` (`persona_id`);

--
-- Indices de la tabla `docente_curso`
--
ALTER TABLE `docente_curso`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_asignacion` (`docente_id`,`curso_id`,`grado_id`,`gestion_id`),
  ADD KEY `docente_curso_curso_id_foreign` (`curso_id`),
  ADD KEY `docente_curso_grado_id_foreign` (`grado_id`),
  ADD KEY `docente_curso_gestion_id_foreign` (`gestion_id`);

--
-- Indices de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `estudiantes_codigo_estudiante_unique` (`codigo_estudiante`),
  ADD KEY `estudiantes_persona_id_foreign` (`persona_id`),
  ADD KEY `estudiantes_grado_id_foreign` (`grado_id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `gestions`
--
ALTER TABLE `gestions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `grados`
--
ALTER TABLE `grados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `grados_nivel_id_foreign` (`nivel_id`),
  ADD KEY `grados_turno_id_foreign` (`turno_id`);

--
-- Indices de la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `horarios_gestion_id_foreign` (`gestion_id`),
  ADD KEY `horarios_curso_id_foreign` (`curso_id`),
  ADD KEY `horarios_grado_id_foreign` (`grado_id`),
  ADD KEY `horarios_docente_id_foreign` (`docente_id`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `matriculas`
--
ALTER TABLE `matriculas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_matricula` (`estudiante_id`,`curso_id`,`gestion_id`),
  ADD KEY `matriculas_curso_id_foreign` (`curso_id`),
  ADD KEY `matriculas_grado_id_foreign` (`grado_id`),
  ADD KEY `matriculas_gestion_id_foreign` (`gestion_id`);

--
-- Indices de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mensajes_remitente_id_foreign` (`remitente_id`),
  ADD KEY `mensajes_estudiante_id_foreign` (`estudiante_id`);

--
-- Indices de la tabla `mensaje_destinatarios`
--
ALTER TABLE `mensaje_destinatarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mensaje_destinatarios_mensaje_id_foreign` (`mensaje_id`),
  ADD KEY `mensaje_destinatarios_destinatario_id_foreign` (`destinatario_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `nivels`
--
ALTER TABLE `nivels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nivels_nombre_unique` (`nombre`);

--
-- Indices de la tabla `notas`
--
ALTER TABLE `notas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notas_matricula_id_foreign` (`matricula_id`),
  ADD KEY `notas_periodo_id_foreign` (`periodo_id`),
  ADD KEY `notas_docente_id_foreign` (`docente_id`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notificaciones_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `periodos`
--
ALTER TABLE `periodos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `periodos_gestion_id_numero_unique` (`gestion_id`,`numero`);

--
-- Indices de la tabla `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_unique` (`name`),
  ADD KEY `permissions_module_index` (`module`);

--
-- Indices de la tabla `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permission_role_permission_id_role_id_unique` (`permission_id`,`role_id`),
  ADD KEY `permission_role_role_id_foreign` (`role_id`);

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personas_dni_unique` (`dni`),
  ADD KEY `1` (`user_id`),
  ADD KEY `personas_estado_index` (`estado`);

--
-- Indices de la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reportes_estudiante_id_foreign` (`estudiante_id`),
  ADD KEY `reportes_docente_id_foreign` (`docente_id`),
  ADD KEY `reportes_periodo_id_foreign` (`periodo_id`),
  ADD KEY `reportes_gestion_id_foreign` (`gestion_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indices de la tabla `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_user_user_id_role_id_unique` (`user_id`,`role_id`),
  ADD KEY `role_user_role_id_foreign` (`role_id`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `talleres`
--
ALTER TABLE `talleres`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tallers`
--
ALTER TABLE `tallers`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tutores`
--
ALTER TABLE `tutores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tutores_codigo_tutor_unique` (`codigo_tutor`),
  ADD KEY `tutores_persona_id_foreign` (`persona_id`);

--
-- Indices de la tabla `tutor_estudiante`
--
ALTER TABLE `tutor_estudiante`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tutor_estudiante_tutor_id_estudiante_id_unique` (`tutor_id`,`estudiante_id`),
  ADD KEY `tutor_estudiante_estudiante_id_foreign` (`estudiante_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `administradores`
--
ALTER TABLE `administradores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `asistencias`
--
ALTER TABLE `asistencias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `comportamientos`
--
ALTER TABLE `comportamientos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `docentes`
--
ALTER TABLE `docentes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `docente_curso`
--
ALTER TABLE `docente_curso`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `gestions`
--
ALTER TABLE `gestions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `grados`
--
ALTER TABLE `grados`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `horarios`
--
ALTER TABLE `horarios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `matriculas`
--
ALTER TABLE `matriculas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `mensaje_destinatarios`
--
ALTER TABLE `mensaje_destinatarios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `nivels`
--
ALTER TABLE `nivels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `notas`
--
ALTER TABLE `notas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `periodos`
--
ALTER TABLE `periodos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT de la tabla `permission_role`
--
ALTER TABLE `permission_role`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `reportes`
--
ALTER TABLE `reportes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `role_user`
--
ALTER TABLE `role_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `talleres`
--
ALTER TABLE `talleres`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tallers`
--
ALTER TABLE `tallers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `turnos`
--
ALTER TABLE `turnos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tutores`
--
ALTER TABLE `tutores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tutor_estudiante`
--
ALTER TABLE `tutor_estudiante`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administradores`
--
ALTER TABLE `administradores`
  ADD CONSTRAINT `administradores_persona_id_foreign` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `asistencias`
--
ALTER TABLE `asistencias`
  ADD CONSTRAINT `asistencias_curso_id_foreign` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `asistencias_docente_id_foreign` FOREIGN KEY (`docente_id`) REFERENCES `docentes` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `asistencias_estudiante_id_foreign` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `comportamientos`
--
ALTER TABLE `comportamientos`
  ADD CONSTRAINT `comportamientos_docente_id_foreign` FOREIGN KEY (`docente_id`) REFERENCES `docentes` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `comportamientos_estudiante_id_foreign` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD CONSTRAINT `cursos_nivel_id_foreign` FOREIGN KEY (`nivel_id`) REFERENCES `nivels` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `docentes`
--
ALTER TABLE `docentes`
  ADD CONSTRAINT `docentes_persona_id_foreign` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `docente_curso`
--
ALTER TABLE `docente_curso`
  ADD CONSTRAINT `docente_curso_curso_id_foreign` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `docente_curso_docente_id_foreign` FOREIGN KEY (`docente_id`) REFERENCES `docentes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `docente_curso_gestion_id_foreign` FOREIGN KEY (`gestion_id`) REFERENCES `gestions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `docente_curso_grado_id_foreign` FOREIGN KEY (`grado_id`) REFERENCES `grados` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD CONSTRAINT `estudiantes_grado_id_foreign` FOREIGN KEY (`grado_id`) REFERENCES `grados` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `estudiantes_persona_id_foreign` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `grados`
--
ALTER TABLE `grados`
  ADD CONSTRAINT `grados_nivel_id_foreign` FOREIGN KEY (`nivel_id`) REFERENCES `nivels` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `grados_turno_id_foreign` FOREIGN KEY (`turno_id`) REFERENCES `turnos` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD CONSTRAINT `horarios_curso_id_foreign` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `horarios_docente_id_foreign` FOREIGN KEY (`docente_id`) REFERENCES `docentes` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `horarios_gestion_id_foreign` FOREIGN KEY (`gestion_id`) REFERENCES `gestions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `horarios_grado_id_foreign` FOREIGN KEY (`grado_id`) REFERENCES `grados` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `matriculas`
--
ALTER TABLE `matriculas`
  ADD CONSTRAINT `matriculas_curso_id_foreign` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `matriculas_estudiante_id_foreign` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `matriculas_gestion_id_foreign` FOREIGN KEY (`gestion_id`) REFERENCES `gestions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `matriculas_grado_id_foreign` FOREIGN KEY (`grado_id`) REFERENCES `grados` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD CONSTRAINT `mensajes_estudiante_id_foreign` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `mensajes_remitente_id_foreign` FOREIGN KEY (`remitente_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mensaje_destinatarios`
--
ALTER TABLE `mensaje_destinatarios`
  ADD CONSTRAINT `mensaje_destinatarios_destinatario_id_foreign` FOREIGN KEY (`destinatario_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mensaje_destinatarios_mensaje_id_foreign` FOREIGN KEY (`mensaje_id`) REFERENCES `mensajes` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `notas`
--
ALTER TABLE `notas`
  ADD CONSTRAINT `notas_docente_id_foreign` FOREIGN KEY (`docente_id`) REFERENCES `docentes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notas_matricula_id_foreign` FOREIGN KEY (`matricula_id`) REFERENCES `matriculas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notas_periodo_id_foreign` FOREIGN KEY (`periodo_id`) REFERENCES `periodos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `periodos`
--
ALTER TABLE `periodos`
  ADD CONSTRAINT `periodos_gestion_id_foreign` FOREIGN KEY (`gestion_id`) REFERENCES `gestions` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `personas`
--
ALTER TABLE `personas`
  ADD CONSTRAINT `1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD CONSTRAINT `reportes_docente_id_foreign` FOREIGN KEY (`docente_id`) REFERENCES `docentes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reportes_estudiante_id_foreign` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reportes_gestion_id_foreign` FOREIGN KEY (`gestion_id`) REFERENCES `gestions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reportes_periodo_id_foreign` FOREIGN KEY (`periodo_id`) REFERENCES `periodos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `tutores`
--
ALTER TABLE `tutores`
  ADD CONSTRAINT `tutores_persona_id_foreign` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `tutor_estudiante`
--
ALTER TABLE `tutor_estudiante`
  ADD CONSTRAINT `tutor_estudiante_estudiante_id_foreign` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tutor_estudiante_tutor_id_foreign` FOREIGN KEY (`tutor_id`) REFERENCES `tutores` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
