-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 21, 2022 at 05:43 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_facesecurity`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_log_akses`
--

CREATE TABLE `tb_log_akses` (
  `id_log_akses` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_security` int(11) NOT NULL,
  `tgl_akses` datetime NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_log_akses`
--

INSERT INTO `tb_log_akses` (`id_log_akses`, `id_user`, `id_security`, `tgl_akses`, `status`) VALUES
(1, 2, 1, '2022-06-14 00:34:15', 'berhasil'),
(2, 5, 2, '2022-06-14 00:34:25', 'gagal'),
(3, 1, 2, '2022-06-21 21:14:02', 'gagal'),
(4, 6, 2, '2022-06-21 21:15:21', 'gagal'),
(5, 7, 2, '2022-06-21 21:15:52', 'gagal'),
(6, 1, 1, '2022-06-21 21:16:02', 'berhasil'),
(7, 8, 2, '2022-06-21 21:42:04', 'gagal'),
(8, 5, 1, '2022-06-21 21:42:10', 'berhasil');

-- --------------------------------------------------------

--
-- Table structure for table `tb_recognition`
--

CREATE TABLE `tb_recognition` (
  `id_recognition` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `face_label` varchar(100) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_recognition`
--

INSERT INTO `tb_recognition` (`id_recognition`, `id_user`, `face_label`, `description`) VALUES
(1, 1, 'rangga', 'user rangga'),
(2, 2, 'fachry', 'user fachry'),
(3, 3, 'citra', 'user citra'),
(4, 4, 'ayub', 'user ayub'),
(5, 5, 'ilham', 'user ilham');

-- --------------------------------------------------------

--
-- Table structure for table `tb_security`
--

CREATE TABLE `tb_security` (
  `id_security` int(11) NOT NULL,
  `lock_notif` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_security`
--

INSERT INTO `tb_security` (`id_security`, `lock_notif`) VALUES
(1, 'terbuka'),
(2, 'terkunci');

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`id_user`, `nama`, `email`, `username`, `password`) VALUES
(1, 'rangga', 'serangga@gmail.com', 'rangrang', 'rahasia'),
(2, 'fachry', 'fachry@gmail.com', 'fachryuyee', 'hayookepo'),
(3, 'Citra', 'citra@gmail.com', 'citra', 'mbakcitra'),
(4, 'ayub', 'ayub@gmail.com', 'masayub', 'ayubdong'),
(5, 'ilham', 'ilham@gmail.com', 'ilhambremm', 'ilham'),
(6, 'bangajiz', 'bangajiz@gmail.com', 'bangajiz', 'ajizbonek'),
(7, 'Rizky', 'rizky15@gmail.com', 'rizkyfach', 'rizkyfach'),
(8, 'alga', 'algaputra@gmail.com', 'putrasenja', 'kopitok'),
(9, 'Prasetya', 'prasetya@gmail.com', 'prasetya', 'prasetya15'),
(10, 'Nugroho', 'nugroho@gmail.com', 'masnugroh', 'nugroho');

-- --------------------------------------------------------

--
-- Table structure for table `tb_valdiasi`
--

CREATE TABLE `tb_valdiasi` (
  `id_validasi` int(11) NOT NULL,
  `id_security` int(11) NOT NULL,
  `id_recognition` int(11) NOT NULL,
  `status_validasi` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_valdiasi`
--

INSERT INTO `tb_valdiasi` (`id_validasi`, `id_security`, `id_recognition`, `status_validasi`) VALUES
(1, 1, 1, 'sukses'),
(2, 2, 2, 'gagal'),
(3, 2, 3, 'gagal'),
(4, 1, 4, 'berhasil'),
(5, 1, 5, 'berhasil'),
(6, 2, 6, 'gagal'),
(7, 2, 7, 'gagal'),
(8, 1, 8, 'berhasil'),
(9, 2, 9, 'gagal'),
(10, 1, 10, 'berhasil');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_log_akses`
--
ALTER TABLE `tb_log_akses`
  ADD PRIMARY KEY (`id_log_akses`);

--
-- Indexes for table `tb_recognition`
--
ALTER TABLE `tb_recognition`
  ADD PRIMARY KEY (`id_recognition`);

--
-- Indexes for table `tb_security`
--
ALTER TABLE `tb_security`
  ADD PRIMARY KEY (`id_security`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `tb_valdiasi`
--
ALTER TABLE `tb_valdiasi`
  ADD PRIMARY KEY (`id_validasi`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_log_akses`
--
ALTER TABLE `tb_log_akses`
  MODIFY `id_log_akses` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tb_recognition`
--
ALTER TABLE `tb_recognition`
  MODIFY `id_recognition` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tb_security`
--
ALTER TABLE `tb_security`
  MODIFY `id_security` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tb_valdiasi`
--
ALTER TABLE `tb_valdiasi`
  MODIFY `id_validasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
