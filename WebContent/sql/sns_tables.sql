/*
CREATE TABLE `s_member` (
  `uid` varchar(10) NOT NULL,
  `name` varchar(15) NOT NULL,
  `passwd` varchar(12) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
*/

CREATE TABLE `s_member` (
  `uid` varchar(10) NOT NULL,
  `name` varchar(15) NOT NULL,
  `passwd` varchar(12) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `date` datetime NOT NULL,
  `hobby` varchar(15) DEFAULT NULL,
  `birth` date DEFAULT NULL,
  `profile_photo_path` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
CREATE TABLE `s_message` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(15) NOT NULL,
  `msg` varchar(100) NOT NULL,
  `favcount` int(11) DEFAULT '0',
  `replycount` int(11) DEFAULT '0',
  `date` datetime NOT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
*/
CREATE TABLE `s_message` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(15) NOT NULL,
  `msg` varchar(100) NOT NULL,
  `favcount` int(11) DEFAULT '0',
  `replycount` int(11) DEFAULT '0',
  `date` datetime NOT NULL,
  `photo_path` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;


CREATE TABLE `s_reply` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) NOT NULL,
  `uid` varchar(12) NOT NULL,
  `date` datetime NOT NULL,
  `rmsg` varchar(50) NOT NULL,
  PRIMARY KEY (`rid`),
  KEY `message_FK_idx` (`mid`),
  CONSTRAINT `message_FK` FOREIGN KEY (`mid`) REFERENCES `s_message` (`mid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8;


CREATE TABLE `s_like` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(10) NOT NULL,
  `mid` int(11) NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='좋아요 관리 ';

