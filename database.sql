SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `products`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

USE `products`;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `reviews`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `product_cards`;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `product_cards` (
                                 `id` int(11) NOT NULL AUTO_INCREMENT,
                                 `item` varchar(255) NOT NULL,
                                 `price` float NOT NULL,
                                 `description` text DEFAULT NULL,
                                 `image_url` varchar(500) DEFAULT NULL,
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `users` (
                         `id` int(11) NOT NULL AUTO_INCREMENT,
                         `username` varchar(50) NOT NULL,
                         `password` varchar(255) NOT NULL,
                         `role` enum('ADMIN','USER') DEFAULT 'USER',
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `reviews` (
                           `id` int(11) NOT NULL AUTO_INCREMENT,
                           `username` varchar(50) DEFAULT NULL,
                           `comment` text DEFAULT NULL,
                           `rating` int(11) DEFAULT NULL,
                           `product_id` int(11) DEFAULT NULL,
                           PRIMARY KEY (`id`),
                           KEY `product_id` (`product_id`),
                           CONSTRAINT `reviews_ibfk_1`
                               FOREIGN KEY (`product_id`)
                                   REFERENCES `product_cards` (`id`)
                                   ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `product_cards` (`id`, `item`, `price`, `description`, `image_url`) VALUES
                                                                                    (1, 'iPhone 15 Pro', 1199.99, 'Apple iPhone 15 Pro with A17 Pro chip, titanium design, 48MP camera system, and USB-C connectivity.', 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=500'),
                                                                                    (3, 'Sony WH-1000XM5', 349.99, 'Industry-leading noise cancelling headphones with 30-hour battery life and crystal clear hands-free calling.', 'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500'),
                                                                                    (4, 'MacBook Air M2', 1099.99, 'Apple MacBook Air with M2 chip, 13.6-inch Liquid Retina display, 18-hour battery life, fanless design.', 'https://images.unsplash.com/photo-1611186871525-9d1a8e6f27da?w=500'),
                                                                                    (5, 'Dell XPS 15', 1599.99, 'Dell XPS 15 with Intel Core i7, OLED display, NVIDIA GeForce RTX 4060, 32GB RAM, 1TB SSD.', 'https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=500'),
                                                                                    (6, 'iPad Pro 12.9"', 1099.99, 'Apple iPad Pro with M2 chip, Liquid Retina XDR display, Thunderbolt port, and Wi-Fi 6E support.', 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500'),
                                                                                    (7, 'Logitech MX Master 3S', 99.99, 'Advanced wireless mouse with ultra-fast MagSpeed scrolling, 8K DPI tracking, and ergonomic design.', 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=500'),
                                                                                    (8, 'Samsung 4K Monitor 27"', 449.99, '27-inch 4K UHD IPS monitor with 144Hz refresh rate, HDR600, USB-C 90W charging, and slim bezel design.', 'https://images.unsplash.com/photo-1585792180666-f7347c490ee2?w=500'),
                                                                                    (9, 'Mechanical Keyboard Keychron K2', 89.99, 'Compact wireless mechanical keyboard with RGB backlight, hot-swappable switches, and Mac/Windows compatibility.', 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500'),
                                                                                    (10, 'GoPro Hero 12 Black', 399.99, 'Action camera with 5.3K video, HyperSmooth 6.0 stabilization, waterproof to 10m, and HDR support.', 'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=500'),
                                                                                    (11, 'DJI Mini 4 Pro', 759.99, 'Foldable drone with 4K/60fps camera, 34-min flight time, omnidirectional obstacle sensing, and ActiveTrack.', 'https://images.unsplash.com/photo-1473968512647-3e447244af8f?w=500'),
                                                                                    (12, 'PlayStation 5', 499.99, 'Sony PS5 console with custom SSD, ray tracing, 4K gaming at 120fps, and DualSense haptic feedback controller.', 'https://images.unsplash.com/photo-1607853202273-232359d6f5c4?w=500'),
                                                                                    (13, 'Xbox Series X', 499.99, 'Microsoft Xbox Series X with 12 teraflops GPU, 1TB NVMe SSD, 4K 120fps gaming, and Quick Resume.', 'https://images.unsplash.com/photo-1621259182978-fbf93132d53d?w=500'),
                                                                                    (14, 'Apple Watch Series 9', 399.99, 'Apple Watch with S9 chip, Always-On Retina display, crash detection, ECG app, and 18-hour battery.', 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=500'),
                                                                                    (15, 'Bose QuietComfort 45', 279.99, 'Bose QC45 wireless headphones with world-class noise cancellation, 24-hour battery, and premium comfort.', 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500'),
                                                                                    (16, 'Anker 65W GaN Charger', 45.99, 'Compact 65W GaN charger with 3 ports (2 USB-C + 1 USB-A), supports PD 3.0 fast charging for all devices.', 'https://images.unsplash.com/photo-1583863788434-e58a36330cf0?w=500'),
                                                                                    (17, 'Raspberry Pi 5', 79.99, 'Latest Raspberry Pi single-board computer with 2.4GHz quad-core CPU, 8GB RAM, PCIe 2.0, and dual 4K display output.', 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=500'),
                                                                                    (18, 'SanDisk 1TB SSD Portable', 109.99, 'Ultra-fast portable SSD with up to 1050MB/s read speed, USB 3.2, shock-resistant, and pocket-sized design.', 'https://images.unsplash.com/photo-1597872200969-2b65d56bd16b?w=500'),
                                                                                    (19, 'Ring Video Doorbell Pro 2', 249.99, 'Smart doorbell with 3D motion detection, 1536p HD video, Head-to-Toe view, and built-in Alexa.', 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=500'),
                                                                                    (20, 'Philips Hue Starter Kit', 199.99, 'Smart lighting starter kit with 4 color bulbs, Hue Bridge, supports 16 million colors and voice control.', 'https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?w=500'),
                                                                                    (21, 'iPhone 15 Pro', 1199.99, 'Apple iPhone 15 Pro with A17 Pro chip, titanium design, 48MP camera system, and USB-C connectivity.', 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=500'),
                                                                                    (22, 'Samsung Galaxy S24 Ultra', 1299.99, 'Samsung flagship with 200MP camera, S Pen, Snapdragon 8 Gen 3, and 5000mAh battery.', 'https://images.unsplash.com/photo-1706193503113-b0de4c8e5f34?w=500'),
                                                                                    (23, 'Sony WH-1000XM5', 349.99, 'Industry-leading noise cancelling headphones with 30-hour battery life and crystal clear hands-free calling.', 'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500'),
                                                                                    (24, 'MacBook Air M2', 1099.99, 'Apple MacBook Air with M2 chip, 13.6-inch Liquid Retina display, 18-hour battery life, fanless design.', 'https://images.unsplash.com/photo-1611186871525-9d1a8e6f27da?w=500'),
                                                                                    (25, 'Dell XPS 15', 1599.99, 'Dell XPS 15 with Intel Core i7, OLED display, NVIDIA GeForce RTX 4060, 32GB RAM, 1TB SSD.', 'https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=500'),
                                                                                    (26, 'iPad Pro 12.9"', 1099.99, 'Apple iPad Pro with M2 chip, Liquid Retina XDR display, Thunderbolt port, and Wi-Fi 6E support.', 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500'),
                                                                                    (27, 'Logitech MX Master 3S', 99.99, 'Advanced wireless mouse with ultra-fast MagSpeed scrolling, 8K DPI tracking, and ergonomic design.', 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=500'),
                                                                                    (28, 'Samsung 4K Monitor 27"', 449.99, '27-inch 4K UHD IPS monitor with 144Hz refresh rate, HDR600, USB-C 90W charging, and slim bezel design.', 'https://images.unsplash.com/photo-1585792180666-f7347c490ee2?w=500'),
                                                                                    (29, 'Mechanical Keyboard Keychron K2', 89.99, 'Compact wireless mechanical keyboard with RGB backlight, hot-swappable switches, and Mac/Windows compatibility.', 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500'),
                                                                                    (30, 'GoPro Hero 12 Black', 399.99, 'Action camera with 5.3K video, HyperSmooth 6.0 stabilization, waterproof to 10m, and HDR support.', 'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=500'),
                                                                                    (31, 'DJI Mini 4 Pro', 759.99, 'Foldable drone with 4K/60fps camera, 34-min flight time, omnidirectional obstacle sensing, and ActiveTrack.', 'https://images.unsplash.com/photo-1473968512647-3e447244af8f?w=500'),
                                                                                    (32, 'PlayStation 5', 499.99, 'Sony PS5 console with custom SSD, ray tracing, 4K gaming at 120fps, and DualSense haptic feedback controller.', 'https://images.unsplash.com/photo-1607853202273-232359d6f5c4?w=500'),
                                                                                    (33, 'Xbox Series X', 499.99, 'Microsoft Xbox Series X with 12 teraflops GPU, 1TB NVMe SSD, 4K 120fps gaming, and Quick Resume.', 'https://images.unsplash.com/photo-1621259182978-fbf93132d53d?w=500'),
                                                                                    (34, 'Apple Watch Series 9', 399.99, 'Apple Watch with S9 chip, Always-On Retina display, crash detection, ECG app, and 18-hour battery.', 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=500'),
                                                                                    (35, 'Bose QuietComfort 45', 279.99, 'Bose QC45 wireless headphones with world-class noise cancellation, 24-hour battery, and premium comfort.', 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500'),
                                                                                    (36, 'Anker 65W GaN Charger', 45.99, 'Compact 65W GaN charger with 3 ports (2 USB-C + 1 USB-A), supports PD 3.0 fast charging for all devices.', 'https://images.unsplash.com/photo-1583863788434-e58a36330cf0?w=500'),
                                                                                    (37, 'Raspberry Pi 5', 79.99, 'Latest Raspberry Pi single-board computer with 2.4GHz quad-core CPU, 8GB RAM, PCIe 2.0, and dual 4K display output.', 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=500'),
                                                                                    (38, 'SanDisk 1TB SSD Portable', 109.99, 'Ultra-fast portable SSD with up to 1050MB/s read speed, USB 3.2, shock-resistant, and pocket-sized design.', 'https://images.unsplash.com/photo-1597872200969-2b65d56bd16b?w=500'),
                                                                                    (39, 'Ring Video Doorbell Pro 2', 249.99, 'Smart doorbell with 3D motion detection, 1536p HD video, Head-to-Toe view, and built-in Alexa.', 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=500'),
                                                                                    (40, 'Philips Hue Starter Kit', 199.99, 'Smart lighting starter kit with 4 color bulbs, Hue Bridge, supports 16 million colors and voice control.', 'https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?w=500');

INSERT INTO `users` (`id`, `username`, `password`, `role`) VALUES
                                                               (1, 'admin', 'admin123', 'ADMIN'),
                                                               (2, 'bia', 'pass123', 'USER');

INSERT INTO `reviews` (`id`, `username`, `comment`, `rating`, `product_id`) VALUES
                                                                                (1, 'john_doe', 'Amazing build quality and the camera is insane. Best iPhone ever!', 5, 1),
                                                                                (2, 'jane_smith', 'Great phone but very expensive. The titanium frame feels premium.', 4, 1),
                                                                                (3, 'ahmed_ali', 'Battery life could be better but overall a solid upgrade.', 4, 1),
                                                                                (4, 'mike_jordan', 'USB-C finally! The A17 Pro chip is blazing fast.', 5, 1),
                                                                                (8, 'john_doe', 'Best noise cancelling headphones I have ever used. Period.', 5, 3),
                                                                                (9, 'mike_jordan', 'Sound quality is exceptional. Great for long flights.', 5, 3),
                                                                                (10, 'jane_smith', 'Very comfortable but I wish they folded flat like the XM4.', 4, 3),
                                                                                (11, 'ahmed_ali', 'Battery lasts forever and ANC works perfectly even on metro.', 5, 3),
                                                                                (12, 'sara_hassan', 'Incredibly fast and silent. The fanless design is a game changer.', 5, 4),
                                                                                (13, 'chris_evans', 'Perfect laptop for developers. Battery life is unreal.', 5, 4),
                                                                                (14, 'layla_omar', 'Lightweight and powerful. Best laptop I have ever owned.', 5, 4),
                                                                                (15, 'john_doe', 'The OLED display is stunning. Great for creative work.', 5, 5),
                                                                                (16, 'mike_jordan', 'Runs a bit hot under load but performance is top tier.', 4, 5),
                                                                                (17, 'jane_smith', 'Build quality is excellent. Keyboard feels great to type on.', 4, 5),
                                                                                (18, 'ahmed_ali', 'The M2 chip makes this feel like a laptop. Incredibly fast.', 5, 6),
                                                                                (19, 'sara_hassan', 'Perfect for digital art with the Apple Pencil. Display is amazing.', 5, 6),
                                                                                (20, 'chris_evans', 'Expensive but worth it if you are in the Apple ecosystem.', 4, 6),
                                                                                (21, 'layla_omar', 'Best mouse I have ever used. The MagSpeed scroll is addictive.', 5, 7),
                                                                                (22, 'john_doe', 'Ergonomic and precise. My wrist pain is gone after switching to this.', 5, 7),
                                                                                (23, 'mike_jordan', 'Connects to 3 devices seamlessly. Perfect for multi-monitor setups.', 5, 7),
                                                                                (24, 'jane_smith', 'Colors are vivid and the 144Hz refresh rate makes everything smooth.', 5, 8),
                                                                                (25, 'ahmed_ali', 'USB-C charging is super convenient. Great monitor for the price.', 4, 8),
                                                                                (26, 'sara_hassan', 'Bezels are thin and the stand is adjustable. Solid build quality.', 4, 8),
                                                                                (27, 'chris_evans', 'Best budget mechanical keyboard. Switches feel amazing.', 5, 9),
                                                                                (28, 'layla_omar', 'Hot-swap feature is great. Changed switches easily without soldering.', 5, 9),
                                                                                (29, 'john_doe', 'Compact layout took some getting used to but I love it now.', 4, 9),
                                                                                (30, 'mike_jordan', 'HyperSmooth stabilization is incredible. Footage looks cinematic.', 5, 10),
                                                                                (31, 'jane_smith', 'Perfect for travel vlogging. Small, durable, and waterproof.', 5, 10),
                                                                                (32, 'ahmed_ali', 'Battery drains fast in 5.3K mode but quality is worth it.', 4, 10),
                                                                                (33, 'sara_hassan', 'Easy to fly and the footage is breathtaking. Highly recommend.', 5, 11),
                                                                                (34, 'chris_evans', 'Folds into my pocket. The obstacle sensing saved my drone twice!', 5, 11),
                                                                                (35, 'layla_omar', 'Wind resistance is impressive for such a small drone.', 4, 11),
                                                                                (36, 'john_doe', 'Loading times are near zero. DualSense haptics are next level.', 5, 12),
                                                                                (37, 'mike_jordan', 'Hard to find in stock but worth the wait. Gaming is incredible.', 5, 12),
                                                                                (38, 'jane_smith', 'Spider-Man 2 looks jaw-dropping on this console. Loving it.', 5, 12),
                                                                                (39, 'ahmed_ali', 'Game Pass is insane value. Quick Resume works like magic.', 5, 13),
                                                                                (40, 'sara_hassan', 'Powerful console. Runs every game at 4K 60fps minimum.', 5, 13),
                                                                                (41, 'chris_evans', 'Controller is the best in the industry. Very comfortable.', 4, 13),
                                                                                (42, 'layla_omar', 'Crash detection already works great. Love the fitness tracking.', 5, 14),
                                                                                (43, 'john_doe', 'Seamlessly integrates with iPhone. Battery lasts all day easily.', 4, 14),
                                                                                (44, 'mike_jordan', 'The double tap gesture is a small but very useful feature.', 4, 14),
                                                                                (45, 'jane_smith', 'So comfortable I forget I am wearing them. ANC is top notch.', 5, 15),
                                                                                (46, 'ahmed_ali', 'Great sound signature. Slightly less ANC than Sony but more comfortable.', 4, 15),
                                                                                (47, 'sara_hassan', 'Perfect for office work. Blocks out everything around me.', 5, 15),
                                                                                (48, 'chris_evans', 'Tiny but charges my MacBook, phone, and earbuds simultaneously.', 5, 16),
                                                                                (49, 'layla_omar', 'Great value. Replaced three bulky chargers with this one brick.', 5, 16),
                                                                                (50, 'john_doe', 'Gets warm but never hot. Does exactly what it promises.', 4, 16),
                                                                                (51, 'mike_jordan', 'Huge performance jump over Pi 4. Perfect for home server projects.', 5, 17),
                                                                                (52, 'jane_smith', 'Finally PCIe support! Running NVMe SSD on it is blazing fast.', 5, 17),
                                                                                (53, 'ahmed_ali', 'Great for learning Linux and programming. Worth every dollar.', 5, 17),
                                                                                (54, 'sara_hassan', 'Transfer speeds are insane. 1TB fits in my palm. Love it.', 5, 18),
                                                                                (55, 'chris_evans', 'Backed up my entire laptop in under 10 minutes. Impressive.', 5, 18),
                                                                                (56, 'layla_omar', 'Durable and fast. Dropped it twice with no data loss.', 4, 18),
                                                                                (57, 'john_doe', 'The 3D motion detection is very accurate. No more false alerts.', 4, 19),
                                                                                (58, 'mike_jordan', 'Easy installation and the app is intuitive. Great smart home device.', 4, 19),
                                                                                (59, 'jane_smith', 'Video quality is crystal clear even at night. Very impressed.', 5, 19),
                                                                                (60, 'ahmed_ali', 'Transforming my living room with these lights was so satisfying.', 5, 20),
                                                                                (61, 'sara_hassan', 'Setup was easy and the app has tons of options. Love the colors.', 5, 20),
                                                                                (62, 'chris_evans', 'Pricey but the quality and reliability of Hue is unmatched.', 4, 20);

ALTER TABLE `product_cards` AUTO_INCREMENT = 41;
ALTER TABLE `reviews` AUTO_INCREMENT = 63;
ALTER TABLE `users` AUTO_INCREMENT = 7;
