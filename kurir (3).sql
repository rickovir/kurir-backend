-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 09, 2018 at 11:40 PM
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
(1, 'Jakarta Barat', 'jalan laksa 2 no.88b', 'DKI Jakarta', '-6.1449657', '106.7873883', '192.168.1.30:3000', 'N', 'N', '1528606080092'),
(2, 'Jakarta Pusat', 'Tanahabang Station, Jalan Jati Baru Raya, Cideng, Central Jakarta City, Jakarta', 'DKI Jakarta', '-6.1857449', '106.8086437', '192.168.1.31:3000', 'N', 'N', '1528606118096');

-- --------------------------------------------------------

--
-- Table structure for table `detail_pengiriman_besar`
--

CREATE TABLE `detail_pengiriman_besar` (
  `IDDetailPengirimanBesar` int(9) NOT NULL,
  `IDListPengirimanBesar` int(9) NOT NULL,
  `IDPaket` int(9) NOT NULL,
  `created_on` varchar(18) NOT NULL,
  `trash` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detail_pengiriman_besar`
--

INSERT INTO `detail_pengiriman_besar` (`IDDetailPengirimanBesar`, `IDListPengirimanBesar`, `IDPaket`, `created_on`, `trash`) VALUES
(39, 23, 12, '1531118671747', 'N'),
(40, 23, 14, '1531118671747', 'N'),
(41, 25, 12, '1531169149034', 'N'),
(42, 25, 13, '1531169149034', 'N'),
(43, 26, 15, '1531169171156', 'N'),
(44, 27, 14, '1531169590533', 'N'),
(45, 28, 12, '1531169635540', 'N'),
(46, 28, 13, '1531169635540', 'N'),
(47, 28, 14, '1531169635540', 'N'),
(48, 29, 12, '1531169921505', 'N'),
(49, 29, 13, '1531169921505', 'N'),
(50, 30, 15, '1531170006155', 'N'),
(51, 30, 13, '1531170006155', 'N'),
(52, 31, 12, '1531170131535', 'N'),
(53, 31, 14, '1531170131535', 'N'),
(54, 32, 13, '1531170356671', 'N'),
(55, 32, 15, '1531170356671', 'N'),
(56, 33, 12, '1531170411807', 'N'),
(57, 33, 13, '1531170411807', 'N'),
(58, 33, 14, '1531170411807', 'N');

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
  `sessionID` varchar(255) NOT NULL,
  `isActive` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kurir`
--

INSERT INTO `kurir` (`IDKurir`, `nama_kurir`, `telepon`, `alamat`, `jenis`, `password`, `created_on`, `isSyn`, `trash`, `sessionID`, `isActive`) VALUES
(1, 'acung ', '123432234234', 'jalan laksa 2', 'MTR', '123', '1528606374904', 'N', 'Y', '', 'N'),
(2, 'usup', '9939330', 'jalan terate 2', 'MTR', '123', '1528606358205', 'N', 'Y', '', 'N'),
(3, 'dilan', '08965641522', 'Esa Unggul, Jalan Arjuna Utara, RT.1/RW.2, Duri Kepa, West Jakarta City, Jakarta', 'BSR', '123', '1528606286862', 'N', 'Y', '', 'N'),
(4, 'rickovir', '909090909', 'jalan laksa 2 no 88', 'MTR', '12345678', '1531004821590', 'N', 'Y', '', 'N'),
(5, 'rickovir', '909090909', 'jalan laksa 2 no 88', 'MTR', '12345678', '1531005524644', 'N', 'Y', '', 'N'),
(6, 'caca', '494949', 'ksdkfasdkfko', 'BSR', '123', '1531005775886', 'N', 'Y', '', 'N'),
(7, 'cacaws', '494949', 'ksdkfasdkfko', 'BSR', '123', '1531005863629', 'N', 'N', '', 'N'),
(8, 'ricko', '494949', 'ka,bomg', 'BSR', '9494948', '1531020390421', 'N', 'N', '', 'N'),
(9, 'dodottttaaa', '9494949', 'jalan sampai rumah aja', 'BSR', '2345', '1531034534320', 'N', 'N', '', 'N'),
(10, 'ricko vir', '3939393333', 'aljadf', 'MTR', 'asdf', '1531038040516', 'N', 'N', '', 'N');

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
-- Table structure for table `list_pengiriman_besar`
--

CREATE TABLE `list_pengiriman_besar` (
  `IDListPengirimanBesar` int(9) NOT NULL,
  `IDKurir` int(9) NOT NULL,
  `IDCabangTujuan` int(9) NOT NULL,
  `IDCabangAsal` int(9) NOT NULL,
  `isSend` enum('Y','N') NOT NULL DEFAULT 'N',
  `isCancel` enum('Y','N') NOT NULL DEFAULT 'N',
  `created_on` varchar(18) NOT NULL,
  `trash` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `list_pengiriman_besar`
--

INSERT INTO `list_pengiriman_besar` (`IDListPengirimanBesar`, `IDKurir`, `IDCabangTujuan`, `IDCabangAsal`, `isSend`, `isCancel`, `created_on`, `trash`) VALUES
(23, 9, 2, 1, 'N', 'Y', '1531118671653', 'N'),
(24, 8, 2, 1, 'N', 'Y', '1531168984274', 'N'),
(25, 8, 2, 1, 'N', 'Y', '1531169148919', 'N'),
(26, 7, 2, 1, 'N', 'Y', '1531169171070', 'N'),
(27, 8, 2, 1, 'N', 'Y', '1531169590463', 'N'),
(28, 8, 2, 1, 'N', 'Y', '1531169635424', 'N'),
(29, 8, 2, 1, 'N', 'Y', '1531169921375', 'N'),
(30, 9, 2, 1, 'N', 'Y', '1531170006096', 'N'),
(31, 8, 2, 1, 'N', 'Y', '1531170131464', 'N'),
(32, 9, 2, 1, 'N', 'Y', '1531170356609', 'N'),
(33, 9, 2, 1, 'N', 'Y', '1531170411713', 'N');

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
(59, 8, 'Pengiriman dengan resi : 1,\n    			oleh Kurir : 1527799041488788 GAGAL <br>\n    			keterangan : ini keterangan, <br />\n    			pada waktu : 21:55:40, <br >\n    			pada tanggal : 2018-6-25\n    			', '152993854035', 'N', 'N'),
(60, 12, 'Barang telah diterima di Cabang Jakarta Barat', '153099366931', 'N', 'N'),
(61, 13, 'Barang telah diterima di Cabang null', '153107793016', 'N', 'N'),
(62, 14, 'Barang telah diterima di Cabang null', '153107816114', 'N', 'N'),
(63, 15, 'Barang telah diterima di Cabang null', '153107820899', 'N', 'N'),
(67, 12, 'Barang sedang dalam pengiriman oleh 9 menuju cabang 2', '153111867182', 'N', 'N'),
(68, 14, 'Barang sedang dalam pengiriman oleh 9 menuju cabang 2', '153111867182', 'N', 'N'),
(69, 12, 'Barang sedang dalam pengiriman oleh 8 menuju cabang 2', '153116914912', 'N', 'N'),
(70, 13, 'Barang sedang dalam pengiriman oleh 8 menuju cabang 2', '153116914912', 'N', 'N'),
(71, 15, 'Barang sedang dalam pengiriman oleh 7 menuju cabang 2', '153116917122', 'N', 'N'),
(72, 14, 'Barang sedang dalam pengiriman oleh 8 menuju cabang 2', '153116959060', 'N', 'N'),
(73, 12, 'Barang sedang dalam pengiriman oleh 8 menuju cabang 2', '153116963562', 'N', 'N'),
(74, 13, 'Barang sedang dalam pengiriman oleh 8 menuju cabang 2', '153116963562', 'N', 'N'),
(75, 14, 'Barang sedang dalam pengiriman oleh 8 menuju cabang 2', '153116963562', 'N', 'N'),
(76, 12, 'Barang sedang dalam pengiriman oleh 8 menuju cabang 2', '153116992162', 'N', 'N'),
(77, 13, 'Barang sedang dalam pengiriman oleh 8 menuju cabang 2', '153116992162', 'N', 'N'),
(78, 15, 'Barang sedang dalam pengiriman oleh 9 menuju cabang 2', '153117000620', 'N', 'N'),
(79, 13, 'Barang sedang dalam pengiriman oleh 9 menuju cabang 2', '153117000620', 'N', 'N'),
(80, 12, 'Barang sedang dalam pengiriman oleh 8 menuju cabang 2', '153117013157', 'N', 'N'),
(81, 14, 'Barang sedang dalam pengiriman oleh 8 menuju cabang 2', '153117013157', 'N', 'N'),
(82, 13, 'Barang sedang dalam pengiriman oleh 9 menuju cabang 2', '153117035670', 'N', 'N'),
(83, 15, 'Barang sedang dalam pengiriman oleh 9 menuju cabang 2', '153117035670', 'N', 'N'),
(84, 12, 'Barang sedang dalam pengiriman oleh 9 menuju cabang 2', '153117041192', 'N', 'N'),
(85, 13, 'Barang sedang dalam pengiriman oleh 9 menuju cabang 2', '153117041192', 'N', 'N'),
(86, 14, 'Barang sedang dalam pengiriman oleh 9 menuju cabang 2', '153117041192', 'N', 'N'),
(87, 16, 'Barang telah diterima di Cabang null', '153117193608', 'N', 'N');

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
(5, 2, 'Mouse Logitex', 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', 'Esa Unggul, Jalan Arjuna Utara, RT.1/RW.2, Duri Kepa, West Jakarta City, Jakarta', '0', '0', 'undefined', 'undefined', '', '', 'undefined', 'undefined', 'Y', 'Y'),
(6, 1, 'Keyboard', 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', '-6.754611', '105.995811', 'undefined', 'undefined', '', '', 'undefined', 'undefined', 'N', 'Y'),
(7, 2, 'Makanan Burung', '1527797577659418', 'undefined', 'undefined', 'undefined', 'undefined', 'Tanahabang Station, Jalan Jati Baru Raya, Cideng, Central Jakarta City, Jakarta', '-6.757711', '106.301111', 'undefined', 'undefined', '', '', 'undefined', '1527797577659', 'N', 'Y'),
(8, 1, 'Lelekk uis', '1527799041488788', 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', '-6.768711', '106.251111', 'undefined', 'undefined', 'REG', '', 'undefined', '1527799041488', 'N', 'Y'),
(9, 2, 'sepatuaaa1`', '1527799041488781', 'kotak', 'Jl. Angkasa, RT.4/RW.9, Gn. Sahari Sel., Kemayoran, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta, Indonesia', 'undefined', 'undefined', 'undefined', '-6.75', '106.75', 'undefined', '10', 'REG', 'BRG', '100000', 'undefined', 'N', 'Y'),
(10, 1, 'Sepatunya gede', '1530748840936662', 'kupat', 'Jl. Karang Gayam Gg. Kuburan No.1, RT.004/RW.09, Tambaksari, Kota SBY, Jawa Timur 60136, Indonesia', '33983939', 'caa', 'Jl. Raya Jatiwaringin Blk. A No.11, RT.8/RW.7, Cipinang Melayu, Makasar, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13620, Indonesia', '-6.75', '106.75', '2333333333', '1', 'REG', 'BRG', '11000', '1530748921135', 'N', 'Y'),
(11, 2, 'dfsafasdfasd', '1530751590458339', 'ricko', 'Laksana, Kuta Alam, Banda Aceh City, Aceh, Indonesia', '23324234', 'coco', 'JL. Jaksa Agung Suprapto, No.40, Ruko Blok B3, Malang, Klojen, Malang City, East Java 65111, Indonesia', '-6.75', '106.75', '32343', '1', 'REG', 'DKM', '10000', '1530751718517', 'N', 'Y'),
(12, 2, 'Combro', '1530993607948292', 'Ricko', 'Jl. Laksamana Martadinata, Kotalama, Kedungkandang, Kota Malang, Jawa Timur, Indonesia', '949494949499', 'Dili', 'Cipondoh, Tangerang City, Banten, Indonesia', '-6.75', '106.75', '9393939393', '10', 'REG', 'BRG', '100000', '1530993669213', 'N', 'N'),
(13, 2, 'Kropo', '1531077867824458', 'ricko virnanda', 'Jl. Laksa II No.2, RT.1/RW.1, Jemb. Lima, Tambora, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11250, Indonesia', '93939939', 'Agus', 'Jl. KH Hasyim Ashari No.05, Nerogtog, Pinang, Kota Tangerang, Banten 15145, Indonesia', '-6.75', '106.75', '9455454545', '10', 'REG', 'BRG', '100000', '1531077930096', 'N', 'N'),
(14, 2, '112312312', '1531078102885916', 'dili', 'Jl. Casablanca, RT.7/RW.11, Menteng Dalam, Tebet, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta, Indonesia', '23423423', 'kotaa', 'Sunter Agung, Tanjung Priok, North Jakarta City, Jakarta, Indonesia', '-6.75', '106.75', '2323423423', '10', 'REG', 'BRG', '100000', '1531078160998', 'N', 'N'),
(15, 2, 'hujan', '1531078160998643', 'dina', 'Jl. Jaksa Agung Suprapto, Klojen, Kota Malang, Jawa Timur, Indonesia', '445454545', 'diah', 'Jl. Raya Jatiwaringin Blk. A No.11, RT.8/RW.7, Cipinang Melayu, Makasar, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13620, Indonesia', '-6.75', '106.75', '45454', '1', 'REG', 'BRG', '10000', '1531078208560', 'N', 'N'),
(16, 1, 'kokotaq', '1531171884916724', 'koko', 'Bekasi Regency, Tambelang, Bekasi, West Java, Indonesia', '1254545', 'koko', 'Koka, Tombulu, Minahasa Regency, North Sulawesi, Indonesia', '-6.75', '106.75', '111111', '1', 'REG', 'BRG', '11000', '1531171936011', 'N', 'N');

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
(1, 1, 1, 'Esa Unggul, Jalan Arjuna Utara, RT.1/RW.2, Duri Kepa, West Jakarta City, Jakarta', '-6.1857285', '106.7768755', 'N', '1528606080092', 'N'),
(2, 6, 1, 'Jakarta, Indonesia', '-6.17511', '106.86503949999997', 'N', '1531005775992', 'N'),
(3, 7, 1, 'Cipondoh, Tangerang City, Banten, Indonesia', '-6.186115999999999', '106.682188', 'N', '1531005863727', 'N'),
(4, 8, 1, 'Jl. Tol Jakarta - Cikampek, Jatibening, Pondokgede, Kota Bks, Jawa Barat, Indonesia', '-6.2569779', '106.94884830000001', 'N', '1531020391187', 'N'),
(5, 9, 1, 'Jl. Tol Jakarta - Cikampek, Jatibening, Pondokgede, Kota Bks, Jawa Barat, Indonesia', 'undefined', 'undefined', 'N', '1531034534484', 'N'),
(6, 10, 1, 'Jl. Soekarno Hatta, Cipadung Kidul, Panyileukan, Kota Bandung, Jawa Barat, Indonesia', '-6.935829099999999', '107.71131919999993', 'N', '1531038040675', 'N');

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
(1, 1, 1, '1530993669317', '1530993669317', 'BRG', 'N', '1530993669317', 'N', 'N'),
(2, 12, 1, '1530993669317', '1530993669317', 'BRG', 'Y', '1530993669317', 'N', 'N'),
(3, 13, 0, '1531077930168', '1531077930168', 'BRG', 'Y', '1531077930168', 'N', 'N'),
(4, 14, 0, '1531078161142', '1531078161142', 'BRG', 'Y', '1531078161142', 'N', 'N'),
(5, 15, 0, '1531078208997', '1531078208997', 'BRG', 'Y', '1531078208997', 'N', 'N'),
(6, 16, 1, '1531171936086', '1531171936086', 'BRG', 'Y', '1531171936086', 'N', 'N');

-- --------------------------------------------------------

--
-- Table structure for table `profile_cabang`
--

CREATE TABLE `profile_cabang` (
  `id` int(9) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `profile_cabang`
--

INSERT INTO `profile_cabang` (`id`, `nama`, `value`) VALUES
(1, 'NamaCabang', 'Jakarta Barat'),
(2, 'IDCabang', '1'),
(3, 'IP', '192.168.1.30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cabang`
--
ALTER TABLE `cabang`
  ADD PRIMARY KEY (`IDCabang`);

--
-- Indexes for table `detail_pengiriman_besar`
--
ALTER TABLE `detail_pengiriman_besar`
  ADD PRIMARY KEY (`IDDetailPengirimanBesar`);

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
-- Indexes for table `list_pengiriman_besar`
--
ALTER TABLE `list_pengiriman_besar`
  ADD PRIMARY KEY (`IDListPengirimanBesar`);

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
-- Indexes for table `profile_cabang`
--
ALTER TABLE `profile_cabang`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cabang`
--
ALTER TABLE `cabang`
  MODIFY `IDCabang` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `detail_pengiriman_besar`
--
ALTER TABLE `detail_pengiriman_besar`
  MODIFY `IDDetailPengirimanBesar` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
--
-- AUTO_INCREMENT for table `harga_paket`
--
ALTER TABLE `harga_paket`
  MODIFY `IDHarga` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `kurir`
--
ALTER TABLE `kurir`
  MODIFY `IDKurir` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `list_pengiriman`
--
ALTER TABLE `list_pengiriman`
  MODIFY `IDPengiriman` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `list_pengiriman_besar`
--
ALTER TABLE `list_pengiriman_besar`
  MODIFY `IDListPengirimanBesar` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `log_tracking`
--
ALTER TABLE `log_tracking`
  MODIFY `IDLog` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;
--
-- AUTO_INCREMENT for table `paket_barang`
--
ALTER TABLE `paket_barang`
  MODIFY `IDPaket` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `penempatan_detail`
--
ALTER TABLE `penempatan_detail`
  MODIFY `IDPenempatan` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `penerimaan_paket`
--
ALTER TABLE `penerimaan_paket`
  MODIFY `IDPenerimaan` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `profile_cabang`
--
ALTER TABLE `profile_cabang`
  MODIFY `id` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
