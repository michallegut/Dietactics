-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 12 Paź 2018, 14:43
-- Wersja serwera: 10.1.36-MariaDB
-- Wersja PHP: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `dietactics`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `meals`
--

CREATE TABLE `meals` (
  `id`       int(11)                             NOT NULL,
  `name`     varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(20) COLLATE utf8_unicode_ci NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `meals_inclusions`
--

CREATE TABLE `meals_inclusions` (
  `id`           int(11) NOT NULL,
  `grams`        int(11) NOT NULL,
  `meal_id`      int(11) NOT NULL,
  `meal_plan_id` int(11) NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `meal_plans`
--

CREATE TABLE `meal_plans` (
  `id`       int(11)                             NOT NULL,
  `name`     varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(20) COLLATE utf8_unicode_ci NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `meal_plans_assignments`
--

CREATE TABLE `meal_plans_assignments` (
  `id`           int(11)                             NOT NULL,
  `date`         date                                NOT NULL,
  `meal_plan_id` int(11)                             NOT NULL,
  `username`     varchar(20) COLLATE utf8_unicode_ci NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `products`
--

CREATE TABLE `products` (
  `id`            int(11)                             NOT NULL,
  `name`          varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `kilocalories`  decimal(10, 2)                      NOT NULL,
  `carbohydrates` decimal(10, 2)                      NOT NULL,
  `fats`          decimal(10, 2)                      NOT NULL,
  `proteins`      decimal(10, 2)                      NOT NULL,
  `username`      varchar(20) COLLATE utf8_unicode_ci NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `products_inclusions`
--

CREATE TABLE `products_inclusions` (
  `id`         int(11) NOT NULL,
  `grams`      int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `meal_id`    int(11) NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `username`             varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `password`             varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `kilocalories_demand`  int(11)                             NOT NULL,
  `carbohydrates_demand` int(11)                             NOT NULL,
  `fats_demand`          int(11)                             NOT NULL,
  `proteins_demand`      int(11)                             NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `weight_records`
--

CREATE TABLE `weight_records` (
  `id`       int(11)                             NOT NULL,
  `weight`   decimal(10, 1)                      NOT NULL,
  `date`     date                                NOT NULL,
  `username` varchar(20) COLLATE utf8_unicode_ci NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `meals`
--
ALTER TABLE `meals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Indeksy dla tabeli `meals_inclusions`
--
ALTER TABLE `meals_inclusions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meal_id` (`meal_id`),
  ADD KEY `meal_plan_id` (`meal_plan_id`);

--
-- Indeksy dla tabeli `meal_plans`
--
ALTER TABLE `meal_plans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Indeksy dla tabeli `meal_plans_assignments`
--
ALTER TABLE `meal_plans_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meal_plan_id` (`meal_plan_id`);

--
-- Indeksy dla tabeli `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Indeksy dla tabeli `products_inclusions`
--
ALTER TABLE `products_inclusions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meal_id` (`meal_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`);

--
-- Indeksy dla tabeli `weight_records`
--
ALTER TABLE `weight_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `meals`
--
ALTER TABLE `meals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `meals_inclusions`
--
ALTER TABLE `meals_inclusions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `meal_plans`
--
ALTER TABLE `meal_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `meal_plans_assignments`
--
ALTER TABLE `meal_plans_assignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `products_inclusions`
--
ALTER TABLE `products_inclusions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `weight_records`
--
ALTER TABLE `weight_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `meals`
--
ALTER TABLE `meals`
  ADD CONSTRAINT `meals_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `meals_inclusions`
--
ALTER TABLE `meals_inclusions`
  ADD CONSTRAINT `meals_inclusions_ibfk_1` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  ADD CONSTRAINT `meals_inclusions_ibfk_2` FOREIGN KEY (`meal_plan_id`) REFERENCES `meal_plans` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `meal_plans`
--
ALTER TABLE `meal_plans`
  ADD CONSTRAINT `meal_plans_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `meal_plans_assignments`
--
ALTER TABLE `meal_plans_assignments`
  ADD CONSTRAINT `meal_plans_assignments_ibfk_1` FOREIGN KEY (`meal_plan_id`) REFERENCES `meal_plans` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  ADD CONSTRAINT `meal_plans_assignments_ibfk_2` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `products_inclusions`
--
ALTER TABLE `products_inclusions`
  ADD CONSTRAINT `products_inclusions_ibfk_1` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  ADD CONSTRAINT `products_inclusions_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `weight_records`
--
ALTER TABLE `weight_records`
  ADD CONSTRAINT `weight_records_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
