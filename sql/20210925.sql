-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2021-09-24 20:51:12
-- 伺服器版本： 10.4.21-MariaDB
-- PHP 版本： 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫: `tingweiengineering`
--

-- --------------------------------------------------------

--
-- 資料表結構 `construction_site`
--

CREATE TABLE `construction_site` (
  `工程位置` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `工程名稱` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `開始日期` date DEFAULT NULL,
  `預計結束日期` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 傾印資料表的資料 `construction_site`
--

INSERT INTO `construction_site` (`工程位置`, `工程名稱`, `開始日期`, `預計結束日期`) VALUES
('台北市', '勁辣雞腿堡', '2019-01-01', '2020-01-31'),
('台北市', '大麥克', '2019-01-01', '2019-01-02'),
('新北市', '火腿蛋餅', '2019-06-01', '2019-02-28'),
('新北市', '雙層牛肉堡', '2021-09-15', '2021-09-17');

-- --------------------------------------------------------

--
-- 資料表結構 `staff_list`
--

CREATE TABLE `staff_list` (
  `id` smallint(4) NOT NULL,
  `職位` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `帳號` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `密碼` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 傾印資料表的資料 `staff_list`
--

INSERT INTO `staff_list` (`id`, `職位`, `帳號`, `密碼`) VALUES
(1, 'boss', 'boss', '$2y$10$/h9udkJN.lz1FPCZFeQZa.xHroeJB3COwedUSCnCnpvmZrz1tSf1O'),
(2, 'manager', 'manager', '$2y$10$9ihD7/i8QmaNfS/Gnm7GZ.xLeRhvFiMJNB9SUV8c3YV8cPzIZoISS'),
(3, 'accountant', 'accountant', '$2y$10$1XGaW/KHjuHXOjBZmm4AvezImYJkH6SzdvEf1blZuM9ndyZtu8rru');

-- --------------------------------------------------------

--
-- 資料表結構 `working_record`
--

CREATE TABLE `working_record` (
  `id` smallint(6) NOT NULL,
  `上傳者` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `工程位置` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `工程名稱` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `工人數量` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `日期` date NOT NULL,
  `時間` time NOT NULL,
  `備註` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 傾印資料表的資料 `working_record`
--

INSERT INTO `working_record` (`id`, `上傳者`, `工程位置`, `工程名稱`, `工人數量`, `日期`, `時間`, `備註`) VALUES
(1, 'wwndbk', '台北市', '台北灣', '{\"模板\":3, \"掃地\":5}', '2021-09-05', '20:08:59', ''),
(2, 'oooptt', '台北市', '台北灣', '{\"模板\":3, \"掃地\":5}', '2021-09-05', '20:47:51', ''),
(3, 'oooptt', '台北市', '雙層牛肉', '{\"模板\":1, \"灌漿\":5}', '2021-09-06', '01:30:00', 'test'),
(4, 'oooptt', '台北市', '大麥克', '{\"模板\":1, \"灌漿\":5}', '2021-09-06', '01:38:00', ''),
(5, 'oooptt', '新北市', '大亨堡', '{\"模板\":2, \"灌漿\":5}', '2021-09-06', '11:49:00', ''),
(6, 'oooptt', '新北市', '大亨堡', '{\"模板\":3, \"灌漿\":5}', '2021-09-06', '19:12:00', '123'),
(7, 'oooptt', '台北市', '大麥克', '{\"模板\":1, \"灌漿\":5}', '2021-09-08', '20:52:00', '456'),
(8, 'manager', '新竹市', '牛肉', '{\"模板\":3, \"掃地\":5, \"灌漿\":12}', '2021-09-18', '01:09:11', ''),
(9, 'manager', '新竹市', '咖哩拌飯', '{\"模板\":10}', '2021-09-18', '01:51:20', ''),
(10, 'wwndbk', '新竹市', '肯德基', '{\"模板\":3, \"掃地\":5}', '2021-09-18', '21:19:07', ''),
(11, 'wwndbk', '新竹市', '肯德基', '{\"模板\":3, \"掃地\":5}', '2021-09-19', '21:19:07', ''),
(12, 'wwndbk', '新竹市', '肯德基1', '{\"灌漿\":3, \"掃地\":5}', '2021-09-18', '21:19:07', ''),
(13, 'wwndbk', '新竹市', '肯德基2', '{\"模板\":3, \"掃地\":5}', '2021-09-18', '21:19:07', ''),
(14, 'wwndbk', '新竹市', '肯德基3', '{\"模板\":3, \"掃地\":5}', '2021-09-18', '21:19:07', ''),
(15, 'wwndbk', '新竹市', '肯德基4', '{\"模板\":3, \"掃地\":5}', '2021-09-18', '21:19:07', '');

-- --------------------------------------------------------

--
-- 資料表結構 `working_record2`
--

CREATE TABLE `working_record2` (
  `id` int(11) NOT NULL,
  `工程名稱` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `日期` date NOT NULL,
  `負責人` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `請款人` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `工數` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `工種` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `工作內容` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `扣工明細` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `工錢` int(11) NOT NULL,
  `總額` int(11) NOT NULL,
  `補請款` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `working_record2`
--

INSERT INTO `working_record2` (`id`, `工程名稱`, `日期`, `負責人`, `請款人`, `工數`, `工種`, `工作內容`, `扣工明細`, `工錢`, `總額`, `補請款`) VALUES
(1, '台北灣七期', '2021-09-15', '莊政勳', '莊政勳', '0.5', '打石工', '整理工地', '公司', 3000, 1500, 0),
(2, '台北灣七期', '2021-09-15', '莊政勳', '莊政勳', '0.5', '打石工', '整理工地', '簡義雄0.07王建興0.06江興福0.1項嘉民0.16林國明0.04曹守杰0.07', 2500, 1250, 0),
(3, '台北灣七期', '2021-09-15', '杜燕玲', '杜燕玲', '1', '打石工', 'G棟7-8F牆壁木板打除', '簡義雄0.34王建興0.27江興福0.39', 3000, 3000, 0),
(4, '台北灣七期', '2021-09-15', '華秀琴', '華秀琴', '3', '打石工', 'B棟2-8F清碎石', '簡義雄0.76項嘉民1.68林國明0.37郭慶清0.19', 2000, 6000, 1),
(5, '欣巴巴', '2021-09-15', '杜燕玲', '杜燕玲', '3', '打石工', '4-7F前後陽台大肚修打\n11-12F樓梯牆壁吊線大肚修打', '楊仲康2楊春德1', 2000, 6000, 0),
(6, '欣巴巴', '2021-09-15', '善德', '善德', '1', '打石工', 'A棟10-12F梯廳吊線修打', '陳文勇0.31項嘉文0.69', 2000, 2000, 0),
(7, '欣巴巴', '2021-09-15', '善德', '善德', '1', '打石工', 'A棟9F室內吊線修打', '陳文勇0.31項嘉文0.69', 2000, 2000, 0),
(8, '欣巴巴', '2021-09-15', '善德', '善德', '1', '打石工', 'A棟14F外露陽台地坪高度', '營造請', 2000, 2000, 0),
(9, '亞昕延北', '2021-09-15', '善德', '善德', '1', '打石工', '打9樓未留窗戶', '蘇志成', 2000, 2000, 0),
(11, '亞昕延北', '2021-09-15', '祥譽', '祥譽', '1', '打石工', '9~10樓外牆螺桿點防銹漆', '公司', 2000, 2000, 0),
(12, '亞昕延北', '2021-09-15', '祥譽', '祥譽', '4', '打石工', '施工電梯載垃圾至14樓倒', '公司', 2000, 8000, 0),
(13, '昕悅灣', '2021-09-15', '善德', '善德', '1', '打石工', '19FA5、A6室內牆牆面打石', '陳義廣(陳孟契)', 2000, 2000, 0),
(14, '昕悅灣', '2021-09-15', '善德', '善德', '1', '打石工', 'B梯梯階打石', '張智強', 2000, 2000, 0),
(15, '基隆德安段', '2021-09-15', '李東', '李東', '3', '打石工', '13-15樓外牆及室內吊線打石', '徐宗財1、林孝恩1、華大成1', 2000, 6000, 1),
(16, '基隆德安段', '2021-09-15', '蔡坤木', '蔡坤木', '10', '打石工', 'R1墩座施作、拆模', '公司', 2000, 20000, 0),
(17, '基隆德安段', '2021-09-15', '蔡坤木', '蔡坤木', '4', '打石工', '1F樓梯施作', '公司', 2000, 8000, 0),
(18, '基隆德安段', '2021-09-15', '蔡坤木', '蔡坤木', '1', '打石工', '補作橋梁', '徐宗財', 2000, 2000, 0),
(19, '基隆德安段', '2021-09-15', '蔡坤木', '蔡坤木', '0.5', '打石工', '補作橋梁', '陳天中', 2000, 1000, 0),
(20, '基隆德安段', '2021-09-15', '蔡坤木', '蔡坤木', '1', '打石工', '防颱', '公司', 2000, 2000, 0),
(21, '基隆德安段', '2021-09-15', '蔡坤木', '蔡坤木', '12', '打石工', '開會、吊料、整理現場', '公司', 2000, 24000, 0),
(22, '德安段C區', '2021-09-15', '蔡坤木', '蔡坤木', '2', '打石工', '防颱', '公司', 2000, 4000, 0),
(23, '德安段C區', '2021-09-15', '蔡坤木', '蔡坤木', '34.5', '打石工', '開會、吊料、整理現場', '公司', 2000, 69000, 0),
(24, '台北灣七期', '2021-09-16', '莊政勳', '莊政勳', '0.5', '打石工', '整理工地', '公司', 2000, 1000, 0),
(25, '台北灣七期', '2021-09-16', '莊政勳', '莊政勳', '0.5', '打石工', '整理工地', '簡義雄0.07王建興0.06江興福0.1項嘉民0.16林國明0.04曹守杰0.07', 2000, 1000, 0),
(26, '台北灣七期', '2021-09-16', '杜燕玲', '杜燕玲', '1', '打石工', 'G棟8F室內牆壁吊線大肚修打', '曹守杰0.25簡義雄0.75', 2000, 2000, 1),
(27, '亞昕延北', '2021-09-16', '善德', '善德', '1', '打石工', '打8樓室內吊線牆', '張鏡輝', 2000, 2000, 0),
(28, '亞昕延北', '2021-09-16', '祥譽', '祥譽', '2', '打石工', '拆3~12樓管道間角材', '公司', 2000, 4000, 0),
(36, '欣巴巴', '2021-09-16', '善德', '善德', '1', '打石工', 'A棟10F室內吊線修打', '陳文勇0.38、項嘉民0.62', 2000, 2000, 0),
(37, '欣巴巴', '2021-09-16', '善德', '善德', '1', '打石工', 'A棟13F陽台天花板修打', '陳文勇0.44、項嘉民0.56', 2000, 2000, 0),
(38, '欣巴巴', '2021-09-16', '善德', '善德', '1', '打石工', 'A棟11F室內吊線修打', '楊春德1、陳文勇1', 2000, 2000, 0),
(39, '欣巴巴', '2021-09-16', '杜燕玲', '杜燕玲', '3', '打石工', '11F-14F外牆壁吊線打石', '公司', 2000, 6000, 0),
(40, '昕悅灣', '2021-09-16', '善德', '善德', '1', '打石工', '1F兒童遊戲室內牆面打石', '顏有貝', 2000, 2000, 0),
(41, '昕悅灣', '2021-09-16', '善德', '善德', '1', '打石工', '19FA1B1室內內牆面打石', '張志強', 2000, 2000, 0),
(42, '基隆德安段', '2021-09-16', '李東', '李東', '4', '打石工', '15F,R1F,R2F外牆吊線打石', '蔡坤木1工，陳天中1工，華大成1工，徐宗財0.5工，林連蘭秀0.5工', 2000, 8000, 1),
(43, '台北灣七期', '2021-09-17', '莊政勳', '莊政勳', '0.5', '打石工', '整理工地', '簡義雄0.07王建興0.06江興福0.1項嘉民0.16林國明0.04曹守杰0.07', 2000, 1000, 0),
(44, '台北灣七期', '2021-09-17', '莊政勳', '莊政勳', '0.5', '打石工', '整理工地', '公司', 2000, 1000, 0),
(45, '台北灣七期', '2021-09-17', '杜燕玲', '杜燕玲', '1', '打石工', '7-8F外牆壁吊線修打', '曹守杰0.25、簡義雄0.75', 2000, 2000, 0),
(46, '亞昕延北', '2021-09-17', '善德', '善德', '1', '打石工', '打22-23樓A4戶窗框', '張鏡輝', 2000, 2000, 0),
(47, '亞昕延北', '2021-09-17', '祥譽', '祥譽', '0.5', '打石工', '施工電梯載保麗龍至27樓', '公司', 2000, 1000, 1),
(48, '亞昕延北', '2021-09-17', '祥譽', '祥譽', '1', '打石工', '清7、8樓打石土屑', '張鏡輝0.2蘇志成0.8', 2000, 2000, 0),
(49, '亞昕延北', '2021-09-17', '祥譽', '祥譽', '1', '打石工', '清22-23樓打石土屑', '張鏡輝', 2000, 2000, 0),
(50, '昕悅灣', '2021-09-17', '善德', '善德', '1', '打石工', '19FB1B2室內內牆面打石', '顏有貝', 2000, 2000, 0),
(51, '昕悅灣', '2021-09-17', '善德', '善德', '1', '打石工', '1F兒童遊戲室內內牆面打石', '張智強', 2000, 2000, 0),
(52, '欣巴巴', '2021-09-17', '善德', '善德', '1', '打石工', 'A棟10-12F室內吊線修打', '陳文勇0.31、項嘉民0.69', 2000, 2000, 0),
(53, '欣巴巴', '2021-09-17', '善德', '善德', '1', '打石工', 'A棟2-4F排水管路修打', '陳文勇0.38、項嘉民0.62', 2000, 2000, 0),
(54, '欣巴巴', '2021-09-17', '善德', '善德', '1', '打石工', 'A棟中庭11-R3內側柱修打', '陳文勇0.44、項嘉民0.56', 2000, 2000, 0),
(55, '欣巴巴', '2021-09-17', '杜燕玲', '杜燕玲', '2', '打石工', 'B棟1-3F左右樓梯背倒吊清水模打毛', '楊春德1、陳文勇1', 2000, 4000, 0),
(56, '欣巴巴', '2021-09-17', '杜燕玲', '杜燕玲', '1', '打石工', '12F吊線外牆壁修打', '項嘉民', 2000, 2000, 0),
(57, '基隆德安段', '2021-09-17', '李東', '李東', '4', '打石工', 'R1F,R2F外牆吊線及女兒牆螺桿鐵線打除', '蔡坤木1工，陳天中1工，華大成1工，徐宗財0.5工，林連秀蘭0.5工', 2000, 8000, 0);

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `construction_site`
--
ALTER TABLE `construction_site`
  ADD PRIMARY KEY (`工程名稱`);

--
-- 資料表索引 `staff_list`
--
ALTER TABLE `staff_list`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `working_record`
--
ALTER TABLE `working_record`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `working_record2`
--
ALTER TABLE `working_record2`
  ADD PRIMARY KEY (`id`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `staff_list`
--
ALTER TABLE `staff_list`
  MODIFY `id` smallint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9223372036854775807;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `working_record`
--
ALTER TABLE `working_record`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `working_record2`
--
ALTER TABLE `working_record2`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
