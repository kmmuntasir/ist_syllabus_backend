/*
Navicat MySQL Data Transfer

Source Server         : lampp
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : ist_syllabus

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2020-08-10 21:20:54
*/

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for `book`
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`
(
    `book_id`        int(10) unsigned                     NOT NULL AUTO_INCREMENT,
    `book_title`     varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `book_author`    varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
    `book_publisher` varchar(255) COLLATE utf8_unicode_ci          DEFAULT NULL,
    `book_edition`   varchar(255) COLLATE utf8_unicode_ci          DEFAULT NULL,
    `book_year`      year(4)                                       DEFAULT NULL,
    `book_pdf_url`   text COLLATE utf8_unicode_ci                  DEFAULT NULL,
    `is_deleted`     bit(1)                               NOT NULL DEFAULT b'0',
    PRIMARY KEY (`book_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

-- ----------------------------
-- Records of book
-- ----------------------------

-- ----------------------------
-- Table structure for `course`
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`
(
    `course_id`          int(10) unsigned                     NOT NULL AUTO_INCREMENT,
    `course_nature_id`   int(10) unsigned                     NOT NULL,
    `course_type_id`     int(10) unsigned                     NOT NULL,
    `semester_id`        int(10) unsigned                     NOT NULL,
    `course_code`        varchar(255) COLLATE utf8_unicode_ci          DEFAULT NULL,
    `course_title`       varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `course_total_mark`  double(10, 2)                        NOT NULL DEFAULT 0.00,
    `course_credit`      double(10, 2)                        NOT NULL DEFAULT 0.00,
    `course_class_hours` double(10, 2)                        NOT NULL DEFAULT 0.00,
    `course_content`     longtext COLLATE utf8_unicode_ci              DEFAULT NULL,
    `is_deleted`         bit(1)                               NOT NULL DEFAULT b'0',
    PRIMARY KEY (`course_id`),
    KEY `FK_course_1` (`course_nature_id`),
    KEY `FK_course_2` (`course_type_id`),
    KEY `FK_course_3` (`semester_id`),
    CONSTRAINT `FK_course_1` FOREIGN KEY (`course_nature_id`) REFERENCES `course_nature` (`course_nature_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_course_2` FOREIGN KEY (`course_type_id`) REFERENCES `course_type` (`course_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_course_3` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`semester_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

-- ----------------------------
-- Records of course
-- ----------------------------

-- ----------------------------
-- Table structure for `course_book`
-- ----------------------------
DROP TABLE IF EXISTS `course_book`;
CREATE TABLE `course_book`
(
    `course_book_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `course_id`      int(10) unsigned NOT NULL,
    `book_id`        int(10) unsigned NOT NULL,
    PRIMARY KEY (`course_book_id`),
    KEY `FK_course_book_1` (`course_id`),
    KEY `FK_course_book_2` (`book_id`),
    CONSTRAINT `FK_course_book_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_course_book_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

-- ----------------------------
-- Records of course_book
-- ----------------------------

-- ----------------------------
-- Table structure for `course_nature`
-- ----------------------------
DROP TABLE IF EXISTS `course_nature`;
CREATE TABLE `course_nature`
(
    `course_nature_id`   int(10) unsigned                     NOT NULL AUTO_INCREMENT,
    `course_nature_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `is_deleted`         bit(1)                               NOT NULL DEFAULT b'0',
    PRIMARY KEY (`course_nature_id`, `course_nature_name`),
    KEY `course_nature_id` (`course_nature_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

-- ----------------------------
-- Records of course_nature
-- ----------------------------
INSERT INTO `course_nature`
VALUES ('1', 'Theory', '');
INSERT INTO `course_nature`
VALUES ('2', 'Practical', '');
INSERT INTO `course_nature`
VALUES ('3', 'Combined', '');

-- ----------------------------
-- Table structure for `course_type`
-- ----------------------------
DROP TABLE IF EXISTS `course_type`;
CREATE TABLE `course_type`
(
    `course_type_id`   int(10) unsigned                     NOT NULL AUTO_INCREMENT,
    `course_type_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `is_deleted`       bit(1)                               NOT NULL DEFAULT b'0',
    PRIMARY KEY (`course_type_id`, `course_type_name`),
    KEY `course_type_id` (`course_type_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

-- ----------------------------
-- Records of course_type
-- ----------------------------
INSERT INTO `course_type`
VALUES ('1', 'Mandatory', '');
INSERT INTO `course_type`
VALUES ('2', 'Optional', '');

-- ----------------------------
-- Table structure for `major`
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major`
(
    `major_id`    int(10) unsigned NOT NULL AUTO_INCREMENT,
    `major_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `program_id`  int(10) unsigned NOT NULL,
    `is_deleted`  bit(1)           NOT NULL            DEFAULT b'0',
    PRIMARY KEY (`major_id`),
    KEY `FK_major_1` (`program_id`),
    CONSTRAINT `FK_major_1` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

-- ----------------------------
-- Records of major
-- ----------------------------

-- ----------------------------
-- Table structure for `manager`
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager`
(
    `manager_id`      int(10) unsigned                     NOT NULL AUTO_INCREMENT,
    `manager_user`    varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `manager_pass`    varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `manager_name`    varchar(255) COLLATE utf8_unicode_ci          DEFAULT '',
    `manager_phone`   varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `manager_address` varchar(255) COLLATE utf8_unicode_ci          DEFAULT '',
    `manager_email`   varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `is_deleted`      bit(1)                               NOT NULL DEFAULT b'0',
    `is_admin`        bit(1)                               NOT NULL DEFAULT b'0',
    `created_by`      int(10) unsigned                              DEFAULT NULL,
    PRIMARY KEY (`manager_id`, `manager_user`, `manager_email`),
    KEY `manager_id` (`manager_id`),
    KEY `manager_FK1` (`created_by`),
    CONSTRAINT `manager_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `manager` (`manager_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager`
VALUES ('1', 'thor', '202cb962ac59075b964b07152d234b70', 'Thor', '01264489484', 'Asgard', 'thor@gmail.com', '', '',
        null);

-- ----------------------------
-- Table structure for `program`
-- ----------------------------
DROP TABLE IF EXISTS `program`;
CREATE TABLE `program`
(
    `program_id`                  int(10) unsigned                     NOT NULL AUTO_INCREMENT,
    `program_title`               varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `program_total_credit`        double(10, 2)                                 DEFAULT 0.00,
    `program_starting_session`    year(4)                                       DEFAULT NULL,
    `program_introduction`        longtext COLLATE utf8_unicode_ci              DEFAULT NULL,
    `program_course_distribution` longtext COLLATE utf8_unicode_ci              DEFAULT NULL,
    `program_grading_system`      longtext COLLATE utf8_unicode_ci              DEFAULT NULL,
    `program_total_year`          int(10) unsigned                              DEFAULT NULL,
    `is_deleted`                  bit(1)                               NOT NULL DEFAULT b'0',
    PRIMARY KEY (`program_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 6
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

-- ----------------------------
-- Records of program
-- ----------------------------
INSERT INTO `program`
VALUES ('1', 'B.Sc in Computer Science and Engineering', '145.00', '2017', 'Introduction', 'Distribution',
        'Grading System', '4', '');
INSERT INTO `program`
VALUES ('2', 'B.Sc in Electronics and Communication Engineering', '147.00', '2018', 'Introduction', 'Distribution',
        'Grading System', '4', '');
INSERT INTO `program`
VALUES ('3', 'Bachelor of Business Administration', '126.00', '2017', 'Introduction', 'Distribution', 'Grading System',
        '4', '');
INSERT INTO `program`
VALUES ('4', 'Master of Computer Science and Engineering', '35.00', '2016', 'Introduction', 'Distribution',
        'Grading System', '1', '');
INSERT INTO `program`
VALUES ('5', 'Master of Business Administration', '35.00', '2016', 'Introduction', 'Distribution', 'Grading System',
        '1', '');

-- ----------------------------
-- Table structure for `semester`
-- ----------------------------
DROP TABLE IF EXISTS `semester`;
CREATE TABLE `semester`
(
    `semester_id`                int(10) unsigned       NOT NULL AUTO_INCREMENT,
    `program_id`                 int(10) unsigned       NOT NULL,
    `major_id`                   int(10) unsigned                DEFAULT NULL,
    `semester_mandatory_courses` int(11) unsigned       NOT NULL DEFAULT 0,
    `semester_optional_courses`  int(11) unsigned       NOT NULL DEFAULT 0,
    `semester_total_credit`      double(10, 2) unsigned NOT NULL DEFAULT 0.00,
    `semester_year`              int(10) unsigned                DEFAULT NULL,
    `is_deleted`                 bit(1)                 NOT NULL DEFAULT b'0',
    PRIMARY KEY (`semester_id`),
    KEY `FK_semester_1` (`major_id`),
    KEY `FK_semester_2` (`program_id`),
    CONSTRAINT `FK_semester_1` FOREIGN KEY (`major_id`) REFERENCES `major` (`major_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_semester_2` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

-- ----------------------------
-- Records of semester
-- ----------------------------
