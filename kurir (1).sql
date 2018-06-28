-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 28, 2018 at 02:38 AM
-- Server version: 10.1.16-MariaDB
-- PHP Version: 7.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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
  `created_on` char(18) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cabang`
--

INSERT INTO `cabang` (`IDCabang`, `nama_cabang`, `alamat`, `nama_kota`, `latitude`, `longitude`, `IP`, `isSyn`, `trash`, `created_on`) VALUES
(1, 'Jakarta Barat', 'jalan laksa 2 no.88b', 'DKI Jakarta', '-6.1449657', '106.7873883', '192.168.1.30', 'N', 'N', '1528606080092'),
(2, 'Jakarta Pusat', 'Tanahabang Station, Jalan Jati Baru Raya, Cideng, Central Jakarta City, Jakarta', 'DKI Jakarta', '-6.1857449', '106.8086437', '192.168.1.31', 'N', 'N', '1528606118096');

-- --------------------------------------------------------

--
-- Table structure for table `harga_paket`
--

CREATE TABLE `harga_paket` (
  `IDHarga` int(9) NOT NULL,
  `IDCabangAsal` int(9) NOT NULL,
  `IDCabangTujuan` int(11) NOT NULL,
  `kategori` enum('REG','EXP') NOT NULL,
  `harga` varchar(100) NOT NULL,
  `isSyn` enum('Y','N') NOT NULL DEFAULT 'N',
  `created_on` char(19) NOT NULL,
  `trash` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `harga_paket`
--

INSERT INTO `harga_paket` (`IDHarga`, `IDCabangAsal`, `IDCabangTujuan`, `kategori`, `harga`, `isSyn`, `created_on`, `trash`) VALUES
(1, 1, 2, 'REG', '10000', 'N', '1528183131541', 'N'),
(2, 2, 1, 'REG', '11000', 'N', '1528183131542', 'N');

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
  `password` varchar(255) NOT NULL,
  `created_on` char(18) NOT NULL,
  `isSyn` enum('Y','N') NOT NULL DEFAULT 'N',
  `trash` enum('Y','N') NOT NULL DEFAULT 'N',
  `key_login` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kurir`
--

INSERT INTO `kurir` (`IDKurir`, `nama_kurir`, `telepon`, `alamat`, `jenis`, `password`, `created_on`, `isSyn`, `trash`, `key_login`) VALUES
(1, 'acung ', '123432234234', 'jalan laksa 2', 'MTR', '123', '1528606374904', 'N', 'N', ''),
(2, 'usup', '9939330', 'jalan terate 2', 'MTR', '123', '1528606358205', 'N', 'N', ''),
(3, 'dilan', '08965641522', 'Esa Unggul, Jalan Arjuna Utara, RT.1/RW.2, Duri Kepa, West Jakarta City, Jakarta', 'BSR', '123', '1528606286862', 'N', 'N', '');

-- --------------------------------------------------------

--
-- Table structure for table `list_pengiriman`
--

CREATE TABLE `list_pengiriman` (
  `IDPengiriman` int(9) NOT NULL,
  `IDKurir` int(9) NOT NULL,
  `IDPaket` int(9) NOT NULL,
  `kategori_paket` enum('REG','EXP') NOT NULL,
  `prioritas` int(10) NOT NULL,
  `waktu_mulai` char(18) NOT NULL,
  `waktu_selesai` char(18) NOT NULL,
  `status_pengiriman` enum('SUKSES','GAGAL','PENDING') NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `IDCabang` int(9) NOT NULL,
  `isSyn` enum('Y','N') NOT NULL DEFAULT 'N',
  `created_on` char(18) NOT NULL,
  `trash` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `list_pengiriman`
--

INSERT INTO `list_pengiriman` (`IDPengiriman`, `IDKurir`, `IDPaket`, `kategori_paket`, `prioritas`, `waktu_mulai`, `waktu_selesai`, `status_pengiriman`, `keterangan`, `IDCabang`, `isSyn`, `created_on`, `trash`) VALUES
(1, 1, 5, 'REG', 1, '1528336958', '1528337958', 'SUKSES', 'undefineddddd', 2312, 'N', '1528183131541', 'N'),
(2, 1, 7, 'EXP', 2, '1528336958', '1528337958', 'GAGAL', 'aaaa', 2312, 'N', '1528183131541', 'N'),
(3, 1, 8, 'REG', 1, '1528336958', '1528337958', 'GAGAL', 'ini keterangan', 2312, 'N', '1528183131541', 'N'),
(4, 1, 8, 'REG', 3, '1528336958', '1528337958', 'SUKSES', 'SUKSES', 2312, 'N', '1528183131541', 'N');

-- --------------------------------------------------------

--
-- Table structure for table `log_tracking`
--

CREATE TABLE `log_tracking` (
  `IDLog` int(9) NOT NULL,
  `IDPaket` int(9) NOT NULL,
  `detail` varchar(255) NOT NULL,
  `created_on` char(12) NOT NULL,
  `trash` enum('Y','N') NOT NULL DEFAULT 'N',
  `isSyn` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `log_tracking`
--

INSERT INTO `log_tracking` (`IDLog`, `IDPaket`, `detail`, `created_on`, `trash`, `isSyn`) VALUES
(1, 0, 'Pengiriman dengan resi : undefined,\n    			oleh Kurir : undefined GAGAL <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 12:1:10, <br >\n    			pada tanggal : 2018-6-14\n    			', '152895247069', 'N', 'N'),
(2, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 SUKSES <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 12:4:15, <br >\n    			pada tanggal : 2018-6-14\n    			', '152895265568', 'N', 'N'),
(3, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 PENDING <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 14:57:28, <br >\n    			pada tanggal : 2018-6-14\n    			', '152896304876', 'N', 'N'),
(4, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 PENDING <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 15:11:6, <br >\n    			pada tanggal : 2018-6-14\n    			', '152896386647', 'N', 'N'),
(5, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 GAGAL <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 15:11:10, <br >\n    			pada tanggal : 2018-6-14\n    			', '152896387009', 'N', 'N'),
(6, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 SUKSES <br>\n    			keterangan : ini keterangan, <br />\n    			pada waktu : 18:25:49, <br >\n    			pada tanggal : 2018-6-25\n    			', '152992594989', 'N', 'N'),
(7, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 SUKSES <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 18:25:55, <br >\n    			pada tanggal : 2018-6-25\n    			', '152992595599', 'N', 'N'),
(8, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 GAGAL <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 18:43:34, <br >\n    			pada tanggal : 2018-6-25\n    			', '152992701482', 'N', 'N'),
(9, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 GAGAL <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 18:43:34, <br >\n    			pada tanggal : 2018-6-25\n    			', '152992701482', 'N', 'N'),
(10, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 SUKSES <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 18:50:3, <br >\n    			pada tanggal : 2018-6-25\n    			', '152992740300', 'N', 'N'),
(11, 7, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527797577659418 SUKSES <br>\n    			keterangan : aaaa, <br />\n    			pada waktu : 18:50:9, <br >\n    			pada tanggal : 2018-6-25\n    			', '152992740921', 'N', 'N'),
(12, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 GAGAL <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 18:50:53, <br >\n    			pada tanggal : 2018-6-25\n    			', '152992745350', 'N', 'N'),
(13, 5, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : undefined GAGAL <br>\n    			keterangan : undefineddddd, <br />\n    			pada waktu : 18:50:53, <br >\n    			pada tanggal : 2018-6-25\n    			', '152992745350', 'N', 'N'),
(14, 7, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527797577659418 GAGAL <br>\n    			keterangan : aaaa, <br />\n    			pada waktu : 18:50:53, <br >\n    			pada tanggal : 2018-6-25\n    			', '152992745350', 'N', 'N'),
(15, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 SUKSES <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 21:20:44, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993644404', 'N', 'N'),
(16, 5, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : undefined PENDING <br>\n    			keterangan : undefineddddd, <br />\n    			pada waktu : 21:20:50, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993645023', 'N', 'N'),
(17, 7, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527797577659418 SUKSES <br>\n    			keterangan : aaaa, <br />\n    			pada waktu : 21:20:57, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993645740', 'N', 'N'),
(18, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 SUKSES <br>\n    			keterangan : ini keterangan, <br />\n    			pada waktu : 21:22:4, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993652438', 'N', 'N'),
(19, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 GAGAL <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 21:22:4, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993652438', 'N', 'N'),
(20, 5, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : undefined SUKSES <br>\n    			keterangan : undefineddddd, <br />\n    			pada waktu : 21:22:7, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993652701', 'N', 'N'),
(21, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 PENDING <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 21:22:7, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993652701', 'N', 'N'),
(22, 5, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : undefined GAGAL <br>\n    			keterangan : undefineddddd, <br />\n    			pada waktu : 21:22:59, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993657939', 'N', 'N'),
(23, 7, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527797577659418 GAGAL <br>\n    			keterangan : aaaa, <br />\n    			pada waktu : 21:22:59, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993657939', 'N', 'N'),
(24, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 GAGAL <br>\n    			keterangan : ini keterangan, <br />\n    			pada waktu : 21:22:59, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993657939', 'N', 'N'),
(25, 7, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527797577659418 PENDING <br>\n    			keterangan : aaaa, <br />\n    			pada waktu : 21:23:0, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993658020', 'N', 'N'),
(26, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 PENDING <br>\n    			keterangan : ini keterangan, <br />\n    			pada waktu : 21:23:0, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993658020', 'N', 'N'),
(27, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 SUKSES <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 21:23:0, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993658020', 'N', 'N'),
(28, 5, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : undefined SUKSES <br>\n    			keterangan : undefineddddd, <br />\n    			pada waktu : 21:23:36, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993661634', 'N', 'N'),
(29, 7, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527797577659418 SUKSES <br>\n    			keterangan : aaaa, <br />\n    			pada waktu : 21:23:36, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993661634', 'N', 'N'),
(30, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 SUKSES <br>\n    			keterangan : ini keterangan, <br />\n    			pada waktu : 21:23:36, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993661634', 'N', 'N'),
(31, 5, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : undefined PENDING <br>\n    			keterangan : undefineddddd, <br />\n    			pada waktu : 21:24:21, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993666139', 'N', 'N'),
(32, 7, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527797577659418 PENDING <br>\n    			keterangan : aaaa, <br />\n    			pada waktu : 21:24:21, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993666139', 'N', 'N'),
(33, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 PENDING <br>\n    			keterangan : ini keterangan, <br />\n    			pada waktu : 21:24:21, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993666139', 'N', 'N'),
(34, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 PENDING <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 21:24:21, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993666139', 'N', 'N'),
(35, 5, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : undefined GAGAL <br>\n    			keterangan : undefineddddd, <br />\n    			pada waktu : 21:24:23, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993666345', 'N', 'N'),
(36, 7, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527797577659418 GAGAL <br>\n    			keterangan : aaaa, <br />\n    			pada waktu : 21:24:23, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993666345', 'N', 'N'),
(37, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 GAGAL <br>\n    			keterangan : ini keterangan, <br />\n    			pada waktu : 21:24:23, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993666345', 'N', 'N'),
(38, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 GAGAL <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 21:24:23, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993666345', 'N', 'N'),
(39, 5, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : undefined SUKSES <br>\n    			keterangan : undefineddddd, <br />\n    			pada waktu : 21:24:37, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993667751', 'N', 'N'),
(40, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 PENDING <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 21:25:44, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993674417', 'N', 'N'),
(41, 7, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527797577659418 SUKSES <br>\n    			keterangan : aaaa, <br />\n    			pada waktu : 21:25:44, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993674417', 'N', 'N'),
(42, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 PENDING <br>\n    			keterangan : ini keterangan, <br />\n    			pada waktu : 21:25:44, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993674417', 'N', 'N'),
(43, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 SUKSES <br>\n    			keterangan : ini keterangan, <br />\n    			pada waktu : 21:25:44, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993674417', 'N', 'N'),
(44, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 GAGAL <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 21:25:44, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993674417', 'N', 'N'),
(45, 7, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527797577659418 PENDING <br>\n    			keterangan : aaaa, <br />\n    			pada waktu : 21:25:44, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993674417', 'N', 'N'),
(46, 7, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527797577659418 GAGAL <br>\n    			keterangan : aaaa, <br />\n    			pada waktu : 21:25:44, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993674417', 'N', 'N'),
(47, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 PENDING <br>\n    			keterangan : ini keterangan, <br />\n    			pada waktu : 21:25:44, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993674417', 'N', 'N'),
(48, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 SUKSES <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 21:25:44, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993674417', 'N', 'N'),
(49, 5, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : undefined PENDING <br>\n    			keterangan : undefineddddd, <br />\n    			pada waktu : 21:25:44, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993674437', 'N', 'N'),
(50, 7, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527797577659418 PENDING <br>\n    			keterangan : aaaa, <br />\n    			pada waktu : 21:25:44, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993674437', 'N', 'N'),
(51, 7, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527797577659418 SUKSES <br>\n    			keterangan : aaaa, <br />\n    			pada waktu : 21:25:44, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993674437', 'N', 'N'),
(52, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 SUKSES <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 21:25:44, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993674437', 'N', 'N'),
(53, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 GAGAL <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 21:25:44, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993674437', 'N', 'N'),
(54, 7, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527797577659418 GAGAL <br>\n    			keterangan : aaaa, <br />\n    			pada waktu : 21:25:44, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993674437', 'N', 'N'),
(55, 7, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527797577659418 GAGAL <br>\n    			keterangan : aaaa, <br />\n    			pada waktu : 21:26:7, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993676737', 'N', 'N'),
(56, 5, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : undefined SUKSES <br>\n    			keterangan : undefineddddd, <br />\n    			pada waktu : 21:54:47, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993848760', 'N', 'N'),
(57, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 SUKSES <br>\n    			keterangan : ini keterangan, <br />\n    			pada waktu : 21:55:5, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993850548', 'N', 'N'),
(58, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 SUKSES <br>\n    			keterangan : SUKSES, <br />\n    			pada waktu : 21:55:23, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993852375', 'N', 'N'),
(59, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 GAGAL <br>\n    			keterangan : ini keterangan, <br />\n    			pada waktu : 21:55:40, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993854035', 'N', 'N');

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
  `lat` varchar(50) NOT NULL DEFAULT '-6.75',
  `lng` varchar(50) NOT NULL DEFAULT '106.75',
  `telepon_penerima` varchar(30) NOT NULL,
  `berat` varchar(10) NOT NULL,
  `kategori_paket` enum('REG','EXP') NOT NULL,
  `jenis_paket` enum('BRG','DKM') NOT NULL,
  `tarif` varchar(50) NOT NULL,
  `created_on` char(18) NOT NULL,
  `isSyn` enum('Y','N') NOT NULL DEFAULT 'N',
  `trash` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `paket_barang`
--

INSERT INTO `paket_barang` (`IDPaket`, `IDCabang`, `nama_paket`, `no_resi`, `nama_pengirim`, `alamat_pengirim`, `telepon_pengirim`, `nama_penerima`, `alamat_penerima`, `lat`, `lng`, `telepon_penerima`, `berat`, `kategori_paket`, `jenis_paket`, `tarif`, `created_on`, `isSyn`, `trash`) VALUES
(5, 2, 'Mouse Logitex', 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', 'Esa Unggul, Jalan Arjuna Utara, RT.1/RW.2, Duri Kepa, West Jakarta City, Jakarta', '0', '0', 'undefined', 'undefined', '', '', 'undefined', 'undefined', 'N', 'Y'),
(6, 1, 'Keyboard', 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', '-6.754611', '105.995811', 'undefined', 'undefined', '', '', 'undefined', 'undefined', 'N', 'Y'),
(7, 2, 'Makanan Burung', '1527797577659418', 'undefined', 'undefined', 'undefined', 'undefined', 'Tanahabang Station, Jalan Jati Baru Raya, Cideng, Central Jakarta City, Jakarta', '-6.757711', '106.301111', 'undefined', 'undefined', '', '', 'undefined', '1527797577659', 'N', 'N'),
(8, 1, 'Gembog', '1527799041488788', 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', '-6.768711', '106.251111', 'undefined', 'undefined', '', '', 'undefined', '1527799041488', 'N', 'N'),
(9, 2, 'Kotak', '1530132840174183', 'ricko', 'Jl. Laksamana Martadinata, Kotalama, Kedungkandang, Kota Malang, Jawa Timur, Indonesia', '121000111', 'koko', 'Jl. Anggrek, Merdeka, Sumur Bandung, Kota Bandung, Jawa Barat, Indonesia', '-6.75', '106.75', '25222454545', '1', 'REG', 'BRG', '10000', '1530132907111', 'N', 'N');

-- --------------------------------------------------------

--
-- Table structure for table `penempatan_detail`
--

CREATE TABLE `penempatan_detail` (
  `IDPenempatan` int(9) NOT NULL,
  `IDKurir` int(9) NOT NULL,
  `IDCabang` int(9) NOT NULL,
  `deskripsi_lokasi` varchar(255) NOT NULL,
  `latitude` varchar(30) NOT NULL,
  `longitude` varchar(30) NOT NULL,
  `isSyn` enum('Y','N') NOT NULL DEFAULT 'N',
  `created_on` char(18) NOT NULL,
  `trash` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `penempatan_detail`
--

INSERT INTO `penempatan_detail` (`IDPenempatan`, `IDKurir`, `IDCabang`, `deskripsi_lokasi`, `latitude`, `longitude`, `isSyn`, `created_on`, `trash`) VALUES
(1, 1, 1, 'Esa Unggul, Jalan Arjuna Utara, RT.1/RW.2, Duri Kepa, West Jakarta City, Jakarta', '-6.1857285', '106.7768755', 'N', '1528606080092', 'N');

-- --------------------------------------------------------

--
-- Table structure for table `penerimaan_paket`
--

CREATE TABLE `penerimaan_paket` (
  `IDPenerimaan` int(9) NOT NULL,
  `IDPaket` int(9) NOT NULL,
  `IDCabang` int(9) NOT NULL,
  `waktu_masuk` char(18) NOT NULL,
  `waktu_keluar` char(18) NOT NULL,
  `jenis_paket` enum('BRG','DKM') NOT NULL,
  `isSend` enum('Y','N') NOT NULL,
  `created_on` char(18) NOT NULL,
  `isSyn` enum('Y','N') NOT NULL DEFAULT 'N',
  `trash` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `penerimaan_paket`
--

INSERT INTO `penerimaan_paket` (`IDPenerimaan`, `IDPaket`, `IDCabang`, `waktu_masuk`, `waktu_keluar`, `jenis_paket`, `isSend`, `created_on`, `isSyn`, `trash`) VALUES
(1, 1, 1, '', '', 'BRG', 'N', '', 'N', 'N');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cabang`
--
ALTER TABLE `cabang`
  ADD PRIMARY KEY (`IDCabang`);

--
-- Indexes for table `harga_paket`
--
ALTER TABLE `harga_paket`
  ADD PRIMARY KEY (`IDHarga`);

--
-- Indexes for table `kurir`
--
ALTER TABLE `kurir`
  ADD PRIMARY KEY (`IDKurir`);

--
-- Indexes for table `list_pengiriman`
--
ALTER TABLE `list_pengiriman`
  ADD PRIMARY KEY (`IDPengiriman`);

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
-- Indexes for table `penempatan_detail`
--
ALTER TABLE `penempatan_detail`
  ADD PRIMARY KEY (`IDPenempatan`);

--
-- Indexes for table `penerimaan_paket`
--
ALTER TABLE `penerimaan_paket`
  ADD PRIMARY KEY (`IDPenerimaan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cabang`
--
ALTER TABLE `cabang`
  MODIFY `IDCabang` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `harga_paket`
--
ALTER TABLE `harga_paket`
  MODIFY `IDHarga` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `kurir`
--
ALTER TABLE `kurir`
  MODIFY `IDKurir` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `list_pengiriman`
--
ALTER TABLE `list_pengiriman`
  MODIFY `IDPengiriman` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `log_tracking`
--
ALTER TABLE `log_tracking`
  MODIFY `IDLog` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;
--
-- AUTO_INCREMENT for table `paket_barang`
--
ALTER TABLE `paket_barang`
  MODIFY `IDPaket` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `penempatan_detail`
--
ALTER TABLE `penempatan_detail`
  MODIFY `IDPenempatan` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `penerimaan_paket`
--
ALTER TABLE `penerimaan_paket`
  MODIFY `IDPenerimaan` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
