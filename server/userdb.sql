-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 04, 2025 at 01:39 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `userdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(5) UNSIGNED NOT NULL,
  `user_id` int(5) UNSIGNED NOT NULL,
  `room_id` int(5) UNSIGNED NOT NULL,
  `slot_id` enum('slot_1','slot_2','slot_3','slot_4') NOT NULL,
  `status` tinyint(3) NOT NULL COMMENT '1=approved 2=Pending, 3 = Disapproved ',
  `approved_by` int(5) UNSIGNED DEFAULT NULL,
  `booking_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `user_id`, `room_id`, `slot_id`, `status`, `approved_by`, `booking_date`) VALUES
(67, 15, 13, 'slot_4', 1, 14, '2024-11-17'),
(68, 16, 12, 'slot_3', 3, 14, '2024-11-17'),
(69, 17, 13, 'slot_2', 3, 14, '2024-11-17'),
(70, 17, 13, 'slot_3', 1, 14, '2024-11-19'),
(71, 18, 13, 'slot_1', 1, 14, '2024-11-20');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `room_id` int(5) UNSIGNED NOT NULL,
  `room_name` varchar(255) NOT NULL,
  `slot_1` tinyint(4) NOT NULL COMMENT '1=free, 2=pending, 3=disable, 4=reserved',
  `slot_2` tinyint(4) NOT NULL COMMENT '1=free, 2=pending, 3=disable, 4=reserved',
  `slot_3` tinyint(4) NOT NULL COMMENT '1=free, 2=pending, 3=disable, 4=reserved',
  `slot_4` tinyint(4) NOT NULL COMMENT '1=free, 2=pending, 3=disable, 4=reserved',
  `img` varchar(255) NOT NULL,
  `size` tinyint(3) NOT NULL COMMENT '1=small, 2=medium, 3=large'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`room_id`, `room_name`, `slot_1`, `slot_2`, `slot_3`, `slot_4`, `img`, `size`) VALUES
(12, 'Meeting Room1', 1, 1, 1, 2, 'TableMediumRoom.png', 2),
(13, 'Meeting Room2', 4, 1, 4, 4, 'TableLargeRoom.png', 3),
(14, 'Meeting Room3', 1, 1, 1, 1, 'TableMediumRoom.png', 2),
(15, 'Test', 1, 1, 1, 1, 'TableMediumRoom.png', 2),
(35, 'Meeting Room5', 1, 1, 1, 1, 'TableSmallRoom.png', 1),
(36, 'Meeting Room5', 1, 1, 1, 1, 'TableMediumRoom.png', 2),
(42, 'Meeting Room6', 1, 1, 1, 1, 'TableLargeRoom.png', 3),
(43, 'Try', 1, 1, 1, 1, 'TableSmallRoom.png', 1),
(44, 'Test', 1, 1, 1, 1, 'TableLargeRoom.png', 3),
(45, 't', 1, 1, 1, 1, 'TableSmallRoom.png', 1),
(46, 'test1', 1, 1, 1, 1, 'TableSmallRoom.png', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(5) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `role` tinyint(3) UNSIGNED NOT NULL COMMENT '1 = student , 2 =staff, 3 = approver'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `email`, `username`, `password`, `name`, `role`) VALUES
(13, 'staff@lamduan.ac.th', 'staff', '$2b$10$Qv3hgIYppG/oj.Xt0Kl41OL/sNo7lEg0stESFhiL0JBVVX9Lz7UmS', '', 1),
(14, 'approver@lamduan.ac.th', 'approver', '$2b$10$35paTcGTt5Y2rFpVP1kbDey/ThnfET..8TdNI355w45ubiDCXtg4e', '', 1),
(15, 'xxx@gmail.com', 'Reyna', '$2b$10$WY./Ds1odpWksNP8BpRwp.NLgmYppuy7nWRxZkX5V/y1lqbnVdhgu', '', 1),
(16, 'user1', 'user1', '$2b$10$UUhW8hQNPa4feIWrjAK2xOMuu4n93JnAMRP6LqdWMbo1yE5hRxFa2', '', 0),
(17, '22', '22', '$2b$10$5ePUcbgugaWoRDzW2h/3XOvAykqHKMz1yZXEtI1Zexpd2G/xuN4bG', '', 0),
(18, '555', '555', '$2b$10$2ngxvLJ1IDlTvqyFtBYKWOJ7rwRkIKWM8OLearYZlSGyTqC8QBF0K', '', 1),
(19, 'test123', 'test', '$2b$10$6TmXDPQmQVV7eU03/.4KQ.1qi/wbw.NWLrjYQkozMTh0dWKFRaXwO', '', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `slot_id` (`slot_id`),
  ADD KEY `approved` (`approved_by`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`room_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`),
  ADD CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`approved_by`) REFERENCES `users` (`user_id`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `resetstatus` ON SCHEDULE EVERY 1 DAY STARTS '2024-11-12 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
UPDATE rooms SET slot_1 = 1 WHERE slot_1 != 1;
UPDATE rooms SET slot_2 = 1 WHERE slot_2 != 1;
UPDATE rooms SET slot_3 = 1 WHERE slot_3 != 1;
UPDATE rooms SET slot_4 = 1 WHERE slot_4 != 1;
END$$

CREATE DEFINER=`root`@`localhost` EVENT `Slot_1` ON SCHEDULE EVERY 1 DAY STARTS '2024-11-12 10:00:00' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE rooms SET slot_1 = 3 WHERE slot_1 != 3$$

CREATE DEFINER=`root`@`localhost` EVENT `Slot_2` ON SCHEDULE EVERY 1 DAY STARTS '2024-11-12 12:00:00' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE rooms SET slot_2 = 3 WHERE slot_2 != 3$$

CREATE DEFINER=`root`@`localhost` EVENT `Slot_3` ON SCHEDULE EVERY 1 DAY STARTS '2024-11-12 15:00:00' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE rooms SET slot_3 = 3 WHERE slot_3 != 3$$

CREATE DEFINER=`root`@`localhost` EVENT `Slot_4` ON SCHEDULE EVERY 1 DAY STARTS '2024-11-12 17:00:00' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE rooms SET slot_4 = 3 WHERE slot_4 != 3$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
