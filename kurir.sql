-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 24, 2018 at 11:18 AM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kurir`
--

-- --------------------------------------------------------

--
-- Table structure for table `cabang`
--

CREATE TABLE `cabang` (
  `IDCabang` int(9) NOT NULL,
  `nama_cabang` varchar(50) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `nama_kota` varchar(100) NOT NULL,
  `latitude` varchar(30) NOT NULL,
  `longitude` varchar(30) NOT NULL,
  `IP` varchar(30) NOT NULL,
  `isSyn` enum('Y','N') NOT NULL DEFAULT 'N',
  `trash` enum('Y','N') NOT NULL DEFAULT 'N',
  `created_on` int(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kurir`
--

CREATE TABLE `kurir` (
  `IDKurir` int(9) NOT NULL,
  `nama_kurir` varchar(100) NOT NULL,
  `telepon` varchar(30) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `jenis` enum('MTR','BSR') NOT NULL,
  `created_on` int(9) NOT NULL,
  `isSyn` enum('Y','N') NOT NULL DEFAULT 'N',
  `trash` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `log_tracking`
--

CREATE TABLE `log_tracking` (
  `IDLog` int(9) NOT NULL,
  `IDPaket` int(9) NOT NULL,
  `detail` varchar(255) NOT NULL,
  `created_on` int(9) NOT NULL,
  `trash` enum('Y','N') NOT NULL DEFAULT 'N',
  `isSyn` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `paket_barang`
--

CREATE TABLE `paket_barang` (
  `IDPaket` int(9) NOT NULL,
  `IDCabang` int(9) NOT NULL,
  `nama_paket` varchar(100) NOT NULL,
  `no_resi` varchar(255) NOT NULL,
  `nama_pengirim` varchar(50) NOT NULL,
  `alamat_pengirim` varchar(255) NOT NULL,
  `telepon_pengirim` varchar(30) NOT NULL,
  `nama_penerima` varchar(50) NOT NULL,
  `alamat_penerima` varchar(255) NOT NULL,
  `telepon_penerima` varchar(30) NOT NULL,
  `berat` varchar(10) NOT NULL,
  `kategori_paket` enum('REG','EXP') NOT NULL,
  `jenis_paket` enum('BRG','DKM') NOT NULL,
  `tarif` varchar(50) NOT NULL,
  `created_on` int(9) NOT NULL,
  `isSyn` enum('Y','N') NOT NULL DEFAULT 'N',
  `trash` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cabang`
--
ALTER TABLE `cabang`
  ADD PRIMARY KEY (`IDCabang`);

--
-- Indexes for table `kurir`
--
ALTER TABLE `kurir`
  ADD PRIMARY KEY (`IDKurir`);

--
-- Indexes for table `log_tracking`
--
ALTER TABLE `log_tracking`
  ADD PRIMARY KEY (`IDLog`);

--
-- Indexes for table `paket_barang`
--
ALTER TABLE `paket_barang`
  ADD PRIMARY KEY (`IDPaket`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cabang`
--
ALTER TABLE `cabang`
  MODIFY `IDCabang` int(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kurir`
--
ALTER TABLE `kurir`
  MODIFY `IDKurir` int(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log_tracking`
--
ALTER TABLE `log_tracking`
  MODIFY `IDLog` int(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `paket_barang`
--
ALTER TABLE `paket_barang`
  MODIFY `IDPaket` int(9) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
