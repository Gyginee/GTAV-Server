CREATE TABLE IF NOT EXISTS `bossmenu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) NOT NULL,
  `amount` int(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `job_name` (`job_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `bossmenu` (`id`, `job_name`, `amount`) VALUES
(1, 'police', 840280),
(2, 'ambulance', 5631706),
(3, 'realestate', 0),
(4, 'taxi', 0),
(5, 'cardealer', 0),
(6, 'mechanic', 2607467);

CREATE TABLE IF NOT EXISTS `gangmenu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) NOT NULL,
  `amount` int(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `job_name` (`job_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `gangmenu` (`id`, `job_name`, `amount`) VALUES
(1, 'lostmc', 0),
(2, 'ballas', 0),
(3, 'vagos', 0),
(4, 'cartel', 0),
(5, 'families', 0),
(6, 'triads', 0);
