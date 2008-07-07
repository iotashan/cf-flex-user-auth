SET NAMES latin1;
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE `users` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_bin NOT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL,
  `verificationCode` varchar(35) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


SET FOREIGN_KEY_CHECKS = 1;
