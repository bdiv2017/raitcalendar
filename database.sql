-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jan 12, 2017 at 03:54 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `rait_calendar_sys`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root1`@`localhost` PROCEDURE `add_cal_event`(IN web_u_name varchar(30),IN http_x varchar(45),IN remote_add varchar(45),IN e_name VARCHAR(30) , IN s_date date, IN e_date date, IN e_desc varchar(500), IN e_location varchar(30),OUT c_success int)
BEGIN
#declare userid varchar(30);
IF e_name IS NOT NULL and s_date is not null and e_date IS NOT NULL and e_desc IS NOT NULL and web_u_name IS NOT NULL THEN
#set @userid=web_u_name;
#set @userid='vfdvf';
set @http_x_forwarded_for=http_x;
set @remote_addr=remote_add;
INSERT INTO `rait_calendar_sys`.`cal_events`( `event_id`,`event_name`, `start_date`, `end_date`, `event_desc`, `location`,`web_user`) VALUES (null ,e_name , s_date,e_date , e_desc , e_location ,web_u_name);
set c_success:=0;
#set @userid= null;
set @http_x_forwarded_for=null;
set @remote_addr=null;
END IF;
set c_success:=1;
END$$

CREATE DEFINER=`root1`@`localhost` PROCEDURE `procedure_to_populate_log_table`(IN actioni VARCHAR(10) , IN ts timestamp,IN useri varchar(30), IN web_useri varchar(30), IN old_event_idi int, IN old_event_namei varchar(30), IN old_start_datei date,IN old_end_datei date,IN old_event_desci varchar(500),IN old_locationi varchar(30), IN new_event_idi int, IN new_event_namei varchar(30), IN new_start_datei date,IN new_end_datei date,IN new_event_desci varchar(500),IN new_locationi varchar(30),IN http_x_forwarded_fori varchar(45),IN remote_addri varchar(45))
BEGIN
#insert into temp (v)values(@userid);

INSERT INTO `rait_calendar_sys`.`cal_events_log`(`log_id`, `action`, `action_time`, `user`,`web_user`, `old_event_id`, `old_event_name`, `old_start_date`, `old_end_date`, `old_event_desc`, `old_location`, `new_event_id`, `new_event_name`, `new_start_date`, `new_end_date`, `new_event_desc`, `new_location`,`http_x_forwarded_for`,`remote_addr`)
 VALUES (null,actioni  ,  ts ,useri,  web_useri ,  old_event_idi , old_event_namei , old_start_datei, old_end_datei,old_event_desci,old_locationi ,new_event_idi,new_event_namei,new_start_datei,new_end_datei,new_event_desci,new_locationi,http_x_forwarded_fori,remote_addri);


END$$

--
-- Functions
--
CREATE DEFINER=`root1`@`localhost` FUNCTION `add_cal_event`(web_u_name varchar(30),http_x varchar(45),remote_add varchar(45),e_name VARCHAR(30) ,s_date date,e_date date, e_desc varchar(500), e_location varchar(30)) RETURNS tinyint(1)
BEGIN
declare c_success boolean;
IF e_name IS NOT NULL and s_date is not null and e_date IS NOT NULL and e_desc IS NOT NULL and web_u_name IS NOT NULL THEN
#set @userid=web_u_name;
set @http_x_forwarded_for=http_x;
set @remote_addr=remote_add;
INSERT INTO `rait_calendar_sys`.`cal_events`( `event_id`,`event_name`, `start_date`, `end_date`, `event_desc`, `location`,`web_user`) VALUES (null ,e_name , s_date,e_date , e_desc , e_location ,web_u_name);
set c_success:=false;
#set @userid=null;
set @http_x_forwarded_for=null;
set @remote_addr=null;
return c_success;
END IF;
set c_success:=true;
return c_success;
END$$

CREATE DEFINER=`root1`@`localhost` FUNCTION `add_user`(uid varchar(30),uname varchar(30), pwd varchar(30)) RETURNS tinyint(1)
BEGIN
declare c_success boolean;
IF uid IS NOT NULL and uname is not null and pwd IS NOT NULL THEN
#set @userid=web_u_name;
#set @http_x_forwarded_for=http_x;
#set @remote_addr=remote_add;
INSERT INTO `rait_calendar_sys`.`usertable`( `id`,`userid`,`username`,`password`) VALUES (null,uid,uname,HEX(pwd));
set c_success:=false;
#set @userid=null;
#set @http_x_forwarded_for=null;
#set @remote_addr=null;
return c_success;
END IF;
set c_success:=true;
return c_success;
END$$

CREATE DEFINER=`root1`@`localhost` FUNCTION `del_cal_event`(web_u_name varchar(30),http_x varchar(45),remote_add varchar(45),e_id int ) RETURNS tinyint(1)
BEGIN
declare c_success boolean;
IF e_id IS NOT NULL THEN
#set @userid=web_u_name;
set @http_x_forwarded_for=http_x;
set @remote_addr=remote_add;
Delete from `rait_calendar_sys`.`cal_events` where event_id=e_id;
set c_success:=false;
#set @userid=null;
set @http_x_forwarded_for=null;
set @remote_addr=null;
return c_success;
END IF;
set c_success:=true;
return c_success;
END$$

CREATE DEFINER=`root1`@`localhost` FUNCTION `del_user`(uid varchar(30)) RETURNS tinyint(1)
BEGIN
declare c_success boolean;
IF uid IS NOT NULL THEN
#set @userid=web_u_name;
#set @http_x_forwarded_for=http_x;
#set @remote_addr=remote_add;
Delete from `rait_calendar_sys`.`usertable` where userid=uid;
set c_success:=false;
#set @userid=null;
#set @http_x_forwarded_for=null;
#set @remote_addr=null;
return c_success;
END IF;
set c_success:=true;
return c_success;
END$$

CREATE DEFINER=`root1`@`localhost` FUNCTION `get_event_name`(eid int) RETURNS varchar(30) CHARSET latin1
BEGIN
set @c_success=null;
IF eid IS NOT NULL  THEN
#set @userid=web_u_name;
#set @http_x_forwarded_for=http_x;
#set @remote_addr=remote;
#set @a='';# MySQL returned an empty result set (i.e. zero rows).
SELECT event_name into @c_success FROM `rait_calendar_sys`.`cal_events` WHERE `event_id`=eid;
#set c_success:=false;
#set @userid=null;
#set @http_x_forwarded_for=null;
#set @remote_addr=null;
return @c_success;
END IF;
set @c_success=null;
return @c_success;
END$$

CREATE DEFINER=`root1`@`localhost` FUNCTION `update_cal_event`(web_u_name varchar(30),http_x varchar(45),remote_add varchar(45),e_id int,e_name VARCHAR(30) ,s_date date,e_date date, e_desc varchar(500), e_location varchar(30)) RETURNS tinyint(1)
BEGIN
declare c_success boolean;
IF e_name IS NOT NULL and s_date is not null and e_date IS NOT NULL and e_desc IS NOT NULL and web_u_name IS NOT NULL THEN
#set @userid=web_u_name;
set @http_x_forwarded_for=http_x;
set @remote_addr=remote_add;
update `rait_calendar_sys`.`cal_events` set `event_name`=e_name, `start_date`=s_date, `end_date`=e_date, `event_desc`=e_desc, `location`=e_location,`web_user`=web_u_name where `event_id`=e_id;
set c_success:=false;
#set @userid=null;
set @http_x_forwarded_for=null;
set @remote_addr=null;
return c_success;
END IF;
set c_success:=true;
return c_success;
END$$

CREATE DEFINER=`root1`@`localhost` FUNCTION `up_user`(uid varchar(30),uname varchar(30), pwd varchar(30)) RETURNS tinyint(1)
BEGIN
declare c_success boolean;
IF uid IS NOT NULL and uname is not null and pwd IS NOT NULL THEN
#set @userid=web_u_name;
#set @http_x_forwarded_for=http_x;
#set @remote_addr=remote_add;
update `rait_calendar_sys`.`usertable` set `username`=uname, `password`=HEX(pwd) where `userid`=uid;
set c_success:=false;
#set @userid=null;
#set @http_x_forwarded_for=null;
#set @remote_addr=null;
return c_success;
END IF;
set c_success:=true;
return c_success;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `user` varchar(50) NOT NULL,
  `pass` varchar(50) NOT NULL,
  PRIMARY KEY (`user`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`user`, `pass`) VALUES
('admin', 'b0c069b21e9688b05894a3329461d572');

-- --------------------------------------------------------

--
-- Table structure for table `cal_events`
--

CREATE TABLE IF NOT EXISTS `cal_events` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `event_desc` varchar(500) NOT NULL,
  `location` varchar(30) NOT NULL,
  `web_user` varchar(30) NOT NULL,
  `branch` varchar(50) NOT NULL,
  `category` varchar(50) NOT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=232 ;

--
-- Dumping data for table `cal_events`
--

INSERT INTO `cal_events` (`event_id`, `event_name`, `start_date`, `end_date`, `event_desc`, `location`, `web_user`, `branch`, `category`) VALUES
(1, 'Test', '2015-08-14', '2015-08-14', 'test', 'test', 'ss', 'IT', 'Placements'),
(2, 'Faculty Meetting', '2015-08-31', '2015-08-31', 'NAAC work review', '112C', 'hodin', '', ''),
(3, 'Workshop on PCB Design', '2015-08-10', '2015-08-14', 'This is a free workshop for third and fourth year students.', 'Lab. 201 and 208', 'hoden', '', ''),
(4, 'Workshop on Rasberry Pi', '2015-08-17', '2015-08-18', 'A workshop is arranged by EXTC department in association with IETE-RAIT.', 'Lab. 201', 'hoden', '', ''),
(5, 'NBA FILES - Meeting', '2015-08-24', '2015-08-24', 'All HODs &amp; Faculty handling NBA Files requested to attend', 'Principal Chambers', 'principal', '', ''),
(6, 'Youth &amp; Communal Harmony- ', '2015-08-31', '2015-08-31', 'Youth &amp; Communal Harmony- School of Eduction', 'Room No 615', 'pa', '', ''),
(10, 'Role of Instrumentation Engg. ', '2015-09-03', '2015-09-03', 'Dept. of Instrumentation Engg Role of Instrumentation Engg. in Corporat World', 'Room No 615', 'pa', '', ''),
(11, 'The Art of Control', '2015-09-02', '2015-09-02', 'The Art of Control - by ISKCON, Juhu, Mumbai - 10.30 to 12.30', 'Room No 615', 'pa', '', ''),
(12, 'Placement Preparation Talk', '2015-09-02', '2015-09-02', 'Placement Preparation Talk 3.00pm onwards.', 'Room No 615', 'pa', '', ''),
(13, 'Placement Preparation Talk', '2015-09-03', '2015-09-03', 'Placement Preparation Talk 3.00pm onwards', 'Room No 615', 'pa', '', ''),
(14, 'Workshop', '2015-09-16', '2015-09-16', 'Network Security workshop for UG and PG', '513', 'hodce5', '', ''),
(15, 'Expert Lecture', '2015-10-01', '2015-10-01', '&quot;IP Awareness Seminar - Everything you wanted to know about Intellectual Property Rights (IPR)&quot; \r\nby Mr. Akhilesh C Srivastava', '615', 'hodce5', '', ''),
(16, 'Expert Lecture', '2015-10-01', '2015-10-01', '&quot;IP Awareness Seminar - Everything you wanted to know about Intellectual Property Rights (IPR)&quot; by Mr. Akhilesh C Srivastava', '615', 'hodce5', '', ''),
(17, 'Expert Lecture', '2015-10-01', '2015-10-01', 'Expert Talk Series\r\nSession-I Expert Talk on\r\nâ€œEvolution of computing grids and cloudsâ€ by \r\nDr. B.S.Jagadeesh, BARC\r\n\r\n\r\n', '615', 'hod', '', ''),
(19, 'Holiday', '2015-07-18', '2015-07-18', 'Ramzan Id', 'with family', 'hodce5', '', ''),
(20, 'Holiday', '2015-08-15', '2015-08-15', 'Independence day', 'President Office', 'hodce5', '', ''),
(21, 'Holiday', '2015-08-18', '2015-08-18', 'Parsi New Year', 'with family', 'hodce5', '', ''),
(24, 'Holiday', '2015-09-17', '2015-09-17', 'Ganesh Chaturti', 'Ground Floor RAIT', 'hodce5', '', ''),
(26, 'Holiday', '2015-09-25', '2015-09-25', 'Bakari Id', 'with family', 'hodce5', '', ''),
(27, 'Holiday', '2015-10-02', '2015-10-02', 'Gandhi Jayanti', 'Tech Fests in RAIT', 'hodce5', '', ''),
(28, 'Holiday', '2015-10-22', '2015-10-22', 'Dussehra', 'with family', 'hodce5', '', ''),
(29, 'Holiday', '2015-10-24', '2015-10-24', 'Moharam', 'with family', 'hodce5', '', ''),
(30, 'Holiday', '2015-11-11', '2015-11-12', 'Deepawapli', 'with family', 'hodce5', '', ''),
(31, 'Donation Drive by Social Wing', '2015-08-03', '2015-08-08', 'Collection of Books, Cloths, stationary, bags, fund from RAIT students and faculty and donted to Rabale Community center', 'RAIT Glass door', 'hodce5', '', ''),
(40, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri  by 102 RAIT students', 'Uran', 'hodce5', '', ''),
(42, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri  by 102 RAIT students', 'RAIT Glass door', 'hodce5', '', ''),
(53, 'Cleanup drive by social wing', '2015-09-29', '2015-09-29', 'Beach Clean-up drive at Juhu Chowpati ', 'Juhu Choupati', 'hodce5', '', ''),
(55, 'Short film ', '2015-10-02', '2015-10-02', 'Short film on a social issue by RAIT students to be put on UTube', 'RAIT Glass door', 'hodce5', '', ''),
(56, 'Fund Raiser', '2015-10-01', '2015-10-03', 'Multiple fund raising and fun events to support under privileged children ', 'RAIT', 'hodce5', '', ''),
(57, 'Skit', '2015-10-01', '2015-10-01', 'Skit on social issue by Social Wing', 'RAIT and stations', 'hodce5', '', ''),
(58, 'Deepawali celebrations', '2015-11-11', '2015-11-11', 'Deepawali celebrations at Quarry center, Nerul MIDC area by Social Wing', 'Nerul', 'hodce5', '', ''),
(59, 'Spirit of Christmas', '2015-12-25', '2015-12-25', 'Christmas celebrations at Rabale Community center for underprivileged children by Social Wing', 'Rabale', 'hodce5', '', ''),
(60, 'medical check-up camp', '2015-10-17', '2015-10-17', 'Medical Check-up camp for Girija Orphanage children at Dr, D Y Patil Hospital by Social Wing', 'D Y Patil Hospital', 'hodce5', '', ''),
(61, 'Workshop', '2015-08-06', '2015-08-06', 'Workshop on Artificial Intelligence for BE students', '615', 'hodce5', '', ''),
(62, 'Expert Lecture', '2015-08-12', '2015-08-12', 'Guest Lecture on Application Architecture and design pattern for TE stuents', '615', 'hodce5', '', ''),
(63, 'Expert Lecture', '2015-08-19', '2015-08-19', 'Expert Lecture on Object oriented analysis and design for SE students by Mrs. Aditi Chabria', '511', 'hodce5', '', ''),
(64, 'Training Program', '2015-09-01', '2015-09-05', 'Training program on Trends and Techniques in Web Technology and Android Technology for TE students by Mr. Samsher Singh, CEO Unisoft Technology, C B D Belapur', '513', 'hodce5', '', ''),
(65, 'Workshop', '2015-09-08', '2015-09-10', 'Workshop on NS2 for TE students by Mrs. Puja Padia and Mr. A V Vidhate', '513', 'hodce5', '', ''),
(66, 'Workshop', '2015-09-16', '2015-09-16', 'Workshop on Network Security for BE students by Mr. Sachin Dedhiya', '513', 'hodce5', '', ''),
(67, 'Expert Lecture', '2015-10-07', '2015-10-07', 'Expert Lecture on Software Architecture for BE students by Prof. Kavita Kelkar', '511', 'hodce5', '', ''),
(68, 'photo copy ', '2015-09-08', '2015-09-14', 'The students who have applied for the Photo copy of the assessed answer books of semester III to VI for the examinations held in May 15. can collect on or before 14th Sep 2015', 'exam section room no 104', 'exam', '', ''),
(69, 'Workshop on Webreneurship', '2015-08-08', '2015-08-09', 'Workshop on Webreneurship consisting of CMS, JOOMLA, DRUPAL Technologies and their business applications.', 'Lab No.: 513', 'csi', '', ''),
(70, 'Webtechnology and PHP Workshop', '2015-09-01', '2015-09-03', 'Training on Web Technology and Php for students of Third Year Computer Engineering organised by Computer Dept. and CSI-RAIT.', 'Lab No.: 513', 'csi', '', ''),
(71, 'Basics of PYTHON', '2015-10-10', '2015-10-11', 'Inhouse workshop on Python Programming organised by CSI-RAIT.', 'Lab No.: 513', 'csi', '', ''),
(74, 'Teahtalk I', '2015-08-10', '2015-08-10', 'Talk on Internship Experience and opportunities by final year students organised by CSI-RAIT.', 'Room No.: 511', 'csi', '', ''),
(75, 'Techtalk II', '2015-08-31', '2015-08-31', 'Talk on &quot;How to publish a Research Paper&quot; by external experienced speakers organised by CSI-RAIT.', 'Room No.: 511', 'csi', '', ''),
(76, 'Techtalk III', '2015-09-07', '2015-09-07', 'Talk on UX/UI (User Experience/User Interface) Design by Faiz Malkani organised by CSI-RAIT.', 'Room No.: 511', 'csi', '', ''),
(77, 'Techmate 2K15', '2015-10-01', '2015-10-03', '3-Day Technical Symposium conducted by CSI-RAIT.', '5th Floor', 'csi', '', ''),
(80, 'Techtalk IV', '2015-10-05', '2015-10-05', 'Talk on BE Project Ideas for Third Year Engineering students by CSI-RAIT.  ', 'Room No.: 511', 'csi', '', ''),
(81, 'Workshop', '2016-01-30', '2016-01-31', 'Organised by CSI-RAIT.', 'Lab No.: 513', 'csi', '', ''),
(83, 'Workshop on Designing.', '2016-02-20', '2016-02-21', 'Creative designing workshop using Corel Draw-(Designing S/W), organised by CSI-RAIT.', 'Lab No.: 513', 'csi', '', ''),
(85, 'Expert Lecture', '2015-09-23', '2015-09-23', 'Expert Lecture by Dr Vrunda Joshi (PVG College of Engineering, Pune) on Spherical Robot: Design and Control.', 'RAIT', 'hodce5', '', ''),
(87, 'Training Program', '2015-10-07', '2015-10-10', 'Hands-on Training Session on Programmable System on Chip (PSoC) using ARM Micro-controllers by Eduvance Technology Ltd.', 'RAIT', 'hodce5', '', ''),
(88, 'Industrial visit', '2015-10-17', '2015-10-17', ' Industrial visit of BE and ME students to M/S Hind Rectifiers, Bhandup.', 'Bhandup', 'hodce5', '', ''),
(89, 'Expert Lecture', '2015-10-30', '2015-10-30', ' Expert Lecture by Mr Ramanan (CEO, Gauranga SoftTech Ltd.) on Career Opportunities for Electronics Graduates in Embedded Systems.\r\n', 'RAIT', 'hodce5', '', ''),
(90, 'Workshop', '2015-11-20', '2015-11-21', '2-day Hands-on Session on COMSOL by Prof Sachin Umbarkar.\r\n', 'RAIT', 'hodce5', '', ''),
(91, 'Expert Lecture', '2015-11-27', '2015-11-27', 'Expert Lecture by Prof Sharad Bhartiya (IIT Bombay) on Systems Biology.\r\n', 'RAIT', 'hodce5', '', ''),
(92, 'Expert Lecture', '2015-11-27', '2015-11-27', 'Expert Lecture by Prof Sharad Bhartiya (IIT Bombay) on Systems Biology.', 'RAIT', 'hodce5', '', ''),
(93, 'meeting', '2015-09-14', '2015-09-14', ' meeting between Tech-Mahindra delegates and HODs on Monday , 14th September, 2015 at 11:20 am to 11:45 am \r\nObjective: &quot; Understanding the industry requirements &quot; ', 'Placement Room', 'hodce5', '', ''),
(94, 'Talk by Padmashree Dr. Sharad ', '2015-08-19', '2015-08-19', 'Special talk on Biogas Technology, Life Science and Waste Management', '615', 'hodes', '', ''),
(98, 'Guest Lecture by Padmashree Dr', '2015-08-19', '2015-08-19', 'Special lecture on biogas technology, waste management and life sciences  ', '615', 'hodes', '', ''),
(99, 'Guest Lecture by Padmashree Dr', '2015-08-19', '2015-08-19', 'Special lecture on biogas technology, waste management and life sciences  ', '615', 'hodes', '', ''),
(100, 'Special Lecture by Dr Kale', '2015-08-19', '2015-08-19', 'Special lecture on biogas technology, waste management and life sciences  ', '615', 'hodes', '', ''),
(101, 'Workshop on stress managemnet', '2013-08-20', '2013-08-20', 'Stress Management by Faculty of Bramha Kumari', '611', 'hodes', '', ''),
(102, 'Technical Talk', '2014-09-24', '2014-09-24', 'Seminar by Dr Zakir Taquvi Ex NASA', '615', 'hodes', '', ''),
(103, 'Workshop on stress managemnet', '2014-02-06', '2014-02-07', 'Stress Management workshop by Ramkrishna Mission to the students so that they can achieve success in their life', '611', 'hodes', '', ''),
(104, 'Workshop on Syllabus Revision ', '2012-09-11', '2012-09-11', 'Orientation Programme on the revised syllabus of Applied Chemistry I &amp; II on the behalf of University of Mumbai. This workshop was organized to get familiar with new pattern of curriculum. ', '615', 'hodes', '', ''),
(105, 'Workshop on revised syllabus', '2012-09-11', '2012-09-11', 'Orientation Programme on the revised syllabus of Applied Chemistry I &amp; II on the behalf of University of Mumbai. This workshop was organized to get familiar with new pattern of curriculum. ', '615', 'hodes', '', ''),
(106, 'Special Lecture by Padmashree ', '2015-03-18', '2015-03-18', 'Padmashree Dr. Basu is Director of BARC, Mumbai delivered lecture on Nuclear Physics and research programs performed by BARC to the development of India', 'Auditorium', 'hodes', '', ''),
(107, 'Guest Lecture by Padmashree Dr', '2015-03-18', '2015-03-18', 'Padmashree Dr. Basu is Director of BARC, Mumbai delivered lecture on Nuclear Physics and research programs performed by BARC to the development of India', 'Auditorium', 'hodes', '', ''),
(109, 'Talk by Dr Basu', '2015-03-18', '2015-03-18', 'Padmashree Dr Basu (Director, BARC) delivered talk on development of Nuclear Physics in India and role of BARC in the development of India', 'Auditorium', 'hodes', '', ''),
(110, 'Talk by Dr Naba Mandal', '2014-09-25', '2014-09-25', 'Dr. Naba Mandal from BARC delivered talk on Neutrino Physics', '615', 'hodes', '', ''),
(111, 'Guest Lecture by Dr S Ghosh', '2015-02-18', '2015-02-18', 'Dr. S Ghosh is scientist in BARC and working at Biotechnology division. He introduced students that how technology can be used to develop biogas and how it can be controlled.', '615', 'hodes', '', ''),
(112, 'Workshop on Sahaj Yoga', '2015-03-02', '2015-03-05', 'Sahaj Yoga Meditation. Faculty of Sahaj Yoga', '611', 'hodes', '', ''),
(113, 'FE Orientation Program 2015', '2015-07-27', '2015-07-27', 'FE orientation programmed conducted very smoothly under guidance of Prof Dr. S. D. Shete Head of Engineering Science Department. He addressed new students about engineering in RAIT and guided them so that they can achieve success in their carrier ', 'Auditorium', 'hodes', '', ''),
(116, 'Workshop on Question Paper pat', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. He was nominated as chairman by University of Mumbai ', '615', 'hodes', '', ''),
(117, 'Workshop on Question Paper pat', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. He was nominated as chairman by University of Mumbai ', '615', 'hodes', '', ''),
(118, 'Work on behalf of University o', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. He was nominated as chairman by University of Mumbai ', '615', 'hodes', '', ''),
(120, 'Workshop on behalf of Universi', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', 'hodes', '', ''),
(121, 'Workshop for question paper pa', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', 'hodes', '', ''),
(122, 'Workshop for question paper pa', '2012-09-13', '2012-09-13', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', 'hodes', '', ''),
(124, 'Question Paper Pattern Develop', '2012-09-13', '2012-09-13', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', 'hodes', '', ''),
(127, 'Workshop on Blueprint of Appli', '2012-09-11', '2012-09-11', 'The Chairman of committee  was Prof. Dr. S. D. Shete, (nominated by University of Mumbai) Head of Department of Engineering Sciences, RAIT. ', '611', 'hodes', '', ''),
(128, 'Workshop on behalf of Mumbai U', '2012-09-11', '2012-09-11', 'The Chairman of committee  was Prof. Dr. S. D. Shete, (nominated by University of Mumbai) Head of Department of Engineering Sciences, RAIT. ', '611', 'hodes', '', ''),
(130, 'Seminar on behalf of Mumbai Un', '2012-09-11', '2012-09-11', 'Workshop for development of blue print for the subject of Applied Chemistry I &amp; II. The Chairman of Committee was Prof. Dr. S. D. Shete, HOD dept of Engineering Sciences. He was nominated as chairman by University of Mumbai', '615', 'hodes', '', ''),
(133, 'workshop on development of blu', '2012-09-11', '2012-09-11', 'Workshop for development of blue print for the subject of Applied Chemistry I &amp; II. The Chairman of Committee was Prof. Dr. S. D. Shete, HOD dept of Engineering Sciences. He was nominated as chairman by University of Mumbai', '615', 'hodes', '', ''),
(142, 'Workshop on Android', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', 'hod', '', ''),
(147, 'Expert Talk Series', '2015-10-01', '2015-10-01', 'Session-II Expert Talk on \r\nâ€œCryptography - Then and Nowâ€\r\nby Dr. Dipan Ghosh, \r\nIIT Mumbai\r\n', '615', 'hod', '', ''),
(148, 'NTPP', '2015-10-01', '2015-10-03', 'Technical Paper Presentation Competition conducted by CSI under Computer Department', '615', 'csi', '', ''),
(149, 'Placement Mantra', '2015-10-01', '2015-10-03', 'Most popular event of Techmate giving experience of mock placements to the participants.', '515 and 520', 'csi', '', ''),
(150, 'Next Aim', '2015-10-01', '2015-10-03', 'Event providing mock practice for examinations of higher education such as GRE, GMAT conducted by CSI under Computer Department.', '514', 'csi', '', ''),
(151, 'ARM University (UK) Workshop', '2015-10-07', '2015-10-11', 'The workshop is arranged for third year students. It will be given by Eduvance, Mumbai in collaboration with ARM University (UK) and Cypress Semiconductors. ', 'IT Centre (2nd FLoor)', 'hoden', '', ''),
(152, 'Demo of New Library Software (', '2015-10-07', '2015-10-07', 'For faculty and students.', '615', 'hoden', '', ''),
(153, 'Demo of New Library Software (', '2015-10-07', '2015-10-07', 'For faculty and students.', '615', 'hoden', '', ''),
(154, 'Demo of New Library Software (', '2015-10-07', '2015-10-07', 'For faculty and students.', '615', 'hoden', '', ''),
(155, 'Demo of New Library Software (', '2015-10-07', '2015-10-07', 'For faculty and students.', '615', 'hoden', '', ''),
(156, 'Training of Library staff for ', '2015-10-10', '2015-10-10', 'For Library and BVG (Tech) staff.', '511/611', 'hoden', '', ''),
(157, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511/611', 'hoden', '', ''),
(158, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511', 'hoden', '', ''),
(159, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511', 'hoden', '', ''),
(160, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511', 'hoden', '', ''),
(161, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511', 'hoden', '', ''),
(162, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511', 'hoden', '', ''),
(163, 'test', '2015-11-10', '2015-11-10', 'test', 'Room No. 615', 'faculty', '', ''),
(164, 'Making Interactive teaching Ha', '2016-01-08', '2016-01-08', 'Session on interactive and participating learning experience by\r\n1) Dr. Ramesh Vasappanavara\r\n2) Dr. M. S Bhatia\r\n3) Mr. hardik Bhatia\r\n\r\nTiming- 2 PM', '615 @ 2PM', 'faculty', '', ''),
(167, 'D Y Patil Polytechnic', '2016-02-23', '2016-02-23', 'Diploma Project Exhibition &amp; presentation\r\n(Room No. 615 &amp; one Class Room in 6th Floor)', '6th Floor', 'PA', '', ''),
(168, 'Expert Session ', '2016-01-18', '2016-01-18', 'Expert Session on E-Learning System by Prof. Sasikumar at 10.00 am', '615', 'faculty', '', ''),
(169, 'Expert Session ', '2016-01-18', '2016-01-18', 'Expert Session on Pattern Recognition for ME ', '615', 'faculty', '', ''),
(170, 'Expert Session ', '2016-01-20', '2016-01-20', 'Expert session for BE students by Mr. Munir Syad', '615', 'faculty', '', ''),
(171, 'Expert Session ', '2016-01-27', '2016-01-27', 'Expert Session by Siby sir for ME students', '615', 'faculty', '', ''),
(184, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to openGL by Prof. Shridhar Donamal for Second Year Students', '511', 'faculty', '', ''),
(187, 'Full Stack Development worksho', '2016-01-29', '2016-01-31', 'Workshop for T.E students organized by IT department.\r\nTime- 10 am to 5 pm', '616 ', 'faculty', '', ''),
(188, 'test', '2016-01-12', '2016-01-12', 'test', 't', 'faculty', '', ''),
(189, 'DDB expert Lecture', '2016-02-08', '2016-02-08', 'Distributed Databases Expert Lecture by S.S Kumar organized for Third year Students\r\n@10 am.', '615', 'faculty', '', ''),
(190, 'Term Test I', '2016-02-11', '2016-02-13', 'Term Test of All Departments.', '5 Floor', 'faculty', '', ''),
(191, 'Horizon', '2016-02-18', '2016-02-20', 'Culture Festival of RAIT', 'RAIT', 'faculty', '', ''),
(192, 'Holiday', '2016-01-26', '2016-01-26', 'Republic Day', 'Near President Office', 'faculty', '', ''),
(193, 'Academic Audit', '2016-02-29', '2016-02-29', 'audit of All Departments. ', 'RAIT', 'faculty', '', ''),
(194, 'Holiday', '2016-03-07', '2016-03-07', 'Mahashivratri', '@ Your Home', 'faculty', '', ''),
(195, 'Tech Fest', '2016-03-21', '2016-03-23', 'Tech Fest of RAIT', 'RAIT', 'faculty', '', ''),
(196, 'EPL', '2016-03-24', '2016-03-25', 'Cricket Matches ', 'DY Patil Stadium', 'faculty', '', ''),
(197, 'Student Feedback', '2016-03-28', '2016-03-29', 'Academic feedback One ', 'ALL Labs', 'faculty', '', ''),
(198, 'Academic Audit II', '2016-03-31', '2016-03-31', 'Academic Audit of all Department', 'RAIT', 'faculty', '', ''),
(199, 'Project Competition ', '2016-04-01', '2016-04-01', 'B. E Project Competition ', 'E- Yantra Lab', 'faculty', '', ''),
(200, 'Term Test II', '2016-04-07', '2016-04-11', 'Term Test II of RAIT', 'RAIT', 'faculty', '', ''),
(201, 'Remedial Classes', '2016-04-12', '2016-04-13', 'Remedial Classes for defaulter students', '5 Floor', 'faculty', '', ''),
(202, 'Term End', '2016-04-16', '2016-04-16', 'End of Even Sem', 'RAIT', 'faculty', '', ''),
(203, 'RAIT Placement', '2016-01-16', '2016-01-16', 'Placement drive of Muthshut.com ', 'Room No. 615', 'PA', '', ''),
(204, 'RAIT Placement', '2016-01-19', '2016-01-19', 'TCS post offer connect sessin\r\n9.00am to 12.00 noon', 'Room No. 615', 'PA', '', ''),
(205, 'Term Start', '2016-01-04', '2016-01-04', 'Start of Sem II', 'RAIT', 'hodfe', '', ''),
(206, 'First Defaulter''s List', '2016-02-09', '2016-01-09', 'Display of First Defaulter''s List', 'RAIT', 'hodfe', '', ''),
(207, 'Term Test I', '2016-02-11', '2016-02-13', 'Term Test I Conduction', 'RAIT', 'hodfe', '', ''),
(208, 'Term Test I Marks Display', '2016-02-17', '2016-02-17', 'Display of Term Test I marks to the students so that they can analyse and improve their performance', 'RAIT Notice Board', 'hodfe', '', ''),
(209, 'Student Feedback', '2016-03-28', '2016-04-01', 'Feedback from students on both CO and Faculty feedback', '212', 'hodfe', '', ''),
(210, 'Second Defaulter''s List', '2016-04-05', '2016-04-05', 'Display of Second Defaulter''s :ist', 'RAIT Notice Board', 'hodfe', '', ''),
(211, 'Term Test II', '2016-04-07', '2016-04-09', 'Term Test II of SEM II', 'RAIT', 'hodfe', '', ''),
(212, 'AutoCAD Practical Examination', '2016-04-18', '2016-04-23', 'AutoCAD Practical Examination Tentative dates', '212', 'hodfe', '', ''),
(213, 'SPA Practical Examination', '2016-04-18', '2016-04-23', 'SPA Practical Examination Tentative Dates', 'SPA Labs at 5th floor and 6th ', 'hodfe', '', ''),
(214, 'Expert Lecture on Softwares to', '2016-01-25', '2016-01-25', 'Use of different softwares for teaching Engineering Drawing Subject of FE Sem II. These softwares will help to understand some concepts of ED more easily to students.', '212', 'hodfe', '', ''),
(215, 'Expert Lecture on Softwares to', '2016-01-25', '2016-01-25', 'Use of different softwares for teaching Engineering Drawing Subject of FE Sem II. These softwares will help to understand some concepts of ED more easily to students.', '212', 'hodfe', '', ''),
(216, 'Seminar on ED software', '2016-01-25', '2016-01-25', 'Seminar on how to use different softwares and AutoCAD to make student understand the concept easily', '212', 'hodfe', '', ''),
(217, 'Latex Training', '2016-01-29', '2016-01-29', 'Training on Latex for BE(IT) students for generation of their project black book.', '616 lab', 'hod', '', ''),
(218, '1 day workshop on Parallel and', '2016-02-04', '2016-01-04', 'Expert session on PDS and Hands on Lab for ME and BE students', '615', 'faculty', '', ''),
(219, '1 day workshop on Parallel and', '2016-02-04', '2016-01-04', 'Expert session on PDS and Hands on Lab for ME and BE students', '615', 'faculty', '', ''),
(220, '1 day workshop on Parallel and', '2016-02-04', '2016-01-04', 'Expert session on PDS and Hands on Lab for ME and BE students', '615', 'faculty', '', ''),
(221, 'RAIT Placement', '2016-01-29', '2016-01-29', 'Teach for India Seminar', 'Room No. 615', 'PA', '', ''),
(222, 'D Y Patil Law College', '2016-02-06', '2016-02-06', 'Vidhi Mitra- 3.30pm to 6.30pm', 'Room No. 615', 'PA', '', ''),
(223, 'Latex Training', '2016-02-05', '2016-02-05', 'Latex Training for BE students for Black book preparation.', '616lab', 'hod', '', ''),
(224, 'Seminar By Oracle', '2016-02-09', '2016-02-09', 'Dept of IT (Seminar By Oracle)\r\n01.30pm ', 'Room 615', 'PA', '', ''),
(225, 'TCS Faculty Development Sessio', '2016-03-10', '2016-03-10', 'TCS Faculty Development Session\r\n(Faculty &amp; ME Students)', '2nd Floor -206', 'PA', '', ''),
(226, 'TCS Post Offer Connect Session', '2016-03-10', '2016-03-10', 'TCS Post Offer Connect Session10.00 to 11.30 \r\n\r\n&amp; TCS Prefinal Year Connect\r\n11.30 to 12.30', 'Room 615', 'PA', '', ''),
(227, 'Expert Lecture', '2016-03-09', '2016-03-09', 'Security Issues In Mobile Computing\r\n8.30 onwords', 'Room 615', 'PA', '', ''),
(228, 'etst', '2016-09-07', '2016-09-08', 'jkdshfkjdhl', 'hlsg', 'mandeep', 'EXTC', 'Examination'),
(229, 'etst', '2016-09-07', '2016-09-08', 'jkdshfkjdhl', 'hlsg', 'mandeep', 'ETRX', 'Examination'),
(230, 'dsfkj', '2016-09-07', '2016-09-09', 'mvgg', 'gghg', 'mandeep', 'COMPUTER', 'Alumini'),
(231, 'bd', '2016-09-07', '2016-09-09', 'djfk', 'ksdkj', 'mandeep', 'IT', 'Examination');

--
-- Triggers `cal_events`
--
DROP TRIGGER IF EXISTS `cal_events_log_on_delete`;
DELIMITER //
CREATE TRIGGER `cal_events_log_on_delete` AFTER DELETE ON `cal_events`
 FOR EACH ROW BEGIN

Call procedure_to_populate_log_table('Delete',  CURRENT_TIMESTAMP(),CURRENT_USER(),old.web_user,old.event_id,old.event_name,old.start_date,old.end_date,old.event_desc,old.location,null,null,null,null,null,null,@http_x_forwarded_for,@remote_addr);


END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `cal_events_log_on_insert`;
DELIMITER //
CREATE TRIGGER `cal_events_log_on_insert` AFTER INSERT ON `cal_events`
 FOR EACH ROW BEGIN
Call procedure_to_populate_log_table('Insert',  CURRENT_TIMESTAMP(),CURRENT_USER(),new.web_user,null,null,null,null,null,null,new.event_id,new.event_name,new.start_date,new.end_date,new.event_desc,new.location,@http_x_forwarded_for,@remote_addr);


END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `cal_events_log_on_update`;
DELIMITER //
CREATE TRIGGER `cal_events_log_on_update` AFTER UPDATE ON `cal_events`
 FOR EACH ROW BEGIN

Call procedure_to_populate_log_table('Update',  CURRENT_TIMESTAMP(),CURRENT_USER(),new.web_user,old.event_id,old.event_name,old.start_date,old.end_date,old.event_desc,old.location,new.event_id,new.event_name,new.start_date,new.end_date,new.event_desc,new.location,@http_x_forwarded_for,@remote_addr);


END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cal_events_log`
--

CREATE TABLE IF NOT EXISTS `cal_events_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(10) NOT NULL,
  `action_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user` varchar(30) NOT NULL,
  `web_user` varchar(30) DEFAULT NULL,
  `old_event_id` int(11) DEFAULT NULL,
  `old_event_name` varchar(100) DEFAULT NULL,
  `old_start_date` date DEFAULT NULL,
  `old_end_date` date DEFAULT NULL,
  `old_event_desc` varchar(500) DEFAULT NULL,
  `old_location` varchar(30) DEFAULT NULL,
  `new_event_id` int(11) DEFAULT NULL,
  `new_event_name` varchar(100) DEFAULT NULL,
  `new_start_date` date DEFAULT NULL,
  `new_end_date` date DEFAULT NULL,
  `new_event_desc` varchar(500) DEFAULT NULL,
  `new_location` varchar(30) DEFAULT NULL,
  `remote_addr` varchar(45) DEFAULT NULL,
  `http_x_forwarded_for` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=962 ;

--
-- Dumping data for table `cal_events_log`
--

INSERT INTO `cal_events_log` (`log_id`, `action`, `action_time`, `user`, `web_user`, `old_event_id`, `old_event_name`, `old_start_date`, `old_end_date`, `old_event_desc`, `old_location`, `new_event_id`, `new_event_name`, `new_start_date`, `new_end_date`, `new_event_desc`, `new_location`, `remote_addr`, `http_x_forwarded_for`) VALUES
(9, 'Update', '2015-07-20 21:22:52', 'root@localhost', '', 5, 'event1', '0000-00-00', '0000-00-00', 'jjjjjjjjjj', 'test', 5, 'event1', '0000-00-00', '0000-00-00', 'jjjjjjjj', 'test', '', ''),
(10, 'Update', '2015-07-20 21:41:28', 'root@localhost', '', 4, 'event1', '2015-07-19', '2015-12-21', 'jjjjjjj', 'test', 4, 'event1', '2015-07-19', '2015-12-21', 'jjjjjjjjjj', 'test', NULL, NULL),
(11, 'Delete', '2015-07-20 21:42:04', 'root@localhost', '', 5, 'event1', '0000-00-00', '0000-00-00', 'jjjjjjjj', 'test', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'Insert', '2015-07-21 12:08:38', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 7, 'test', '2015-07-16', '2015-07-17', 'test', '', '', ''),
(13, 'Insert', '2015-07-21 12:09:43', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 8, 'test', '2015-07-16', '2015-07-17', 'test', 'test', '', ''),
(14, 'Insert', '2015-07-21 12:10:34', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 9, 'test', '2015-07-16', '2015-07-17', 'test', 'test', '::1', ''),
(15, 'Insert', '2015-07-21 12:15:50', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 10, 'test', '2015-07-16', '2015-07-17', 'test', 'test', '::1', ''),
(16, 'Insert', '2015-07-21 12:18:29', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 11, 'test', '2015-07-16', '2015-07-17', 'test', 'test', '::1', ''),
(17, 'Update', '2015-07-21 14:13:28', 'root@localhost', 'ss', 4, 'event1', '2015-07-19', '2015-12-21', 'jjjjjjjjjj', 'test', 4, 'event1', '2015-07-19', '2015-12-21', 'hhhhhhhhhhhhhh', 'test', '::1', ''),
(18, 'Delete', '2015-07-21 15:32:59', 'root@localhost', 'ss', 9, 'test', '2015-07-16', '2015-07-17', 'test', 'test', NULL, NULL, NULL, NULL, NULL, NULL, '1234', '1234'),
(19, 'Delete', '2015-07-21 15:42:40', 'root@localhost', 'ss', 8, 'test', '2015-07-16', '2015-07-17', 'test', 'test', NULL, NULL, NULL, NULL, NULL, NULL, '::1', ''),
(20, 'Delete', '2015-07-21 15:51:55', 'root@localhost', 'ss', 7, 'test', '2015-07-16', '2015-07-17', 'test', '', NULL, NULL, NULL, NULL, NULL, NULL, '::1', ''),
(21, 'Delete', '2015-07-21 15:52:26', 'root@localhost', 'ss', 10, 'test', '2015-07-16', '2015-07-17', 'test', 'test', NULL, NULL, NULL, NULL, NULL, NULL, '::1', ''),
(22, 'Insert', '2015-07-21 15:56:42', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 12, 'test2', '2015-07-10', '2015-07-24', 'test3', '', '::1', ''),
(23, 'Delete', '2015-07-21 16:05:06', 'root@localhost', 'ss', 12, 'test2', '2015-07-10', '2015-07-24', 'test3', '', NULL, NULL, NULL, NULL, NULL, NULL, '::1', ''),
(24, 'Delete', '2015-07-21 16:05:14', 'root@localhost', 'ss', 11, 'test', '2015-07-16', '2015-07-17', 'test', 'test', NULL, NULL, NULL, NULL, NULL, NULL, '::1', ''),
(25, 'Insert', '2015-07-21 16:06:06', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 13, 'test', '2015-07-21', '2015-07-22', 'tre', '', '::1', ''),
(26, 'Insert', '2015-07-22 06:33:15', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 14, 'tt', '2015-07-01', '2015-07-02', 'tttttttttttttt ttttttttttttttt tttttttttttttt tttttttttttttttt ttttttttttt tttttttttttttt ttttttttttttttttttt ttttttttttttttt ttttttttttttttttt tttttttttttttt ttttttttttttt tttttttttttttt tttttttttttttt ttttttttttttt tt          t         ttttttttt ttttttttt ttttttttt tttttttttttt ', '', '::1', ''),
(27, 'Insert', '2015-07-22 06:33:49', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 15, 'tr', '2015-07-09', '2015-07-10', 'rvsvvvvvvvvvvvvvvvvvvvvsdv efve evf fv ddfv dfv fdv fvg bd', '', '::1', ''),
(28, 'Delete', '2015-07-22 08:42:04', 'root@localhost', 'ss', 14, 'tt', '2015-07-01', '2015-07-02', 'tttttttttttttt ttttttttttttttt tttttttttttttt tttttttttttttttt ttttttttttt tttttttttttttt ttttttttttttttttttt ttttttttttttttt ttttttttttttttttt tttttttttttttt ttttttttttttt tttttttttttttt tttttttttttttt ttttttttttttt tt          t         ttttttttt ttttttttt ttttttttt tttttttttttt ', '', NULL, NULL, NULL, NULL, NULL, NULL, '::1', ''),
(29, 'Update', '2015-07-25 01:04:10', 'root@localhost', 'ss', 13, 'test', '2015-07-21', '2015-07-22', 'tre', '', 13, 'test', '2015-07-21', '2015-07-22', 'tre', 'f', NULL, NULL),
(30, 'Update', '2015-07-25 01:04:24', 'root@localhost', 'ss', 13, 'test', '2015-07-21', '2015-07-22', 'tre', 'f', 13, 'test', '2015-07-21', '2015-07-22', 'tre', '', NULL, NULL),
(31, 'Update', '2015-07-26 17:16:18', 'root@localhost', 'ss', 13, 'test', '2015-07-21', '2015-07-22', 'tre', '', 13, 'test', '2015-07-21', '2015-07-22', 'tre', 'test', NULL, NULL),
(32, 'Update', '2015-07-26 17:16:27', 'root@localhost', 'ss', 15, 'tr', '2015-07-09', '2015-07-10', 'rvsvvvvvvvvvvvvvvvvvvvvsdv efve evf fv ddfv dfv fdv fvg bd', '', 15, 'tr', '2015-07-09', '2015-07-10', 'rvsvvvvvvvvvvvvvvvvvvvvsdv efve evf fv ddfv dfv fdv fvg bd', 'others', NULL, NULL),
(33, 'Update', '2015-07-26 17:25:23', 'root@localhost', 'ss', 13, 'test', '2015-07-21', '2015-07-22', 'tre', 'test', 13, 'test', '2015-07-21', '2015-07-22', 'tre', 'others', NULL, NULL),
(34, 'Insert', '2015-08-06 03:50:45', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 16, 'tt', '2015-07-22', '2015-08-22', 'nlah', 'test', NULL, NULL),
(35, 'Insert', '2015-08-06 11:45:21', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 17, 'ttt', '2015-07-22', '2015-08-22', 'nnnlah', 'others', NULL, NULL),
(36, 'Insert', '2015-08-06 12:03:51', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 18, 'tttt', '2015-07-22', '2015-08-22', 'nnnlah', 'others', NULL, NULL),
(37, 'Insert', '2015-08-06 12:04:02', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 19, 'tttt', '2015-07-22', '2015-08-22', 'nnnlah', 'others', NULL, NULL),
(38, 'Insert', '2015-08-06 12:04:02', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 20, 'ttttt', '2015-07-22', '2015-08-22', 'nnnlah', 'others', NULL, NULL),
(39, 'Insert', '2015-08-06 12:04:33', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 21, 'tttt', '2015-07-22', '2015-08-22', 'nnnlah', 'others', NULL, NULL),
(40, 'Insert', '2015-08-06 12:04:33', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 22, 'ttttt', '2015-07-22', '2015-08-22', 'nnnlah', 'others', NULL, NULL),
(41, 'Insert', '2015-08-06 12:04:33', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 23, 'tttttt', '2015-07-22', '2015-08-22', 'nnnlah', 'others', NULL, NULL),
(42, 'Insert', '2015-08-07 18:50:46', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 24, 'check', '2015-07-20', '2015-07-20', 'tp\r\ntp\r\nto\r\ntop\r\npot', 'others', NULL, NULL),
(43, 'Delete', '2015-08-07 19:00:50', 'root@localhost', 'ss', 17, 'ttt', '2015-07-22', '2015-08-22', 'nnnlah', 'others', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 'Delete', '2015-08-07 19:00:50', 'root@localhost', 'ss', 18, 'tttt', '2015-07-22', '2015-08-22', 'nnnlah', 'others', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(45, 'Delete', '2015-08-07 19:00:50', 'root@localhost', 'ss', 19, 'tttt', '2015-07-22', '2015-08-22', 'nnnlah', 'others', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(46, 'Delete', '2015-08-07 19:00:51', 'root@localhost', 'ss', 20, 'ttttt', '2015-07-22', '2015-08-22', 'nnnlah', 'others', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(47, 'Delete', '2015-08-07 19:00:51', 'root@localhost', 'ss', 21, 'tttt', '2015-07-22', '2015-08-22', 'nnnlah', 'others', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(48, 'Delete', '2015-08-07 19:00:51', 'root@localhost', 'ss', 22, 'ttttt', '2015-07-22', '2015-08-22', 'nnnlah', 'others', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(49, 'Insert', '2015-08-07 19:07:32', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 25, 'check1', '2015-08-23', '2015-08-24', 'test', 'test', NULL, NULL),
(50, 'Insert', '2015-08-07 19:30:45', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 26, 'check2', '2015-08-24', '2015-08-24', 'test', 'test', NULL, NULL),
(51, 'Insert', '2015-08-07 19:31:38', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 27, 'check2', '2015-07-24', '2015-07-24', 'test', 'test', NULL, NULL),
(52, 'Insert', '2015-08-07 19:31:53', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 28, 'check2', '2015-07-23', '2015-07-24', 'test', 'test', NULL, NULL),
(53, 'Insert', '2015-08-07 19:33:57', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 29, 'check3', '2015-07-26', '2015-07-26', 'test', 'test', NULL, NULL),
(54, 'Insert', '2015-08-07 22:16:10', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 30, 'check34', '2015-07-05', '2015-07-05', 'test1', 'test', NULL, NULL),
(55, 'Insert', '2015-08-07 22:26:02', 'root@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 31, 'check34', '2015-08-05', '2015-08-05', 'test1', 'test', NULL, NULL),
(56, 'Update', '2015-08-08 20:52:39', 'root@localhost', 'ss', 31, 'check34', '2015-08-05', '2015-08-05', 'test1', 'test', 31, 'check34', '2015-08-05', '2015-08-05', 'test1kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk', 'test', NULL, NULL),
(57, 'Delete', '2015-08-10 12:26:04', 'root1@localhost', 'ss', 24, 'check', '2015-07-20', '2015-07-20', 'tp\r\ntp\r\nto\r\ntop\r\npot', 'others', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', ''),
(58, 'Delete', '2015-08-10 12:28:12', 'root1@localhost', 'ss', 25, 'check1', '2015-08-23', '2015-08-24', 'test', 'test', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', ''),
(59, 'Delete', '2015-08-10 12:28:23', 'root1@localhost', 'ss', 27, 'check2', '2015-07-24', '2015-07-24', 'test', 'test', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', ''),
(60, 'Delete', '2015-08-10 12:28:31', 'root1@localhost', 'ss', 28, 'check2', '2015-07-23', '2015-07-24', 'test', 'test', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', ''),
(61, 'Delete', '2015-08-10 12:28:37', 'root1@localhost', 'ss', 26, 'check2', '2015-08-24', '2015-08-24', 'test', 'test', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', ''),
(62, 'Delete', '2015-08-10 12:28:46', 'root1@localhost', 'ss', 31, 'check34', '2015-08-05', '2015-08-05', 'test1kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk', 'test', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', ''),
(63, 'Delete', '2015-08-10 12:28:52', 'root1@localhost', 'ss', 29, 'check3', '2015-07-26', '2015-07-26', 'test', 'test', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', ''),
(64, 'Delete', '2015-08-10 12:28:59', 'root1@localhost', 'ss', 30, 'check34', '2015-07-05', '2015-07-05', 'test1', 'test', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', ''),
(65, 'Delete', '2015-08-10 12:29:05', 'root1@localhost', 'ss', 4, 'event1', '2015-07-19', '2015-12-21', 'hhhhhhhhhhhhhh', 'test', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', ''),
(66, 'Delete', '2015-08-10 12:29:12', 'root1@localhost', '', 6, 'event1', '2015-12-26', '2015-12-27', 'jjjjjjjjjj', 'test', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', ''),
(67, 'Delete', '2015-08-10 12:29:18', 'root1@localhost', 'ss', 13, 'test', '2015-07-21', '2015-07-22', 'tre', 'others', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', ''),
(68, 'Delete', '2015-08-10 12:29:23', 'root1@localhost', 'ss', 15, 'tr', '2015-07-09', '2015-07-10', 'rvsvvvvvvvvvvvvvvvvvvvvsdv efve evf fv ddfv dfv fdv fvg bd', 'others', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', ''),
(69, 'Delete', '2015-08-10 12:29:28', 'root1@localhost', 'ss', 16, 'tt', '2015-07-22', '2015-08-22', 'nlah', 'test', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', ''),
(70, 'Delete', '2015-08-10 12:29:34', 'root1@localhost', 'ss', 23, 'tttttt', '2015-07-22', '2015-08-22', 'nnnlah', 'others', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', ''),
(71, 'Insert', '2015-08-10 13:08:29', 'root1@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 32, 'sample event', '2015-08-10', '2015-08-10', 'this is desc', 'technical', '127.0.0.1', ''),
(72, 'Insert', '2015-08-10 13:22:15', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 33, 'CSI Techfest', '2015-08-28', '2015-08-30', 'TehFest By CSI to show your technical skills', 'fest', '127.0.0.1', ''),
(73, 'Update', '2015-08-10 13:30:07', 'root1@localhost', 'ss', 32, 'sample event', '2015-08-10', '2015-08-10', 'this is desc', 'technical', 32, 'sample event', '2015-08-10', '2015-08-10', 'this is desc', 'cultural', '127.0.0.1', ''),
(74, 'Insert', '2015-08-11 11:04:45', 'root1@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 34, 'temp', '2015-08-10', '2015-08-11', 'try', 'test', '10.0.0.1', ''),
(75, 'Insert', '2015-08-11 11:05:33', 'root1@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 35, 'try', '2015-08-20', '2015-08-20', 'try', 'others', '10.0.0.1', ''),
(76, 'Insert', '2015-08-11 11:06:38', 'root1@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 36, 'tcs placement drive', '2015-08-25', '2015-08-26', 'Placement drive by tata consultancy services', 'placement', '10.0.0.1', ''),
(77, 'Delete', '2015-08-13 16:59:19', 'root1@localhost', 'faculty', 33, 'CSI Techfest', '2015-08-28', '2015-08-30', 'TehFest By CSI to show your technical skills', 'fest', NULL, NULL, NULL, NULL, NULL, NULL, '::1', ''),
(78, 'Delete', '2015-08-13 16:59:30', 'root1@localhost', 'ss', 32, 'sample event', '2015-08-10', '2015-08-10', 'this is desc', 'cultural', NULL, NULL, NULL, NULL, NULL, NULL, '::1', ''),
(79, 'Delete', '2015-08-13 16:59:39', 'root1@localhost', 'ss', 36, 'tcs placement drive', '2015-08-25', '2015-08-26', 'Placement drive by tata consultancy services', 'placement', NULL, NULL, NULL, NULL, NULL, NULL, '::1', ''),
(80, 'Delete', '2015-08-13 16:59:46', 'root1@localhost', 'ss', 34, 'temp', '2015-08-10', '2015-08-11', 'try', 'test', NULL, NULL, NULL, NULL, NULL, NULL, '::1', ''),
(81, 'Delete', '2015-08-13 16:59:53', 'root1@localhost', 'ss', 35, 'try', '2015-08-20', '2015-08-20', 'try', 'others', NULL, NULL, NULL, NULL, NULL, NULL, '::1', ''),
(82, 'Insert', '2015-08-13 17:50:52', 'root1@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 37, 'Tech Fest', '2015-08-14', '2015-08-14', 'temj', 'Room No. 615', '10.0.0.4', ''),
(83, 'Delete', '2015-08-13 17:54:19', 'root1@localhost', 'ss', 37, 'Tech Fest', '2015-08-14', '2015-08-14', 'temj', 'Room No. 615', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(84, 'Insert', '2015-08-13 18:50:52', 'root1@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 1, 'Test', '2015-08-14', '2015-08-14', 'test', 'test', '10.0.0.4', ''),
(85, 'Update', '2015-08-19 16:26:10', 'root1@localhost', 'ss', 1, 'Test', '2015-08-14', '2015-08-14', 'test', 'test', 1, 'Test', '2015-08-14', '2015-08-14', 'test', 'test', '127.0.0.1', ''),
(86, 'Update', '2015-08-19 16:26:39', 'root1@localhost', 'ss', 1, 'Test', '2015-08-14', '2015-08-14', 'test', 'test', 1, 'Test', '2015-08-14', '2015-08-14', 'test', 'test', '127.0.0.1', ''),
(87, 'Insert', '2015-08-19 16:27:15', 'root1@localhost', 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 2, 'holidaytest', '2015-08-16', '2015-08-16', 'test', 'RAIT', '127.0.0.1', ''),
(88, 'Delete', '2015-08-19 16:56:16', 'root1@localhost', 'ss', 2, 'holidaytest', '2015-08-16', '2015-08-16', 'test', 'RAIT', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', ''),
(89, 'Insert', '2015-08-21 16:06:14', 'root1@localhost', 'hodin', NULL, NULL, NULL, NULL, NULL, NULL, 2, 'Faculty Meetting', '2015-08-31', '2015-08-31', 'NAAC work review', '112C', '192.168.2.30', ''),
(90, 'Insert', '2015-08-21 16:25:41', 'root1@localhost', 'hoden', NULL, NULL, NULL, NULL, NULL, NULL, 3, 'Workshop on PCB Design', '2015-08-10', '2015-08-14', 'This is a free workshop for third and fourth year students.', 'Lab. 201 and 208', '192.168.1.17', ''),
(91, 'Insert', '2015-08-21 16:27:17', 'root1@localhost', 'hoden', NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Workshop on Rasberry Pi', '2015-08-17', '2015-08-18', 'A workshop is arranged by EXTC department in association with IETE-RAIT.', 'Lab. 201', '192.168.1.17', ''),
(92, 'Insert', '2015-08-21 16:42:07', 'root1@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 5, 'NBA FILES - Meeting', '2015-08-24', '2015-08-24', 'All HODs &amp; Faculty handling NBA Files requested to attend', 'Principal Chambers', '192.168.1.52', ''),
(93, 'Insert', '2015-08-31 09:50:31', 'root1@localhost', 'pa', NULL, NULL, NULL, NULL, NULL, NULL, 6, 'Youth &amp; Communal Harmony- ', '2015-08-31', '2015-08-31', 'Youth &amp; Communal Harmony- School of Eduction', 'Room No 615', '192.168.1.14', ''),
(94, 'Insert', '2015-08-31 09:53:31', 'root1@localhost', 'pa', NULL, NULL, NULL, NULL, NULL, NULL, 7, 'Youth &amp; Communal Harmony- ', '2015-08-31', '2015-08-31', 'Youth &amp; Communal Harmony- School of Eduction', 'Room No 615', '192.168.1.14', ''),
(95, 'Insert', '2015-08-31 09:53:36', 'root1@localhost', 'pa', NULL, NULL, NULL, NULL, NULL, NULL, 8, 'Youth &amp; Communal Harmony- ', '2015-08-31', '2015-08-31', 'Youth &amp; Communal Harmony- School of Eduction', 'Room No 615', '192.168.1.14', ''),
(96, 'Insert', '2015-08-31 09:55:21', 'root1@localhost', 'pa', NULL, NULL, NULL, NULL, NULL, NULL, 9, 'Youth &amp; Communal Harmony- ', '2015-09-04', '2015-09-04', 'Youth &amp; Communal Harmony- School of Eduction from 9.00am to 02.00pm', 'Room No 615', '192.168.1.14', ''),
(97, 'Insert', '2015-09-01 09:54:43', 'root1@localhost', 'pa', NULL, NULL, NULL, NULL, NULL, NULL, 10, 'Role of Instrumentation Engg. ', '2015-09-03', '2015-09-03', 'Dept. of Instrumentation Engg\r\n\r\nRole of Instrumentation Engg. in Corporat World', 'Room No 615', '192.168.1.136', ''),
(98, 'Insert', '2015-09-01 17:10:40', 'root1@localhost', 'pa', NULL, NULL, NULL, NULL, NULL, NULL, 11, 'The Art of Control', '2015-09-02', '2015-09-02', 'The Art of Control - by ISKCON, Juhu, Mumbai - 10.30 to 12.30', 'Room No 615', '192.168.1.136', ''),
(99, 'Insert', '2015-09-01 17:13:03', 'root1@localhost', 'pa', NULL, NULL, NULL, NULL, NULL, NULL, 12, 'Placement Preparation Talk', '2015-09-02', '2015-09-02', 'Placement Preparation Talk 3.00pm onwards.', 'Room No 615', '192.168.1.136', ''),
(100, 'Insert', '2015-09-01 17:14:32', 'root1@localhost', 'pa', NULL, NULL, NULL, NULL, NULL, NULL, 13, 'Placement Preparation Talk', '2015-09-03', '2015-09-03', 'Placement Preparation Talk 3.00pm onwards', 'Room No 615', '192.168.1.136', ''),
(101, 'Insert', '2015-09-15 17:21:42', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 14, 'Workshop', '2015-09-16', '2015-09-16', 'Network Security workshop for UG and PG', '513', '192.168.5.170', ''),
(102, 'Insert', '2015-09-15 17:35:28', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 15, 'Expert Lecture', '2015-10-01', '2015-10-01', '&quot;IP Awareness Seminar - Everything you wanted to know about Intellectual Property Rights (IPR)&quot; \r\nby Mr. Akhilesh C Srivastava', '615', '192.168.5.170', ''),
(103, 'Insert', '2015-09-15 17:36:10', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 16, 'Expert Lecture', '2015-10-01', '2015-10-01', '&quot;IP Awareness Seminar - Everything you wanted to know about Intellectual Property Rights (IPR)&quot; \\r\\nby Mr. Akhilesh C Srivastava', '615', '192.168.5.170', ''),
(104, 'Insert', '2015-09-16 12:36:53', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 17, 'Expert Lecture', '2015-10-01', '2015-10-01', 'Expert Talk Series', '615', '192.168.5.234', ''),
(105, 'Insert', '2015-09-16 12:42:45', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 18, 'Training', '2015-09-25', '2015-09-26', 'Android OS and Open Source Technology', '613', '192.168.5.234', ''),
(106, 'Insert', '2015-09-16 12:56:49', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 19, 'Holiday', '2015-07-18', '2015-07-18', 'Ramzan Id', 'with family', '192.168.5.234', ''),
(107, 'Insert', '2015-09-16 12:57:50', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 20, 'Holiday', '2015-08-15', '2015-08-15', 'Independence day', 'President Office', '192.168.5.234', ''),
(108, 'Insert', '2015-09-16 12:58:30', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 21, 'Holiday', '2015-08-18', '2015-08-18', 'Parsi New Year', 'with family', '192.168.5.234', ''),
(109, 'Insert', '2015-09-16 12:59:45', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 22, 'Holiday', '2015-09-17', '2015-09-17', 'Ganesh Chaturti', 'With Family and Ground Floor R', '192.168.5.234', ''),
(110, 'Insert', '2015-09-16 12:59:56', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 23, 'Holiday', '2015-09-17', '2015-09-17', 'Ganesh Chaturti', 'With Family and Ground Floor R', '192.168.5.234', ''),
(111, 'Insert', '2015-09-16 13:00:27', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 24, 'Holiday', '2015-09-17', '2015-09-17', 'Ganesh Chaturti', 'Ground Floor RAIT', '192.168.5.234', ''),
(112, 'Insert', '2015-09-16 13:00:34', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 25, 'Holiday', '2015-09-17', '2015-09-17', 'Ganesh Chaturti', 'Ground Floor RAIT', '192.168.5.234', ''),
(113, 'Insert', '2015-09-16 13:01:14', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 26, 'Holiday', '2015-09-25', '2015-09-25', 'Bakari Id', 'with family', '192.168.5.234', ''),
(114, 'Insert', '2015-09-16 13:02:26', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 27, 'Holiday', '2015-10-02', '2015-10-02', 'Gandhi Jayanti', 'Tech Fests in RAIT', '192.168.5.234', ''),
(115, 'Insert', '2015-09-16 13:03:20', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 28, 'Holiday', '2015-10-22', '2015-10-22', 'Dussehra', 'with family', '192.168.5.234', ''),
(116, 'Insert', '2015-09-16 13:04:00', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 29, 'Holiday', '2015-10-24', '2015-10-24', 'Moharam', 'with family', '192.168.5.234', ''),
(117, 'Insert', '2015-09-16 13:05:12', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 30, 'Holiday', '2015-11-11', '2015-11-12', 'Deepawapli', 'with family', '192.168.5.234', ''),
(118, 'Update', '2015-09-16 13:12:34', 'root1@localhost', 'hodce5', 16, 'Expert Lecture', '2015-10-01', '2015-10-01', '&quot;IP Awareness Seminar - Everything you wanted to know about Intellectual Property Rights (IPR)&quot; \\r\\nby Mr. Akhilesh C Srivastava', '615', 16, 'Expert Lecture', '2015-10-01', '2015-10-01', '&quot;IP Awareness Seminar - Everything you wanted to know about Intellectual Property Rights (IPR)&quot; by Mr. Akhilesh C Srivastava', '615', '192.168.5.234', ''),
(119, 'Insert', '2015-09-16 13:26:21', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 31, 'Donation Drive by Social Wing', '2015-08-03', '2015-08-08', 'Collection of Books, Cloths, stationary, bags, fund from RAIT students and faculty and donted to Rabale Community center', 'RAIT Glass door', '192.168.5.234', ''),
(120, 'Insert', '2015-09-16 13:27:44', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 32, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri, Uran by RAIT students', 'Dronagiri', '192.168.5.234', ''),
(121, 'Insert', '2015-09-16 13:27:59', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 33, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri, Uran by RAIT students', 'Dronagiri', '192.168.5.234', ''),
(122, 'Insert', '2015-09-16 13:28:07', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 34, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri, Uran by RAIT students', 'Dr', '192.168.5.234', ''),
(123, 'Insert', '2015-09-16 13:28:20', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 35, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri, Uran by RAIT students', 'Dronagiri', '192.168.5.234', ''),
(124, 'Insert', '2015-09-16 13:28:29', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 36, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri, Uran by RAIT students', 'Uran', '192.168.5.234', ''),
(125, 'Insert', '2015-09-16 13:28:33', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 37, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri, Uran by RAIT students', 'Uran', '192.168.5.234', ''),
(126, 'Insert', '2015-09-16 13:29:02', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 38, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri  by RAIT students', 'Uran', '192.168.5.234', ''),
(127, 'Insert', '2015-09-16 13:29:06', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 39, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri  by RAIT students', 'Uran', '192.168.5.234', ''),
(128, 'Insert', '2015-09-16 13:29:45', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 40, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri  by 102 RAIT students', 'Uran', '192.168.5.234', ''),
(129, 'Insert', '2015-09-16 13:30:25', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 41, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri  by 102 RAIT students', 'RAIT Glass door', '192.168.5.234', ''),
(130, 'Insert', '2015-09-16 13:30:30', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 42, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri  by 102 RAIT students', 'RAIT Glass door', '192.168.5.234', ''),
(131, 'Insert', '2015-09-16 13:31:01', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 43, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri  by RAIT students', 'Uran', '192.168.5.234', ''),
(132, 'Insert', '2015-09-16 13:31:07', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 44, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri  by RAIT students', 'Uran', '192.168.5.234', ''),
(133, 'Insert', '2015-09-16 13:31:12', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 45, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri  by RAIT students', 'Uran', '192.168.5.234', ''),
(134, 'Insert', '2015-09-16 13:31:15', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 46, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri  by RAIT students', 'Uran', '192.168.5.234', ''),
(135, 'Insert', '2015-09-16 13:31:53', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 47, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri  by students', 'Uran', '192.168.5.234', ''),
(136, 'Insert', '2015-09-16 13:31:59', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 48, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri  by students', 'Uran', '192.168.5.234', ''),
(137, 'Insert', '2015-09-16 13:32:03', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 49, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri  by students', 'Uran', '192.168.5.234', ''),
(138, 'Insert', '2015-09-16 13:32:25', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 50, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri ', 'Uran', '192.168.5.234', ''),
(139, 'Insert', '2015-09-16 13:32:29', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 51, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri ', 'Uran', '192.168.5.234', ''),
(140, 'Insert', '2015-09-16 13:33:39', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 52, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree palntation at Dronagiri ', 'Uran', '192.168.5.234', ''),
(141, 'Insert', '2015-09-16 13:37:17', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 53, 'Cleanup drive by social wing', '2015-09-29', '2015-09-29', 'Beach Clean-up drive at Juhu Chowpati ', 'Juhu Choupati', '192.168.5.234', ''),
(142, 'Insert', '2015-09-16 13:38:18', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 54, 'tree-plantation', '2015-08-22', '2015-08-22', '150 Tree plantation by 110 students ', 'Dronagiri ', '192.168.5.234', ''),
(143, 'Insert', '2015-09-16 13:42:34', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 55, 'Short film ', '2015-10-02', '2015-10-02', 'Short film on a social issue by RAIT students to be put on UTube', 'RAIT Glass door', '192.168.5.234', ''),
(144, 'Insert', '2015-09-16 13:44:01', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 56, 'Fund Raiser', '2015-10-01', '2015-10-03', 'Multiple fund raising and fun events to support under privileged children ', 'RAIT', '192.168.5.234', ''),
(145, 'Insert', '2015-09-16 13:44:58', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 57, 'Skit', '2015-10-01', '2015-10-01', 'Skit on social issue by Social Wing', 'RAIT and stations', '192.168.5.234', ''),
(146, 'Insert', '2015-09-16 13:48:02', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 58, 'Deepawali celebrations', '2015-11-11', '2015-11-11', 'Deepawali celebrations at Quarry center, Nerul MIDC area by Social Wing', 'Nerul', '192.168.5.234', ''),
(147, 'Insert', '2015-09-16 13:49:21', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 59, 'Spirit of Christmas', '2015-12-25', '2015-12-25', 'Christmas celebrations at Rabale Community center for underprivileged children by Social Wing', 'Rabale', '192.168.5.234', ''),
(148, 'Insert', '2015-09-16 13:53:37', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 60, 'medical check-up camp', '2015-10-17', '2015-10-17', 'Medical Check-up camp for Girija Orphanage children at Dr, D Y Patil Hospital by Social Wing', 'D Y Patil Hospital', '192.168.5.234', ''),
(149, 'Insert', '2015-09-16 13:55:24', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 61, 'Workshop', '2015-08-06', '2015-08-06', 'Workshop on Artificial Intelligence for BE students', '615', '192.168.5.234', ''),
(150, 'Insert', '2015-09-16 13:56:26', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 62, 'Expert Lecture', '2015-08-12', '2015-08-12', 'Guest Lecture on Application Architecture and design pattern for TE stuents', '615', '192.168.5.234', ''),
(151, 'Insert', '2015-09-16 13:57:55', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 63, 'Expert Lecture', '2015-08-19', '2015-08-19', 'Expert Lecture on Object oriented analysis and design for SE students by Mrs. Aditi Chabria', '511', '192.168.5.234', ''),
(152, 'Insert', '2015-09-16 14:00:01', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 64, 'Training Program', '2015-09-01', '2015-09-05', 'Training program on Trends and Techniques in Web Technology and Android Technology for TE students by Mr. Samsher Singh, CEO Unisoft Technology, C B D Belapur', '513', '192.168.5.234', ''),
(153, 'Insert', '2015-09-16 14:01:05', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 65, 'Workshop', '2015-09-08', '2015-09-10', 'Workshop on NS2 for TE students by Mrs. Puja Padia and Mr. A V Vidhate', '513', '192.168.5.234', ''),
(154, 'Insert', '2015-09-16 14:04:06', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 66, 'Workshop', '2015-09-16', '2015-09-16', 'Workshop on Network Security for BE students by Mr. Sachin Dedhiya', '513', '192.168.5.234', ''),
(155, 'Insert', '2015-09-16 14:05:25', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 67, 'Expert Lecture', '2015-10-07', '2015-10-07', 'Expert Lecture on Software Architecture for BE students by Prof. Kavita Kelkar', '511', '192.168.5.234', ''),
(156, 'Insert', '2015-09-16 14:56:56', 'root1@localhost', 'exam', NULL, NULL, NULL, NULL, NULL, NULL, 68, 'photo copy ', '2015-09-08', '2015-09-14', 'The students who have applied for the Photo copy of the assessed answer books of semester III to VI for the examinations held in May 15. can collect on or before 14th Sep 2015', 'exam section room no 104', '192.168.2.19', ''),
(157, 'Insert', '2015-09-16 17:33:46', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 69, 'Workshop on Webreneurship', '2015-08-08', '2015-08-09', 'Workshop on Webreneurship consisting of CMS, JOOMLA, DRUPAL Technologies and their business applications.', 'Lab No.: 513', '192.168.5.63', ''),
(158, 'Insert', '2015-09-16 17:38:24', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 70, 'Webtechnology and PHP Workshop', '2015-09-01', '2015-09-03', 'Training on Web Technology and Php for students of Third Year Computer Engineering.', 'Lab No.: 513', '192.168.5.63', ''),
(159, 'Update', '2015-09-16 17:38:56', 'root1@localhost', 'csi', 70, 'Webtechnology and PHP Workshop', '2015-09-01', '2015-09-03', 'Training on Web Technology and Php for students of Third Year Computer Engineering.', 'Lab No.: 513', 70, 'Webtechnology and PHP Workshop', '2015-09-01', '2015-09-03', 'Training on Web Technology and Php for students of Third Year Computer Engineering.', 'Lab No.: 513', '192.168.5.63', ''),
(160, 'Update', '2015-09-16 17:39:50', 'root1@localhost', 'csi', 70, 'Webtechnology and PHP Workshop', '2015-09-01', '2015-09-03', 'Training on Web Technology and Php for students of Third Year Computer Engineering.', 'Lab No.: 513', 70, 'Webtechnology and PHP Workshop', '2015-09-01', '2015-09-03', 'Training on Web Technology and Php for students of Third Year Computer Engineering.', 'Lab No.: 513', '192.168.5.63', ''),
(161, 'Update', '2015-09-16 17:40:14', 'root1@localhost', 'csi', 70, 'Webtechnology and PHP Workshop', '2015-09-01', '2015-09-03', 'Training on Web Technology and Php for students of Third Year Computer Engineering.', 'Lab No.: 513', 70, 'Webtechnology and PHP Workshop', '2015-09-01', '2015-09-03', 'Training on Web Technology and Php for students of Third Year Computer Engineering.', 'Lab No.: 513', '192.168.5.63', ''),
(162, 'Update', '2015-09-16 17:40:32', 'root1@localhost', 'csi', 69, 'Workshop on Webreneurship', '2015-08-08', '2015-08-09', 'Workshop on Webreneurship consisting of CMS, JOOMLA, DRUPAL Technologies and their business applications.', 'Lab No.: 513', 69, 'Workshop on Webreneurship', '2015-08-08', '2015-08-09', 'Workshop on Webreneurship consisting of CMS, JOOMLA, DRUPAL Technologies and their business applications.', 'Lab No.: 513', '192.168.5.63', ''),
(163, 'Insert', '2015-09-16 17:42:31', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 71, 'Basics of Computation using PY', '2015-10-10', '2015-10-11', 'Inhouse workshop on Python Programming.', 'Lab No.: 513', '192.168.5.63', ''),
(164, 'Insert', '2015-09-16 17:42:55', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 72, 'Basics of Computation using PY', '2015-10-10', '2015-10-11', 'Inhouse workshop on Python Programming.', 'Lab No.: 513', '192.168.5.63', ''),
(165, 'Insert', '2015-09-16 17:44:13', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 73, 'Basics of Computation using PY', '2015-10-10', '2015-10-11', 'Inhouse workshop on Python Programming.', 'Lab No.: 513', '192.168.5.63', ''),
(166, 'Insert', '2015-09-16 17:46:49', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 74, 'Teahtalk I', '2015-08-10', '2015-08-10', 'Talk on Internship Experience and opportunities by final year students.', 'Room No.: 511', '192.168.5.63', ''),
(167, 'Insert', '2015-09-16 17:49:10', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 75, 'Techtalk II', '2015-08-31', '2015-08-31', 'Talk on &quot;How to publish a Research Paper&quot; by external experienced speakers.', 'Room No.: 511', '192.168.5.63', ''),
(168, 'Insert', '2015-09-16 17:52:48', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 76, 'Techtalk III', '2015-09-07', '2015-09-07', 'Talk on UX/UI (User Experience/User Interface) Design by Faiz Malkani.', 'Room No.: 511', '192.168.5.63', ''),
(169, 'Insert', '2015-09-16 17:55:30', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 77, 'Techmate 2K15', '2015-10-01', '2015-10-03', '3-Day Technical Symposium conducted by CSI-RAIT.', '5th Floor', '192.168.5.63', ''),
(170, 'Update', '2015-09-16 17:56:16', 'root1@localhost', 'csi', 75, 'Techtalk II', '2015-08-31', '2015-08-31', 'Talk on &quot;How to publish a Research Paper&quot; by external experienced speakers.', 'Room No.: 511', 75, 'Techtalk II', '2015-08-31', '2015-08-31', 'Talk on &quot;How to publish a Research Paper&quot; by external experienced speakers organised by CSI-RAIT.', 'Room No.: 511', '192.168.5.63', ''),
(171, 'Update', '2015-09-16 17:57:02', 'root1@localhost', 'csi', 76, 'Techtalk III', '2015-09-07', '2015-09-07', 'Talk on UX/UI (User Experience/User Interface) Design by Faiz Malkani.', 'Room No.: 511', 76, 'Techtalk III', '2015-09-07', '2015-09-07', 'Talk on UX/UI (User Experience/User Interface) Design by Faiz Malkani organised by CSI-RAIT.', 'Room No.: 511', '192.168.5.63', ''),
(172, 'Update', '2015-09-16 17:57:25', 'root1@localhost', 'csi', 74, 'Teahtalk I', '2015-08-10', '2015-08-10', 'Talk on Internship Experience and opportunities by final year students.', 'Room No.: 511', 74, 'Teahtalk I', '2015-08-10', '2015-08-10', 'Talk on Internship Experience and opportunities by final year students organised by CSI-RAIT.', 'Room No.: 511', '192.168.5.63', ''),
(173, 'Update', '2015-09-16 17:58:07', 'root1@localhost', 'csi', 70, 'Webtechnology and PHP Workshop', '2015-09-01', '2015-09-03', 'Training on Web Technology and Php for students of Third Year Computer Engineering.', 'Lab No.: 513', 70, 'Webtechnology and PHP Workshop', '2015-09-01', '2015-09-03', 'Training on Web Technology and Php for students of Third Year Computer Engineering organised by Computer Dept. and CSI-RAIT.', 'Lab No.: 513', '192.168.5.63', ''),
(174, 'Insert', '2015-09-16 18:01:15', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 78, 'Basics of Computation using PY', '2015-10-10', '2015-10-11', 'PYTHON programming workshop.', 'Room No.: 511', '192.168.5.63', ''),
(175, 'Insert', '2015-09-16 18:01:46', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 79, 'Basics of Computation using PY', '2015-10-17', '2015-10-18', 'PYTHON programming workshop.', 'Room No.: 511', '192.168.5.63', ''),
(176, 'Delete', '2015-09-16 18:02:53', 'root1@localhost', 'csi', 73, 'Basics of Computation using PY', '2015-10-10', '2015-10-11', 'Inhouse workshop on Python Programming.', 'Lab No.: 513', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.5.63', ''),
(177, 'Delete', '2015-09-16 18:03:03', 'root1@localhost', 'csi', 78, 'Basics of Computation using PY', '2015-10-10', '2015-10-11', 'PYTHON programming workshop.', 'Room No.: 511', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.5.63', ''),
(178, 'Delete', '2015-09-16 18:03:13', 'root1@localhost', 'csi', 79, 'Basics of Computation using PY', '2015-10-17', '2015-10-18', 'PYTHON programming workshop.', 'Room No.: 511', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.5.63', ''),
(179, 'Delete', '2015-09-16 18:03:24', 'root1@localhost', 'csi', 72, 'Basics of Computation using PY', '2015-10-10', '2015-10-11', 'Inhouse workshop on Python Programming.', 'Lab No.: 513', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.5.63', ''),
(180, 'Update', '2015-09-16 18:04:07', 'root1@localhost', 'csi', 71, 'Basics of Computation using PY', '2015-10-10', '2015-10-11', 'Inhouse workshop on Python Programming.', 'Lab No.: 513', 71, 'Basics of PYTHON', '2015-10-10', '2015-10-11', 'Inhouse workshop on Python Programming.', 'Lab No.: 513', '192.168.5.63', ''),
(181, 'Update', '2015-09-16 18:04:40', 'root1@localhost', 'csi', 71, 'Basics of PYTHON', '2015-10-10', '2015-10-11', 'Inhouse workshop on Python Programming.', 'Lab No.: 513', 71, 'Basics of PYTHON', '2015-10-10', '2015-10-11', 'Inhouse workshop on Python Programming organised by CSI-RAIT.', 'Lab No.: 513', '192.168.5.63', ''),
(182, 'Insert', '2015-09-16 18:06:49', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 80, 'Techtalk IV', '2015-10-05', '2015-10-05', 'Talk on BE Project Ideas for Third Year Engineering students by CSI-RAIT.  ', 'Room No.: 511', '192.168.5.63', ''),
(183, 'Insert', '2015-09-16 18:08:34', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 81, 'Workshop', '2016-01-30', '2016-01-31', 'Organised by CSI-RAIT.', 'Lab No.: 513', '192.168.5.63', ''),
(184, 'Insert', '2015-09-16 18:13:45', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 82, 'Workshop on Designing Using Co', '2016-02-20', '2016-02-21', 'Creative designing workshop using Corel Draw-(Designing S/W), organised by CSI-RAIT.', 'Lab No.: 513', '192.168.5.63', ''),
(185, 'Insert', '2015-09-16 18:15:18', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 83, 'Workshop on Designing.', '2016-02-20', '2016-02-21', 'Creative designing workshop using Corel Draw-(Designing S/W), organised by CSI-RAIT.', 'Lab No.: 513', '192.168.5.63', ''),
(186, 'Insert', '2015-09-16 18:15:41', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 84, 'Workshop on Designing.', '2016-02-20', '2016-02-21', 'Creative designing workshop using Corel Draw-(Designing S/W), organised by CSI-RAIT.', 'Lab No.: 513', '192.168.5.63', ''),
(187, 'Insert', '2015-09-16 18:21:50', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 85, 'Expert Lecture', '2015-09-23', '2015-09-23', 'Expert Lecture by Dr Vrunda Joshi (PVG College of Engineering, Pune) on Spherical Robot: Design and Control.', 'RAIT', '192.168.5.234', ''),
(188, 'Insert', '2015-09-16 18:22:11', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 86, 'Expert Lecture', '2015-09-23', '2015-09-23', 'Expert Lecture by Dr Vrunda Joshi (PVG College of Engineering, Pune) on Spherical Robot: Design and Control.', 'RAIT', '192.168.5.234', ''),
(189, 'Insert', '2015-09-16 18:23:04', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 87, 'Training Program', '2015-10-07', '2015-10-10', 'Hands-on Training Session on Programmable System on Chip (PSoC) using ARM Micro-controllers by Eduvance Technology Ltd.', 'RAIT', '192.168.5.234', ''),
(190, 'Insert', '2015-09-16 18:23:54', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 88, 'Industrial visit', '2015-10-17', '2015-10-17', ' Industrial visit of BE and ME students to M/S Hind Rectifiers, Bhandup.', 'Bhandup', '192.168.5.234', ''),
(191, 'Insert', '2015-09-16 18:24:40', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 89, 'Expert Lecture', '2015-10-30', '2015-10-30', ' Expert Lecture by Mr Ramanan (CEO, Gauranga SoftTech Ltd.) on Career Opportunities for Electronics Graduates in Embedded Systems.\r\n', 'RAIT', '192.168.5.234', ''),
(192, 'Insert', '2015-09-16 18:25:30', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 90, 'Workshop', '2015-11-20', '2015-11-21', '2-day Hands-on Session on COMSOL by Prof Sachin Umbarkar.\r\n', 'RAIT', '192.168.5.234', ''),
(193, 'Insert', '2015-09-16 18:26:04', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 91, 'Expert Lecture', '2015-11-27', '2015-11-27', 'Expert Lecture by Prof Sharad Bhartiya (IIT Bombay) on Systems Biology.\r\n', 'RAIT', '192.168.5.234', ''),
(194, 'Insert', '2015-09-16 18:26:21', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 92, 'Expert Lecture', '2015-11-27', '2015-11-27', 'Expert Lecture by Prof Sharad Bhartiya (IIT Bombay) on Systems Biology.', 'RAIT', '192.168.5.234', ''),
(195, 'Insert', '2015-09-16 18:29:08', 'root1@localhost', 'hodce5', NULL, NULL, NULL, NULL, NULL, NULL, 93, 'meeting', '2015-09-14', '2015-09-14', ' meeting between Tech-Mahindra delegates and HODs on Monday , 14th September, 2015 at 11:20 am to 11:45 am \r\nObjective: &quot; Understanding the industry requirements &quot; ', 'Placement Room', '192.168.5.234', ''),
(196, 'Insert', '2015-09-18 08:52:19', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 94, 'Talk by Padmashree Dr. Sharad ', '2015-08-19', '2015-08-19', 'Special talk on Biogas Technology, Life Science and Waste Management', '615', '192.168.2.187', ''),
(197, 'Insert', '2015-09-18 08:52:51', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 95, 'Talk by Padmashree Dr. Sharad ', '2015-08-19', '2015-08-19', 'Special talk on Biogas Technology, Life Science and Waste Management', '615', '192.168.2.187', ''),
(198, 'Insert', '2015-09-18 08:53:07', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 96, 'Talk by Padmashree Dr Sharad K', '2015-08-19', '2015-08-19', 'Special talk on Biogas Technology, Life Science and Waste Management', '615', '192.168.2.187', ''),
(199, 'Insert', '2015-09-18 08:53:52', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 97, 'Talk by Padmashree Dr Sharad K', '2015-08-19', '2015-08-19', 'Special talk on Biogas Technology, Life Science and Waste Management', '615', '192.168.2.187', ''),
(200, 'Insert', '2015-09-18 08:57:43', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 98, 'Guest Lecture by Padmashree Dr', '2015-08-19', '2015-08-19', 'Special lecture on biogas technology, waste management and life sciences  ', '615', '192.168.2.187', ''),
(201, 'Insert', '2015-09-18 08:58:15', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 99, 'Guest Lecture by Padmashree Dr', '2015-08-19', '2015-08-19', 'Special lecture on biogas technology, waste management and life sciences  ', '615', '192.168.2.187', ''),
(202, 'Insert', '2015-09-18 09:01:50', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 100, 'Special Lecture by Dr Kale', '2015-08-19', '2015-08-19', 'Special lecture on biogas technology, waste management and life sciences  ', '615', '192.168.2.187', ''),
(203, 'Insert', '2015-09-18 09:15:52', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 101, 'Workshop on stress managemnet', '2013-08-20', '2013-08-20', 'Stress Management by Faculty of Bramha Kumari', '611', '192.168.2.187', ''),
(204, 'Insert', '2015-09-18 09:17:47', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 102, 'Technical Talk', '2014-09-24', '2014-09-24', 'Seminar by Dr Zakir Taquvi Ex NASA', '615', '192.168.2.187', ''),
(205, 'Insert', '2015-09-18 09:21:06', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 103, 'Workshop on stress managemnet', '2014-02-06', '2014-02-07', 'Stress Management workshop by Ramkrishna Mission to the students so that they can achieve success in their life', '611', '192.168.2.187', ''),
(206, 'Insert', '2015-09-18 09:24:46', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 104, 'Workshop on Syllabus Revision ', '2012-09-11', '2012-09-11', 'Orientation Programme on the revised syllabus of Applied Chemistry I &amp; II on the behalf of University of Mumbai. This workshop was organized to get familiar with new pattern of curriculum. ', '615', '192.168.2.187', ''),
(207, 'Insert', '2015-09-18 09:25:28', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 105, 'Workshop on revised syllabus', '2012-09-11', '2012-09-11', 'Orientation Programme on the revised syllabus of Applied Chemistry I &amp; II on the behalf of University of Mumbai. This workshop was organized to get familiar with new pattern of curriculum. ', '615', '192.168.2.187', ''),
(208, 'Insert', '2015-09-18 09:30:16', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 106, 'Special Lecture by Padmashree ', '2015-03-18', '2015-03-18', 'Padmashree Dr. Basu is Director of BARC, Mumbai delivered lecture on Nuclear Physics and research programs performed by BARC to the development of India', 'Auditorium', '192.168.2.187', ''),
(209, 'Insert', '2015-09-18 09:30:33', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 107, 'Guest Lecture by Padmashree Dr', '2015-03-18', '2015-03-18', 'Padmashree Dr. Basu is Director of BARC, Mumbai delivered lecture on Nuclear Physics and research programs performed by BARC to the development of India', 'Auditorium', '192.168.2.187', ''),
(210, 'Insert', '2015-09-18 09:30:45', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 108, 'Guest Lecture by Padmashree Dr', '2015-03-18', '2015-03-18', 'Padmashree Dr. Basu is Director of BARC, Mumbai delivered lecture on Nuclear Physics and research programs performed by BARC to the development of India', 'Auditorium', '192.168.2.187', ''),
(211, 'Insert', '2015-09-18 09:32:44', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 109, 'Talk by Dr Basu', '2015-03-18', '2015-03-18', 'Padmashree Dr Basu (Director, BARC) delivered talk on development of Nuclear Physics in India and role of BARC in the development of India', 'Auditorium', '192.168.2.187', ''),
(212, 'Insert', '2015-09-18 09:35:05', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 110, 'Talk by Dr Naba Mandal', '2014-09-25', '2014-09-25', 'Dr. Naba Mandal from BARC delivered talk on Neutrino Physics', '615', '192.168.2.187', ''),
(213, 'Insert', '2015-09-18 09:37:21', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 111, 'Guest Lecture by Dr S Ghosh', '2015-02-18', '2015-02-18', 'Dr. S Ghosh is scientist in BARC and working at Biotechnology division. He introduced students that how technology can be used to develop biogas and how it can be controlled.', '615', '192.168.2.187', ''),
(214, 'Insert', '2015-09-18 09:40:18', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 112, 'Workshop on Sahaj Yoga', '2015-03-02', '2015-03-05', 'Sahaj Yoga Meditation. Faculty of Sahaj Yoga', '611', '192.168.2.187', '');
INSERT INTO `cal_events_log` (`log_id`, `action`, `action_time`, `user`, `web_user`, `old_event_id`, `old_event_name`, `old_start_date`, `old_end_date`, `old_event_desc`, `old_location`, `new_event_id`, `new_event_name`, `new_start_date`, `new_end_date`, `new_event_desc`, `new_location`, `remote_addr`, `http_x_forwarded_for`) VALUES
(215, 'Insert', '2015-09-18 09:44:17', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 113, 'FE Orientation Program 2015', '2015-07-27', '2015-07-27', 'FE orientation programmed conducted very smoothly under guidance of Prof Dr. S. D. Shete Head of Engineering Science Department. He addressed new students about engineering in RAIT and guided them so that they can achieve success in their carrier ', 'Auditorium', '192.168.2.187', ''),
(216, 'Insert', '2015-09-18 09:45:47', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 114, 'FE Orientation Program 2015', '2014-07-21', '2014-07-21', 'FE orientation programmed conducted very smoothly under guidance of Prof Dr. S. D. Shete Head of Engineering Science Department. He addressed new students about engineering in RAIT and guided them so that they can achieve success in their carrier. Students and their parents were very much pleased with the guidance provided by Prof. Dr. S. D. Shete sir', 'Auditorium', '192.168.2.187', ''),
(217, 'Insert', '2015-09-18 09:49:52', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 115, 'FE Orientation Program 2013', '2013-07-29', '2013-07-29', 'FE orientation programmed conducted very smoothly under guidance of Prof Dr. S. D. Shete Head of Engineering Science Department. He addressed new students about engineering in RAIT and guided them so that they can achieve success in their carrier. Students and their parents were very much pleased with the guidance provided by Prof. Dr. S. D. Shete sir. ', 'Auditorium', '192.168.2.187', ''),
(218, 'Insert', '2015-09-18 09:58:29', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 116, 'Workshop on Question Paper pat', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. He was nominated as chairman by University of Mumbai ', '615', '192.168.2.187', ''),
(219, 'Insert', '2015-09-18 09:58:52', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 117, 'Workshop on Question Paper pat', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. He was nominated as chairman by University of Mumbai ', '615', '192.168.2.187', ''),
(220, 'Insert', '2015-09-18 09:59:19', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 118, 'Work on behalf of University o', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. He was nominated as chairman by University of Mumbai ', '615', '192.168.2.187', ''),
(221, 'Insert', '2015-09-18 09:59:42', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 119, 'Workshop on behalf of Universi', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. He was nominated as chairman by University of Mumbai ', '615', '192.168.2.187', ''),
(222, 'Insert', '2015-09-18 10:00:17', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 120, 'Workshop on behalf of Universi', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', '192.168.2.187', ''),
(223, 'Insert', '2015-09-18 10:00:43', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 121, 'Workshop for question paper pa', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', '192.168.2.187', ''),
(224, 'Insert', '2015-09-18 10:00:58', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 122, 'Workshop for question paper pa', '2012-09-13', '2012-09-13', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', '192.168.2.187', ''),
(225, 'Insert', '2015-09-18 10:01:22', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 123, 'Program for question paper pat', '2012-09-13', '2012-09-13', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', '192.168.2.187', ''),
(226, 'Insert', '2015-09-18 10:02:03', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 124, 'Question Paper Pattern Develop', '2012-09-13', '2012-09-13', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', '192.168.2.187', ''),
(227, 'Insert', '2015-09-18 10:03:29', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 125, 'Workshop on Blueprint of Appli', '2012-09-12', '2012-09-12', 'he workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee  was Prof. Dr. S. D. Shete, (nominated by University of Mumbai) Head of Department of Engineering Sciences, RAIT. ', '611', '192.168.2.187', ''),
(228, 'Insert', '2015-09-18 10:03:46', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 126, 'Workshop on Blueprint of Appli', '2012-09-11', '2012-09-11', 'he workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee  was Prof. Dr. S. D. Shete, (nominated by University of Mumbai) Head of Department of Engineering Sciences, RAIT. ', '611', '192.168.2.187', ''),
(229, 'Insert', '2015-09-18 10:04:24', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 127, 'Workshop on Blueprint of Appli', '2012-09-11', '2012-09-11', 'The Chairman of committee  was Prof. Dr. S. D. Shete, (nominated by University of Mumbai) Head of Department of Engineering Sciences, RAIT. ', '611', '192.168.2.187', ''),
(230, 'Insert', '2015-09-18 10:04:57', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 128, 'Workshop on behalf of Mumbai U', '2012-09-11', '2012-09-11', 'The Chairman of committee  was Prof. Dr. S. D. Shete, (nominated by University of Mumbai) Head of Department of Engineering Sciences, RAIT. ', '611', '192.168.2.187', ''),
(231, 'Insert', '2015-09-18 10:07:48', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 129, 'Workshop on behalf of Mumbai U', '2012-09-11', '2012-09-11', 'Workshop for development of blue print for the subject of Applied Chemistry I &amp; II. The Chairman of Committee was Prof. Dr. S. D. Shete, HOD dept of Engineering Sciences. He was nominated as chairman by University of Mumbai', '615', '192.168.2.187', ''),
(232, 'Insert', '2015-09-18 10:08:03', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 130, 'Seminar on behalf of Mumbai Un', '2012-09-11', '2012-09-11', 'Workshop for development of blue print for the subject of Applied Chemistry I &amp; II. The Chairman of Committee was Prof. Dr. S. D. Shete, HOD dept of Engineering Sciences. He was nominated as chairman by University of Mumbai', '615', '192.168.2.187', ''),
(233, 'Insert', '2015-09-18 10:08:16', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 131, 'Seminar on behalf of Mumbai Un', '2012-09-13', '2012-09-13', 'Workshop for development of blue print for the subject of Applied Chemistry I &amp; II. The Chairman of Committee was Prof. Dr. S. D. Shete, HOD dept of Engineering Sciences. He was nominated as chairman by University of Mumbai', '615', '192.168.2.187', ''),
(234, 'Insert', '2015-09-18 10:09:06', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 132, 'workshop on development of blu', '2012-09-13', '2012-09-13', 'Workshop for development of blue print for the subject of Applied Chemistry I &amp; II. The Chairman of Committee was Prof. Dr. S. D. Shete, HOD dept of Engineering Sciences. He was nominated as chairman by University of Mumbai', '615', '192.168.2.187', ''),
(235, 'Insert', '2015-09-18 10:09:33', 'root1@localhost', 'hodes', NULL, NULL, NULL, NULL, NULL, NULL, 133, 'workshop on development of blu', '2012-09-11', '2012-09-11', 'Workshop for development of blue print for the subject of Applied Chemistry I &amp; II. The Chairman of Committee was Prof. Dr. S. D. Shete, HOD dept of Engineering Sciences. He was nominated as chairman by University of Mumbai', '615', '192.168.2.187', ''),
(236, 'Delete', '2015-09-18 11:06:52', 'root1@localhost', 'hodes', 114, 'FE Orientation Program 2015', '2014-07-21', '2014-07-21', 'FE orientation programmed conducted very smoothly under guidance of Prof Dr. S. D. Shete Head of Engineering Science Department. He addressed new students about engineering in RAIT and guided them so that they can achieve success in their carrier. Students and their parents were very much pleased with the guidance provided by Prof. Dr. S. D. Shete sir', 'Auditorium', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(237, 'Delete', '2015-09-18 11:07:21', 'root1@localhost', 'hodce5', 86, 'Expert Lecture', '2015-09-23', '2015-09-23', 'Expert Lecture by Dr Vrunda Joshi (PVG College of Engineering, Pune) on Spherical Robot: Design and Control.', 'RAIT', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(238, 'Delete', '2015-09-18 11:08:06', 'root1@localhost', 'hodes', 115, 'FE Orientation Program 2013', '2013-07-29', '2013-07-29', 'FE orientation programmed conducted very smoothly under guidance of Prof Dr. S. D. Shete Head of Engineering Science Department. He addressed new students about engineering in RAIT and guided them so that they can achieve success in their carrier. Students and their parents were very much pleased with the guidance provided by Prof. Dr. S. D. Shete sir. ', 'Auditorium', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(239, 'Delete', '2015-09-18 11:08:25', 'root1@localhost', 'hodes', 108, 'Guest Lecture by Padmashree Dr', '2015-03-18', '2015-03-18', 'Padmashree Dr. Basu is Director of BARC, Mumbai delivered lecture on Nuclear Physics and research programs performed by BARC to the development of India', 'Auditorium', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(240, 'Delete', '2015-09-18 11:09:13', 'root1@localhost', 'hodce5', 23, 'Holiday', '2015-09-17', '2015-09-17', 'Ganesh Chaturti', 'With Family and Ground Floor R', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(241, 'Delete', '2015-09-18 11:09:27', 'root1@localhost', 'hodce5', 25, 'Holiday', '2015-09-17', '2015-09-17', 'Ganesh Chaturti', 'Ground Floor RAIT', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(242, 'Delete', '2015-09-18 11:09:47', 'root1@localhost', 'hodce5', 22, 'Holiday', '2015-09-17', '2015-09-17', 'Ganesh Chaturti', 'With Family and Ground Floor R', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(243, 'Delete', '2015-09-18 11:10:03', 'root1@localhost', 'hodes', 123, 'Program for question paper pat', '2012-09-13', '2012-09-13', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(244, 'Delete', '2015-09-18 11:10:50', 'root1@localhost', 'hodes', 131, 'Seminar on behalf of Mumbai Un', '2012-09-13', '2012-09-13', 'Workshop for development of blue print for the subject of Applied Chemistry I &amp; II. The Chairman of Committee was Prof. Dr. S. D. Shete, HOD dept of Engineering Sciences. He was nominated as chairman by University of Mumbai', '615', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(245, 'Delete', '2015-09-18 11:11:08', 'root1@localhost', 'hodes', 96, 'Talk by Padmashree Dr Sharad K', '2015-08-19', '2015-08-19', 'Special talk on Biogas Technology, Life Science and Waste Management', '615', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(246, 'Delete', '2015-09-18 11:11:18', 'root1@localhost', 'hodes', 95, 'Talk by Padmashree Dr. Sharad ', '2015-08-19', '2015-08-19', 'Special talk on Biogas Technology, Life Science and Waste Management', '615', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(247, 'Delete', '2015-09-18 11:11:30', 'root1@localhost', 'hodes', 97, 'Talk by Padmashree Dr Sharad K', '2015-08-19', '2015-08-19', 'Special talk on Biogas Technology, Life Science and Waste Management', '615', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(248, 'Delete', '2015-09-18 11:12:51', 'root1@localhost', 'hodce5', 33, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri, Uran by RAIT students', 'Dronagiri', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(249, 'Delete', '2015-09-18 11:13:07', 'root1@localhost', 'hodce5', 54, 'tree-plantation', '2015-08-22', '2015-08-22', '150 Tree plantation by 110 students ', 'Dronagiri ', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(250, 'Delete', '2015-09-18 11:13:30', 'root1@localhost', 'hodce5', 49, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri  by students', 'Uran', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(251, 'Delete', '2015-09-18 11:13:44', 'root1@localhost', 'hodce5', 47, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri  by students', 'Uran', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(252, 'Delete', '2015-09-18 11:14:07', 'root1@localhost', 'hodce5', 44, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri  by RAIT students', 'Uran', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(253, 'Delete', '2015-09-18 11:14:22', 'root1@localhost', 'hodce5', 45, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri  by RAIT students', 'Uran', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(254, 'Delete', '2015-09-18 11:14:37', 'root1@localhost', 'hodce5', 52, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree palntation at Dronagiri ', 'Uran', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(255, 'Delete', '2015-09-18 11:15:07', 'root1@localhost', 'hodce5', 48, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri  by students', 'Uran', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(256, 'Delete', '2015-09-18 11:15:22', 'root1@localhost', 'hodce5', 43, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri  by RAIT students', 'Uran', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(257, 'Delete', '2015-09-18 11:15:45', 'root1@localhost', 'hodce5', 41, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri  by 102 RAIT students', 'RAIT Glass door', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(258, 'Delete', '2015-09-18 11:16:14', 'root1@localhost', 'hodce5', 51, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri ', 'Uran', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(259, 'Delete', '2015-09-18 11:16:37', 'root1@localhost', 'hodce5', 50, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri ', 'Uran', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(260, 'Delete', '2015-09-18 11:16:58', 'root1@localhost', 'hodce5', 39, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri  by RAIT students', 'Uran', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(261, 'Delete', '2015-09-18 11:18:36', 'root1@localhost', 'hodce5', 34, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri, Uran by RAIT students', 'Dr', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(262, 'Delete', '2015-09-18 11:18:52', 'root1@localhost', 'hodce5', 36, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri, Uran by RAIT students', 'Uran', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(263, 'Delete', '2015-09-18 11:19:16', 'root1@localhost', 'hodce5', 37, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri, Uran by RAIT students', 'Uran', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(264, 'Delete', '2015-09-18 11:19:29', 'root1@localhost', 'hodce5', 32, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri, Uran by RAIT students', 'Dronagiri', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(265, 'Delete', '2015-09-18 11:19:45', 'root1@localhost', 'hodce5', 38, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri  by RAIT students', 'Uran', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(266, 'Delete', '2015-09-18 11:19:56', 'root1@localhost', 'hodce5', 46, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', 'Tree plantation at Dronagiri  by RAIT students', 'Uran', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(267, 'Delete', '2015-09-18 11:20:19', 'root1@localhost', 'hodce5', 35, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri, Uran by RAIT students', 'Dronagiri', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(268, 'Delete', '2015-09-18 11:21:15', 'root1@localhost', 'hodes', 126, 'Workshop on Blueprint of Appli', '2012-09-11', '2012-09-11', 'he workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee  was Prof. Dr. S. D. Shete, (nominated by University of Mumbai) Head of Department of Engineering Sciences, RAIT. ', '611', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(269, 'Delete', '2015-09-18 11:21:44', 'root1@localhost', 'hodes', 119, 'Workshop on behalf of Universi', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. He was nominated as chairman by University of Mumbai ', '615', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(270, 'Delete', '2015-09-18 11:22:00', 'root1@localhost', 'hodes', 125, 'Workshop on Blueprint of Appli', '2012-09-12', '2012-09-12', 'he workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee  was Prof. Dr. S. D. Shete, (nominated by University of Mumbai) Head of Department of Engineering Sciences, RAIT. ', '611', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(271, 'Delete', '2015-09-18 11:22:24', 'root1@localhost', 'hodes', 132, 'workshop on development of blu', '2012-09-13', '2012-09-13', 'Workshop for development of blue print for the subject of Applied Chemistry I &amp; II. The Chairman of Committee was Prof. Dr. S. D. Shete, HOD dept of Engineering Sciences. He was nominated as chairman by University of Mumbai', '615', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(272, 'Delete', '2015-09-18 11:23:26', 'root1@localhost', 'csi', 84, 'Workshop on Designing.', '2016-02-20', '2016-02-21', 'Creative designing workshop using Corel Draw-(Designing S/W), organised by CSI-RAIT.', 'Lab No.: 513', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(273, 'Delete', '2015-09-18 11:23:46', 'root1@localhost', 'hodes', 129, 'Workshop on behalf of Mumbai U', '2012-09-11', '2012-09-11', 'Workshop for development of blue print for the subject of Applied Chemistry I &amp; II. The Chairman of Committee was Prof. Dr. S. D. Shete, HOD dept of Engineering Sciences. He was nominated as chairman by University of Mumbai', '615', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(274, 'Delete', '2015-09-18 11:24:14', 'root1@localhost', 'pa', 8, 'Youth &amp; Communal Harmony- ', '2015-08-31', '2015-08-31', 'Youth &amp; Communal Harmony- School of Eduction', 'Room No 615', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(275, 'Delete', '2015-09-18 11:24:25', 'root1@localhost', 'pa', 7, 'Youth &amp; Communal Harmony- ', '2015-08-31', '2015-08-31', 'Youth &amp; Communal Harmony- School of Eduction', 'Room No 615', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(276, 'Delete', '2015-09-18 11:24:33', 'root1@localhost', 'pa', 9, 'Youth &amp; Communal Harmony- ', '2015-09-04', '2015-09-04', 'Youth &amp; Communal Harmony- School of Eduction from 9.00am to 02.00pm', 'Room No 615', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(277, 'Insert', '2015-09-28 11:54:13', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 134, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.\r\nSuccessfully planned and Conducted.', '616 LAB', '192.168.6.137', ''),
(278, 'Insert', '2015-09-28 11:54:47', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 135, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.\\r\\nSuccessfully planned and Conducted.', '616 LAB', '192.168.6.137', ''),
(279, 'Insert', '2015-09-28 11:54:59', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 136, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.\\\\r\\\\nSuccessfully planned and Conducted.', '616 LAB', '192.168.6.137', ''),
(280, 'Insert', '2015-09-28 11:55:41', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 137, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616 LAB', '192.168.6.137', ''),
(281, 'Insert', '2015-09-28 11:55:51', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 138, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616 LAB', '192.168.6.137', ''),
(282, 'Insert', '2015-09-28 11:56:49', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 139, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616 LAB', '192.168.6.137', ''),
(283, 'Insert', '2015-09-28 11:57:27', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 140, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616 LAB', '192.168.6.137', ''),
(284, 'Insert', '2015-09-28 11:58:44', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 141, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', '192.168.6.137', ''),
(285, 'Insert', '2015-09-28 11:59:05', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 142, 'Workshop on Android App Develo', '2015-09-28', '2015-09-29', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', '192.168.6.137', ''),
(286, 'Insert', '2015-09-28 11:59:17', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 143, 'Workshop on Android App Develo', '2015-09-28', '2015-09-29', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', '192.168.6.137', ''),
(287, 'Insert', '2015-09-28 11:59:44', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 144, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', '192.168.6.137', ''),
(288, 'Insert', '2015-09-28 12:01:16', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 145, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', '192.168.6.137', ''),
(289, 'Insert', '2015-09-28 12:01:34', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 146, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', '192.168.6.137', ''),
(290, 'Delete', '2015-09-28 12:02:47', 'root1@localhost', 'hod', 143, 'Workshop on Android App Develo', '2015-09-28', '2015-09-29', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.6.137', ''),
(291, 'Update', '2015-09-28 12:03:10', 'root1@localhost', 'hod', 142, 'Workshop on Android App Develo', '2015-09-28', '2015-09-29', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', 142, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', '192.168.6.137', ''),
(292, 'Delete', '2015-09-28 12:09:14', 'root1@localhost', 'hod', 144, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.6.137', ''),
(293, 'Delete', '2015-09-28 12:10:01', 'root1@localhost', 'hod', 141, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.6.137', ''),
(294, 'Delete', '2015-09-28 12:12:41', 'root1@localhost', 'hod', 139, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616 LAB', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.6.137', ''),
(295, 'Delete', '2015-09-28 12:13:20', 'root1@localhost', 'hod', 146, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.6.137', ''),
(296, 'Delete', '2015-09-28 12:13:51', 'root1@localhost', 'hodce5', 18, 'Training', '2015-09-25', '2015-09-26', 'Android OS and Open Source Technology', '613', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.6.137', ''),
(297, 'Delete', '2015-09-28 12:14:10', 'root1@localhost', 'hod', 145, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.6.137', ''),
(298, 'Delete', '2015-09-28 12:14:38', 'root1@localhost', 'hod', 140, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616 LAB', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.6.137', ''),
(299, 'Delete', '2015-09-28 12:14:55', 'root1@localhost', 'hod', 135, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.\\r\\nSuccessfully planned and Conducted.', '616 LAB', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.6.137', ''),
(300, 'Delete', '2015-09-28 12:15:10', 'root1@localhost', 'hod', 134, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.\r\nSuccessfully planned and Conducted.', '616 LAB', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.6.137', ''),
(301, 'Delete', '2015-09-28 12:15:24', 'root1@localhost', 'hod', 137, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616 LAB', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.6.137', ''),
(302, 'Delete', '2015-09-28 12:15:43', 'root1@localhost', 'hod', 138, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616 LAB', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.6.137', ''),
(303, 'Delete', '2015-09-28 12:15:57', 'root1@localhost', 'hod', 136, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.\\\\r\\\\nSuccessfully planned and Conducted.', '616 LAB', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.6.137', ''),
(304, 'Update', '2015-09-28 12:17:07', 'root1@localhost', 'hod', 142, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', 142, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', '192.168.6.137', ''),
(305, 'Update', '2015-09-28 12:18:43', 'root1@localhost', 'hod', 142, 'Workshop on Android App Develo', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', 142, 'Workshop &quot;Android App Dev', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', '192.168.6.137', ''),
(306, 'Update', '2015-09-28 12:19:40', 'root1@localhost', 'hod', 142, 'Workshop &quot;Android App Dev', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', 142, 'Workshop on Android', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', '192.168.6.137', ''),
(307, 'Update', '2015-09-28 12:23:39', 'root1@localhost', 'hod', 17, 'Expert Lecture', '2015-10-01', '2015-10-01', 'Expert Talk Series', '615', 17, 'Expert Lecture', '2015-10-01', '2015-10-01', 'Expert Talk Series\r\nSession-I Expert Talk on\r\nâ€œEvolution of computing grids and cloudsâ€ by \r\nDr. B.S.Jagadeesh, BARC\r\n\r\n\r\n', '615', '192.168.6.137', ''),
(308, 'Insert', '2015-09-28 12:25:02', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 147, 'Expert Talk Series', '2015-10-01', '2015-10-01', 'Session-II Expert Talk on \r\nâ€œCryptography - Then and Nowâ€\r\nby Dr. Dipan Ghosh, \r\nIIT Mumbai\r\n', '615', '192.168.6.137', ''),
(309, 'Insert', '2015-10-05 13:55:40', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 148, 'NTPP', '2015-10-01', '2015-10-03', 'Technical Paper Presentation Competition conducted by CSI under Computer Department', '615', '10.0.0.1', ''),
(310, 'Insert', '2015-10-05 15:17:50', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 149, 'Placement Mantra', '2015-10-01', '2015-10-03', 'Most popular event of Techmate giving experience of mock placements to the participants.', '515 and 520', '10.0.0.1', ''),
(311, 'Insert', '2015-10-05 15:20:54', 'root1@localhost', 'csi', NULL, NULL, NULL, NULL, NULL, NULL, 150, 'Next Aim', '2015-10-01', '2015-10-03', 'Event providing mock practice for examinations of higher education such as GRE, GMAT conducted by CSI under Computer Department.', '514', '10.0.0.1', ''),
(312, 'Insert', '2015-10-08 08:55:39', 'root1@localhost', 'hoden', NULL, NULL, NULL, NULL, NULL, NULL, 151, 'ARM University (UK) Workshop', '2015-10-07', '2015-10-11', 'The workshop is arranged for third year students. It will be given by Eduvance, Mumbai in collaboration with ARM University (UK) and Cypress Semiconductors. ', 'IT Centre (2nd FLoor)', '192.168.4.65', ''),
(313, 'Insert', '2015-10-08 08:58:32', 'root1@localhost', 'hoden', NULL, NULL, NULL, NULL, NULL, NULL, 152, 'Demo of New Library Software (', '2015-10-07', '2015-10-07', 'For faculty and students.', '615', '192.168.4.65', ''),
(314, 'Insert', '2015-10-08 08:59:07', 'root1@localhost', 'hoden', NULL, NULL, NULL, NULL, NULL, NULL, 153, 'Demo of New Library Software (', '2015-10-07', '2015-10-07', 'For faculty and students.', '615', '192.168.4.65', ''),
(315, 'Insert', '2015-10-08 08:59:12', 'root1@localhost', 'hoden', NULL, NULL, NULL, NULL, NULL, NULL, 154, 'Demo of New Library Software (', '2015-10-07', '2015-10-07', 'For faculty and students.', '615', '192.168.4.65', ''),
(316, 'Insert', '2015-10-08 08:59:18', 'root1@localhost', 'hoden', NULL, NULL, NULL, NULL, NULL, NULL, 155, 'Demo of New Library Software (', '2015-10-07', '2015-10-07', 'For faculty and students.', '615', '192.168.4.65', ''),
(317, 'Insert', '2015-10-08 09:00:38', 'root1@localhost', 'hoden', NULL, NULL, NULL, NULL, NULL, NULL, 156, 'Training of Library staff for ', '2015-10-10', '2015-10-10', 'For Library and BVG (Tech) staff.', '511/611', '192.168.4.65', ''),
(318, 'Insert', '2015-10-08 09:00:50', 'root1@localhost', 'hoden', NULL, NULL, NULL, NULL, NULL, NULL, 157, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511/611', '192.168.4.65', ''),
(319, 'Insert', '2015-10-08 09:01:00', 'root1@localhost', 'hoden', NULL, NULL, NULL, NULL, NULL, NULL, 158, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511', '192.168.4.65', ''),
(320, 'Insert', '2015-10-08 09:01:06', 'root1@localhost', 'hoden', NULL, NULL, NULL, NULL, NULL, NULL, 159, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511', '192.168.4.65', ''),
(321, 'Insert', '2015-10-08 09:01:17', 'root1@localhost', 'hoden', NULL, NULL, NULL, NULL, NULL, NULL, 160, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511', '192.168.4.65', ''),
(322, 'Insert', '2015-10-08 09:02:53', 'root1@localhost', 'hoden', NULL, NULL, NULL, NULL, NULL, NULL, 161, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511', '192.168.4.65', ''),
(323, 'Insert', '2015-10-08 09:03:12', 'root1@localhost', 'hoden', NULL, NULL, NULL, NULL, NULL, NULL, 162, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511', '192.168.4.65', ''),
(324, 'Insert', '2015-11-23 12:02:01', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 163, 'test', '2015-11-10', '2015-11-10', 'test', 'Room No. 615', '10.0.0.4', ''),
(325, 'Insert', '2015-11-23 12:06:24', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 164, 'testing', '2015-11-10', '2015-11-10', 'test event please ignore', '5th floor', '10.0.0.4', ''),
(326, 'Update', '2015-11-23 12:07:14', 'root1@localhost', 'faculty', 164, 'testing', '2015-11-10', '2015-11-10', 'test event please ignore', '5th floor', 164, 'testing', '2015-11-10', '2015-11-10', 'test event please ignore', '5th floor', '10.0.0.4', ''),
(327, 'Update', '2015-11-23 12:08:14', 'root1@localhost', 'faculty', 164, 'testing', '2015-11-10', '2015-11-10', 'test event please ignore', '5th floor', 164, 'testing', '2015-11-10', '2015-11-10', 'test event please ignore', '5th floor', '10.0.0.4', ''),
(328, 'Update', '2015-11-23 12:08:38', 'root1@localhost', 'faculty', 164, 'testing', '2015-11-10', '2015-11-10', 'test event please ignore', '5th floor', 164, 'testing', '2015-11-10', '2015-11-10', 'test event please ignore', '5th floor', '10.0.0.4', ''),
(329, 'Insert', '2015-11-23 12:25:47', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 165, 'testing', '2015-11-24', '2015-11-24', 'test event please ignore', 'RAIT', '10.0.0.4', ''),
(330, 'Update', '2015-11-23 12:26:49', 'root1@localhost', 'hod', 165, 'testing', '2015-11-24', '2015-11-24', 'test event please ignore', 'RAIT', 165, 'testing', '2015-11-24', '2015-11-24', 'test event please ignore1', 'RAIT', '10.0.0.4', ''),
(331, 'Delete', '2015-11-24 10:55:32', 'root1@localhost', 'faculty', 164, 'testing', '2015-11-10', '2015-11-10', 'test event please ignore', '5th floor', NULL, NULL, NULL, NULL, NULL, NULL, '106.79.116.139', ''),
(332, 'Delete', '2015-11-24 10:55:41', 'root1@localhost', 'hod', 165, 'testing', '2015-11-24', '2015-11-24', 'test event please ignore1', 'RAIT', NULL, NULL, NULL, NULL, NULL, NULL, '106.79.116.139', ''),
(333, 'Insert', '2016-01-07 10:34:35', 'root1@localhost', 'PA', NULL, NULL, NULL, NULL, NULL, NULL, 164, 'Making Interactive teaching Ha', '2016-01-08', '2016-01-08', 'Session on interactive and participating learning experience by\r\n1) Dr. Ramesh Vasappanavara\r\n2) Dr. M. S Bhatia\r\n3) Mr. hardik Bhatia\r\n\r\nTiming- 2 PM', '615 @ 2PM', '10.0.0.4', ''),
(334, 'Insert', '2016-01-07 10:34:58', 'root1@localhost', 'PA', NULL, NULL, NULL, NULL, NULL, NULL, 165, 'Making Interactive teaching Ha', '2016-01-08', '2016-01-08', 'Session on interactive and participating learning experience by\\r\\n1) Dr. Ramesh Vasappanavara\\r\\n2) Dr. M. S Bhatia\\r\\n3) Mr. hardik Bhatia\\r\\n\\r\\nTiming- 2 PM', '615 @ 2PM', '10.0.0.4', ''),
(335, 'Insert', '2016-01-07 10:35:11', 'root1@localhost', 'PA', NULL, NULL, NULL, NULL, NULL, NULL, 166, 'Making Interactive teaching Ha', '2016-01-08', '2016-01-08', 'Session on interactive and participating learning experience by\\\\r\\\\n1) Dr. Ramesh Vasappanavara\\\\r\\\\n2) Dr. M. S Bhatia\\\\r\\\\n3) Mr. hardik Bhatia\\\\r\\\\n\\\\r\\\\nTiming- 2 PM', '615 @ 2PM', '10.0.0.4', ''),
(336, 'Delete', '2016-01-07 10:42:47', 'root1@localhost', 'PA', 165, 'Making Interactive teaching Ha', '2016-01-08', '2016-01-08', 'Session on interactive and participating learning experience by\\r\\n1) Dr. Ramesh Vasappanavara\\r\\n2) Dr. M. S Bhatia\\r\\n3) Mr. hardik Bhatia\\r\\n\\r\\nTiming- 2 PM', '615 @ 2PM', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(337, 'Delete', '2016-01-07 10:42:56', 'root1@localhost', 'PA', 166, 'Making Interactive teaching Ha', '2016-01-08', '2016-01-08', 'Session on interactive and participating learning experience by\\\\r\\\\n1) Dr. Ramesh Vasappanavara\\\\r\\\\n2) Dr. M. S Bhatia\\\\r\\\\n3) Mr. hardik Bhatia\\\\r\\\\n\\\\r\\\\nTiming- 2 PM', '615 @ 2PM', NULL, NULL, NULL, NULL, NULL, NULL, '10.0.0.4', ''),
(338, 'Insert', '2016-01-07 10:50:26', 'root1@localhost', 'PA', NULL, NULL, NULL, NULL, NULL, NULL, 167, 'D Y Patil Polytechnic', '2016-02-23', '2016-02-23', 'Diploma Project Exhibition &amp; presentation\r\n(Room No. 615 &amp; one Class Room in 6th Floor)', '6th Floor', '192.168.1.55', ''),
(339, 'Update', '2016-01-07 12:44:56', 'root1@localhost', 'faculty', 164, 'Making Interactive teaching Ha', '2016-01-08', '2016-01-08', 'Session on interactive and participating learning experience by\r\n1) Dr. Ramesh Vasappanavara\r\n2) Dr. M. S Bhatia\r\n3) Mr. hardik Bhatia\r\n\r\nTiming- 2 PM', '615 @ 2PM', 164, 'Making Interactive teaching Ha', '2016-01-08', '2016-01-08', 'Session on interactive and participating learning experience by\r\n1) Dr. Ramesh Vasappanavara\r\n2) Dr. M. S Bhatia\r\n3) Mr. hardik Bhatia\r\n\r\nTiming- 2 PM', '615 @ 2PM', '49.14.226.79', ''),
(340, 'Insert', '2016-01-07 13:08:06', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 168, 'testevent', '2015-07-01', '2015-07-01', 'Testevent', 'na', '1.39.8.80', ''),
(341, 'Delete', '2016-01-07 13:11:44', 'root1@localhost', 'faculty', 168, 'testevent', '2015-07-01', '2015-07-01', 'Testevent', 'na', NULL, NULL, NULL, NULL, NULL, NULL, '1.39.8.80', ''),
(342, 'Insert', '2016-01-08 20:04:30', 'root1@localhost', 'PA', NULL, NULL, NULL, NULL, NULL, NULL, 168, 'Testevent', '2016-01-08', '2016-01-08', 'Test event', 'Na', '45.112.9.13', ''),
(343, 'Delete', '2016-01-08 20:05:30', 'root1@localhost', 'PA', 168, 'Testevent', '2016-01-08', '2016-01-08', 'Test event', 'Na', NULL, NULL, NULL, NULL, NULL, NULL, '45.112.9.13', ''),
(344, 'Insert', '2016-01-08 20:06:48', 'root1@localhost', 'PA', NULL, NULL, NULL, NULL, NULL, NULL, 169, 'Testevent', '2016-01-09', '2016-01-13', 'ignore', 'Na', '45.112.9.13', ''),
(345, 'Update', '2016-01-08 20:07:56', 'root1@localhost', 'PA', 169, 'Testevent', '2016-01-09', '2016-01-13', 'ignore', 'Na', 169, 'Testevent', '2016-01-09', '2016-01-13', 'ignore', 'Na', '45.112.9.13', ''),
(346, 'Delete', '2016-01-08 20:08:10', 'root1@localhost', 'PA', 169, 'Testevent', '2016-01-09', '2016-01-13', 'ignore', 'Na', NULL, NULL, NULL, NULL, NULL, NULL, '45.112.9.13', ''),
(347, 'Delete', '2016-01-12 10:48:19', 'root1@localhost', 'csi', 82, 'Workshop on Designing Using Co', '2016-02-20', '2016-02-21', 'Creative designing workshop using Corel Draw-(Designing S/W), organised by CSI-RAIT.', 'Lab No.: 513', NULL, NULL, NULL, NULL, NULL, NULL, '27.97.85.4', ''),
(348, 'Insert', '2016-01-12 13:53:15', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 168, 'Expert Session ', '2016-01-18', '2016-01-18', 'Expert Session on E-Learning System by Prof. Sasikumar at 10.00 am', '615', '10.0.0.1', ''),
(349, 'Insert', '2016-01-12 13:58:18', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 169, 'Expert Session ', '2016-01-18', '2016-01-18', 'Expert Session on Pattern Recognition for ME ', '615', '10.0.0.1', ''),
(350, 'Insert', '2016-01-12 14:09:30', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 170, 'Expert Session ', '2016-01-20', '2016-01-20', 'Expert session for BE students by Mr. Munir Syad', '615', '10.0.0.1', ''),
(351, 'Insert', '2016-01-12 14:11:47', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 171, 'Expert Session ', '2016-01-27', '2016-01-27', 'Expert Session by Siby sir for ME students', '615', '10.0.0.1', ''),
(352, 'Insert', '2016-01-12 14:17:08', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 172, 'Expert Lecture on &quot;Introd', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to OPENGL by Prof. Shridhar Domanal, NIT, Surtahkal for Second Year students', '511', '10.0.0.1', ''),
(353, 'Insert', '2016-01-12 14:17:29', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 173, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to OPENGL by Prof. Shridhar Domanal, NIT, Surtahkal for Second Year students', '511', '10.0.0.1', ''),
(354, 'Insert', '2016-01-12 14:17:52', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 174, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to OPENGL by Prof. Shridhar Domanal, NIT, Surtahkal for Second Year students', '511', '10.0.0.1', ''),
(355, 'Insert', '2016-01-12 14:17:59', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 175, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to OPENGL by Prof. Shridhar Domanal, NIT, Surtahkal for Second Year students', '511', '10.0.0.1', ''),
(356, 'Insert', '2016-01-12 14:18:05', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 176, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to OPENGL by Prof. Shridhar Domanal, NIT, Surtahkal for Second Year students', '511', '10.0.0.1', ''),
(357, 'Insert', '2016-01-12 14:20:10', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 177, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to OPENGL by Prof. Shridhar Domanal, NIT, Surtahkal for Second Year students', '511', '10.0.0.1', ''),
(358, 'Insert', '2016-01-12 14:20:20', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 178, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to OPENGL by Prof. Shridhar Domanal, NIT, Surtahkal for Second Year students', '511', '10.0.0.1', ''),
(359, 'Delete', '2016-01-12 14:24:38', 'root1@localhost', 'faculty', 172, 'Expert Lecture on &quot;Introd', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to OPENGL by Prof. Shridhar Domanal, NIT, Surtahkal for Second Year students', '511', NULL, NULL, NULL, NULL, NULL, NULL, '27.97.85.173', ''),
(360, 'Delete', '2016-01-12 14:25:10', 'root1@localhost', 'faculty', 178, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to OPENGL by Prof. Shridhar Domanal, NIT, Surtahkal for Second Year students', '511', NULL, NULL, NULL, NULL, NULL, NULL, '27.97.85.173', ''),
(361, 'Insert', '2016-01-12 14:26:50', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 179, 'Testevent', '2016-01-08', '2016-01-08', 'Ignore', 'Na', '27.97.85.173', ''),
(362, 'Insert', '2016-01-12 14:29:51', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 180, 'Testevent', '2016-01-09', '2016-01-09', 'Ignore', 'Na', '27.97.85.173', ''),
(363, 'Insert', '2016-01-12 14:29:59', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 181, 'Testevent', '2016-01-09', '2016-01-09', 'Ignore', 'Na', '27.97.85.173', ''),
(364, 'Insert', '2016-01-12 14:30:04', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 182, 'Testevent', '2016-01-09', '2016-01-09', 'Ignore', 'Na', '27.97.85.173', ''),
(365, 'Insert', '2016-01-12 14:30:24', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 183, 'Testevent', '2016-01-09', '2016-01-09', 'Ignore', 'Na', '27.97.85.173', ''),
(366, 'Delete', '2016-01-12 14:31:44', 'root1@localhost', 'faculty', 183, 'Testevent', '2016-01-09', '2016-01-09', 'Ignore', 'Na', NULL, NULL, NULL, NULL, NULL, NULL, '27.97.85.173', ''),
(367, 'Delete', '2016-01-12 14:32:06', 'root1@localhost', 'faculty', 175, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to OPENGL by Prof. Shridhar Domanal, NIT, Surtahkal for Second Year students', '511', NULL, NULL, NULL, NULL, NULL, NULL, '27.97.85.173', '');
INSERT INTO `cal_events_log` (`log_id`, `action`, `action_time`, `user`, `web_user`, `old_event_id`, `old_event_name`, `old_start_date`, `old_end_date`, `old_event_desc`, `old_location`, `new_event_id`, `new_event_name`, `new_start_date`, `new_end_date`, `new_event_desc`, `new_location`, `remote_addr`, `http_x_forwarded_for`) VALUES
(368, 'Delete', '2016-01-12 14:32:26', 'root1@localhost', 'faculty', 176, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to OPENGL by Prof. Shridhar Domanal, NIT, Surtahkal for Second Year students', '511', NULL, NULL, NULL, NULL, NULL, NULL, '27.97.85.173', ''),
(369, 'Delete', '2016-01-12 14:32:41', 'root1@localhost', 'faculty', 174, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to OPENGL by Prof. Shridhar Domanal, NIT, Surtahkal for Second Year students', '511', NULL, NULL, NULL, NULL, NULL, NULL, '27.97.85.173', ''),
(370, 'Delete', '2016-01-12 14:32:59', 'root1@localhost', 'faculty', 177, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to OPENGL by Prof. Shridhar Domanal, NIT, Surtahkal for Second Year students', '511', NULL, NULL, NULL, NULL, NULL, NULL, '27.97.85.173', ''),
(371, 'Delete', '2016-01-12 14:33:17', 'root1@localhost', 'faculty', 180, 'Testevent', '2016-01-09', '2016-01-09', 'Ignore', 'Na', NULL, NULL, NULL, NULL, NULL, NULL, '27.97.85.173', ''),
(372, 'Delete', '2016-01-12 14:33:39', 'root1@localhost', 'faculty', 179, 'Testevent', '2016-01-08', '2016-01-08', 'Ignore', 'Na', NULL, NULL, NULL, NULL, NULL, NULL, '27.97.85.173', ''),
(373, 'Delete', '2016-01-12 14:33:58', 'root1@localhost', 'faculty', 181, 'Testevent', '2016-01-09', '2016-01-09', 'Ignore', 'Na', NULL, NULL, NULL, NULL, NULL, NULL, '27.97.85.173', ''),
(374, 'Delete', '2016-01-12 14:34:19', 'root1@localhost', 'faculty', 182, 'Testevent', '2016-01-09', '2016-01-09', 'Ignore', 'Na', NULL, NULL, NULL, NULL, NULL, NULL, '27.97.85.173', ''),
(375, 'Insert', '2016-01-12 14:44:07', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 184, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to openGL by Prof. Shridhar Donamal for Second Year Students', '511', '10.0.0.1', ''),
(376, 'Insert', '2016-01-12 14:45:06', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 185, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to openGL by Prof. Shridhar Donamal for Second Year Students', '515', '10.0.0.1', ''),
(377, 'Insert', '2016-01-12 14:45:15', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 186, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to openGL by Prof. Shridhar Donamal for Second Year Students', '515', '10.0.0.1', ''),
(378, 'Insert', '2016-01-12 15:44:05', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 187, 'Full Stack Development worksho', '2016-01-29', '2016-01-31', 'Workshop for T.E students organized by IT department.\r\nTime- 10 am to 5 pm', '616 ', '192.168.5.217', ''),
(379, 'Update', '2016-01-12 15:55:19', 'root1@localhost', 'faculty', 187, 'Full Stack Development worksho', '2016-01-29', '2016-01-31', 'Workshop for T.E students organized by IT department.\r\nTime- 10 am to 5 pm', '616 ', 187, 'Full Stack Development worksho', '2016-01-29', '2016-01-31', 'Workshop for T.E students organized by IT department.\r\nTime- 10 am to 5 pm', '616 ', '27.97.85.173', ''),
(380, 'Delete', '2016-01-12 16:01:06', 'root1@localhost', 'faculty', 186, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to openGL by Prof. Shridhar Donamal for Second Year Students', '515', NULL, NULL, NULL, NULL, NULL, NULL, '27.97.85.173', ''),
(381, 'Delete', '2016-01-12 16:02:07', 'root1@localhost', 'faculty', 185, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to openGL by Prof. Shridhar Donamal for Second Year Students', '515', NULL, NULL, NULL, NULL, NULL, NULL, '27.97.85.173', ''),
(382, 'Delete', '2016-01-12 16:02:24', 'root1@localhost', 'faculty', 173, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to OPENGL by Prof. Shridhar Domanal, NIT, Surtahkal for Second Year students', '511', NULL, NULL, NULL, NULL, NULL, NULL, '27.97.85.173', ''),
(383, 'Update', '2016-01-12 16:15:41', 'root1@localhost', 'faculty', 184, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to openGL by Prof. Shridhar Donamal for Second Year Students', '511', 184, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to openGL by Prof. Shridhar Donamal for Second Year Students', '511', '27.97.85.173', ''),
(384, 'Insert', '2016-01-12 23:46:13', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 188, 'test', '2016-01-12', '2016-01-12', 'test', 't', '103.226.243.201', ''),
(385, 'Insert', '2016-01-13 11:28:02', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 189, 'DDB expert Lecture', '2016-02-08', '2016-02-08', 'Distributed Databases Expert Lecture by S.S Kumar organized for Third year Students\r\n@10 am.', '615', '10.0.0.4', ''),
(386, 'Insert', '2016-01-13 11:46:57', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 190, 'Term Test I', '2016-02-11', '2016-02-13', 'Term Test of All Departments.', '5 Floor', '192.168.5.186', ''),
(387, 'Insert', '2016-01-13 11:48:28', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 191, 'Horizon', '2016-02-18', '2016-02-20', 'Culture Festival of RAIT', 'RAIT', '192.168.5.186', ''),
(388, 'Insert', '2016-01-13 11:49:39', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 192, 'Holiday', '2016-01-26', '2016-01-26', 'Republic Day', 'Near President Office', '192.168.5.186', ''),
(389, 'Insert', '2016-01-13 11:51:05', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 193, 'Academic Audit', '2016-02-29', '2016-02-29', 'audit of All Departments. ', 'RAIT', '192.168.5.186', ''),
(390, 'Insert', '2016-01-13 11:52:13', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 194, 'Holiday', '2016-03-07', '2016-03-07', 'Mahashivratri', '@ Your Home', '192.168.5.186', ''),
(391, 'Insert', '2016-01-13 11:53:04', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 195, 'Tech Fest', '2016-03-21', '2016-03-23', 'Tech Fest of RAIT', 'RAIT', '192.168.5.186', ''),
(392, 'Insert', '2016-01-13 11:53:53', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 196, 'EPL', '2016-03-24', '2016-03-25', 'Cricket Matches ', 'DY Patil Stadium', '192.168.5.186', ''),
(393, 'Insert', '2016-01-13 11:55:13', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 197, 'Student Feedback', '2016-03-28', '2016-03-29', 'Academic feedback One ', 'ALL Labs', '192.168.5.186', ''),
(394, 'Insert', '2016-01-13 11:56:09', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 198, 'Academic Audit II', '2016-03-31', '2016-03-31', 'Academic Audit of all Department', 'RAIT', '192.168.5.186', ''),
(395, 'Insert', '2016-01-13 11:57:43', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 199, 'Project Competition ', '2016-04-01', '2016-04-01', 'B. E Project Competition ', 'E- Yantra Lab', '192.168.5.186', ''),
(396, 'Insert', '2016-01-13 11:58:49', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 200, 'Term Test II', '2016-04-07', '2016-04-11', 'Term Test II of RAIT', 'RAIT', '192.168.5.186', ''),
(397, 'Insert', '2016-01-13 11:59:47', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 201, 'Remedial Classes', '2016-04-12', '2016-04-13', 'Remedial Classes for defaulter students', '5 Floor', '192.168.5.186', ''),
(398, 'Insert', '2016-01-13 12:00:58', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 202, 'Term End', '2016-04-16', '2016-04-16', 'End of Even Sem', 'RAIT', '192.168.5.186', ''),
(399, 'Update', '2016-01-13 17:00:06', 'root1@localhost', 'faculty', 187, 'Full Stack Development worksho', '2016-01-29', '2016-01-31', 'Workshop for T.E students organized by IT department.\r\nTime- 10 am to 5 pm', '616 ', 187, 'Full Stack Development worksho', '2016-01-29', '2016-01-31', 'Workshop for T.E students organized by IT department.\r\nTime- 10 am to 5 pm', '616 ', '112.110.65.97', ''),
(400, 'Update', '2016-01-13 20:21:43', 'root1@localhost', 'faculty', 187, 'Full Stack Development worksho', '2016-01-29', '2016-01-31', 'Workshop for T.E students organized by IT department.\r\nTime- 10 am to 5 pm', '616 ', 187, 'Full Stack Development worksho', '2016-01-29', '2016-01-31', 'Workshop for T.E students organized by IT department.\r\nTime- 10 am to 5 pm', '616 ', '103.226.243.201', ''),
(401, 'Insert', '2016-01-14 17:14:11', 'root1@localhost', 'PA', NULL, NULL, NULL, NULL, NULL, NULL, 203, 'RAIT Placement', '2016-01-16', '2016-01-16', 'Placement drive of Muthshut.com ', 'Room No. 615', '192.168.1.28', ''),
(402, 'Insert', '2016-01-14 17:16:07', 'root1@localhost', 'PA', NULL, NULL, NULL, NULL, NULL, NULL, 204, 'RAIT Placement', '2016-01-19', '2016-01-19', 'TCS post offer connect sessin\r\n9.00am to 12.00 noon', 'Room No. 615', '192.168.1.28', ''),
(403, 'Insert', '2016-01-15 16:07:10', 'root1@localhost', 'hodfe', NULL, NULL, NULL, NULL, NULL, NULL, 205, 'Term Start', '2016-01-04', '2016-01-04', 'Start of Sem II', 'RAIT', '192.168.1.58', ''),
(404, 'Insert', '2016-01-15 16:08:11', 'root1@localhost', 'hodfe', NULL, NULL, NULL, NULL, NULL, NULL, 206, 'First Defaulter''s List', '2016-02-09', '2016-01-09', 'Display of First Defaulter''s List', 'RAIT', '192.168.1.58', ''),
(405, 'Insert', '2016-01-15 16:09:07', 'root1@localhost', 'hodfe', NULL, NULL, NULL, NULL, NULL, NULL, 207, 'Term Test I', '2016-02-11', '2016-02-13', 'Term Test I Conduction', 'RAIT', '192.168.1.58', ''),
(406, 'Insert', '2016-01-15 16:10:17', 'root1@localhost', 'hodfe', NULL, NULL, NULL, NULL, NULL, NULL, 208, 'Term Test I Marks Display', '2016-02-17', '2016-02-17', 'Display of Term Test I marks to the students so that they can analyse and improve their performance', 'RAIT', '192.168.1.58', ''),
(407, 'Insert', '2016-01-15 16:13:59', 'root1@localhost', 'hodfe', NULL, NULL, NULL, NULL, NULL, NULL, 209, 'Student Feedback', '2016-03-28', '2016-04-01', 'Feedback from students on both CO and Faculty feedback', '212', '192.168.1.58', ''),
(408, 'Insert', '2016-01-15 16:14:56', 'root1@localhost', 'hodfe', NULL, NULL, NULL, NULL, NULL, NULL, 210, 'Second Defaulter''s List', '2016-04-05', '2016-04-05', 'Display of Second Defaulter''s :ist', 'RAIT Notice Board', '192.168.1.58', ''),
(409, 'Update', '2016-01-15 16:15:54', 'root1@localhost', 'hodfe', 208, 'Term Test I Marks Display', '2016-02-17', '2016-02-17', 'Display of Term Test I marks to the students so that they can analyse and improve their performance', 'RAIT', 208, 'Term Test I Marks Display', '2016-02-17', '2016-02-17', 'Display of Term Test I marks to the students so that they can analyse and improve their performance', 'RAIT Notice Board', '192.168.1.58', ''),
(410, 'Insert', '2016-01-15 16:19:07', 'root1@localhost', 'hodfe', NULL, NULL, NULL, NULL, NULL, NULL, 211, 'Term Test II', '2016-04-07', '2016-04-09', 'Term Test II of SEM II', 'RAIT', '192.168.1.58', ''),
(411, 'Insert', '2016-01-15 16:20:22', 'root1@localhost', 'hodfe', NULL, NULL, NULL, NULL, NULL, NULL, 212, 'AutoCAD Practical Examination', '2016-04-18', '2016-04-23', 'AutoCAD Practical Examination Tentative dates', '212', '192.168.1.58', ''),
(412, 'Insert', '2016-01-15 16:21:47', 'root1@localhost', 'hodfe', NULL, NULL, NULL, NULL, NULL, NULL, 213, 'SPA Practical Examination', '2016-04-18', '2016-04-23', 'SPA Practical Examination Tentative Dates', 'SPA Labs at 5th floor and 6th ', '192.168.1.58', ''),
(413, 'Insert', '2016-01-15 16:27:32', 'root1@localhost', 'hodfe', NULL, NULL, NULL, NULL, NULL, NULL, 214, 'Expert Lecture on Softwares to', '2016-01-25', '2016-01-25', 'Use of different softwares for teaching Engineering Drawing Subject of FE Sem II. These softwares will help to understand some concepts of ED more easily to students.', '212', '192.168.1.58', ''),
(414, 'Insert', '2016-01-15 16:27:45', 'root1@localhost', 'hodfe', NULL, NULL, NULL, NULL, NULL, NULL, 215, 'Expert Lecture on Softwares to', '2016-01-25', '2016-01-25', 'Use of different softwares for teaching Engineering Drawing Subject of FE Sem II. These softwares will help to understand some concepts of ED more easily to students.', '212', '192.168.1.58', ''),
(415, 'Insert', '2016-01-15 16:31:02', 'root1@localhost', 'hodfe', NULL, NULL, NULL, NULL, NULL, NULL, 216, 'Seminar on ED software', '2016-01-25', '2016-01-25', 'Seminar on how to use different softwares and AutoCAD to make student understand the concept easily', '212', '192.168.1.58', ''),
(416, 'Update', '2016-01-15 16:36:28', 'root1@localhost', 'hodfe', 216, 'Seminar on ED software', '2016-01-25', '2016-01-25', 'Seminar on how to use different softwares and AutoCAD to make student understand the concept easily', '212', 216, 'Seminar on ED software', '2016-01-25', '2016-01-25', 'Seminar on how to use different softwares and AutoCAD to make student understand the concept easily', '212', '192.168.1.58', ''),
(417, 'Insert', '2016-01-20 11:31:01', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 217, 'Latex Training', '2016-01-28', '2016-01-28', 'Training on Latex for BE(IT) students for generation of their project black book.', '616 lab', '192.168.6.41', ''),
(418, 'Insert', '2016-01-25 14:06:51', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 218, '1 day workshop on Parallel and', '2016-02-04', '2016-01-04', 'Expert session on PDS and Hands on Lab for ME and BE students', '615', '10.0.0.1', ''),
(419, 'Insert', '2016-01-25 14:07:07', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 219, '1 day workshop on Parallel and', '2016-02-04', '2016-01-04', 'Expert session on PDS and Hands on Lab for ME and BE students', '615', '10.0.0.1', ''),
(420, 'Insert', '2016-01-25 14:07:19', 'root1@localhost', 'faculty', NULL, NULL, NULL, NULL, NULL, NULL, 220, '1 day workshop on Parallel and', '2016-02-04', '2016-01-04', 'Expert session on PDS and Hands on Lab for ME and BE students', '615', '10.0.0.1', ''),
(421, 'Insert', '2016-01-28 13:18:48', 'root1@localhost', 'PA', NULL, NULL, NULL, NULL, NULL, NULL, 221, 'RAIT Placement', '2016-01-29', '2016-01-29', 'Teach for India Seminar', 'Room No. 615', '192.168.1.161', ''),
(422, 'Insert', '2016-01-28 15:29:16', 'root1@localhost', 'PA', NULL, NULL, NULL, NULL, NULL, NULL, 222, 'D Y Patil Law College', '2016-02-06', '2016-02-06', 'Vidhi Mitra- 3.30pm to 6.30pm', 'Room No. 615', '192.168.1.161', ''),
(423, 'Update', '2016-01-29 09:18:53', 'root1@localhost', 'hod', 217, 'Latex Training', '2016-01-28', '2016-01-28', 'Training on Latex for BE(IT) students for generation of their project black book.', '616 lab', 217, 'Latex Training', '2016-01-29', '2016-01-29', 'Training on Latex for BE(IT) students for generation of their project black book.', '616 lab', '192.168.6.188', ''),
(424, 'Insert', '2016-02-03 16:27:32', 'root1@localhost', 'hod', NULL, NULL, NULL, NULL, NULL, NULL, 223, 'Latex Training', '2016-02-05', '2016-02-05', 'Latex Training for BE students for Black book preparation.', '616lab', '192.168.6.169', ''),
(425, 'Insert', '2016-02-09 13:06:26', 'root1@localhost', 'PA', NULL, NULL, NULL, NULL, NULL, NULL, 224, 'Seminar By Oracle', '2016-02-09', '2016-02-09', 'Dept of IT (Seminar By Oracle)\r\n01.30pm ', 'Room 615', '192.168.1.118', ''),
(426, 'Insert', '2016-03-08 17:17:02', 'root1@localhost', 'PA', NULL, NULL, NULL, NULL, NULL, NULL, 225, 'TCS Faculty Development Sessio', '2016-03-10', '2016-03-10', 'TCS Faculty Development Session\r\n(Faculty &amp; ME Students)', '2nd Floor -206', '192.168.1.19', ''),
(427, 'Insert', '2016-03-08 17:20:52', 'root1@localhost', 'PA', NULL, NULL, NULL, NULL, NULL, NULL, 226, 'TCS Post Offer Connect Session', '2016-03-10', '2016-03-10', 'TCS Post Offer Connect Session10.00 to 11.30 \r\n\r\n&amp; TCS Prefinal Year Connect\r\n11.30 to 12.30', 'Room 615', '192.168.1.19', ''),
(428, 'Insert', '2016-03-08 17:36:14', 'root1@localhost', 'PA', NULL, NULL, NULL, NULL, NULL, NULL, 227, 'Expert Lecture', '2016-03-09', '2016-03-09', 'Security Issues In Mobile Computing\r\n8.30 onwords', 'Room 615', '192.168.1.19', ''),
(429, 'Update', '2016-07-10 12:52:44', 'root@localhost', 'hode', 3, 'Workshop on PCB Design', '2015-08-10', '2015-08-14', 'This is a free workshop for third and fourth year students.', 'Lab. 201 and 208', 3, 'Workshop on PCB Design', '2015-08-10', '2015-08-14', 'This is a free workshop for third and fourth year students.', 'Lab. 201 and 208', NULL, NULL),
(430, 'Update', '2016-07-10 12:52:54', 'root@localhost', 'hoden', 3, 'Workshop on PCB Design', '2015-08-10', '2015-08-14', 'This is a free workshop for third and fourth year students.', 'Lab. 201 and 208', 3, 'Workshop on PCB Design', '2015-08-10', '2015-08-14', 'This is a free workshop for third and fourth year students.', 'Lab. 201 and 208', NULL, NULL),
(431, 'Update', '2016-07-10 12:53:03', 'root@localhost', 'pa', 10, 'Role of Instrumentation Engg. ', '2015-09-03', '2015-09-03', 'Dept. of Instrumentation Engg\r\n\r\nRole of Instrumentation Engg. in Corporat World', 'Room No 615', 10, 'Role of Instrumentation Engg. ', '2015-09-03', '2015-09-03', 'Dept. of Instrumentation Engg\nRole of Instrumentation Engg. in Corporat World', 'Room No 615', NULL, NULL),
(432, 'Update', '2016-07-10 12:53:22', 'root@localhost', 'pa', 10, 'Role of Instrumentation Engg. ', '2015-09-03', '2015-09-03', 'Dept. of Instrumentation Engg\nRole of Instrumentation Engg. in Corporat World', 'Room No 615', 10, 'Role of Instrumentation Engg. ', '2015-09-03', '2015-09-03', 'Dept. of Instrumentation Engg Role of Instrumentation Engg. in Corporat World', 'Room No 615', NULL, NULL),
(433, 'Update', '2016-07-10 12:55:19', 'root@localhost', 'hodce5', 15, 'Expert Lecture', '2015-10-01', '2015-10-01', '&quot;IP Awareness Seminar - Everything you wanted to know about Intellectual Property Rights (IPR)&quot; \r\nby Mr. Akhilesh C Srivastava', '615', 15, 'Expert Lecture', '2015-10-01', '2015-10-01', 'IP Awareness Seminar - Everything you wanted to know about Intellectual Property Rights (IPR)&quot; \nby Mr. Akhilesh C Srivastava', '615', NULL, NULL),
(434, 'Update', '2016-07-10 12:56:07', 'root@localhost', 'hodce5', 16, 'Expert Lecture', '2015-10-01', '2015-10-01', '&quot;IP Awareness Seminar - Everything you wanted to know about Intellectual Property Rights (IPR)&quot; by Mr. Akhilesh C Srivastava', '615', 16, 'Expert Lecture', '2015-10-01', '2015-10-01', 'IP Awareness Seminar - Everything you wanted to know about Intellectual Property Rights (IPR) by Mr. Akhilesh C Srivastava', '615', NULL, NULL),
(435, 'Update', '2016-07-10 12:57:23', 'root@localhost', 'hodce5', 15, 'Expert Lecture', '2015-10-01', '2015-10-01', 'IP Awareness Seminar - Everything you wanted to know about Intellectual Property Rights (IPR)&quot; \nby Mr. Akhilesh C Srivastava', '615', 15, 'Expert Lecture', '2015-10-01', '2015-10-01', 'IP Awareness Seminar - Everything you wanted to know about Intellectual Property Rights (IPR) by Mr. Akhilesh C Srivastava', '615', NULL, NULL),
(436, 'Update', '2016-07-10 12:57:49', 'root@localhost', 'hod', 17, 'Expert Lecture', '2015-10-01', '2015-10-01', 'Expert Talk Series\r\nSession-I Expert Talk on\r\nâ€œEvolution of computing grids and cloudsâ€ by \r\nDr. B.S.Jagadeesh, BARC\r\n\r\n\r\n', '615', 17, 'Expert Lecture', '2015-10-01', '2015-10-01', 'Expert Talk Series\nSession-I Expert Talk on\nâ€œEvolution of computing grids and cloudsâ€ by Dr. B.S.Jagadeesh, BARC\n\n\n', '615', NULL, NULL),
(437, 'Delete', '2016-07-10 13:04:17', 'root@localhost', 'hod', 17, 'Expert Lecture', '2015-10-01', '2015-10-01', 'Expert Talk Series\nSession-I Expert Talk on\nâ€œEvolution of computing grids and cloudsâ€ by Dr. B.S.Jagadeesh, BARC\n\n\n', '615', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(438, 'Delete', '2016-07-10 13:04:42', 'root@localhost', 'hodce5', 89, 'Expert Lecture', '2015-10-30', '2015-10-30', ' Expert Lecture by Mr Ramanan (CEO, Gauranga SoftTech Ltd.) on Career Opportunities for Electronics Graduates in Embedded Systems.\r\n', 'RAIT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(439, 'Delete', '2016-07-10 13:04:58', 'root@localhost', 'hodce5', 90, 'Workshop', '2015-11-20', '2015-11-21', '2-day Hands-on Session on COMSOL by Prof Sachin Umbarkar.\r\n', 'RAIT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(440, 'Delete', '2016-07-10 13:05:10', 'root@localhost', 'hodce5', 91, 'Expert Lecture', '2015-11-27', '2015-11-27', 'Expert Lecture by Prof Sharad Bhartiya (IIT Bombay) on Systems Biology.\r\n', 'RAIT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(441, 'Delete', '2016-07-10 13:05:21', 'root@localhost', 'hodce5', 93, 'meeting', '2015-09-14', '2015-09-14', ' meeting between Tech-Mahindra delegates and HODs on Monday , 14th September, 2015 at 11:20 am to 11:45 am \r\nObjective: &quot; Understanding the industry requirements &quot; ', 'Placement Room', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(442, 'Delete', '2016-07-10 13:05:36', 'root@localhost', 'hod', 147, 'Expert Talk Series', '2015-10-01', '2015-10-01', 'Session-II Expert Talk on \r\nâ€œCryptography - Then and Nowâ€\r\nby Dr. Dipan Ghosh, \r\nIIT Mumbai\r\n', '615', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(443, 'Delete', '2016-07-10 13:05:54', 'root@localhost', 'faculty', 164, 'Making Interactive teaching Ha', '2016-01-08', '2016-01-08', 'Session on interactive and participating learning experience by\r\n1) Dr. Ramesh Vasappanavara\r\n2) Dr. M. S Bhatia\r\n3) Mr. hardik Bhatia\r\n\r\nTiming- 2 PM', '615 @ 2PM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(444, 'Delete', '2016-07-10 13:06:12', 'root@localhost', 'PA', 167, 'D Y Patil Polytechnic', '2016-02-23', '2016-02-23', 'Diploma Project Exhibition &amp; presentation\r\n(Room No. 615 &amp; one Class Room in 6th Floor)', '6th Floor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(445, 'Delete', '2016-07-10 13:06:26', 'root@localhost', 'faculty', 168, 'Expert Session ', '2016-01-18', '2016-01-18', 'Expert Session on E-Learning System by Prof. Sasikumar at 10.00 am', '615', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(446, 'Delete', '2016-07-10 13:06:43', 'root@localhost', 'faculty', 187, 'Full Stack Development worksho', '2016-01-29', '2016-01-31', 'Workshop for T.E students organized by IT department.\r\nTime- 10 am to 5 pm', '616 ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(447, 'Delete', '2016-07-10 13:06:53', 'root@localhost', 'faculty', 189, 'DDB expert Lecture', '2016-02-08', '2016-02-08', 'Distributed Databases Expert Lecture by S.S Kumar organized for Third year Students\r\n@10 am.', '615', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(448, 'Delete', '2016-07-10 13:07:07', 'root@localhost', 'PA', 204, 'RAIT Placement', '2016-01-19', '2016-01-19', 'TCS post offer connect sessin\r\n9.00am to 12.00 noon', 'Room No. 615', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(449, 'Delete', '2016-07-10 13:07:20', 'root@localhost', 'PA', 224, 'Seminar By Oracle', '2016-02-09', '2016-02-09', 'Dept of IT (Seminar By Oracle)\r\n01.30pm ', 'Room 615', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(450, 'Delete', '2016-07-10 13:07:31', 'root@localhost', 'PA', 225, 'TCS Faculty Development Sessio', '2016-03-10', '2016-03-10', 'TCS Faculty Development Session\r\n(Faculty &amp; ME Students)', '2nd Floor -206', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(451, 'Delete', '2016-07-10 13:07:40', 'root@localhost', 'PA', 226, 'TCS Post Offer Connect Session', '2016-03-10', '2016-03-10', 'TCS Post Offer Connect Session10.00 to 11.30 \r\n\r\n&amp; TCS Prefinal Year Connect\r\n11.30 to 12.30', 'Room 615', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(452, 'Delete', '2016-07-10 13:07:50', 'root@localhost', 'PA', 227, 'Expert Lecture', '2016-03-09', '2016-03-09', 'Security Issues In Mobile Computing\r\n8.30 onwords', 'Room 615', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(453, 'Update', '2016-07-10 13:08:27', 'root@localhost', 'PA', 222, 'D Y Patil Law College', '2016-02-06', '2016-02-06', 'Vidhi Mitra- 3.30pm to 6.30pm', 'Room No. 615', 222, 'D Y Patil Law College', '2016-02-06', '2016-02-06', 'Vidhi Mitra- 3.30pm to 6.30pm', 'Room No. 615', NULL, NULL),
(454, 'Update', '2016-07-10 13:08:43', 'root@localhost', 'PA', 222, 'D Y Patil Law College', '2016-02-06', '2016-02-06', 'Vidhi Mitra- 3.30pm to 6.30pm', 'Room No. 615', 222, 'D Y Patil Law College', '2016-02-06', '2016-02-06', 'Vidhi Mitra- 3.30pm to 6.30pm', 'Room No. 615', NULL, NULL),
(455, 'Update', '2016-07-10 13:09:33', 'root@localhost', 'hodfe', 215, 'Expert Lecture on Softwares to', '2016-01-25', '2016-01-25', 'Use of different softwares for teaching Engineering Drawing Subject of FE Sem II. These softwares will help to understand some concepts of ED more easily to students.', '212', 215, 'Expert Lecture on Softwares to', '2016-01-25', '2016-01-25', 'Use of different softwares for teaching Engineering Drawing Subject of FE Sem II. These softwares will help to understand some concepts of ED more easily to students.', '212', NULL, NULL),
(456, 'Update', '2016-07-10 13:10:11', 'root@localhost', 'hodfe', 215, 'Expert Lecture on Softwares to', '2016-01-25', '2016-01-25', 'Use of different softwares for teaching Engineering Drawing Subject of FE Sem II. These softwares will help to understand some concepts of ED more easily to students.', '212', 215, 'Expert Lecture on Softwares to', '2016-01-25', '2016-01-25', 'Use of different softwares for teaching Engineering Drawing Subject of FE Sem II. These softwares will help to understand some concepts of ED more easily to students.', '212', NULL, NULL),
(457, 'Update', '2016-07-10 13:11:56', 'root@localhost', 'ss', 1, 'Test', '2015-08-14', '2015-08-14', 'test', 'test', 1, 'Test', '2015-08-14', '2015-08-14', 'test', 'test', NULL, NULL),
(458, 'Insert', '2016-07-10 14:02:59', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12345, 'mandeep is the best', '2016-07-10', '2016-07-10', 'yooo...soo true', 'home', NULL, NULL),
(459, 'Insert', '2016-07-10 16:01:45', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12346, 'she', '0000-00-00', '0000-00-00', 'fdbfb', 'dffh', NULL, NULL),
(460, 'Delete', '2016-07-10 16:02:41', 'root@localhost', 'principal', 12346, 'she', '0000-00-00', '0000-00-00', 'fdbfb', 'dffh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(461, 'Insert', '2016-07-10 16:03:01', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12347, 'she', '0000-00-00', '0000-00-00', 'fdbfb', '', NULL, NULL),
(462, 'Insert', '2016-07-10 16:33:44', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12348, 'mandeep', '0000-00-00', '0000-00-00', 'yp', 'mandir', NULL, NULL),
(463, 'Delete', '2016-07-10 16:34:12', 'root@localhost', 'principal', 12348, 'mandeep', '0000-00-00', '0000-00-00', 'yp', 'mandir', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(464, 'Delete', '2016-07-10 16:34:14', 'root@localhost', 'principal', 12347, 'she', '0000-00-00', '0000-00-00', 'fdbfb', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(465, 'Insert', '2016-07-10 16:34:52', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12349, 'mandeep', '0000-00-00', '0000-00-00', 'yp', '', NULL, NULL),
(466, 'Delete', '2016-07-10 16:35:27', 'root@localhost', 'principal', 12349, 'mandeep', '0000-00-00', '0000-00-00', 'yp', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(467, 'Delete', '2016-07-10 16:35:29', 'root@localhost', 'mandeep', 12345, 'mandeep is the best', '2016-07-10', '2016-07-10', 'yooo...soo true', 'home', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(468, 'Insert', '2016-07-10 16:39:20', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12350, 'mandeep', '0000-00-00', '0000-00-00', 'yp', '', NULL, NULL),
(469, 'Insert', '2016-07-10 16:41:04', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12351, 'mandeep', '0000-00-00', '0000-00-00', 'yp', '', NULL, NULL),
(470, 'Insert', '2016-07-10 16:41:12', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12352, 'mandeep', '0000-00-00', '0000-00-00', 'yp', '', NULL, NULL),
(471, 'Insert', '2016-07-10 16:41:52', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12353, 'fmsnjfk', '2016-07-05', '2016-07-12', 'msnbl', 'hel', NULL, NULL),
(472, 'Delete', '2016-07-10 16:42:07', 'root@localhost', 'principal', 12352, 'mandeep', '0000-00-00', '0000-00-00', 'yp', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(473, 'Delete', '2016-07-10 16:42:14', 'root@localhost', 'principal', 12351, 'mandeep', '0000-00-00', '0000-00-00', 'yp', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(474, 'Delete', '2016-07-10 16:42:17', 'root@localhost', 'principal', 12350, 'mandeep', '0000-00-00', '0000-00-00', 'yp', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(475, 'Delete', '2016-07-10 16:42:20', 'root@localhost', 'principal', 12353, 'fmsnjfk', '2016-07-05', '2016-07-12', 'msnbl', 'hel', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(476, 'Insert', '2016-07-10 16:43:13', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12354, 'mandeep testing', '2016-07-05', '2016-07-12', 'heyyy description', 'mumbai', NULL, NULL),
(477, 'Delete', '2016-07-10 16:46:01', 'root@localhost', 'principal', 12354, 'mandeep testing', '2016-07-05', '2016-07-12', 'heyyy description', 'mumbai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(478, 'Insert', '2016-07-10 16:49:12', 'root@localhost', '', NULL, NULL, NULL, NULL, NULL, NULL, 12355, 'mandeep testing', '2016-07-05', '2016-07-12', 'heyyy description', 'mumbai', NULL, NULL),
(479, 'Insert', '2016-07-10 16:51:05', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12356, 'i am principal', '2016-07-01', '2016-07-10', 'testingg buddy', 'college', NULL, NULL),
(480, 'Delete', '2016-07-10 16:53:45', 'root@localhost', '', 12355, 'mandeep testing', '2016-07-05', '2016-07-12', 'heyyy description', 'mumbai', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(481, 'Delete', '2016-07-10 16:53:55', 'root@localhost', 'principal', 12356, 'i am principal', '2016-07-01', '2016-07-10', 'testingg buddy', 'college', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(482, 'Insert', '2016-07-10 17:15:48', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12357, 'test2', '2016-07-13', '2016-07-28', 'test desc', 'here', NULL, NULL),
(483, 'Insert', '2016-07-10 17:23:21', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12358, 'time', '2016-07-11', '2016-07-05', '', 'yo', NULL, NULL),
(484, 'Delete', '2016-07-10 17:24:20', 'root@localhost', 'principal', 12358, 'time', '2016-07-11', '2016-07-05', '', 'yo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(485, 'Delete', '2016-07-10 17:24:26', 'root@localhost', 'principal', 12357, 'test2', '2016-07-13', '2016-07-28', 'test desc', 'here', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(486, 'Insert', '2016-07-10 17:27:13', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12359, 'time', '2016-07-11', '2016-07-05', 'dhgchk', 'ajk', NULL, NULL),
(487, 'Insert', '2016-07-10 17:27:13', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12360, 'time', '2016-07-11', '2016-07-05', 'dhgchk', 'ajk', NULL, NULL),
(488, 'Insert', '2016-07-10 17:27:13', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12361, 'time', '2016-07-11', '2016-07-05', 'dhgchk', 'ajk', NULL, NULL),
(489, 'Insert', '2016-07-10 17:27:13', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12362, 'time', '2016-07-11', '2016-07-05', 'dhgchk', 'ajk', NULL, NULL),
(490, 'Insert', '2016-07-10 17:27:13', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12363, 'time', '2016-07-11', '2016-07-05', 'dhgchk', 'ajk', NULL, NULL),
(491, 'Delete', '2016-07-10 17:27:23', 'root@localhost', 'principal', 12363, 'time', '2016-07-11', '2016-07-05', 'dhgchk', 'ajk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(492, 'Delete', '2016-07-10 17:27:45', 'root@localhost', 'principal', 12362, 'time', '2016-07-11', '2016-07-05', 'dhgchk', 'ajk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(493, 'Delete', '2016-07-10 17:27:45', 'root@localhost', 'principal', 12361, 'time', '2016-07-11', '2016-07-05', 'dhgchk', 'ajk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(494, 'Delete', '2016-07-10 17:27:45', 'root@localhost', 'principal', 12360, 'time', '2016-07-11', '2016-07-05', 'dhgchk', 'ajk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(495, 'Delete', '2016-07-10 17:27:45', 'root@localhost', 'principal', 12359, 'time', '2016-07-11', '2016-07-05', 'dhgchk', 'ajk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(496, 'Insert', '2016-07-10 17:29:41', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12364, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(497, 'Insert', '2016-07-10 17:29:41', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12365, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(498, 'Insert', '2016-07-10 17:29:41', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12366, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(499, 'Insert', '2016-07-10 17:29:41', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12367, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(500, 'Insert', '2016-07-10 17:33:19', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12368, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(501, 'Insert', '2016-07-10 17:33:28', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12369, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(502, 'Insert', '2016-07-10 17:33:28', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12370, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(503, 'Insert', '2016-07-10 17:33:37', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12371, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(504, 'Insert', '2016-07-10 17:33:37', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12372, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(505, 'Insert', '2016-07-10 17:33:37', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12373, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(506, 'Insert', '2016-07-10 17:33:37', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12374, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(507, 'Insert', '2016-07-10 17:33:41', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12375, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(508, 'Insert', '2016-07-10 17:33:41', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12376, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(509, 'Insert', '2016-07-10 17:33:41', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12377, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(510, 'Insert', '2016-07-10 17:33:41', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12378, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(511, 'Insert', '2016-07-10 17:33:42', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12379, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(512, 'Insert', '2016-07-10 17:33:42', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12380, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(513, 'Insert', '2016-07-10 17:33:42', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12381, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(514, 'Insert', '2016-07-10 17:33:42', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12382, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL),
(515, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12364, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(516, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12365, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(517, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12366, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(518, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12367, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(519, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12368, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(520, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12369, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(521, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12370, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(522, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12371, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(523, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12372, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(524, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12373, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(525, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12374, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(526, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12375, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(527, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12376, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(528, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12377, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(529, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12378, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(530, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12379, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(531, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12380, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(532, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12381, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(533, 'Delete', '2016-07-10 17:34:28', 'root@localhost', 'principal', 12382, 'time', '2016-07-11', '2016-07-05', 'dhgchk', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(534, 'Insert', '2016-07-10 17:35:28', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12383, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL),
(535, 'Insert', '2016-07-10 17:35:28', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12384, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL),
(536, 'Insert', '2016-07-10 17:35:28', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12385, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL),
(537, 'Insert', '2016-07-10 17:35:28', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12386, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL),
(538, 'Insert', '2016-07-10 17:35:28', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12387, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL),
(539, 'Insert', '2016-07-10 17:35:28', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12388, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL),
(540, 'Update', '2016-07-10 17:37:11', 'root@localhost', 'principal', 12387, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', 12387, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL),
(541, 'Insert', '2016-07-10 17:40:23', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12389, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL),
(542, 'Insert', '2016-07-10 17:40:23', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12390, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL),
(543, 'Insert', '2016-07-10 17:40:23', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12391, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL),
(544, 'Insert', '2016-07-10 17:40:23', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12392, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL),
(545, 'Insert', '2016-07-10 17:40:23', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12393, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL),
(546, 'Insert', '2016-07-10 17:40:23', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12394, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL),
(547, 'Delete', '2016-07-10 17:41:26', 'root@localhost', 'principal', 12383, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(548, 'Delete', '2016-07-10 17:41:26', 'root@localhost', 'principal', 12384, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(549, 'Delete', '2016-07-10 17:41:26', 'root@localhost', 'principal', 12385, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(550, 'Delete', '2016-07-10 17:41:26', 'root@localhost', 'principal', 12386, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(551, 'Delete', '2016-07-10 17:41:26', 'root@localhost', 'principal', 12387, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(552, 'Delete', '2016-07-10 17:41:26', 'root@localhost', 'principal', 12388, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(553, 'Delete', '2016-07-10 17:41:26', 'root@localhost', 'principal', 12389, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(554, 'Delete', '2016-07-10 17:41:26', 'root@localhost', 'principal', 12390, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(555, 'Delete', '2016-07-10 17:41:26', 'root@localhost', 'principal', 12391, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(556, 'Delete', '2016-07-10 17:41:26', 'root@localhost', 'principal', 12392, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(557, 'Delete', '2016-07-10 17:41:26', 'root@localhost', 'principal', 12393, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(558, 'Delete', '2016-07-10 17:41:26', 'root@localhost', 'principal', 12394, 'time', '2016-07-05', '2016-07-07', 'submissions', 'college', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(559, 'Insert', '2016-07-10 17:42:39', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12395, 'time', '2016-07-13', '2016-08-04', 'yo', 'cool', NULL, NULL),
(560, 'Insert', '2016-07-10 17:42:39', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12396, 'time', '2016-07-13', '2016-08-04', 'yo', 'cool', NULL, NULL),
(561, 'Delete', '2016-07-10 17:43:18', 'root@localhost', 'principal', 12396, 'time', '2016-07-13', '2016-08-04', 'yo', 'cool', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(562, 'Insert', '2016-07-10 17:44:06', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12397, 'time', '2016-07-13', '2016-07-20', '', 'go', NULL, NULL),
(563, 'Insert', '2016-07-10 17:44:06', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12398, 'time', '2016-07-13', '2016-07-20', '', 'go', NULL, NULL),
(564, 'Delete', '2016-07-10 17:44:55', 'root@localhost', 'principal', 12398, 'time', '2016-07-13', '2016-07-20', '', 'go', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(565, 'Delete', '2016-07-10 17:45:01', 'root@localhost', 'principal', 12397, 'time', '2016-07-13', '2016-07-20', '', 'go', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(566, 'Delete', '2016-07-10 17:45:05', 'root@localhost', 'principal', 12395, 'time', '2016-07-13', '2016-08-04', 'yo', 'cool', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(567, 'Insert', '2016-07-10 17:45:39', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12399, 'mandeep', '2016-07-10', '2016-07-10', 'bhbl', 'th', NULL, NULL),
(568, 'Delete', '2016-07-10 17:46:15', 'root@localhost', 'principal', 12399, 'mandeep', '2016-07-10', '2016-07-10', 'bhbl', 'th', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(569, 'Insert', '2016-07-10 18:18:36', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12400, 'main', '2016-07-10', '2016-07-10', 'yo', 'cool', NULL, NULL),
(570, 'Insert', '2016-07-10 21:09:59', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12401, 'masneep', '2016-07-05', '2016-07-21', 'fsd', 'sbdblsd', NULL, NULL),
(571, 'Insert', '2016-07-10 21:09:59', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12402, 'masneep', '2016-07-05', '2016-07-21', 'fsd', 'sbdblsd', NULL, NULL),
(572, 'Update', '2016-07-10 21:11:08', 'root@localhost', 'principal', 12402, 'masneep', '2016-07-05', '2016-07-21', 'fsd', 'sbdblsd', 12402, 'masneep', '2016-07-05', '2016-07-21', 'fsd', 'sbdblsd', NULL, NULL),
(573, 'Insert', '2016-07-10 21:12:02', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12403, 'masneep', '2016-07-05', '2016-07-21', 'fsd', 'sbdblsd', NULL, NULL),
(574, 'Insert', '2016-07-10 21:12:02', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12404, 'masneep', '2016-07-05', '2016-07-21', 'fsd', 'sbdblsd', NULL, NULL),
(575, 'Update', '2016-07-10 21:13:34', 'root@localhost', 'principal', 12404, 'masneep', '2016-07-05', '2016-07-21', 'fsd', 'sbdblsd', 12404, 'masneep', '2016-07-05', '2016-07-21', 'fsd', 'sbdblsd', NULL, NULL),
(576, 'Update', '2016-07-10 21:13:40', 'root@localhost', 'principal', 12403, 'masneep', '2016-07-05', '2016-07-21', 'fsd', 'sbdblsd', 12403, 'masneep', '2016-07-05', '2016-07-21', 'fsd', 'sbdblsd', NULL, NULL),
(577, 'Update', '2016-07-10 21:13:47', 'root@localhost', 'principal', 12401, 'masneep', '2016-07-05', '2016-07-21', 'fsd', 'sbdblsd', 12401, 'masneep', '2016-07-05', '2016-07-21', 'fsd', 'sbdblsd', NULL, NULL),
(578, 'Insert', '2016-07-11 21:38:46', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12405, 'yes', '2016-07-11', '2016-07-10', 'afdf', 'boo', NULL, NULL),
(579, 'Insert', '2016-07-11 21:38:46', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12406, 'yes', '2016-07-11', '2016-07-10', 'afdf', 'boo', NULL, NULL),
(580, 'Insert', '2016-07-12 09:59:19', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12407, 'yo', '2016-07-14', '2016-07-11', 'dnsdf', 'dkflskjdfl', NULL, NULL),
(581, 'Insert', '2016-07-12 10:00:43', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12408, 'jkdj', '2016-06-28', '2016-07-01', 'kfjd', 'jkfjd', NULL, NULL),
(582, 'Insert', '2016-07-12 10:03:03', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12409, 'yoho', '2016-07-06', '2016-07-08', 'sdbhjd', 'dblds', NULL, NULL),
(583, 'Insert', '2016-07-12 10:04:13', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12410, 'stamina', '2016-06-29', '2016-07-02', 'djfslfjdn', 'dskldj', NULL, NULL),
(584, 'Insert', '2016-07-12 10:05:57', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12411, 'fools', '2016-07-13', '2016-07-17', 'sldjglsj', 'bfsglbg', NULL, NULL),
(585, 'Insert', '2016-07-12 10:06:14', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12412, 'sdfjld', '2016-07-12', '2016-07-15', 'dfjkkdsbj', 'sndfkjd', NULL, NULL),
(586, 'Insert', '2016-07-12 10:06:14', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12413, 'sdfjld', '2016-07-12', '2016-07-15', 'dfjkkdsbj', 'sndfkjd', NULL, NULL),
(587, 'Delete', '2016-07-12 10:07:01', 'root@localhost', 'mandeep', 12413, 'sdfjld', '2016-07-12', '2016-07-15', 'dfjkkdsbj', 'sndfkjd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(588, 'Delete', '2016-07-12 10:07:01', 'root@localhost', 'mandeep', 12412, 'sdfjld', '2016-07-12', '2016-07-15', 'dfjkkdsbj', 'sndfkjd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(589, 'Delete', '2016-07-12 10:07:02', 'root@localhost', 'mandeep', 12411, 'fools', '2016-07-13', '2016-07-17', 'sldjglsj', 'bfsglbg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `cal_events_log` (`log_id`, `action`, `action_time`, `user`, `web_user`, `old_event_id`, `old_event_name`, `old_start_date`, `old_end_date`, `old_event_desc`, `old_location`, `new_event_id`, `new_event_name`, `new_start_date`, `new_end_date`, `new_event_desc`, `new_location`, `remote_addr`, `http_x_forwarded_for`) VALUES
(590, 'Delete', '2016-07-12 10:07:02', 'root@localhost', 'mandeep', 12410, 'stamina', '2016-06-29', '2016-07-02', 'djfslfjdn', 'dskldj', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(591, 'Delete', '2016-07-12 10:07:02', 'root@localhost', 'mandeep', 12409, 'yoho', '2016-07-06', '2016-07-08', 'sdbhjd', 'dblds', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592, 'Delete', '2016-07-12 10:07:02', 'root@localhost', 'mandeep', 12408, 'jkdj', '2016-06-28', '2016-07-01', 'kfjd', 'jkfjd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(593, 'Delete', '2016-07-12 10:07:02', 'root@localhost', 'mandeep', 12407, 'yo', '2016-07-14', '2016-07-11', 'dnsdf', 'dkflskjdfl', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(594, 'Delete', '2016-07-12 10:07:02', 'root@localhost', 'mandeep', 12406, 'yes', '2016-07-11', '2016-07-10', 'afdf', 'boo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(595, 'Delete', '2016-07-12 10:07:02', 'root@localhost', 'mandeep', 12405, 'yes', '2016-07-11', '2016-07-10', 'afdf', 'boo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(596, 'Delete', '2016-07-12 10:07:02', 'root@localhost', 'principal', 12404, 'masneep', '2016-07-05', '2016-07-21', 'fsd', 'sbdblsd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(597, 'Delete', '2016-07-12 10:07:02', 'root@localhost', 'principal', 12403, 'masneep', '2016-07-05', '2016-07-21', 'fsd', 'sbdblsd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(598, 'Delete', '2016-07-12 10:07:02', 'root@localhost', 'principal', 12402, 'masneep', '2016-07-05', '2016-07-21', 'fsd', 'sbdblsd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(599, 'Delete', '2016-07-12 10:07:02', 'root@localhost', 'principal', 12401, 'masneep', '2016-07-05', '2016-07-21', 'fsd', 'sbdblsd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(600, 'Delete', '2016-07-12 10:07:02', 'root@localhost', 'principal', 12400, 'main', '2016-07-10', '2016-07-10', 'yo', 'cool', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(601, 'Insert', '2016-07-12 10:09:08', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12414, 'mandeep event', '2016-07-07', '2016-07-10', 'nfjdlfjd', 'dnsbfjdkbf', NULL, NULL),
(602, 'Insert', '2016-07-12 10:12:30', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12415, 'mandeep error', '2016-07-13', '2016-07-16', 'mandeep\r\n"yo"', '324', NULL, NULL),
(603, 'Delete', '2016-07-12 10:13:48', 'root@localhost', 'mandeep', 12415, 'mandeep error', '2016-07-13', '2016-07-16', 'mandeep\r\n"yo"', '324', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(604, 'Insert', '2016-07-12 10:19:47', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12416, 'dfl', '2016-07-06', '2016-07-09', ',dsfm', 'lk;nk', NULL, NULL),
(605, 'Insert', '2016-07-12 10:20:18', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12417, 'mandeep', '2016-07-12', '2016-07-16', 'sjfdk', 'dkfjkd', NULL, NULL),
(606, 'Insert', '2016-07-12 10:42:40', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12418, 'drti', '2016-07-11', '2016-07-14', 'yjyg', 'g', NULL, NULL),
(607, 'Insert', '2016-07-12 10:44:43', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12419, 'dfkjk', '2016-06-29', '2016-07-01', 'dfkjkjd', 'jdfjhd', NULL, NULL),
(608, 'Insert', '2016-07-12 10:44:57', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12420, 'kdjkf', '2016-07-20', '2016-07-23', 'flhdhf', 'ldjf', NULL, NULL),
(609, 'Delete', '2016-07-12 11:57:15', 'root@localhost', 'mandeep', 12414, 'mandeep event', '2016-07-07', '2016-07-10', 'nfjdlfjd', 'dnsbfjdkbf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(610, 'Delete', '2016-07-12 11:57:28', 'root@localhost', 'mandeep', 12416, 'dfl', '2016-07-06', '2016-07-09', ',dsfm', 'lk;nk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(611, 'Insert', '2016-07-13 09:31:50', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12421, 'mandeeptesting', '2016-07-05', '2016-07-07', 'workshop today', '513', NULL, NULL),
(612, 'Delete', '2016-07-13 09:51:31', 'root@localhost', 'mandeep', 12419, 'dfkjk', '2016-06-29', '2016-07-01', 'dfkjkjd', 'jdfjhd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(613, 'Update', '2016-07-13 09:52:09', 'root@localhost', 'mandeep', 12421, 'mandeeptesting', '2016-07-05', '2016-07-07', 'workshop today', '513', 12421, 'mandeeptesting', '2016-07-05', '2016-07-08', 'workshop today', '513', NULL, NULL),
(614, 'Update', '2016-07-13 09:52:59', 'root@localhost', 'mandeep', 12421, 'mandeeptesting', '2016-07-05', '2016-07-08', 'workshop today', '513', 12421, 'mandeeptesting', '2016-07-05', '2016-07-09', 'workshop today', '513', NULL, NULL),
(615, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'ss', 1, 'Test', '2015-08-14', '2015-08-14', 'test', 'test', 1, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(616, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodin', 2, 'Faculty Meetting', '2015-08-31', '2015-08-31', 'NAAC work review', '112C', 2, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(617, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hoden', 3, 'Workshop on PCB Design', '2015-08-10', '2015-08-14', 'This is a free workshop for third and fourth year students.', 'Lab. 201 and 208', 3, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(618, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hoden', 4, 'Workshop on Rasberry Pi', '2015-08-17', '2015-08-18', 'A workshop is arranged by EXTC department in association with IETE-RAIT.', 'Lab. 201', 4, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(619, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'principal', 5, 'NBA FILES - Meeting', '2015-08-24', '2015-08-24', 'All HODs &amp; Faculty handling NBA Files requested to attend', 'Principal Chambers', 5, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(620, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'pa', 6, 'Youth &amp; Communal Harmony- ', '2015-08-31', '2015-08-31', 'Youth &amp; Communal Harmony- School of Eduction', 'Room No 615', 6, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(621, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'pa', 10, 'Role of Instrumentation Engg. ', '2015-09-03', '2015-09-03', 'Dept. of Instrumentation Engg Role of Instrumentation Engg. in Corporat World', 'Room No 615', 10, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(622, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'pa', 11, 'The Art of Control', '2015-09-02', '2015-09-02', 'The Art of Control - by ISKCON, Juhu, Mumbai - 10.30 to 12.30', 'Room No 615', 11, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(623, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'pa', 12, 'Placement Preparation Talk', '2015-09-02', '2015-09-02', 'Placement Preparation Talk 3.00pm onwards.', 'Room No 615', 12, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(624, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'pa', 13, 'Placement Preparation Talk', '2015-09-03', '2015-09-03', 'Placement Preparation Talk 3.00pm onwards', 'Room No 615', 13, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(625, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 14, 'Workshop', '2015-09-16', '2015-09-16', 'Network Security workshop for UG and PG', '513', 14, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(626, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 15, 'Expert Lecture', '2015-10-01', '2015-10-01', 'IP Awareness Seminar - Everything you wanted to know about Intellectual Property Rights (IPR) by Mr. Akhilesh C Srivastava', '615', 15, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(627, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 16, 'Expert Lecture', '2015-10-01', '2015-10-01', 'IP Awareness Seminar - Everything you wanted to know about Intellectual Property Rights (IPR) by Mr. Akhilesh C Srivastava', '615', 16, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(628, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 19, 'Holiday', '2015-07-18', '2015-07-18', 'Ramzan Id', 'with family', 19, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(629, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 20, 'Holiday', '2015-08-15', '2015-08-15', 'Independence day', 'President Office', 20, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(630, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 21, 'Holiday', '2015-08-18', '2015-08-18', 'Parsi New Year', 'with family', 21, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(631, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 24, 'Holiday', '2015-09-17', '2015-09-17', 'Ganesh Chaturti', 'Ground Floor RAIT', 24, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(632, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 26, 'Holiday', '2015-09-25', '2015-09-25', 'Bakari Id', 'with family', 26, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(633, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 27, 'Holiday', '2015-10-02', '2015-10-02', 'Gandhi Jayanti', 'Tech Fests in RAIT', 27, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(634, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 28, 'Holiday', '2015-10-22', '2015-10-22', 'Dussehra', 'with family', 28, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(635, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 29, 'Holiday', '2015-10-24', '2015-10-24', 'Moharam', 'with family', 29, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(636, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 30, 'Holiday', '2015-11-11', '2015-11-12', 'Deepawapli', 'with family', 30, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(637, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 31, 'Donation Drive by Social Wing', '2015-08-03', '2015-08-08', 'Collection of Books, Cloths, stationary, bags, fund from RAIT students and faculty and donted to Rabale Community center', 'RAIT Glass door', 31, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(638, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 40, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri  by 102 RAIT students', 'Uran', 40, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(639, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 42, 'Tree Plantation Drive by Socia', '2015-08-22', '2015-08-22', '150 Tree plantation at Dronagiri  by 102 RAIT students', 'RAIT Glass door', 42, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(640, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 53, 'Cleanup drive by social wing', '2015-09-29', '2015-09-29', 'Beach Clean-up drive at Juhu Chowpati ', 'Juhu Choupati', 53, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(641, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 55, 'Short film ', '2015-10-02', '2015-10-02', 'Short film on a social issue by RAIT students to be put on UTube', 'RAIT Glass door', 55, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(642, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 56, 'Fund Raiser', '2015-10-01', '2015-10-03', 'Multiple fund raising and fun events to support under privileged children ', 'RAIT', 56, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(643, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 57, 'Skit', '2015-10-01', '2015-10-01', 'Skit on social issue by Social Wing', 'RAIT and stations', 57, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(644, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 58, 'Deepawali celebrations', '2015-11-11', '2015-11-11', 'Deepawali celebrations at Quarry center, Nerul MIDC area by Social Wing', 'Nerul', 58, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(645, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 59, 'Spirit of Christmas', '2015-12-25', '2015-12-25', 'Christmas celebrations at Rabale Community center for underprivileged children by Social Wing', 'Rabale', 59, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(646, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 60, 'medical check-up camp', '2015-10-17', '2015-10-17', 'Medical Check-up camp for Girija Orphanage children at Dr, D Y Patil Hospital by Social Wing', 'D Y Patil Hospital', 60, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(647, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 61, 'Workshop', '2015-08-06', '2015-08-06', 'Workshop on Artificial Intelligence for BE students', '615', 61, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(648, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 62, 'Expert Lecture', '2015-08-12', '2015-08-12', 'Guest Lecture on Application Architecture and design pattern for TE stuents', '615', 62, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(649, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 63, 'Expert Lecture', '2015-08-19', '2015-08-19', 'Expert Lecture on Object oriented analysis and design for SE students by Mrs. Aditi Chabria', '511', 63, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(650, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 64, 'Training Program', '2015-09-01', '2015-09-05', 'Training program on Trends and Techniques in Web Technology and Android Technology for TE students by Mr. Samsher Singh, CEO Unisoft Technology, C B D Belapur', '513', 64, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(651, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 65, 'Workshop', '2015-09-08', '2015-09-10', 'Workshop on NS2 for TE students by Mrs. Puja Padia and Mr. A V Vidhate', '513', 65, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(652, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 66, 'Workshop', '2015-09-16', '2015-09-16', 'Workshop on Network Security for BE students by Mr. Sachin Dedhiya', '513', 66, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(653, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 67, 'Expert Lecture', '2015-10-07', '2015-10-07', 'Expert Lecture on Software Architecture for BE students by Prof. Kavita Kelkar', '511', 67, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(654, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'exam', 68, 'photo copy ', '2015-09-08', '2015-09-14', 'The students who have applied for the Photo copy of the assessed answer books of semester III to VI for the examinations held in May 15. can collect on or before 14th Sep 2015', 'exam section room no 104', 68, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(655, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'csi', 69, 'Workshop on Webreneurship', '2015-08-08', '2015-08-09', 'Workshop on Webreneurship consisting of CMS, JOOMLA, DRUPAL Technologies and their business applications.', 'Lab No.: 513', 69, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(656, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'csi', 70, 'Webtechnology and PHP Workshop', '2015-09-01', '2015-09-03', 'Training on Web Technology and Php for students of Third Year Computer Engineering organised by Computer Dept. and CSI-RAIT.', 'Lab No.: 513', 70, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(657, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'csi', 71, 'Basics of PYTHON', '2015-10-10', '2015-10-11', 'Inhouse workshop on Python Programming organised by CSI-RAIT.', 'Lab No.: 513', 71, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(658, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'csi', 74, 'Teahtalk I', '2015-08-10', '2015-08-10', 'Talk on Internship Experience and opportunities by final year students organised by CSI-RAIT.', 'Room No.: 511', 74, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(659, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'csi', 75, 'Techtalk II', '2015-08-31', '2015-08-31', 'Talk on &quot;How to publish a Research Paper&quot; by external experienced speakers organised by CSI-RAIT.', 'Room No.: 511', 75, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(660, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'csi', 76, 'Techtalk III', '2015-09-07', '2015-09-07', 'Talk on UX/UI (User Experience/User Interface) Design by Faiz Malkani organised by CSI-RAIT.', 'Room No.: 511', 76, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(661, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'csi', 77, 'Techmate 2K15', '2015-10-01', '2015-10-03', '3-Day Technical Symposium conducted by CSI-RAIT.', '5th Floor', 77, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(662, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'csi', 80, 'Techtalk IV', '2015-10-05', '2015-10-05', 'Talk on BE Project Ideas for Third Year Engineering students by CSI-RAIT.  ', 'Room No.: 511', 80, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(663, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'csi', 81, 'Workshop', '2016-01-30', '2016-01-31', 'Organised by CSI-RAIT.', 'Lab No.: 513', 81, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(664, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'csi', 83, 'Workshop on Designing.', '2016-02-20', '2016-02-21', 'Creative designing workshop using Corel Draw-(Designing S/W), organised by CSI-RAIT.', 'Lab No.: 513', 83, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(665, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 85, 'Expert Lecture', '2015-09-23', '2015-09-23', 'Expert Lecture by Dr Vrunda Joshi (PVG College of Engineering, Pune) on Spherical Robot: Design and Control.', 'RAIT', 85, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(666, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 87, 'Training Program', '2015-10-07', '2015-10-10', 'Hands-on Training Session on Programmable System on Chip (PSoC) using ARM Micro-controllers by Eduvance Technology Ltd.', 'RAIT', 87, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(667, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 88, 'Industrial visit', '2015-10-17', '2015-10-17', ' Industrial visit of BE and ME students to M/S Hind Rectifiers, Bhandup.', 'Bhandup', 88, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(668, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodce5', 92, 'Expert Lecture', '2015-11-27', '2015-11-27', 'Expert Lecture by Prof Sharad Bhartiya (IIT Bombay) on Systems Biology.', 'RAIT', 92, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(669, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 94, 'Talk by Padmashree Dr. Sharad ', '2015-08-19', '2015-08-19', 'Special talk on Biogas Technology, Life Science and Waste Management', '615', 94, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(670, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 98, 'Guest Lecture by Padmashree Dr', '2015-08-19', '2015-08-19', 'Special lecture on biogas technology, waste management and life sciences  ', '615', 98, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(671, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 99, 'Guest Lecture by Padmashree Dr', '2015-08-19', '2015-08-19', 'Special lecture on biogas technology, waste management and life sciences  ', '615', 99, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(672, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 100, 'Special Lecture by Dr Kale', '2015-08-19', '2015-08-19', 'Special lecture on biogas technology, waste management and life sciences  ', '615', 100, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(673, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 101, 'Workshop on stress managemnet', '2013-08-20', '2013-08-20', 'Stress Management by Faculty of Bramha Kumari', '611', 101, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(674, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 102, 'Technical Talk', '2014-09-24', '2014-09-24', 'Seminar by Dr Zakir Taquvi Ex NASA', '615', 102, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(675, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 103, 'Workshop on stress managemnet', '2014-02-06', '2014-02-07', 'Stress Management workshop by Ramkrishna Mission to the students so that they can achieve success in their life', '611', 103, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(676, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 104, 'Workshop on Syllabus Revision ', '2012-09-11', '2012-09-11', 'Orientation Programme on the revised syllabus of Applied Chemistry I &amp; II on the behalf of University of Mumbai. This workshop was organized to get familiar with new pattern of curriculum. ', '615', 104, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(677, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 105, 'Workshop on revised syllabus', '2012-09-11', '2012-09-11', 'Orientation Programme on the revised syllabus of Applied Chemistry I &amp; II on the behalf of University of Mumbai. This workshop was organized to get familiar with new pattern of curriculum. ', '615', 105, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(678, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 106, 'Special Lecture by Padmashree ', '2015-03-18', '2015-03-18', 'Padmashree Dr. Basu is Director of BARC, Mumbai delivered lecture on Nuclear Physics and research programs performed by BARC to the development of India', 'Auditorium', 106, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(679, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 107, 'Guest Lecture by Padmashree Dr', '2015-03-18', '2015-03-18', 'Padmashree Dr. Basu is Director of BARC, Mumbai delivered lecture on Nuclear Physics and research programs performed by BARC to the development of India', 'Auditorium', 107, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(680, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 109, 'Talk by Dr Basu', '2015-03-18', '2015-03-18', 'Padmashree Dr Basu (Director, BARC) delivered talk on development of Nuclear Physics in India and role of BARC in the development of India', 'Auditorium', 109, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(681, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 110, 'Talk by Dr Naba Mandal', '2014-09-25', '2014-09-25', 'Dr. Naba Mandal from BARC delivered talk on Neutrino Physics', '615', 110, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(682, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 111, 'Guest Lecture by Dr S Ghosh', '2015-02-18', '2015-02-18', 'Dr. S Ghosh is scientist in BARC and working at Biotechnology division. He introduced students that how technology can be used to develop biogas and how it can be controlled.', '615', 111, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(683, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 112, 'Workshop on Sahaj Yoga', '2015-03-02', '2015-03-05', 'Sahaj Yoga Meditation. Faculty of Sahaj Yoga', '611', 112, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(684, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 113, 'FE Orientation Program 2015', '2015-07-27', '2015-07-27', 'FE orientation programmed conducted very smoothly under guidance of Prof Dr. S. D. Shete Head of Engineering Science Department. He addressed new students about engineering in RAIT and guided them so that they can achieve success in their carrier ', 'Auditorium', 113, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(685, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 116, 'Workshop on Question Paper pat', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. He was nominated as chairman by University of Mumbai ', '615', 116, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(686, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 117, 'Workshop on Question Paper pat', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. He was nominated as chairman by University of Mumbai ', '615', 117, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(687, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 118, 'Work on behalf of University o', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. He was nominated as chairman by University of Mumbai ', '615', 118, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(688, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 120, 'Workshop on behalf of Universi', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', 120, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(689, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 121, 'Workshop for question paper pa', '2012-09-12', '2012-09-12', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', 121, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(690, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 122, 'Workshop for question paper pa', '2012-09-13', '2012-09-13', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', 122, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(691, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 124, 'Question Paper Pattern Develop', '2012-09-13', '2012-09-13', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', 124, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(692, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 127, 'Workshop on Blueprint of Appli', '2012-09-11', '2012-09-11', 'The Chairman of committee  was Prof. Dr. S. D. Shete, (nominated by University of Mumbai) Head of Department of Engineering Sciences, RAIT. ', '611', 127, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(693, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 128, 'Workshop on behalf of Mumbai U', '2012-09-11', '2012-09-11', 'The Chairman of committee  was Prof. Dr. S. D. Shete, (nominated by University of Mumbai) Head of Department of Engineering Sciences, RAIT. ', '611', 128, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(694, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 130, 'Seminar on behalf of Mumbai Un', '2012-09-11', '2012-09-11', 'Workshop for development of blue print for the subject of Applied Chemistry I &amp; II. The Chairman of Committee was Prof. Dr. S. D. Shete, HOD dept of Engineering Sciences. He was nominated as chairman by University of Mumbai', '615', 130, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(695, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodes', 133, 'workshop on development of blu', '2012-09-11', '2012-09-11', 'Workshop for development of blue print for the subject of Applied Chemistry I &amp; II. The Chairman of Committee was Prof. Dr. S. D. Shete, HOD dept of Engineering Sciences. He was nominated as chairman by University of Mumbai', '615', 133, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(696, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hod', 142, 'Workshop on Android', '2015-09-25', '2015-09-26', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', 142, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(697, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'csi', 148, 'NTPP', '2015-10-01', '2015-10-03', 'Technical Paper Presentation Competition conducted by CSI under Computer Department', '615', 148, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(698, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'csi', 149, 'Placement Mantra', '2015-10-01', '2015-10-03', 'Most popular event of Techmate giving experience of mock placements to the participants.', '515 and 520', 149, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(699, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'csi', 150, 'Next Aim', '2015-10-01', '2015-10-03', 'Event providing mock practice for examinations of higher education such as GRE, GMAT conducted by CSI under Computer Department.', '514', 150, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(700, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hoden', 151, 'ARM University (UK) Workshop', '2015-10-07', '2015-10-11', 'The workshop is arranged for third year students. It will be given by Eduvance, Mumbai in collaboration with ARM University (UK) and Cypress Semiconductors. ', 'IT Centre (2nd FLoor)', 151, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(701, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hoden', 152, 'Demo of New Library Software (', '2015-10-07', '2015-10-07', 'For faculty and students.', '615', 152, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(702, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hoden', 153, 'Demo of New Library Software (', '2015-10-07', '2015-10-07', 'For faculty and students.', '615', 153, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(703, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hoden', 154, 'Demo of New Library Software (', '2015-10-07', '2015-10-07', 'For faculty and students.', '615', 154, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(704, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hoden', 155, 'Demo of New Library Software (', '2015-10-07', '2015-10-07', 'For faculty and students.', '615', 155, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(705, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hoden', 156, 'Training of Library staff for ', '2015-10-10', '2015-10-10', 'For Library and BVG (Tech) staff.', '511/611', 156, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(706, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hoden', 157, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511/611', 157, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(707, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hoden', 158, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511', 158, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(708, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hoden', 159, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511', 159, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(709, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hoden', 160, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511', 160, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(710, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hoden', 161, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511', 161, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(711, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hoden', 162, 'Training of Library staff for ', '2015-10-10', '2015-10-11', 'For Library and BVG (Tech) staff.', '511', 162, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(712, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 163, 'test', '2015-11-10', '2015-11-10', 'test', 'Room No. 615', 163, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(713, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 169, 'Expert Session ', '2016-01-18', '2016-01-18', 'Expert Session on Pattern Recognition for ME ', '615', 169, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(714, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 170, 'Expert Session ', '2016-01-20', '2016-01-20', 'Expert session for BE students by Mr. Munir Syad', '615', 170, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(715, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 171, 'Expert Session ', '2016-01-27', '2016-01-27', 'Expert Session by Siby sir for ME students', '615', 171, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(716, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 184, 'Expert Lecture on Introduction', '2016-01-08', '2016-01-08', 'Expert Lecture on Introduction to openGL by Prof. Shridhar Donamal for Second Year Students', '511', 184, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(717, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 188, 'test', '2016-01-12', '2016-01-12', 'test', 't', 188, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(718, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 190, 'Term Test I', '2016-02-11', '2016-02-13', 'Term Test of All Departments.', '5 Floor', 190, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(719, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 191, 'Horizon', '2016-02-18', '2016-02-20', 'Culture Festival of RAIT', 'RAIT', 191, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(720, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 192, 'Holiday', '2016-01-26', '2016-01-26', 'Republic Day', 'Near President Office', 192, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(721, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 193, 'Academic Audit', '2016-02-29', '2016-02-29', 'audit of All Departments. ', 'RAIT', 193, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(722, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 194, 'Holiday', '2016-03-07', '2016-03-07', 'Mahashivratri', '@ Your Home', 194, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(723, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 195, 'Tech Fest', '2016-03-21', '2016-03-23', 'Tech Fest of RAIT', 'RAIT', 195, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(724, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 196, 'EPL', '2016-03-24', '2016-03-25', 'Cricket Matches ', 'DY Patil Stadium', 196, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(725, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 197, 'Student Feedback', '2016-03-28', '2016-03-29', 'Academic feedback One ', 'ALL Labs', 197, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(726, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 198, 'Academic Audit II', '2016-03-31', '2016-03-31', 'Academic Audit of all Department', 'RAIT', 198, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(727, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 199, 'Project Competition ', '2016-04-01', '2016-04-01', 'B. E Project Competition ', 'E- Yantra Lab', 199, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(728, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 200, 'Term Test II', '2016-04-07', '2016-04-11', 'Term Test II of RAIT', 'RAIT', 200, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(729, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 201, 'Remedial Classes', '2016-04-12', '2016-04-13', 'Remedial Classes for defaulter students', '5 Floor', 201, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(730, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 202, 'Term End', '2016-04-16', '2016-04-16', 'End of Even Sem', 'RAIT', 202, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(731, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'PA', 203, 'RAIT Placement', '2016-01-16', '2016-01-16', 'Placement drive of Muthshut.com ', 'Room No. 615', 203, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(732, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodfe', 205, 'Term Start', '2016-01-04', '2016-01-04', 'Start of Sem II', 'RAIT', 205, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(733, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodfe', 206, 'First Defaulter''s List', '2016-02-09', '2016-01-09', 'Display of First Defaulter''s List', 'RAIT', 206, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(734, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodfe', 207, 'Term Test I', '2016-02-11', '2016-02-13', 'Term Test I Conduction', 'RAIT', 207, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(735, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodfe', 208, 'Term Test I Marks Display', '2016-02-17', '2016-02-17', 'Display of Term Test I marks to the students so that they can analyse and improve their performance', 'RAIT Notice Board', 208, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(736, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodfe', 209, 'Student Feedback', '2016-03-28', '2016-04-01', 'Feedback from students on both CO and Faculty feedback', '212', 209, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(737, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodfe', 210, 'Second Defaulter''s List', '2016-04-05', '2016-04-05', 'Display of Second Defaulter''s :ist', 'RAIT Notice Board', 210, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(738, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodfe', 211, 'Term Test II', '2016-04-07', '2016-04-09', 'Term Test II of SEM II', 'RAIT', 211, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(739, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodfe', 212, 'AutoCAD Practical Examination', '2016-04-18', '2016-04-23', 'AutoCAD Practical Examination Tentative dates', '212', 212, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(740, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodfe', 213, 'SPA Practical Examination', '2016-04-18', '2016-04-23', 'SPA Practical Examination Tentative Dates', 'SPA Labs at 5th floor and 6th ', 213, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(741, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodfe', 214, 'Expert Lecture on Softwares to', '2016-01-25', '2016-01-25', 'Use of different softwares for teaching Engineering Drawing Subject of FE Sem II. These softwares will help to understand some concepts of ED more easily to students.', '212', 214, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(742, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodfe', 215, 'Expert Lecture on Softwares to', '2016-01-25', '2016-01-25', 'Use of different softwares for teaching Engineering Drawing Subject of FE Sem II. These softwares will help to understand some concepts of ED more easily to students.', '212', 215, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(743, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hodfe', 216, 'Seminar on ED software', '2016-01-25', '2016-01-25', 'Seminar on how to use different softwares and AutoCAD to make student understand the concept easily', '212', 216, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(744, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hod', 217, 'Latex Training', '2016-01-29', '2016-01-29', 'Training on Latex for BE(IT) students for generation of their project black book.', '616 lab', 217, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(745, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 218, '1 day workshop on Parallel and', '2016-02-04', '2016-01-04', 'Expert session on PDS and Hands on Lab for ME and BE students', '615', 218, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(746, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 219, '1 day workshop on Parallel and', '2016-02-04', '2016-01-04', 'Expert session on PDS and Hands on Lab for ME and BE students', '615', 219, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(747, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'faculty', 220, '1 day workshop on Parallel and', '2016-02-04', '2016-01-04', 'Expert session on PDS and Hands on Lab for ME and BE students', '615', 220, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(748, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'PA', 221, 'RAIT Placement', '2016-01-29', '2016-01-29', 'Teach for India Seminar', 'Room No. 615', 221, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(749, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'PA', 222, 'D Y Patil Law College', '2016-02-06', '2016-02-06', 'Vidhi Mitra- 3.30pm to 6.30pm', 'Room No. 615', 222, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(750, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'hod', 223, 'Latex Training', '2016-02-05', '2016-02-05', 'Latex Training for BE students for Black book preparation.', '616lab', 223, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(751, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'mandeep', 12417, 'mandeep', '2016-07-12', '2016-07-16', 'sjfdk', 'dkfjkd', 12417, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(752, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'mandeep', 12418, 'drti', '2016-07-11', '2016-07-14', 'yjyg', 'g', 12418, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(753, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'mandeep', 12420, 'kdjkf', '2016-07-20', '2016-07-23', 'flhdhf', 'ldjf', 12420, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(754, 'Update', '2016-07-13 10:58:19', 'root@localhost', 'mandeep', 12421, 'mandeeptesting', '2016-07-05', '2016-07-09', 'workshop today', '513', 12421, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(755, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'ss', 1, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 1, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(756, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodin', 2, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 2, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(757, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hoden', 3, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 3, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(758, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hoden', 4, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 4, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(759, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'principal', 5, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 5, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(760, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'pa', 6, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 6, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(761, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'pa', 10, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 10, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(762, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'pa', 11, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 11, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(763, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'pa', 12, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 12, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(764, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'pa', 13, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 13, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(765, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 14, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 14, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(766, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 15, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 15, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL);
INSERT INTO `cal_events_log` (`log_id`, `action`, `action_time`, `user`, `web_user`, `old_event_id`, `old_event_name`, `old_start_date`, `old_end_date`, `old_event_desc`, `old_location`, `new_event_id`, `new_event_name`, `new_start_date`, `new_end_date`, `new_event_desc`, `new_location`, `remote_addr`, `http_x_forwarded_for`) VALUES
(767, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 16, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 16, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(768, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 19, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 19, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(769, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 20, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 20, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(770, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 21, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 21, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(771, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 24, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 24, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(772, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 26, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 26, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(773, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 27, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 27, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(774, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 28, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 28, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(775, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 29, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 29, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(776, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 30, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 30, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(777, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 31, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 31, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(778, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 40, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 40, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(779, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 42, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 42, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(780, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 53, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 53, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(781, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 55, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 55, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(782, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 56, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 56, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(783, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 57, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 57, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(784, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 58, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 58, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(785, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 59, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 59, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(786, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 60, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 60, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(787, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 61, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 61, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(788, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 62, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 62, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(789, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 63, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 63, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(790, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 64, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 64, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(791, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 65, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 65, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(792, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 66, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 66, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(793, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 67, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 67, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(794, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'exam', 68, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 68, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(795, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'csi', 69, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 69, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(796, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'csi', 70, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 70, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(797, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'csi', 71, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 71, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(798, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'csi', 74, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 74, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(799, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'csi', 75, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 75, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(800, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'csi', 76, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 76, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(801, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'csi', 77, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 77, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(802, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'csi', 80, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 80, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(803, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'csi', 81, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 81, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(804, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'csi', 83, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 83, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(805, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 85, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 85, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(806, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 87, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 87, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(807, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 88, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 88, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(808, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodce5', 92, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 92, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(809, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 94, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 94, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(810, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 98, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 98, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(811, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 99, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 99, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(812, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 100, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 100, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(813, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 101, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 101, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(814, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 102, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 102, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(815, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 103, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 103, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(816, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 104, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 104, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(817, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 105, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 105, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(818, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 106, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 106, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(819, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 107, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 107, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(820, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 109, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 109, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(821, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 110, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 110, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(822, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 111, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 111, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(823, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 112, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 112, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(824, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 113, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 113, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(825, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 116, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 116, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(826, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 117, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 117, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(827, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 118, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 118, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(828, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 120, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 120, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(829, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 121, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 121, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(830, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 122, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 122, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(831, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 124, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 124, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(832, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 127, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 127, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(833, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 128, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 128, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(834, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 130, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 130, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(835, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodes', 133, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 133, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(836, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hod', 142, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 142, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(837, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'csi', 148, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 148, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(838, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'csi', 149, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 149, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(839, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'csi', 150, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 150, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(840, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hoden', 151, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 151, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(841, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hoden', 152, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 152, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(842, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hoden', 153, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 153, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(843, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hoden', 154, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 154, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(844, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hoden', 155, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 155, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(845, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hoden', 156, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 156, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(846, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hoden', 157, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 157, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(847, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hoden', 158, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 158, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(848, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hoden', 159, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 159, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(849, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hoden', 160, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 160, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(850, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hoden', 161, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 161, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(851, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hoden', 162, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 162, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(852, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 163, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 163, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(853, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 169, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 169, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(854, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 170, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 170, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(855, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 171, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 171, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(856, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 184, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 184, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(857, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 188, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 188, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(858, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 190, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 190, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(859, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 191, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 191, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(860, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 192, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 192, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(861, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 193, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 193, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(862, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 194, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 194, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(863, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 195, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 195, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(864, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 196, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 196, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(865, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 197, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 197, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(866, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 198, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 198, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(867, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 199, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 199, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(868, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 200, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 200, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(869, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 201, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 201, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(870, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 202, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 202, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(871, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'PA', 203, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 203, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(872, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodfe', 205, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 205, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(873, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodfe', 206, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 206, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(874, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodfe', 207, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 207, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(875, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodfe', 208, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 208, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(876, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodfe', 209, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 209, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(877, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodfe', 210, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 210, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(878, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodfe', 211, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 211, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(879, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodfe', 212, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 212, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(880, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodfe', 213, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 213, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(881, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodfe', 214, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 214, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(882, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodfe', 215, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 215, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(883, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hodfe', 216, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 216, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(884, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hod', 217, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 217, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(885, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 218, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 218, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(886, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 219, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 219, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(887, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'faculty', 220, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 220, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(888, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'PA', 221, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 221, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(889, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'PA', 222, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 222, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(890, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'hod', 223, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 223, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(891, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'mandeep', 12417, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 12417, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(892, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'mandeep', 12418, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 12418, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(893, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'mandeep', 12420, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 12420, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(894, 'Update', '2016-07-13 10:59:05', 'root@localhost', 'mandeep', 12421, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', 12421, 'mandeeptesting', '0000-00-00', '0000-00-00', 'workshop today', '513', NULL, NULL),
(895, 'Insert', '2016-07-13 11:03:25', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12422, '', '2016-06-29', '2016-06-30', '', '', NULL, NULL),
(896, 'Update', '2016-07-13 11:08:30', 'root@localhost', 'mandeep', 12422, '', '2016-06-29', '2016-06-30', '', '', 12422, 'mandeep', '2016-06-29', '2016-06-30', '', '', NULL, NULL),
(897, 'Update', '2016-07-13 11:09:13', 'root@localhost', 'mandeep', 12422, 'mandeep', '2016-06-29', '2016-06-30', '', '', 12422, 'mandeep', '2016-06-29', '2016-06-30', '', '', NULL, NULL),
(898, 'Update', '2016-07-13 11:10:06', 'root@localhost', 'mandeep', 12422, 'mandeep', '2016-06-29', '2016-06-30', '', '', 12422, 'mandeep changed', '2016-06-29', '2016-06-30', 'changed', '513 changed', NULL, NULL),
(899, 'Insert', '2016-07-13 20:31:48', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12423, 'mandeep is yo', '2016-07-06', '2016-07-09', 'meeting ', '513', NULL, NULL),
(900, 'Insert', '2016-07-13 20:31:48', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12424, 'mandeep is yo', '2016-07-06', '2016-07-09', 'meeting ', '513', NULL, NULL),
(901, 'Insert', '2016-07-13 20:31:48', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12425, 'mandeep is yo', '2016-07-06', '2016-07-09', 'meeting ', '513', NULL, NULL),
(902, 'Insert', '2016-07-13 20:32:47', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12426, 'dfkljd', '2016-07-06', '2016-07-07', 'kjgf', '', NULL, NULL),
(903, 'Insert', '2016-07-13 20:32:55', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12427, '', '2016-07-06', '2016-07-07', '', '', NULL, NULL),
(904, 'Insert', '2016-07-14 11:36:11', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12428, 'Tech fest', '2016-07-11', '2016-07-14', 'tecghnical fest', '5th floor', NULL, NULL),
(905, 'Insert', '2016-07-14 11:39:27', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12429, 'meeting', '2016-07-05', '2016-07-09', 'topic: AI', '513', NULL, NULL),
(906, 'Insert', '2016-07-14 11:39:27', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12430, 'meeting', '2016-07-05', '2016-07-09', 'topic: AI', '513', NULL, NULL),
(907, 'Insert', '2016-07-14 11:39:27', 'root@localhost', 'principal', NULL, NULL, NULL, NULL, NULL, NULL, 12431, 'meeting', '2016-07-05', '2016-07-09', 'topic: AI', '513', NULL, NULL),
(908, 'Update', '2016-07-14 11:58:37', 'root@localhost', 'mandeep', 12422, 'mandeep changed', '2016-06-29', '2016-06-30', 'changed', '513 changed', 12422, 'mandeep changed', '2016-06-29', '2016-06-30', 'changed', '513 changed', NULL, NULL),
(909, 'Update', '2016-07-14 11:58:54', 'root@localhost', 'mandeep', 12422, 'mandeep changed', '2016-06-29', '2016-06-30', 'changed', '513 changed', 12422, 'mandeep changed', '2016-06-29', '2016-06-30', 'changed', '513 changed', NULL, NULL),
(910, 'Update', '2016-07-14 12:22:55', 'root@localhost', 'principal', 12431, 'meeting', '2016-07-05', '2016-07-09', 'topic: AI', '513', 12431, 'meeting', '0000-00-00', '0000-00-00', 'topic: AI', '513', NULL, NULL),
(911, 'Insert', '2016-07-14 12:23:26', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12432, 'kjsfs', '2016-07-12', '2016-07-14', 'dsfdjbk', 'jhsljd', NULL, NULL),
(912, 'Delete', '2016-07-14 12:24:32', 'root@localhost', 'mandeep', 12422, 'mandeep changed', '2016-06-29', '2016-06-30', 'changed', '513 changed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(913, 'Insert', '2016-07-14 12:25:28', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12433, 'sdjas', '2016-06-29', '2016-07-01', 'sg', 'jgjhk', NULL, NULL),
(914, 'Update', '2016-07-14 12:53:31', 'root@localhost', 'mandeep', 12423, 'mandeep is yo', '2016-07-06', '2016-07-09', 'meeting ', '513', 12423, 'mandeep is yo', '2016-07-06', '2016-07-09', 'meeting ', '513', NULL, NULL),
(915, 'Insert', '2016-07-14 12:53:55', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12434, '', '2016-07-20', '2016-07-23', '', '', NULL, NULL),
(916, 'Update', '2016-07-14 12:55:12', 'root@localhost', 'mandeep', 12433, 'sdjas', '2016-06-29', '2016-07-01', 'sg', 'jgjhk', 12433, 'sdjasbakfjsdfk', '2016-06-29', '2016-07-01', 'sg', 'jgjhk', NULL, NULL),
(917, 'Insert', '2016-07-18 11:20:25', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12435, 'todayas', '2016-07-18', '2016-07-19', 'blah', 'blah', NULL, NULL),
(918, 'Insert', '2016-07-18 13:04:52', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12436, 'diti', '2016-07-14', '2016-07-17', 'akhf;sih', '543', NULL, NULL),
(919, 'Insert', '2016-07-18 13:04:52', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12437, 'diti', '2016-07-14', '2016-07-17', 'akhf;sih', '543', NULL, NULL),
(920, 'Insert', '2016-07-23 16:27:15', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12438, 'workshop', '2016-06-30', '2016-07-03', 'JPMC is coming', '513', NULL, NULL),
(921, 'Insert', '2016-07-23 16:27:16', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12439, 'workshop', '2016-06-30', '2016-07-03', 'JPMC is coming', '513', NULL, NULL),
(922, 'Insert', '2016-07-23 16:27:16', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 12440, 'workshop', '2016-06-30', '2016-07-03', 'JPMC is coming', '513', NULL, NULL),
(923, 'Insert', '2016-07-24 09:32:58', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 1, 'Workshop', '2016-06-29', '2016-07-02', 'A workshop on women empowerment', 'andheri', NULL, NULL),
(924, 'Insert', '2016-07-24 09:33:36', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 2, 'Meeting', '2016-07-05', '2016-07-06', 'A meeting to interact with the NGO ', 'Thane', NULL, NULL),
(925, 'Insert', '2016-07-24 09:34:07', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 3, 'Meeting', '2016-07-05', '2016-07-07', 'sjsajlfjasb', 'andheri', NULL, NULL),
(926, 'Update', '2016-07-24 09:34:25', 'root@localhost', 'mandeep', 2, 'Meeting', '2016-07-05', '2016-07-06', 'A meeting to interact with the NGO ', 'Thane', 2, 'Meeting', '2016-07-05', '2016-07-06', 'A meeting to interact with the NGO ', 'Thane', NULL, NULL),
(927, 'Update', '2016-07-24 09:34:36', 'root@localhost', 'mandeep', 2, 'Meeting', '2016-07-05', '2016-07-06', 'A meeting to interact with the NGO ', 'Thane', 2, 'Meeting', '2016-07-05', '2016-07-06', 'A meeting to interact with the NGO ', 'Thane', NULL, NULL),
(928, 'Update', '2016-07-24 09:34:44', 'root@localhost', 'mandeep', 2, 'Meeting', '2016-07-05', '2016-07-06', 'A meeting to interact with the NGO ', 'Thane', 2, 'Meeting', '2016-07-05', '2016-07-06', 'A meeting to interact with the NGO ', 'Thane', NULL, NULL),
(929, 'Update', '2016-07-24 09:34:54', 'root@localhost', 'mandeep', 2, 'Meeting', '2016-07-05', '2016-07-06', 'A meeting to interact with the NGO ', 'Thane', 2, 'Meeting', '2016-07-05', '2016-07-06', 'A meeting to interact with the NGO ', 'Thane', NULL, NULL),
(930, 'Update', '2016-07-24 09:35:01', 'root@localhost', 'mandeep', 2, 'Meeting', '2016-07-05', '2016-07-06', 'A meeting to interact with the NGO ', 'Thane', 2, 'Meeting', '2016-07-05', '2016-07-06', 'A meeting to interact with the NGO ', 'Thane', NULL, NULL),
(931, 'Update', '2016-07-24 09:35:07', 'root@localhost', 'mandeep', 2, 'Meeting', '2016-07-05', '2016-07-06', 'A meeting to interact with the NGO ', 'Thane', 2, 'Meeting', '2016-07-05', '2016-07-06', 'A meeting to interact with the NGO ', 'Thane', NULL, NULL),
(932, 'Insert', '2016-07-24 09:35:33', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Training', '2016-07-20', '2016-07-24', 'training ', 'wadala', NULL, NULL),
(933, 'Insert', '2016-07-24 13:58:51', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 5, 'test', '2016-07-07', '2016-07-09', '', '', NULL, NULL),
(934, 'Delete', '2016-07-24 13:58:59', 'root@localhost', 'mandeep', 5, 'test', '2016-07-07', '2016-07-09', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(935, 'Insert', '2016-07-24 14:19:04', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 6, 'meeting', '2016-07-06', '2016-07-09', 'fmndkjf', '', NULL, NULL),
(936, 'Insert', '2016-07-24 15:51:25', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 7, 'meeting', '2016-06-28', '2016-06-30', 'meeting on p', 'andheri', NULL, NULL),
(937, 'Update', '2016-08-13 08:42:02', 'root@localhost', 'mandeep', 4, 'Training', '2016-07-20', '2016-07-24', 'training ', 'wadala', 4, 'Training', '2016-07-20', '2016-07-24', 'training ', 'wadala', NULL, NULL),
(938, 'Update', '2016-08-13 08:42:06', 'root@localhost', 'mandeep', 3, 'Meeting', '2016-07-05', '2016-07-07', 'sjsajlfjasb', 'andheri', 3, 'Meeting', '2016-07-05', '2016-07-07', 'sjsajlfjasb', 'andheri', NULL, NULL),
(939, 'Update', '2016-08-13 08:42:09', 'root@localhost', 'mandeep', 1, 'Workshop', '2016-06-29', '2016-07-02', 'A workshop on women empowerment', 'andheri', 1, 'Workshop', '2016-06-29', '2016-07-02', 'A workshop on women empowerment', 'andheri', NULL, NULL),
(940, 'Update', '2016-08-13 08:42:12', 'root@localhost', 'mandeep', 2, 'Meeting', '2016-07-05', '2016-07-06', 'A meeting to interact with the NGO ', 'Thane', 2, 'Meeting', '2016-07-05', '2016-07-06', 'A meeting to interact with the NGO ', 'Thane', NULL, NULL),
(941, 'Insert', '2016-08-13 08:52:42', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 5, '', '2016-08-03', '2016-08-04', '', '', NULL, NULL),
(942, 'Insert', '2016-08-13 08:56:50', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 6, 'mandeep', '2016-08-03', '2016-08-04', 'mandeep is the best', '513', NULL, NULL),
(943, 'Delete', '2016-08-13 08:57:01', 'root@localhost', 'mandeep', 6, 'mandeep', '2016-08-03', '2016-08-04', 'mandeep is the best', '513', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(944, 'Delete', '2016-08-13 08:57:10', 'root@localhost', 'mandeep', 5, '', '2016-08-03', '2016-08-04', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(945, 'Insert', '2016-08-13 08:57:29', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 7, 'yp', '2016-08-03', '2016-08-06', 'ndfnkjn', '34567', NULL, NULL),
(946, 'Insert', '2016-08-13 08:57:29', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 8, 'yp', '2016-08-03', '2016-08-06', 'ndfnkjn', '34567', NULL, NULL),
(947, 'Update', '2016-08-13 08:59:52', 'root@localhost', 'mandeep', 8, 'yp', '2016-08-03', '2016-08-06', 'ndfnkjn', '34567', 8, 'mandeep', '2016-08-03', '2016-08-06', 'ndfnkjn', '34567', NULL, NULL),
(948, 'Insert', '2016-08-13 10:59:35', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 9, 'mandeep', '2016-08-11', '2016-08-12', 'skfjl', 'jssjfl', NULL, NULL),
(949, 'Insert', '2016-08-13 13:11:30', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 10, 'skfaskh', '2016-08-17', '2016-08-20', 'ssfkllh', 'jksskjsdl', NULL, NULL),
(950, 'Update', '2016-08-13 13:11:38', 'root@localhost', 'mandeep', 10, 'skfaskh', '2016-08-17', '2016-08-20', 'ssfkllh', 'jksskjsdl', 10, 'skfaskh', '2016-08-17', '2016-08-20', 'ssfkllh', 'jksskjsdl', NULL, NULL),
(951, 'Update', '2016-08-14 09:05:15', 'root@localhost', 'pa', 10, 'Role of Instrumentation Engg. ', '2015-09-03', '2015-09-03', 'Dept. of Instrumentation Engg\r\n\r\nRole of Instrumentation Engg. in Corporat World', 'Room No 615', 10, 'Role of Instrumentation Engg. ', '2015-09-03', '2015-09-03', 'Dept. of Instrumentation Engg Role of Instrumentation Engg. in Corporat World', 'Room No 615', NULL, NULL),
(952, 'Insert', '2016-09-27 19:18:11', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 228, 'etst', '2016-09-07', '2016-09-08', 'jkdshfkjdhl', 'hlsg', NULL, NULL),
(953, 'Insert', '2016-09-27 19:18:11', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 229, 'etst', '2016-09-07', '2016-09-08', 'jkdshfkjdhl', 'hlsg', NULL, NULL),
(954, 'Insert', '2016-09-27 19:18:33', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 230, 'dsfkj', '2016-09-07', '2016-09-09', 'mvgg', 'gghg', NULL, NULL),
(955, 'Insert', '2016-09-27 19:18:54', 'root@localhost', 'mandeep', NULL, NULL, NULL, NULL, NULL, NULL, 231, 'bd', '2016-09-07', '2016-09-09', 'djfk', 'ksdkj', NULL, NULL),
(956, 'Update', '2016-10-04 10:51:58', 'root@localhost', 'ss', 1, 'Test', '2015-08-14', '2015-08-14', 'test', 'test', 1, 'Test', '2015-08-14', '2015-08-14', 'test', 'test', NULL, NULL),
(957, 'Update', '2016-10-04 10:52:06', 'root@localhost', 'ss', 1, 'Test', '2015-08-14', '2015-08-14', 'test', 'test', 1, 'Test', '2015-08-14', '2015-08-14', 'test', 'test', NULL, NULL),
(958, 'Update', '2016-10-04 10:52:24', 'root@localhost', 'ss', 1, 'Test', '2015-08-14', '2015-08-14', 'test', 'test', 1, 'Test', '2015-08-14', '2015-08-14', 'test', 'test', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cal_events_new`
--

CREATE TABLE IF NOT EXISTS `cal_events_new` (
  `event_id` int(11) NOT NULL,
  `event_name` varchar(100) NOT NULL,
  `start_date` timestamp NOT NULL,
  `end_date` timestamp NOT NULL,
  `event_desc` longtext NOT NULL,
  `location` varchar(30) NOT NULL,
  `web_user` varchar(30) NOT NULL,
  `branch` varchar(20) NOT NULL DEFAULT 'COMPUTER',
  `category` varchar(20) NOT NULL DEFAULT 'Technical',
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cal_events_new`
--

INSERT INTO `cal_events_new` (`event_id`, `event_name`, `start_date`, `end_date`, `event_desc`, `location`, `web_user`, `branch`, `category`) VALUES
(0, 'testing trigger update', '2017-01-03 18:30:00', '2017-01-05 18:30:00', 'testing triff==gger decs', 'testing trigger location', 'mandeep', 'ETRX', 'Examination'),
(2, 'Faculty Meetting', '2015-08-30 18:30:00', '2015-08-30 18:30:00', 'NAAC work review', '112C', 'hodin', '', ''),
(3, 'Workshop on PCB Design', '2015-08-09 18:30:00', '2015-08-13 18:30:00', 'This is a free workshop for third and fourth year students.', 'Lab. 201 and 208', 'hoden', '', ''),
(4, 'Workshop on Rasberry Pi', '2015-08-16 18:30:00', '2015-08-17 18:30:00', 'A workshop is arranged by EXTC department in association with IETE-RAIT.', 'Lab. 201', 'hoden', '', ''),
(5, 'NBA FILES - Meeting', '2015-08-23 18:30:00', '2015-08-23 18:30:00', 'All HODs &amp; Faculty handling NBA Files requested to attend', 'Principal Chambers', 'principal', '', ''),
(6, 'Youth &amp; Communal Harmony- ', '2015-08-30 18:30:00', '2015-08-30 18:30:00', 'Youth &amp; Communal Harmony- School of Eduction', 'Room No 615', 'pa', '', ''),
(10, 'Role of Instrumentation Engg. ', '2015-09-02 18:30:00', '2015-09-02 18:30:00', 'Dept. of Instrumentation Engg Role of Instrumentation Engg. in Corporat World', 'Room No 615', 'pa', '', ''),
(11, 'The Art of Control', '2015-09-01 18:30:00', '2015-09-01 18:30:00', 'The Art of Control - by ISKCON, Juhu, Mumbai - 10.30 to 12.30', 'Room No 615', 'pa', '', ''),
(12, 'Placement Preparation Talk', '2015-09-01 18:30:00', '2015-09-01 18:30:00', 'Placement Preparation Talk 3.00pm onwards.', 'Room No 615', 'pa', '', ''),
(13, 'Placement Preparation Talk', '2015-09-02 18:30:00', '2015-09-02 18:30:00', 'Placement Preparation Talk 3.00pm onwards', 'Room No 615', 'pa', '', ''),
(14, 'Workshop', '2015-09-15 18:30:00', '2015-09-15 18:30:00', 'Network Security workshop for UG and PG', '513', 'hodce5', '', ''),
(15, 'Expert Lecture', '2015-09-30 18:30:00', '2015-09-30 18:30:00', '&quot;IP Awareness Seminar - Everything you wanted to know about Intellectual Property Rights (IPR)&quot; by Mr. Akhilesh C Srivastava', '615', 'hodce5', '', ''),
(16, 'Expert Lecture', '2015-09-30 18:30:00', '2015-09-30 18:30:00', '&quot;IP Awareness Seminar - Everything you wanted to know about Intellectual Property Rights (IPR)&quot; by Mr. Akhilesh C Srivastava', '615', 'hodce5', '', ''),
(17, 'Expert Lecture', '2015-09-30 18:30:00', '2015-09-30 18:30:00', 'Expert Talk Series: Session-I Expert Talk on Evolution of computing grids and clouds by Dr. B.S.Jagadeesh, BARC', '615', 'hod', '', ''),
(19, 'Holiday', '2015-07-17 18:30:00', '2015-07-17 18:30:00', 'Ramzan Id', 'with family', 'hodce5', '', ''),
(20, 'Holiday', '2015-08-14 18:30:00', '2015-08-14 18:30:00', 'Independence day', 'President Office', 'hodce5', '', ''),
(21, 'Holiday', '2015-08-17 18:30:00', '2015-08-17 18:30:00', 'Parsi New Year', 'with family', 'hodce5', '', ''),
(24, 'Holiday', '2015-09-16 18:30:00', '2015-09-16 18:30:00', 'Ganesh Chaturti', 'Ground Floor RAIT', 'hodce5', '', ''),
(26, 'Holiday', '2015-09-24 18:30:00', '2015-09-24 18:30:00', 'Bakari Id', 'with family', 'hodce5', '', ''),
(27, 'Holiday', '2015-10-01 18:30:00', '2015-10-01 18:30:00', 'Gandhi Jayanti', 'Tech Fests in RAIT', 'hodce5', '', ''),
(28, 'Holiday', '2015-10-21 18:30:00', '2015-10-21 18:30:00', 'Dussehra', 'with family', 'hodce5', '', ''),
(29, 'Holiday', '2015-10-23 18:30:00', '2015-10-23 18:30:00', 'Moharam', 'with family', 'hodce5', '', ''),
(30, 'Holiday', '2015-11-10 18:30:00', '2015-11-11 18:30:00', 'Deepawapli', 'with family', 'hodce5', '', ''),
(31, 'Donation Drive by Social Wing', '2015-08-02 18:30:00', '2015-08-07 18:30:00', 'Collection of Books, Cloths, stationary, bags, fund from RAIT students and faculty and donted to Rabale Community center', 'RAIT Glass door', 'hodce5', '', ''),
(40, 'Tree Plantation Drive by Socia', '2015-08-21 18:30:00', '2015-08-21 18:30:00', '150 Tree plantation at Dronagiri  by 102 RAIT students', 'Uran', 'hodce5', '', ''),
(42, 'Tree Plantation Drive by Socia', '2015-08-21 18:30:00', '2015-08-21 18:30:00', '150 Tree plantation at Dronagiri  by 102 RAIT students', 'RAIT Glass door', 'hodce5', '', ''),
(53, 'Cleanup drive by social wing', '2015-09-28 18:30:00', '2015-09-28 18:30:00', 'Beach Clean-up drive at Juhu Chowpati ', 'Juhu Choupati', 'hodce5', '', ''),
(55, 'Short film ', '2015-10-01 18:30:00', '2015-10-01 18:30:00', 'Short film on a social issue by RAIT students to be put on UTube', 'RAIT Glass door', 'hodce5', '', ''),
(56, 'Fund Raiser', '2015-09-30 18:30:00', '2015-10-02 18:30:00', 'Multiple fund raising and fun events to support under privileged children ', 'RAIT', 'hodce5', '', ''),
(57, 'Skit', '2015-09-30 18:30:00', '2015-09-30 18:30:00', 'Skit on social issue by Social Wing', 'RAIT and stations', 'hodce5', '', ''),
(58, 'Deepawali celebrations', '2015-11-10 18:30:00', '2015-11-10 18:30:00', 'Deepawali celebrations at Quarry center, Nerul MIDC area by Social Wing', 'Nerul', 'hodce5', '', ''),
(59, 'Spirit of Christmas', '2015-12-24 18:30:00', '2015-12-24 18:30:00', 'Christmas celebrations at Rabale Community center for underprivileged children by Social Wing', 'Rabale', 'hodce5', '', ''),
(60, 'medical check-up camp', '2015-10-16 18:30:00', '2015-10-16 18:30:00', 'Medical Check-up camp for Girija Orphanage children at Dr, D Y Patil Hospital by Social Wing', 'D Y Patil Hospital', 'hodce5', '', ''),
(61, 'Workshop', '2015-08-05 18:30:00', '2015-08-05 18:30:00', 'Workshop on Artificial Intelligence for BE students', '615', 'hodce5', '', ''),
(62, 'Expert Lecture', '2015-08-11 18:30:00', '2015-08-11 18:30:00', 'Guest Lecture on Application Architecture and design pattern for TE stuents', '615', 'hodce5', '', ''),
(63, 'Expert Lecture', '2015-08-18 18:30:00', '2015-08-18 18:30:00', 'Expert Lecture on Object oriented analysis and design for SE students by Mrs. Aditi Chabria', '511', 'hodce5', '', ''),
(64, 'Training Program', '2015-08-31 18:30:00', '2015-09-04 18:30:00', 'Training program on Trends and Techniques in Web Technology and Android Technology for TE students by Mr. Samsher Singh, CEO Unisoft Technology, C B D Belapur', '513', 'hodce5', '', ''),
(65, 'Workshop', '2015-09-07 18:30:00', '2015-09-09 18:30:00', 'Workshop on NS2 for TE students by Mrs. Puja Padia and Mr. A V Vidhate', '513', 'hodce5', '', ''),
(66, 'Workshop', '2015-09-15 18:30:00', '2015-09-15 18:30:00', 'Workshop on Network Security for BE students by Mr. Sachin Dedhiya', '513', 'hodce5', '', ''),
(67, 'Expert Lecture', '2015-10-06 18:30:00', '2015-10-06 18:30:00', 'Expert Lecture on Software Architecture for BE students by Prof. Kavita Kelkar', '511', 'hodce5', '', ''),
(68, 'photo copy ', '2015-09-07 18:30:00', '2015-09-13 18:30:00', 'The students who have applied for the Photo copy of the assessed answer books of semester III to VI for the examinations held in May 15. can collect on or before 14th Sep 2015', 'exam section room no 104', 'exam', '', ''),
(69, 'Workshop on Webreneurship', '2015-08-07 18:30:00', '2015-08-08 18:30:00', 'Workshop on Webreneurship consisting of CMS, JOOMLA, DRUPAL Technologies and their business applications.', 'Lab No.: 513', 'csi', '', ''),
(70, 'Webtechnology and PHP Workshop', '2015-08-31 18:30:00', '2015-09-02 18:30:00', 'Training on Web Technology and Php for students of Third Year Computer Engineering organised by Computer Dept. and CSI-RAIT.', 'Lab No.: 513', 'csi', '', ''),
(71, 'Basics of PYTHON', '2015-10-09 18:30:00', '2015-10-10 18:30:00', 'Inhouse workshop on Python Programming organised by CSI-RAIT.', 'Lab No.: 513', 'csi', '', ''),
(74, 'Teahtalk I', '2015-08-09 18:30:00', '2015-08-09 18:30:00', 'Talk on Internship Experience and opportunities by final year students organised by CSI-RAIT.', 'Room No.: 511', 'csi', '', ''),
(75, 'Techtalk II', '2015-08-30 18:30:00', '2015-08-30 18:30:00', 'Talk on &quot;How to publish a Research Paper&quot; by external experienced speakers organised by CSI-RAIT.', 'Room No.: 511', 'csi', '', ''),
(76, 'Techtalk III', '2015-09-06 18:30:00', '2015-09-06 18:30:00', 'Talk on UX/UI (User Experience/User Interface) Design by Faiz Malkani organised by CSI-RAIT.', 'Room No.: 511', 'csi', '', ''),
(77, 'Techmate 2K15', '2015-09-30 18:30:00', '2015-10-02 18:30:00', '3-Day Technical Symposium conducted by CSI-RAIT.', '5th Floor', 'csi', '', ''),
(80, 'Techtalk IV', '2015-10-04 18:30:00', '2015-10-04 18:30:00', 'Talk on BE Project Ideas for Third Year Engineering students by CSI-RAIT.  ', 'Room No.: 511', 'csi', '', ''),
(81, 'Workshop', '2016-01-29 18:30:00', '2016-01-30 18:30:00', 'Organised by CSI-RAIT.', 'Lab No.: 513', 'csi', '', ''),
(83, 'Workshop on Designing.', '2016-02-19 18:30:00', '2016-02-20 18:30:00', 'Creative designing workshop using Corel Draw-(Designing S/W), organised by CSI-RAIT.', 'Lab No.: 513', 'csi', '', ''),
(85, 'Expert Lecture', '2015-09-22 18:30:00', '2015-09-22 18:30:00', 'Expert Lecture by Dr Vrunda Joshi (PVG College of Engineering, Pune) on Spherical Robot: Design and Control.', 'RAIT', 'hodce5', '', ''),
(87, 'Training Program', '2015-10-06 18:30:00', '2015-10-09 18:30:00', 'Hands-on Training Session on Programmable System on Chip (PSoC) using ARM Micro-controllers by Eduvance Technology Ltd.', 'RAIT', 'hodce5', '', ''),
(88, 'Industrial visit', '2015-10-16 18:30:00', '2015-10-16 18:30:00', ' Industrial visit of BE and ME students to M/S Hind Rectifiers, Bhandup.', 'Bhandup', 'hodce5', '', ''),
(89, 'Expert Lecture', '2015-10-29 18:30:00', '2015-10-29 18:30:00', ' Expert Lecture by Mr Ramanan (CEO, Gauranga SoftTech Ltd.) on Career Opportunities for Electronics Graduates in Embedded Systems.', 'RAIT', 'hodce5', '', ''),
(90, 'Workshop', '2015-11-19 18:30:00', '2015-11-20 18:30:00', '2-day Hands-on Session on COMSOL by Prof Sachin Umbarkar.', 'RAIT', 'hodce5', '', ''),
(91, 'Expert Lecture', '2015-11-26 18:30:00', '2015-11-26 18:30:00', 'Expert Lecture by Prof Sharad Bhartiya (IIT Bombay) on Systems Biology.', 'RAIT', 'hodce5', '', ''),
(92, 'Expert Lecture', '2015-11-26 18:30:00', '2015-11-26 18:30:00', 'Expert Lecture by Prof Sharad Bhartiya (IIT Bombay) on Systems Biology.', 'RAIT', 'hodce5', '', ''),
(93, 'meeting', '2015-09-13 18:30:00', '2015-09-13 18:30:00', ' meeting between Tech-Mahindra delegates and HODs on Monday , 14th September, 2015 at 11:20 am to 11:45 am : Objective: &quot; Understanding the industry requirements &quot; ', 'Placement Room', 'hodce5', '', ''),
(94, 'Talk by Padmashree Dr. Sharad ', '2015-08-18 18:30:00', '2015-08-18 18:30:00', 'Special talk on Biogas Technology, Life Science and Waste Management', '615', 'hodes', '', ''),
(98, 'Guest Lecture by Padmashree Dr', '2015-08-18 18:30:00', '2015-08-18 18:30:00', 'Special lecture on biogas technology, waste management and life sciences  ', '615', 'hodes', '', ''),
(99, 'Guest Lecture by Padmashree Dr', '2015-08-18 18:30:00', '2015-08-18 18:30:00', 'Special lecture on biogas technology, waste management and life sciences  ', '615', 'hodes', '', ''),
(100, 'Special Lecture by Dr Kale', '2015-08-18 18:30:00', '2015-08-18 18:30:00', 'Special lecture on biogas technology, waste management and life sciences  ', '615', 'hodes', '', ''),
(101, 'Workshop on stress managemnet', '2013-08-19 18:30:00', '2013-08-19 18:30:00', 'Stress Management by Faculty of Bramha Kumari', '611', 'hodes', '', ''),
(102, 'Technical Talk', '2014-09-23 18:30:00', '2014-09-23 18:30:00', 'Seminar by Dr Zakir Taquvi Ex NASA', '615', 'hodes', '', ''),
(103, 'Workshop on stress managemnet', '2014-02-05 18:30:00', '2014-02-06 18:30:00', 'Stress Management workshop by Ramkrishna Mission to the students so that they can achieve success in their life', '611', 'hodes', '', ''),
(104, 'Workshop on Syllabus Revision ', '2012-09-10 18:30:00', '2012-09-10 18:30:00', 'Orientation Programme on the revised syllabus of Applied Chemistry I &amp; II on the behalf of University of Mumbai. This workshop was organized to get familiar with new pattern of curriculum. ', '615', 'hodes', '', ''),
(105, 'Workshop on revised syllabus', '2012-09-10 18:30:00', '2012-09-10 18:30:00', 'Orientation Programme on the revised syllabus of Applied Chemistry I &amp; II on the behalf of University of Mumbai. This workshop was organized to get familiar with new pattern of curriculum. ', '615', 'hodes', '', ''),
(106, 'Special Lecture by Padmashree ', '2015-03-17 18:30:00', '2015-03-17 18:30:00', 'Padmashree Dr. Basu is Director of BARC, Mumbai delivered lecture on Nuclear Physics and research programs performed by BARC to the development of India', 'Auditorium', 'hodes', '', ''),
(107, 'Guest Lecture by Padmashree Dr', '2015-03-17 18:30:00', '2015-03-17 18:30:00', 'Padmashree Dr. Basu is Director of BARC, Mumbai delivered lecture on Nuclear Physics and research programs performed by BARC to the development of India', 'Auditorium', 'hodes', '', ''),
(109, 'Talk by Dr Basu', '2015-03-17 18:30:00', '2015-03-17 18:30:00', 'Padmashree Dr Basu (Director, BARC) delivered talk on development of Nuclear Physics in India and role of BARC in the development of India', 'Auditorium', 'hodes', '', ''),
(110, 'Talk by Dr Naba Mandal', '2014-09-24 18:30:00', '2014-09-24 18:30:00', 'Dr. Naba Mandal from BARC delivered talk on Neutrino Physics', '615', 'hodes', '', ''),
(111, 'Guest Lecture by Dr S Ghosh', '2015-02-17 18:30:00', '2015-02-17 18:30:00', 'Dr. S Ghosh is scientist in BARC and working at Biotechnology division. He introduced students that how technology can be used to develop biogas and how it can be controlled.', '615', 'hodes', '', ''),
(112, 'Workshop on Sahaj Yoga', '2015-03-01 18:30:00', '2015-03-04 18:30:00', 'Sahaj Yoga Meditation. Faculty of Sahaj Yoga', '611', 'hodes', '', ''),
(113, 'FE Orientation Program 2015', '2015-07-26 18:30:00', '2015-07-26 18:30:00', 'FE orientation programmed conducted very smoothly under guidance of Prof Dr. S. D. Shete Head of Engineering Science Department. He addressed new students about engineering in RAIT and guided them so that they can achieve success in their carrier ', 'Auditorium', 'hodes', '', ''),
(116, 'Workshop on Question Paper pat', '2012-09-11 18:30:00', '2012-09-11 18:30:00', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. He was nominated as chairman by University of Mumbai ', '615', 'hodes', '', ''),
(117, 'Workshop on Question Paper pat', '2012-09-11 18:30:00', '2012-09-11 18:30:00', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. He was nominated as chairman by University of Mumbai ', '615', 'hodes', '', ''),
(118, 'Work on behalf of University o', '2012-09-11 18:30:00', '2012-09-11 18:30:00', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. He was nominated as chairman by University of Mumbai ', '615', 'hodes', '', ''),
(120, 'Workshop on behalf of Universi', '2012-09-11 18:30:00', '2012-09-11 18:30:00', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', 'hodes', '', ''),
(121, 'Workshop for question paper pa', '2012-09-11 18:30:00', '2012-09-11 18:30:00', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', 'hodes', '', ''),
(122, 'Workshop for question paper pa', '2012-09-12 18:30:00', '2012-09-12 18:30:00', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', 'hodes', '', ''),
(124, 'Question Paper Pattern Develop', '2012-09-12 18:30:00', '2012-09-12 18:30:00', 'The workshop organized on behalf of University of Mumbai for development of standard question paper pattern and blueprint for the subject of Applied Chemistry I &amp; II. The Chairman of committee (nominated by University of Mumbai) was Prof. Dr. S. D. Shete, Head of Department of Engineering Sciences, RAIT. ', '615', 'hodes', '', ''),
(127, 'Workshop on Blueprint of Appli', '2012-09-10 18:30:00', '2012-09-10 18:30:00', 'The Chairman of committee  was Prof. Dr. S. D. Shete, (nominated by University of Mumbai) Head of Department of Engineering Sciences, RAIT. ', '611', 'hodes', '', ''),
(128, 'Workshop on behalf of Mumbai U', '2012-09-10 18:30:00', '2012-09-10 18:30:00', 'The Chairman of committee  was Prof. Dr. S. D. Shete, (nominated by University of Mumbai) Head of Department of Engineering Sciences, RAIT. ', '611', 'hodes', '', ''),
(130, 'Seminar on behalf of Mumbai Un', '2012-09-10 18:30:00', '2012-09-10 18:30:00', 'Workshop for development of blue print for the subject of Applied Chemistry I &amp; II. The Chairman of Committee was Prof. Dr. S. D. Shete, HOD dept of Engineering Sciences. He was nominated as chairman by University of Mumbai', '615', 'hodes', '', ''),
(133, 'workshop on development of blu', '2012-09-10 18:30:00', '2012-09-10 18:30:00', 'Workshop for development of blue print for the subject of Applied Chemistry I &amp; II. The Chairman of Committee was Prof. Dr. S. D. Shete, HOD dept of Engineering Sciences. He was nominated as chairman by University of Mumbai', '615', 'hodes', '', ''),
(142, 'Workshop on Android', '2015-09-24 18:30:00', '2015-09-25 18:30:00', 'Successfully planned and Conducted workshop for android App Development for Third Year Engineering students of Information Technology Department.', '616', 'hod', '', ''),
(147, 'Expert Talk Series', '2015-09-30 18:30:00', '2015-09-30 18:30:00', 'Session-II Expert Talk on ''Cryptography - Then and Now'' by Dr. Dipan Ghosh, IIT Mumbai', '615', 'hod', '', ''),
(148, 'NTPP', '2015-09-30 18:30:00', '2015-10-02 18:30:00', 'Technical Paper Presentation Competition conducted by CSI under Computer Department', '615', 'csi', '', ''),
(149, 'Placement Mantra', '2015-09-30 18:30:00', '2015-10-02 18:30:00', 'Most popular event of Techmate giving experience of mock placements to the participants.', '515 and 520', 'csi', '', ''),
(150, 'Next Aim', '2015-09-30 18:30:00', '2015-10-02 18:30:00', 'Event providing mock practice for examinations of higher education such as GRE, GMAT conducted by CSI under Computer Department.', '514', 'csi', '', ''),
(151, 'ARM University (UK) Workshop', '2015-10-06 18:30:00', '2015-10-10 18:30:00', 'The workshop is arranged for third year students. It will be given by Eduvance, Mumbai in collaboration with ARM University (UK) and Cypress Semiconductors. ', 'IT Centre (2nd FLoor)', 'hoden', '', ''),
(152, 'Demo of New Library Software (', '2015-10-06 18:30:00', '2015-10-06 18:30:00', 'For faculty and students.', '615', 'hoden', '', ''),
(153, 'Demo of New Library Software (', '2015-10-06 18:30:00', '2015-10-06 18:30:00', 'For faculty and students.', '615', 'hoden', '', ''),
(154, 'Demo of New Library Software (', '2015-10-06 18:30:00', '2015-10-06 18:30:00', 'For faculty and students.', '615', 'hoden', '', ''),
(155, 'Demo of New Library Software (', '2015-10-06 18:30:00', '2015-10-06 18:30:00', 'For faculty and students.', '615', 'hoden', '', ''),
(156, 'Training of Library staff for ', '2015-10-09 18:30:00', '2015-10-09 18:30:00', 'For Library and BVG (Tech) staff.', '511/611', 'hoden', '', ''),
(157, 'Training of Library staff for ', '2015-10-09 18:30:00', '2015-10-10 18:30:00', 'For Library and BVG (Tech) staff.', '511/611', 'hoden', '', ''),
(158, 'Training of Library staff for ', '2015-10-09 18:30:00', '2015-10-10 18:30:00', 'For Library and BVG (Tech) staff.', '511', 'hoden', '', ''),
(159, 'Training of Library staff for ', '2015-10-09 18:30:00', '2015-10-10 18:30:00', 'For Library and BVG (Tech) staff.', '511', 'hoden', '', ''),
(160, 'Training of Library staff for ', '2015-10-09 18:30:00', '2015-10-10 18:30:00', 'For Library and BVG (Tech) staff.', '511', 'hoden', '', ''),
(161, 'Training of Library staff for ', '2015-10-09 18:30:00', '2015-10-10 18:30:00', 'For Library and BVG (Tech) staff.', '511', 'hoden', '', ''),
(162, 'Training of Library staff for ', '2015-10-09 18:30:00', '2015-10-10 18:30:00', 'For Library and BVG (Tech) staff.', '511', 'hoden', '', ''),
(163, 'test', '2015-11-09 18:30:00', '2015-11-09 18:30:00', 'test', 'Room No. 615', 'faculty', '', ''),
(164, 'Making Interactive teaching Ha', '2016-01-07 18:30:00', '2016-01-07 18:30:00', 'Session on interactive and participating learning experience by 1) Dr. Ramesh Vasappanavara 2) Dr. M. S Bhatia 3) Mr. hardik Bhatia Timing- 2 PM', '615 @ 2PM', 'faculty', '', ''),
(167, 'D Y Patil Polytechnic', '2016-02-22 18:30:00', '2016-02-22 18:30:00', 'Diploma Project Exhibition &amp; presentation (Room No. 615 &amp; one Class Room in 6th Floor)', '6th Floor', 'PA', '', ''),
(168, 'Expert Session ', '2016-01-17 18:30:00', '2016-01-17 18:30:00', 'Expert Session on E-Learning System by Prof. Sasikumar at 10.00 am', '615', 'faculty', '', ''),
(169, 'Expert Session ', '2016-01-17 18:30:00', '2016-01-17 18:30:00', 'Expert Session on Pattern Recognition for ME ', '615', 'faculty', '', ''),
(170, 'Expert Session ', '2016-01-19 18:30:00', '2016-01-19 18:30:00', 'Expert session for BE students by Mr. Munir Syad', '615', 'faculty', '', ''),
(171, 'Expert Session ', '2016-01-26 18:30:00', '2016-01-26 18:30:00', 'Expert Session by Siby sir for ME students', '615', 'faculty', '', ''),
(184, 'Expert Lecture on Introduction', '2016-01-07 18:30:00', '2016-01-07 18:30:00', 'Expert Lecture on Introduction to openGL by Prof. Shridhar Donamal for Second Year Students', '511', 'faculty', '', ''),
(187, 'Full Stack Development worksho', '2016-01-28 18:30:00', '2016-01-30 18:30:00', 'Workshop for T.E students organized by IT department. Time- 10 am to 5 pm', '616 ', 'faculty', '', ''),
(188, 'test', '2016-01-11 18:30:00', '2016-01-11 18:30:00', 'test', 't', 'faculty', '', ''),
(189, 'DDB expert Lecture', '2016-02-07 18:30:00', '2016-02-07 18:30:00', 'Distributed Databases Expert Lecture by S.S Kumar organized for Third year Students @10 am.a', '615', 'faculty', '', ''),
(190, 'Term Test I', '2016-02-10 18:30:00', '2016-02-12 18:30:00', 'Term Test of All Departments.', '5 Floor', 'faculty', '', ''),
(191, 'Horizon', '2016-02-17 18:30:00', '2016-02-19 18:30:00', 'Culture Festival of RAIT', 'RAIT', 'faculty', '', ''),
(192, 'Holiday', '2016-01-25 18:30:00', '2016-01-25 18:30:00', 'Republic Day', 'Near President Office', 'faculty', '', ''),
(193, 'Academic Audit', '2016-02-28 18:30:00', '2016-02-28 18:30:00', 'audit of All Departments. ', 'RAIT', 'faculty', '', ''),
(194, 'Holiday', '2016-03-06 18:30:00', '2016-03-06 18:30:00', 'Mahashivratri', '@ Your Home', 'faculty', '', ''),
(195, 'Tech Fest', '2016-03-20 18:30:00', '2016-03-22 18:30:00', 'Tech Fest of RAIT', 'RAIT', 'faculty', '', ''),
(196, 'EPL', '2016-03-23 18:30:00', '2016-03-24 18:30:00', 'Cricket Matches ', 'DY Patil Stadium', 'faculty', '', ''),
(197, 'Student Feedback', '2016-03-27 18:30:00', '2016-03-28 18:30:00', 'Academic feedback One ', 'ALL Labs', 'faculty', '', ''),
(198, 'Academic Audit II', '2016-03-30 18:30:00', '2016-03-30 18:30:00', 'Academic Audit of all Department', 'RAIT', 'faculty', '', ''),
(199, 'Project Competition ', '2016-03-31 18:30:00', '2016-03-31 18:30:00', 'B. E Project Competition ', 'E- Yantra Lab', 'faculty', '', ''),
(200, 'Term Test II', '2016-04-06 18:30:00', '2016-04-10 18:30:00', 'Term Test II of RAIT', 'RAIT', 'faculty', '', ''),
(201, 'Remedial Classes', '2016-04-11 18:30:00', '2016-04-12 18:30:00', 'Remedial Classes for defaulter students', '5 Floor', 'faculty', '', ''),
(202, 'Term End', '2016-04-15 18:30:00', '2016-04-15 18:30:00', 'End of Even Sem', 'RAIT', 'faculty', '', ''),
(203, 'RAIT Placement', '2016-01-15 18:30:00', '2016-01-15 18:30:00', 'Placement drive of Muthshut.com ', 'Room No. 615', 'PA', '', ''),
(204, 'RAIT Placement', '2016-01-18 18:30:00', '2016-01-18 18:30:00', 'TCS post offer connect session 9.00am to 12.00 noon', 'Room No. 615', 'PA', '', ''),
(205, 'Term Start', '2016-01-03 18:30:00', '2016-01-03 18:30:00', 'Start of Sem II', 'RAIT', 'hodfe', '', ''),
(206, 'First Defaulter''s List', '2016-02-08 18:30:00', '2016-01-08 18:30:00', 'Display of First Defaulter''s List', 'RAIT', 'hodfe', '', ''),
(207, 'Term Test I', '2016-02-10 18:30:00', '2016-02-12 18:30:00', 'Term Test I Conduction', 'RAIT', 'hodfe', '', ''),
(208, 'Term Test I Marks Display', '2016-02-16 18:30:00', '2016-02-16 18:30:00', 'Display of Term Test I marks to the students so that they can analyse and improve their performance', 'RAIT Notice Board', 'hodfe', '', ''),
(209, 'Student Feedback', '2016-03-27 18:30:00', '2016-03-31 18:30:00', 'Feedback from students on both CO and Faculty feedback', '212', 'hodfe', '', ''),
(210, 'Second Defaulter''s List', '2016-04-04 18:30:00', '2016-04-04 18:30:00', 'Display of Second Defaulter''s :ist', 'RAIT Notice Board', 'hodfe', '', ''),
(211, 'Term Test II', '2016-04-06 18:30:00', '2016-04-08 18:30:00', 'Term Test II of SEM II', 'RAIT', 'hodfe', '', ''),
(212, 'AutoCAD Practical Examination', '2016-04-17 18:30:00', '2016-04-22 18:30:00', 'AutoCAD Practical Examination Tentative dates', '212', 'hodfe', '', ''),
(213, 'SPA Practical Examination', '2016-04-17 18:30:00', '2016-04-22 18:30:00', 'SPA Practical Examination Tentative Dates', 'SPA Labs at 5th floor and 6th ', 'hodfe', '', ''),
(214, 'Expert Lecture on Softwares to', '2016-01-24 18:30:00', '2016-01-24 18:30:00', 'Use of different softwares for teaching Engineering Drawing Subject of FE Sem II. These softwares will help to understand some concepts of ED more easily to students.', '212', 'hodfe', '', ''),
(215, 'Expert Lecture on Softwares to', '2016-01-24 18:30:00', '2016-01-24 18:30:00', 'Use of different softwares for teaching Engineering Drawing Subject of FE Sem II. These softwares will help to understand some concepts of ED more easily to students.', '212', 'hodfe', '', ''),
(216, 'Seminar on ED software', '2016-01-24 18:30:00', '2016-01-24 18:30:00', 'Seminar on how to use different softwares and AutoCAD to make student understand the concept easily', '212', 'hodfe', '', ''),
(217, 'Latex Training', '2016-01-28 18:30:00', '2016-01-28 18:30:00', 'Training on Latex for BE(IT) students for generation of their project black book.', '616 lab', 'hod', '', ''),
(218, '1 day workshop on Parallel and', '2016-02-03 18:30:00', '2016-01-03 18:30:00', 'Expert session on PDS and Hands on Lab for ME and BE students', '615', 'faculty', '', ''),
(219, '1 day workshop on Parallel and', '2016-02-03 18:30:00', '2016-01-03 18:30:00', 'Expert session on PDS and Hands on Lab for ME and BE students', '615', 'faculty', '', ''),
(220, '1 day workshop on Parallel and', '2016-02-03 18:30:00', '2016-01-03 18:30:00', 'Expert session on PDS and Hands on Lab for ME and BE students', '615', 'faculty', '', ''),
(221, 'RAIT Placement', '2016-01-28 18:30:00', '2016-01-28 18:30:00', 'Teach for India Seminar', 'Room No. 615', 'PA', '', ''),
(222, 'D Y Patil Law College', '2016-02-05 18:30:00', '2016-02-05 18:30:00', 'Vidhi Mitra- 3.30pm to 6.30pm', 'Room No. 615', 'PA', '', ''),
(223, 'Latex Training', '2016-02-04 18:30:00', '2016-02-04 18:30:00', 'Latex Training for BE students for Black book preparation.', '616lab', 'hod', '', ''),
(224, 'Seminar By Oracle', '2016-02-08 18:30:00', '2016-02-08 18:30:00', 'Dept of IT (Seminar By Oracle) 01.30pm', 'Room 615', 'PA', '', ''),
(225, 'TCS Faculty Development Sessio', '2016-03-09 18:30:00', '2016-03-09 18:30:00', 'TCS Faculty Development Session (Faculty &amp; ME Students)', '2nd Floor -206', 'PA', '', ''),
(226, 'TCS Post Offer Connect Session', '2016-03-09 18:30:00', '2016-03-09 18:30:00', 'TCS Post Offer Connect Session10.00 to 11.30 &amp; TCS Prefinal Year Connect 11.30 to 12.30', 'Room 615', 'PA', '', ''),
(227, 'Expert Lecture', '2016-03-08 18:30:00', '2016-03-08 18:30:00', 'Security Issues In Mobile Computing 8.30 onwords', 'Room 615', 'PA', '', ''),
(228, 'etst', '2016-09-06 18:30:00', '2016-09-07 18:30:00', 'jkdshfkjdhl', 'hlsg', 'mandeep', 'EXTC', 'Examination'),
(229, 'etst', '2016-09-06 18:30:00', '2016-09-07 18:30:00', 'jkdshfkjdhl', 'hlsg', 'mandeep', 'ETRX', 'Examination');

--
-- Triggers `cal_events_new`
--
DROP TRIGGER IF EXISTS `calendar_delete_log`;
DELIMITER //
CREATE TRIGGER `calendar_delete_log` AFTER DELETE ON `cal_events_new`
 FOR EACH ROW BEGIN

INSERT INTO `log_calendar`(`timestamp`,`operation`,`old_event_id`,`old_event_start`,`old_event_end`,`old_event_location`,`old_event_department`,`old_event_category`,`old_event_title`,`old_event_desc`,`web_user`) VALUES (NOW(),"DELETE",OLD.event_id,OLD.start_date,OLD.end_date,OLD.location,OLD.branch, OLD.category, OLD.event_name, OLD.event_desc,OLD.web_user);


END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `calendar_insert_log`;
DELIMITER //
CREATE TRIGGER `calendar_insert_log` AFTER INSERT ON `cal_events_new`
 FOR EACH ROW BEGIN

INSERT INTO `log_calendar`(`timestamp`,`operation`,`new_event_id`,`new_event_start`,`new_event_end`,`new_event_location`,`new_event_department`,`new_event_category`,`new_event_title`,`new_event_desc`,`web_user`) VALUES (NOW(),"INSERT",NEW.event_id,NEW.start_date,NEW.end_date,NEW.location,NEW.branch, NEW.category, NEW.event_name, NEW.event_desc,NEW.web_user);


END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `calendar_update_log`;
DELIMITER //
CREATE TRIGGER `calendar_update_log` AFTER UPDATE ON `cal_events_new`
 FOR EACH ROW BEGIN

INSERT INTO `log_calendar`(`timestamp`, `operation`, `old_event_id`, `old_event_start`, `old_event_end`, `old_event_location`, `old_event_department`, `old_event_category`, `old_event_title`, `old_event_desc`, `new_event_id`, `new_event_category`, `new_event_department`, `new_event_desc`, `new_event_end`, `new_event_location`, `new_event_start`, `new_event_title`, `web_user`) VALUES (NOW(),"UPDATE",OLD.event_id,OLD.start_date,OLD.end_date,OLD.location,OLD.branch,OLD.category,OLD.event_name,OLD.event_desc,NEW.event_id,NEW.category,NEW.branch,NEW.event_desc,NEW.end_date,NEW.location,NEW.start_date,NEW.event_name,NEW.web_user);

END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category_table`
--

CREATE TABLE IF NOT EXISTS `category_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `branch_indicator` varchar(20) NOT NULL,
  `category_color` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `category_table`
--

INSERT INTO `category_table` (`id`, `name`, `branch_indicator`, `category_color`) VALUES
(1, 'Technical', '', '#0000FF'),
(2, 'Placement', '', '#7FFF00'),
(3, 'Examination', '', '#A52A2A'),
(4, 'Administraion', '', '#FF8C00'),
(5, 'Alumni', '', '#00CED1'),
(6, 'Wall', '', '#EE82EE'),
(7, 'Cultural', '', '#006400'),
(8, 'Fest', '', '#8A2BE2'),
(9, 'Sports', '', '#FFFF00'),
(10, 'Workshop/Seminar', '', '#A0522D'),
(11, 'COMPUTER', 'desktop', ''),
(12, 'EXTC', 'signal', ''),
(13, 'IT', 'globe', ''),
(14, 'ETRX', 'plug', ''),
(15, 'INSTRU', 'wrench', ''),
(16, 'FE', 'book', ''),
(17, 'Committee', '', '#EE82EE'),
(18, 'Faculty', '', '#00FFFF'),
(19, 'Holiday', '', '#FF0000'),
(20, 'Others', '', '#000000'),
(21, 'Student', '', '#808080'),
(22, '', '', '#aaa');

-- --------------------------------------------------------

--
-- Table structure for table `log_calendar`
--

CREATE TABLE IF NOT EXISTS `log_calendar` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL,
  `operation` varchar(10) NOT NULL,
  `old_event_id` int(11) NOT NULL,
  `old_event_name` varchar(50) NOT NULL,
  `old_event_start` date NOT NULL,
  `old_event_end` date NOT NULL,
  `old_event_location` varchar(50) NOT NULL,
  `old_event_department` varchar(50) NOT NULL,
  `old_event_category` varchar(50) NOT NULL,
  `old_event_title` varchar(50) NOT NULL,
  `old_event_desc` text NOT NULL,
  `new_event_id` int(11) NOT NULL,
  `new_event_category` varchar(50) NOT NULL,
  `new_event_department` varchar(50) NOT NULL,
  `new_event_desc` text NOT NULL,
  `new_event_end` timestamp NOT NULL,
  `new_event_location` varchar(50) NOT NULL,
  `new_event_start` timestamp NOT NULL,
  `new_event_title` varchar(50) NOT NULL,
  `web_user` varchar(50) NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `log_calendar`
--

INSERT INTO `log_calendar` (`log_id`, `timestamp`, `operation`, `old_event_id`, `old_event_name`, `old_event_start`, `old_event_end`, `old_event_location`, `old_event_department`, `old_event_category`, `old_event_title`, `old_event_desc`, `new_event_id`, `new_event_category`, `new_event_department`, `new_event_desc`, `new_event_end`, `new_event_location`, `new_event_start`, `new_event_title`, `web_user`) VALUES
(1, '2017-01-10 16:40:54', 'DELETE', 231, 'bd', '2016-09-07', '2016-09-09', 'ksdkj', 'IT', 'Examination', '', 'djfk', 0, '', '', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', 'mandeep'),
(2, '2017-01-10 16:43:53', 'DELETE', 1, 'Tname', '2015-08-14', '2015-08-14', 'testlocation', 'ITbranch', 'Placements', '', 'testdesc', 0, '', '', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', 'ssweb user'),
(3, '2017-01-10 16:45:18', 'DELETE', 230, '', '2016-09-07', '2016-09-09', 'gghg', 'COMPUTER', 'Alumini', 'dsfkj', 'mvgg', 0, '', '', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', 'mandeep'),
(4, '2017-01-10 17:01:26', 'INSERT', 0, '', '0000-00-00', '0000-00-00', '', '', '', '', '', 0, 'Examination', 'ETRX', 'testing triff==gger decs', '2017-01-05 18:30:00', 'testing trigger location', '2017-01-03 18:30:00', 'testing trigger', 'mandeep'),
(5, '2017-01-11 03:52:52', 'UPDATE', 0, '', '2017-01-04', '2017-01-06', 'testing trigger location', 'ETRX', 'Examination', 'testing trigger', 'testing triff==gger decs', 0, 'Examination', 'ETRX', 'testing triff==gger decs', '2017-01-05 18:30:00', 'testing trigger location', '2017-01-03 18:30:00', 'testing trigger update', 'mandeep');

-- --------------------------------------------------------

--
-- Table structure for table `log_user`
--

CREATE TABLE IF NOT EXISTS `log_user` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `old_username` varchar(50) NOT NULL,
  `new_username` varchar(50) NOT NULL,
  `old_password` varchar(50) NOT NULL,
  `new_password` varchar(50) NOT NULL,
  `timestamp` timestamp NOT NULL,
  `operation` varchar(10) NOT NULL,
  `user` varchar(50) NOT NULL,
  `IP` varchar(30) NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `log_user`
--

INSERT INTO `log_user` (`log_id`, `old_username`, `new_username`, `old_password`, `new_password`, `timestamp`, `operation`, `user`, `IP`) VALUES
(1, 'hodfe', '', 'WOFno8WZsZ0FnSeAAJ/yPLsk0ecR3M4JKOLFwy0xX50=', '', '2017-01-11 04:03:26', 'DELETE', '', '0.0.0.0'),
(2, '', 'testing trigger', '', 'testign trigger\r\n\r\n', '2017-01-11 04:06:15', 'INSERT', '', '0.0.0.0'),
(3, 'sheshans', 'sheshans trigger testing', '7368657368616E7373', '7368657368616E7373', '2017-01-11 04:08:34', 'UPDATE', '', '0.0.0.0');

-- --------------------------------------------------------

--
-- Table structure for table `restrictions`
--

CREATE TABLE IF NOT EXISTS `restrictions` (
  `rest_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `category` varchar(20) NOT NULL,
  `branch` varchar(20) NOT NULL,
  PRIMARY KEY (`rest_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `restrictions`
--

INSERT INTO `restrictions` (`rest_id`, `username`, `category`, `branch`) VALUES
(1, 'principal', 'Technical', ''),
(2, 'hodcs', '', 'COMPUTER'),
(3, 'hodcs', 'Committee', ''),
(4, 'hodcs', 'Holiday', ''),
(5, 'hodcs', 'Workshop', ''),
(6, 'hodcs', 'Others', ''),
(7, 'principal', '', 'COMPUTER'),
(8, 'principal', '', 'EXTC'),
(9, 'principal', '', 'IT'),
(10, 'principal', '', 'ETRX'),
(11, 'principal', '', 'INSTRU'),
(12, 'principal', '', 'FE'),
(13, 'prinncipal', 'Placement', ''),
(14, 'principal', 'Examination', ''),
(15, 'principal', 'Administration', ''),
(16, 'principal', 'Alumini', ''),
(17, 'principal', 'Wall', ''),
(18, 'principal', 'Fest', ''),
(19, 'principal', 'Sports', ''),
(20, 'principal', 'Committee', ''),
(21, 'principal', 'Holiday', ''),
(22, 'principal', 'Others', ''),
(23, 'principal', 'Workshop', ''),
(24, 'principal', 'Others', '');

-- --------------------------------------------------------

--
-- Table structure for table `usertable`
--

CREATE TABLE IF NOT EXISTS `usertable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=40 ;

--
-- Dumping data for table `usertable`
--

INSERT INTO `usertable` (`id`, `username`, `password`) VALUES
(1, 'sheshans trigger testing', '7368657368616E7373'),
(2, 'faculty', '666163756C7479'),
(3, 'Pramod Bide', '7072616D6F64'),
(4, 'temp', '74656D70'),
(8, 'hodcs', 'WOFno8WZsZ0FnSeAAJ/yPLsk0ecR3M4JKOLFwy0xX50='),
(10, 'hodit', '686F646974'),
(11, 'hodce5', '686F6463653535'),
(14, 'hodin', '686F64696E32'),
(15, 'hoden', '686F64656E34'),
(17, 'hodap', '686F64617030'),
(21, 'principal', 'WOFno8WZsZ0FnSeAAJ/yPLsk0ecR3M4JKOLFwy0xX50='),
(22, 'tpo', '74706F6176'),
(23, 'exam', '6578616D7670'),
(24, 'register', '72656769737465727367'),
(25, 'admin', 'WOFno8WZsZ0FnSeAAJ/yPLsk0ecR3M4JKOLFwy0xX50='),
(26, 'alumni', '616C756D6E69313233'),
(27, 'wall', '77616C6C736D'),
(28, 'sport', '73706F72747368'),
(30, 'ieee', '696565657368'),
(31, 'cultural', '63756C747572616C313233'),
(32, 'hodex', '686F646578303333'),
(33, 'hodes', '736473303132'),
(34, 'csi', '637369636F7265313233'),
(35, 'PA', '31323334'),
(37, 'mandeep', 'WOFno8WZsZ0FnSeAAJ/yPLsk0ecR3M4JKOLFwy0xX50='),
(38, 'man', 'man'),
(39, 'testing trigger', 'testign trigger\r\n\r\n');

--
-- Triggers `usertable`
--
DROP TRIGGER IF EXISTS `usertable_log_on_delete`;
DELIMITER //
CREATE TRIGGER `usertable_log_on_delete` AFTER DELETE ON `usertable`
 FOR EACH ROW BEGIN

INSERT INTO `rait_calendar_sys`.`log_user`(`timestamp`,`operation`,`old_username`,`old_password`,`IP`) VALUES (NOW(),"DELETE",OLD.username,OLD.password,"0.0.0.0");

END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `usertable_log_on_insert`;
DELIMITER //
CREATE TRIGGER `usertable_log_on_insert` AFTER INSERT ON `usertable`
 FOR EACH ROW BEGIN

INSERT INTO `log_user`(`new_username`,`new_password`, `timestamp`, `operation`,`IP`) VALUES (NEW.username,NEW.password,NOW(),"INSERT","0.0.0.0");

END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `usertable_log_on_update`;
DELIMITER //
CREATE TRIGGER `usertable_log_on_update` AFTER UPDATE ON `usertable`
 FOR EACH ROW BEGIN

INSERT INTO `log_user`(`old_username`, `new_username`, `old_password`, `new_password`, `timestamp`, `operation`, `IP`) VALUES (OLD.username, NEW.username, OLD.password, NEW.password, NOW(), "UPDATE", "0.0.0.0");

END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_table_log`
--

CREATE TABLE IF NOT EXISTS `user_table_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(30) NOT NULL,
  `action` varchar(30) NOT NULL,
  `time_of_action` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `remote_addr` varchar(45) NOT NULL,
  `http_x_forwarded_for` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=357 ;

--
-- Dumping data for table `user_table_log`
--

INSERT INTO `user_table_log` (`id`, `userid`, `action`, `time_of_action`, `remote_addr`, `http_x_forwarded_for`) VALUES
(1, 'ss', 'LOGIN', '2015-07-21 02:00:55', '123', '123'),
(2, 'ss', 'LOGIN', '2015-07-21 02:01:40', '123', '123'),
(3, 'ss', 'LOGIN', '2015-07-21 02:02:33', '123', '123'),
(5, 'ss', 'LOGIN', '2015-07-21 02:25:39', '321', '321'),
(6, 'ss', 'LOGIN', '2015-07-21 02:31:32', '4321', '4212'),
(8, 'ss', 'LOGIN', '2015-07-21 02:36:23', '2321', '232'),
(9, 'ss', 'LOGIN', '2015-07-21 02:36:43', '2321', '232'),
(10, 'ss', 'LOGIN', '2015-07-21 02:43:17', '54', '3344'),
(11, 'ss', 'LOGIN', '2015-07-21 02:50:58', '453', '333553'),
(12, 'ss', 'LOGIN', '2015-07-21 02:50:58', '453', '333553'),
(13, 'ss', 'LOGIN', '2015-07-21 02:52:22', '453', '333553'),
(14, 'ss', 'LOGIN', '2015-07-21 02:52:53', '453', '333553'),
(15, 'ss', 'LOGIN', '2015-07-21 02:56:35', '453', '333553'),
(16, 'ss', 'LOGIN', '2015-07-21 02:57:32', '453', '333553'),
(17, 'ss', 'LOGIN', '2015-07-21 02:57:54', '453', '333553'),
(18, 'ss', 'LOGIN', '2015-07-21 02:58:53', '453', '333553'),
(19, 'ss', 'LOGIN', '2015-07-21 02:59:21', '453', '333553'),
(20, 'ss', 'LOGIN', '2015-07-21 03:18:14', '::1', ''),
(21, 'ss', 'LOGIN', '2015-07-21 03:19:10', '::1', ''),
(22, 'ss', 'LOGIN', '2015-07-21 03:21:12', '::1', ''),
(23, 'ss', 'LOGIN', '2015-07-21 03:23:52', '::1', ''),
(24, 'ss', 'LOGIN', '2015-07-21 03:24:07', '::1', ''),
(25, 'ss', 'LOGIN', '2015-07-21 03:29:52', '192.168.1.6', ''),
(26, 'ss', 'LOGIN', '2015-07-21 03:47:33', '::1', ''),
(27, 'ss', 'LOGIN', '2015-07-21 05:06:17', '::1', ''),
(28, 'ss', 'LOGIN', '2015-07-21 15:25:29', '::1', ''),
(29, '2', 'Created', '2015-07-21 16:53:57', '', ''),
(30, '2', 'Deleted', '2015-07-21 17:00:51', '', ''),
(31, '1', 'Updated', '2015-07-21 17:10:09', '', ''),
(32, 'ss', 'LOGIN', '2015-07-21 17:10:56', '::1', ''),
(33, 'ss', 'LOGIN', '2015-07-22 01:31:28', '::1', ''),
(34, 'ss', 'LOGIN', '2015-07-22 02:26:42', '::1', ''),
(35, 'ss', 'LOGIN', '2015-07-22 04:43:11', '::1', ''),
(36, 'ss', 'LOGIN', '2015-07-22 06:13:01', '::1', ''),
(37, 'ss', 'LOGIN', '2015-07-22 08:41:52', '::1', ''),
(38, 'sss', 'LOGIN', '2015-07-22 08:45:04', '::1', ''),
(39, 'sss', 'LOGIN', '2015-07-22 08:48:27', '::1', ''),
(40, 'ss', 'LOGIN', '2015-08-09 00:50:57', '::1', ''),
(41, 'ss', 'LOGIN', '2015-08-09 13:39:45', '::1', ''),
(42, 'ss', 'LOGIN', '2015-08-09 13:39:53', '::1', ''),
(43, 'ss', 'LOGIN', '2015-08-10 12:25:54', '127.0.0.1', ''),
(44, 'ss', 'LOGIN', '2015-08-10 12:28:02', '127.0.0.1', ''),
(45, '2', 'Created', '2015-08-10 13:13:13', '', ''),
(46, 'faculty', 'LOGIN', '2015-08-10 13:13:41', '127.0.0.1', ''),
(47, 'ss', 'LOGIN', '2015-08-10 14:32:32', '127.0.0.1', ''),
(48, 'faculty', 'LOGIN', '2015-08-10 14:33:11', '127.0.0.1', ''),
(49, 'ss', 'LOGIN', '2015-08-10 15:02:03', '127.0.0.1', ''),
(50, 'ss', 'LOGIN', '2015-08-10 15:32:55', '127.0.0.1', ''),
(51, 'ss', 'LOGIN', '2015-08-10 15:48:52', '127.0.0.1', ''),
(52, 'ss', 'LOGIN', '2015-08-10 15:48:58', '127.0.0.1', ''),
(53, '3', 'Created', '2015-08-10 16:00:50', '', ''),
(54, 'pramod', 'LOGIN', '2015-08-10 16:00:59', '127.0.0.1', ''),
(55, 'ss', 'LOGIN', '2015-08-10 16:22:17', '127.0.0.1', ''),
(56, 'pramod', 'LOGIN', '2015-08-10 16:58:00', '127.0.0.1', ''),
(57, 'ss', 'LOGIN', '2015-08-10 17:05:19', '127.0.0.1', ''),
(58, 'ss', 'LOGIN', '2015-08-10 17:16:13', '127.0.0.1', ''),
(59, 'faculty', 'LOGIN', '2015-08-11 10:58:34', '10.0.0.1', ''),
(60, 'ss', 'LOGIN', '2015-08-11 11:00:35', '10.0.0.1', ''),
(61, 'ss', 'LOGIN', '2015-08-11 11:00:46', '10.0.0.1', ''),
(62, 'ss', 'LOGIN', '2015-08-11 11:01:38', '10.0.0.1', ''),
(63, 'ss', 'LOGIN', '2015-08-11 11:04:16', '10.0.0.1', ''),
(64, 'ss', 'LOGIN', '2015-08-12 18:26:48', '192.168.1.70', ''),
(65, 'ss', 'LOGIN', '2015-08-13 16:18:09', '::1', ''),
(66, '4', 'Created', '2015-08-13 17:46:11', '', ''),
(67, 'ss', 'LOGIN', '2015-08-13 17:47:32', '10.0.0.4', ''),
(68, 'ss', 'LOGIN', '2015-08-13 18:50:20', '10.0.0.4', ''),
(69, '12it2016', 'LOGIN', '2015-08-14 10:46:10', '192.168.6.115', ''),
(70, 'ss', 'LOGIN', '2015-08-14 12:46:32', '192.168.5.79', ''),
(71, '13ee5005', 'LOGIN', '2015-08-19 14:00:21', '192.168.1.209', ''),
(72, 'ss', 'LOGIN', '2015-08-19 16:25:48', '127.0.0.1', ''),
(73, '5', 'Created', '2015-08-21 13:06:06', '', ''),
(74, '5', 'Updated', '2015-08-21 13:06:50', '', ''),
(75, '6', 'Created', '2015-08-21 13:08:11', '', ''),
(76, '6', 'Updated', '2015-08-21 13:08:40', '', ''),
(77, 'hodce', 'LOGIN', '2015-08-21 13:10:04', '10.0.0.4', ''),
(78, 'hodce', 'LOGIN', '2015-08-21 13:10:27', '10.0.0.4', ''),
(79, 'hodce', 'LOGIN', '2015-08-21 13:10:43', '10.0.0.4', ''),
(80, 'faculty', 'LOGIN', '2015-08-21 13:11:53', '10.0.0.4', ''),
(81, 'hodce', 'LOGIN', '2015-08-21 13:12:14', '10.0.0.4', ''),
(82, '5', 'Updated', '2015-08-21 13:21:56', '', ''),
(83, '6', 'Updated', '2015-08-21 13:22:05', '', ''),
(84, 'hodce', 'LOGIN', '2015-08-21 13:22:19', '10.0.0.4', ''),
(85, 'hodce', 'LOGIN', '2015-08-21 13:22:42', '10.0.0.4', ''),
(86, '5', 'Deleted', '2015-08-21 13:23:09', '', ''),
(87, '6', 'Deleted', '2015-08-21 13:23:22', '', ''),
(88, '7', 'Created', '2015-08-21 13:24:21', '', ''),
(89, 'hodce', 'LOGIN', '2015-08-21 13:24:35', '10.0.0.4', ''),
(90, 'hodce', 'LOGIN', '2015-08-21 13:24:40', '10.0.0.4', ''),
(91, '7', 'Updated', '2015-08-21 13:25:08', '', ''),
(92, 'hodce', 'LOGIN', '2015-08-21 13:25:19', '10.0.0.4', ''),
(93, 'hodce', 'LOGIN', '2015-08-21 13:25:30', '10.0.0.4', ''),
(94, 'hodce', 'LOGIN', '2015-08-21 13:25:54', '10.0.0.4', ''),
(95, 'hod5', 'LOGIN', '2015-08-21 13:27:48', '10.0.0.4', ''),
(96, 'hod5', 'LOGIN', '2015-08-21 13:28:18', '10.0.0.4', ''),
(97, 'hod5', 'LOGIN', '2015-08-21 13:29:30', '10.0.0.4', ''),
(98, '7', 'Updated', '2015-08-21 13:29:39', '', ''),
(99, 'hod', 'LOGIN', '2015-08-21 13:29:53', '10.0.0.4', ''),
(100, 'hod', 'LOGIN', '2015-08-21 13:30:43', '10.0.0.4', ''),
(101, '7', 'Deleted', '2015-08-21 13:33:54', '', ''),
(102, 'faculty ', 'LOGIN', '2015-08-21 13:34:07', '10.0.0.4', ''),
(103, '8', 'Created', '2015-08-21 13:35:51', '', ''),
(104, 'hodce', 'LOGIN', '2015-08-21 13:36:15', '10.0.0.4', ''),
(105, 'hodce', 'LOGIN', '2015-08-21 13:36:37', '10.0.0.4', ''),
(106, 'hodce', 'LOGIN', '2015-08-21 13:37:00', '10.0.0.4', ''),
(107, 'hodce', 'LOGIN', '2015-08-21 13:37:11', '10.0.0.4', ''),
(108, 'hodce', 'LOGIN', '2015-08-21 13:37:20', '10.0.0.4', ''),
(109, 'hodce', 'LOGIN', '2015-08-21 13:39:52', '10.0.0.4', ''),
(110, 'hodce', 'LOGIN', '2015-08-21 13:40:41', '10.0.0.4', ''),
(111, 'hodce', 'LOGIN', '2015-08-21 13:41:02', '10.0.0.4', ''),
(112, '10', 'Created', '2015-08-21 13:47:23', '', ''),
(113, 'hodce', 'LOGIN', '2015-08-21 13:47:47', '10.0.0.4', ''),
(114, 'hodit', 'LOGIN', '2015-08-21 13:48:08', '10.0.0.4', ''),
(115, 'hod', 'LOGIN', '2015-08-21 13:48:55', '10.0.0.4', ''),
(116, 'hodce', 'LOGIN', '2015-08-21 13:49:42', '10.0.0.4', ''),
(117, '8', 'Updated', '2015-08-21 13:49:55', '', ''),
(118, 'hodce', 'LOGIN', '2015-08-21 13:50:02', '10.0.0.4', ''),
(119, 'hod5', 'LOGIN', '2015-08-21 13:50:21', '10.0.0.4', ''),
(120, '11', 'Created', '2015-08-21 13:57:11', '', ''),
(121, 'hod5', 'LOGIN', '2015-08-21 13:57:23', '10.0.0.4', ''),
(122, 'hodce5', 'LOGIN', '2015-08-21 13:57:35', '10.0.0.4', ''),
(123, '12', 'Created', '2015-08-21 14:41:34', '', ''),
(124, 'hodin', 'LOGIN', '2015-08-21 14:42:19', '10.0.0.4', ''),
(125, '12', 'Deleted', '2015-08-21 14:43:30', '', ''),
(126, '14', 'Created', '2015-08-21 14:43:54', '', ''),
(127, 'hodin', 'LOGIN', '2015-08-21 14:44:15', '10.0.0.4', ''),
(128, '15', 'Created', '2015-08-21 14:46:18', '', ''),
(129, 'hoden', 'LOGIN', '2015-08-21 14:46:48', '10.0.0.4', ''),
(130, '16', 'Created', '2015-08-21 14:47:32', '', ''),
(131, '17', 'Created', '2015-08-21 14:48:31', '', ''),
(132, '18', 'Created', '2015-08-21 14:49:10', '', ''),
(133, '19', 'Created', '2015-08-21 14:50:03', '', ''),
(134, 'principal', 'LOGIN', '2015-08-21 14:50:18', '10.0.0.4', ''),
(135, 'principal', 'LOGIN', '2015-08-21 14:50:43', '10.0.0.4', ''),
(136, '19', 'Deleted', '2015-08-21 14:51:00', '', ''),
(137, '20', 'Created', '2015-08-21 14:51:48', '', ''),
(138, 'principal', 'LOGIN', '2015-08-21 14:52:04', '10.0.0.4', ''),
(139, '20', 'Deleted', '2015-08-21 14:52:16', '', ''),
(140, '21', 'Created', '2015-08-21 14:52:51', '', ''),
(141, 'principal', 'LOGIN', '2015-08-21 14:52:59', '10.0.0.4', ''),
(142, '22', 'Created', '2015-08-21 14:54:03', '', ''),
(143, 'tpo', 'LOGIN', '2015-08-21 14:54:12', '10.0.0.4', ''),
(144, '23', 'Created', '2015-08-21 14:55:09', '', ''),
(145, '24', 'Created', '2015-08-21 14:56:45', '', ''),
(146, '25', 'Created', '2015-08-21 14:57:29', '', ''),
(147, '26', 'Created', '2015-08-21 14:58:47', '', ''),
(148, '27', 'Created', '2015-08-21 14:59:35', '', ''),
(149, '28', 'Created', '2015-08-21 15:00:19', '', ''),
(150, '29', 'Created', '2015-08-21 15:00:40', '', ''),
(151, '30', 'Created', '2015-08-21 15:01:25', '', ''),
(152, '31', 'Created', '2015-08-21 15:04:23', '', ''),
(153, 'faculty', 'LOGIN', '2015-08-21 15:04:41', '10.0.0.4', ''),
(154, 'hodin', 'LOGIN', '2015-08-21 16:05:22', '192.168.2.30', ''),
(155, 'pa', 'LOGIN', '2015-08-21 16:16:22', '192.168.1.115', ''),
(156, 'hodex', 'LOGIN', '2015-08-21 16:22:16', '192.168.1.17', ''),
(157, 'hodex', 'LOGIN', '2015-08-21 16:22:41', '192.168.1.17', ''),
(158, 'hodex', 'LOGIN', '2015-08-21 16:22:58', '192.168.1.17', ''),
(159, 'hoden', 'LOGIN', '2015-08-21 16:23:15', '192.168.1.17', ''),
(160, 'principal', 'LOGIN', '2015-08-21 16:39:32', '192.168.1.52', ''),
(161, '16', 'Deleted', '2015-08-28 12:08:55', '', ''),
(162, '32', 'Created', '2015-08-28 12:09:29', '', ''),
(163, 'hodex', 'LOGIN', '2015-08-28 12:10:05', '10.0.0.4', ''),
(164, 'hodex', 'LOGIN', '2015-08-28 12:11:08', '10.0.0.4', ''),
(165, '32', 'Updated', '2015-08-28 12:11:08', '', ''),
(166, 'hodex', 'LOGIN', '2015-08-28 12:11:37', '10.0.0.4', ''),
(167, 'pa', 'LOGIN', '2015-08-31 09:46:34', '192.168.1.14', ''),
(168, 'pa', 'LOGIN', '2015-08-31 09:53:53', '192.168.1.14', ''),
(169, 'pa', 'LOGIN', '2015-09-01 09:51:59', '192.168.1.136', ''),
(170, 'pa', 'LOGIN', '2015-09-01 09:52:11', '192.168.1.136', ''),
(171, 'faculty', 'LOGIN', '2015-09-01 11:19:45', '10.0.0.4', ''),
(172, 'pa', 'LOGIN', '2015-09-01 17:08:33', '192.168.1.136', ''),
(173, 'ss', 'LOGIN', '2015-09-02 07:51:27', '64.233.173.222', '49.14.53.88'),
(174, 'faculty', 'LOGIN', '2015-09-02 07:52:03', '64.233.173.222', '49.14.53.88'),
(175, 'hodce5', 'LOGIN', '2015-09-15 17:19:21', '192.168.5.170', ''),
(176, 'hodce5', 'LOGIN', '2015-09-15 17:29:06', '192.168.5.170', ''),
(177, 'hodce5', 'LOGIN', '2015-09-16 12:35:18', '192.168.5.234', ''),
(178, 'hodce5', 'LOGIN', '2015-09-16 13:23:53', '192.168.5.234', ''),
(179, 'exam', 'LOGIN', '2015-09-16 14:18:32', '192.168.2.19', ''),
(180, 'exam', 'LOGIN', '2015-09-16 14:54:26', '192.168.2.19', ''),
(181, 'exam', 'LOGIN', '2015-09-16 14:58:40', '192.168.2.19', ''),
(182, 'hodes', 'LOGIN', '2015-09-16 16:41:10', '192.168.2.124', ''),
(183, 'hodas', 'LOGIN', '2015-09-16 16:41:28', '192.168.2.124', ''),
(184, 'hodas', 'LOGIN', '2015-09-16 16:41:41', '192.168.2.124', ''),
(185, 'hodas', 'LOGIN', '2015-09-16 16:41:57', '192.168.2.124', ''),
(186, 'hodes', 'LOGIN', '2015-09-16 16:42:36', '192.168.2.124', ''),
(187, 'hodes', 'LOGIN', '2015-09-16 16:42:47', '192.168.2.124', ''),
(188, 'hodes', 'LOGIN', '2015-09-16 16:42:56', '192.168.2.124', ''),
(189, 'hodas', 'LOGIN', '2015-09-16 16:43:26', '192.168.2.124', ''),
(190, 'hodas', 'LOGIN', '2015-09-16 16:45:20', '192.168.2.124', ''),
(191, 'hodas', 'LOGIN', '2015-09-16 16:51:33', '192.168.5.129', ''),
(192, 'hodas', 'LOGIN', '2015-09-16 16:51:49', '192.168.5.129', ''),
(193, 'csi', 'LOGIN', '2015-09-16 16:52:15', '192.168.5.129', ''),
(194, '33', 'Created', '2015-09-16 17:00:53', '', ''),
(195, 'hodes', 'LOGIN', '2015-09-16 17:01:42', '127.0.0.1', ''),
(196, 'hodes', 'LOGIN', '2015-09-16 17:03:25', '192.168.2.124', ''),
(197, 'csi', 'LOGIN', '2015-09-16 17:21:09', '192.168.5.198', ''),
(198, 'csi', 'LOGIN', '2015-09-16 17:22:46', '192.168.5.63', ''),
(199, 'hodes', 'LOGIN', '2015-09-16 17:37:59', '192.168.2.71', ''),
(200, 'csi', 'LOGIN', '2015-09-16 18:20:47', '192.168.5.63', ''),
(201, '29', 'Updated', '2015-09-16 18:20:48', '', ''),
(202, 'csi', 'LOGIN', '2015-09-16 18:21:01', '192.168.5.63', ''),
(203, 'csi', 'LOGIN', '2015-09-16 18:21:12', '192.168.5.63', ''),
(204, 'csi', 'LOGIN', '2015-09-16 18:21:29', '192.168.5.63', ''),
(205, 'csi', 'LOGIN', '2015-09-16 18:21:36', '192.168.5.63', ''),
(206, 'csi', 'LOGIN', '2015-09-16 18:21:48', '192.168.5.63', ''),
(207, 'csi', 'LOGIN', '2015-09-16 18:22:04', '192.168.5.63', ''),
(208, 'csi', 'LOGIN', '2015-09-16 18:22:21', '192.168.5.63', ''),
(209, 'csi', 'LOGIN', '2015-09-16 18:23:12', '192.168.5.63', ''),
(210, 'csi', 'LOGIN', '2015-09-16 18:23:24', '192.168.5.63', ''),
(211, 'csi', 'LOGIN', '2015-09-16 18:23:40', '192.168.5.63', ''),
(212, 'csi', 'LOGIN', '2015-09-16 18:23:53', '192.168.5.63', ''),
(213, 'CSI', 'LOGIN', '2015-09-16 18:24:08', '192.168.5.63', ''),
(214, 'csi', 'LOGIN', '2015-09-16 18:24:33', '192.168.5.63', ''),
(215, 'csi', 'LOGIN', '2015-09-16 18:24:55', '192.168.5.63', ''),
(216, 'csi', 'LOGIN', '2015-09-16 18:25:29', '192.168.5.63', ''),
(217, 'csi', 'LOGIN', '2015-09-16 18:25:56', '192.168.5.63', ''),
(218, 'csi', 'LOGIN', '2015-09-16 18:26:08', '192.168.5.63', ''),
(219, 'csi', 'LOGIN', '2015-09-16 18:26:29', '192.168.5.63', ''),
(220, 'csi ', 'LOGIN', '2015-09-16 18:26:47', '192.168.5.63', ''),
(221, 'CSI', 'LOGIN', '2015-09-16 18:27:05', '192.168.5.63', ''),
(222, 'CSI', 'LOGIN', '2015-09-16 18:27:23', '192.168.5.63', ''),
(223, 'CSI', 'LOGIN', '2015-09-16 18:27:29', '192.168.5.63', ''),
(224, 'csi', 'LOGIN', '2015-09-16 18:28:26', '192.168.5.63', ''),
(225, 'hodes', 'LOGIN', '2015-09-18 08:45:18', '192.168.2.187', ''),
(226, 'hodes', 'LOGIN', '2015-09-18 08:46:50', '192.168.2.187', ''),
(227, 'hodes', 'LOGIN', '2015-09-18 08:47:15', '192.168.2.187', ''),
(228, '33', 'Updated', '2015-09-18 08:47:15', '', ''),
(229, 'hodes', 'LOGIN', '2015-09-18 08:47:35', '192.168.2.187', ''),
(230, '33', 'Updated', '2015-09-18 08:47:35', '', ''),
(231, 'hodes', 'LOGIN', '2015-09-18 08:47:49', '192.168.2.187', ''),
(232, 'hodes', 'LOGIN', '2015-09-18 10:13:55', '192.168.2.187', ''),
(233, 'hodce5', 'LOGIN', '2015-09-18 10:57:02', '10.0.0.4', ''),
(234, 'hodce5', 'LOGIN', '2015-09-18 11:26:20', '10.0.0.4', ''),
(235, 'hodce5', 'LOGIN', '2015-09-18 12:02:00', '192.168.5.237', ''),
(236, '29', 'Deleted', '2015-09-21 13:33:54', '', ''),
(237, '34', 'Created', '2015-09-21 13:34:30', '', ''),
(238, 'csi', 'LOGIN', '2015-09-21 13:34:49', '10.0.0.4', ''),
(239, 'CSI', 'LOGIN', '2015-09-21 13:39:27', '192.168.4.95', ''),
(240, 'Faculty', 'LOGIN', '2015-09-24 15:35:38', '106.78.205.119', ''),
(241, 'csi', 'LOGIN', '2015-09-24 19:24:57', '10.0.0.1', ''),
(242, 'csi', 'LOGIN', '2015-09-24 19:25:14', '10.0.0.1', ''),
(243, 'csi', 'LOGIN', '2015-09-25 16:36:40', '10.0.0.1', ''),
(244, 'hod', 'LOGIN', '2015-09-28 11:50:38', '192.168.6.137', ''),
(245, 'hod', 'LOGIN', '2015-09-28 12:02:28', '192.168.6.137', ''),
(246, 'hod', 'LOGIN', '2015-09-28 12:06:18', '192.168.6.137', ''),
(247, 'hod', 'LOGIN', '2015-09-28 12:10:32', '192.168.6.137', ''),
(248, 'CSI', 'LOGIN', '2015-10-05 13:51:27', '10.0.0.1', ''),
(249, 'csi', 'LOGIN', '2015-10-05 15:15:42', '10.0.0.1', ''),
(250, 'hoden', 'LOGIN', '2015-10-07 13:45:51', '192.168.4.59', ''),
(251, 'hoden', 'LOGIN', '2015-10-07 13:46:16', '192.168.4.59', ''),
(252, 'hodel', 'LOGIN', '2015-10-07 13:46:28', '192.168.4.59', ''),
(253, 'hoden', 'LOGIN', '2015-10-08 08:53:12', '192.168.4.65', ''),
(254, 'hoden', 'LOGIN', '2015-10-09 11:31:47', '10.0.0.4', ''),
(255, 'faculty', 'LOGIN', '2015-10-15 10:47:32', '10.0.0.4', ''),
(256, 'Faculty', 'LOGIN', '2015-10-28 09:52:38', '103.226.141.62', ''),
(257, 'Faculty', 'LOGIN', '2015-11-12 16:29:02', '106.66.127.249', ''),
(258, 'faculty', 'LOGIN', '2015-11-12 22:33:45', '103.226.241.111', ''),
(259, 'faculty', 'LOGIN', '2015-11-23 11:55:22', '10.0.0.4', ''),
(260, 'hodce', 'LOGIN', '2015-11-23 12:09:00', '10.0.0.4', ''),
(261, 'hod', 'LOGIN', '2015-11-23 12:09:14', '10.0.0.4', ''),
(262, 'Faculty', 'LOGIN', '2015-11-24 10:55:06', '106.79.116.139', ''),
(263, 'Faculty', 'LOGIN', '2015-11-24 23:44:14', '103.226.146.159', ''),
(264, 'pa', 'LOGIN', '2016-01-07 10:20:48', '192.168.1.55', ''),
(265, 'pa', 'LOGIN', '2016-01-07 10:21:04', '192.168.1.55', ''),
(266, 'pa', 'LOGIN', '2016-01-07 10:27:36', '10.0.0.4', ''),
(267, 'pa', 'LOGIN', '2016-01-07 10:28:03', '10.0.0.4', ''),
(268, '18', 'Deleted', '2016-01-07 10:28:55', '', ''),
(269, '35', 'Created', '2016-01-07 10:29:32', '', ''),
(270, 'PA', 'LOGIN', '2016-01-07 10:29:49', '10.0.0.4', ''),
(271, 'admin', 'LOGIN', '2016-01-07 10:38:53', '10.0.0.4', ''),
(272, 'pramodb', 'LOGIN', '2016-01-07 10:39:03', '10.0.0.4', ''),
(273, 'faculty ', 'LOGIN', '2016-01-07 10:40:45', '10.0.0.4', ''),
(274, 'pa', 'LOGIN', '2016-01-07 10:45:54', '192.168.1.55', ''),
(275, 'faculty', 'LOGIN', '2016-01-07 12:35:16', '49.14.226.79', ''),
(276, 'faculty', 'LOGIN', '2016-01-07 13:05:44', '1.39.8.80', ''),
(277, 'PA', 'LOGIN', '2016-01-08 19:57:37', '45.112.9.13', ''),
(278, 'faculty', 'LOGIN', '2016-01-11 18:59:28', '::1', ''),
(279, 'itHOD', 'LOGIN', '2016-01-12 10:29:50', '10.0.0.1', ''),
(280, 'itHOD', 'LOGIN', '2016-01-12 10:30:21', '10.0.0.1', ''),
(281, 'faculty', 'LOGIN', '2016-01-12 10:45:22', '27.97.85.4', ''),
(282, 'hod', 'LOGIN', '2016-01-12 12:16:21', '192.168.6.178', ''),
(283, 'faculty ', 'LOGIN', '2016-01-12 13:41:29', '10.0.0.4', ''),
(284, 'hodce', 'LOGIN', '2016-01-12 13:51:13', '10.0.0.1', ''),
(285, 'hodce', 'LOGIN', '2016-01-12 13:51:29', '10.0.0.1', ''),
(286, 'faculty', 'LOGIN', '2016-01-12 13:51:55', '10.0.0.1', ''),
(287, 'pa', 'LOGIN', '2016-01-12 13:56:37', '192.168.1.18', ''),
(288, 'faculty', 'LOGIN', '2016-01-12 14:21:38', '27.97.85.173', ''),
(289, 'faculty', 'LOGIN', '2016-01-12 14:43:01', '10.0.0.1', ''),
(290, 'hod', 'LOGIN', '2016-01-12 15:41:42', '192.168.5.217', ''),
(291, 'hod', 'LOGIN', '2016-01-12 15:56:33', '192.168.5.217', ''),
(292, 'PA', 'LOGIN', '2016-01-12 16:00:38', '27.97.85.173', ''),
(293, 'faculty', 'LOGIN', '2016-01-12 16:13:05', '27.97.85.173', ''),
(294, 'hod', 'LOGIN', '2016-01-12 16:14:40', '192.168.5.217', ''),
(295, 'faculty', 'LOGIN', '2016-01-12 23:30:55', '103.226.243.201', ''),
(296, 'facultty', 'LOGIN', '2016-01-13 11:25:26', '10.0.0.4', ''),
(297, 'faculty', 'LOGIN', '2016-01-13 11:25:41', '10.0.0.4', ''),
(298, 'faculty', 'LOGIN', '2016-01-13 11:29:04', '10.0.0.4', ''),
(299, 'faculty ', 'LOGIN', '2016-01-13 11:45:09', '192.168.5.186', ''),
(300, 'HODFE', 'LOGIN', '2016-01-13 13:53:25', '192.168.1.218', ''),
(301, 'HODfe', 'LOGIN', '2016-01-13 13:53:40', '192.168.1.218', ''),
(302, 'faculty', 'LOGIN', '2016-01-13 16:58:07', '112.110.65.97', ''),
(303, 'faculty', 'LOGIN', '2016-01-13 20:20:56', '103.226.243.201', ''),
(304, 'FACULTY ', 'LOGIN', '2016-01-14 13:43:37', '192.168.5.82', ''),
(305, 'faculty', 'LOGIN', '2016-01-14 13:44:00', '192.168.5.82', ''),
(306, 'pa', 'LOGIN', '2016-01-14 17:10:59', '192.168.1.28', ''),
(307, 'faculty', 'LOGIN', '2016-01-14 17:16:38', '27.97.89.138', ''),
(308, 'hodfe', 'LOGIN', '2016-01-15 12:06:33', '192.168.1.58', ''),
(309, 'HODFE', 'LOGIN', '2016-01-15 12:06:52', '192.168.1.58', ''),
(310, 'HODFE', 'LOGIN', '2016-01-15 12:07:00', '192.168.1.58', ''),
(311, 'HODFE', 'LOGIN', '2016-01-15 14:53:05', '192.168.1.58', ''),
(312, 'hodfe', 'LOGIN', '2016-01-15 14:53:13', '192.168.1.58', ''),
(313, '36', 'Created', '2016-01-15 15:12:28', '', ''),
(314, 'hodfe', 'LOGIN', '2016-01-15 15:12:41', '10.0.0.4', ''),
(315, 'hodce5', 'LOGIN', '2016-01-15 15:41:39', '192.168.5.164', ''),
(316, 'hodfe', 'LOGIN', '2016-01-15 15:44:58', '192.168.1.58', ''),
(317, 'hodfe', 'LOGIN', '2016-01-15 16:06:16', '192.168.1.58', ''),
(318, 'faculty', 'LOGIN', '2016-01-15 16:07:43', '192.168.1.140', ''),
(319, 'faculty', 'LOGIN', '2016-01-15 16:17:57', '192.168.1.140', ''),
(320, 'faculty', 'LOGIN', '2016-01-15 16:21:32', '192.168.1.140', ''),
(321, 'hodfe', 'LOGIN', '2016-01-15 16:32:04', '192.168.1.58', ''),
(322, 'faculty', 'LOGIN', '2016-01-15 16:37:55', '10.0.0.1', ''),
(323, 'faculty', 'LOGIN', '2016-01-19 09:28:25', '103.226.243.165', ''),
(324, 'hodfe', 'LOGIN', '2016-01-19 11:49:33', '192.168.1.82', ''),
(325, 'hod', 'LOGIN', '2016-01-20 11:28:32', '192.168.6.41', ''),
(326, 'faculty', 'LOGIN', '2016-01-25 13:46:31', '10.0.0.1', ''),
(327, 'faculty', 'LOGIN', '2016-01-25 14:04:38', '10.0.0.1', ''),
(328, 'pa', 'LOGIN', '2016-01-28 13:13:15', '192.168.1.161', ''),
(329, 'pa', 'LOGIN', '2016-01-28 13:13:23', '192.168.1.161', ''),
(330, 'pa', 'LOGIN', '2016-01-28 15:24:37', '192.168.1.161', ''),
(331, 'hod', 'LOGIN', '2016-01-29 09:17:26', '192.168.6.188', ''),
(332, 'hod', 'LOGIN', '2016-02-03 16:23:16', '192.168.6.50', ''),
(333, 'hod', 'LOGIN', '2016-02-03 16:26:33', '192.168.6.169', ''),
(334, 'pa', 'LOGIN', '2016-02-09 13:04:15', '192.168.1.118', ''),
(335, 'student ', 'LOGIN', '2016-02-29 09:08:31', '192.168.5.125', ''),
(336, 'faculty', 'LOGIN', '2016-02-29 09:08:44', '192.168.5.125', ''),
(337, 'pa', 'LOGIN', '2016-03-08 17:12:41', '192.168.1.19', ''),
(338, 'pa', 'LOGIN', '2016-03-08 17:12:51', '192.168.1.19', ''),
(339, 'pa', 'LOGIN', '2016-03-08 17:34:36', '192.168.1.19', ''),
(340, '13ce1052', 'LOGIN', '2016-03-15 11:52:42', '192.168.7.108', ''),
(341, 'faculty', 'LOGIN', '2016-05-14 20:05:20', '182.237.133.149', ''),
(342, 'faculty', 'LOGIN', '2016-05-14 20:05:58', '182.237.133.149', ''),
(343, 'student ', 'LOGIN', '2016-05-30 14:01:10', '192.168.5.115', ''),
(344, 'student ', 'LOGIN', '2016-05-30 14:01:22', '192.168.5.115', ''),
(345, 'faculty ', 'LOGIN', '2016-05-30 14:01:35', '192.168.5.115', ''),
(346, 'hod', 'LOGIN', '2016-05-30 14:04:17', '192.168.5.115', ''),
(347, '16', 'Created', '2016-06-13 21:24:32', '', ''),
(348, '37', 'Created', '2016-06-30 13:16:26', '', ''),
(349, '16', 'Updated', '2016-06-30 15:49:00', '', ''),
(350, '16', 'Deleted', '2016-06-30 15:49:00', '', ''),
(351, '38', 'Created', '2016-07-09 08:30:20', '', ''),
(352, '36', 'Updated', '2016-07-10 14:26:20', '', ''),
(353, '21', 'Updated', '2016-07-10 14:35:45', '', ''),
(354, '25', 'Updated', '2016-07-10 18:08:54', '', ''),
(355, '8', 'Updated', '2016-10-04 09:50:27', '', ''),
(356, '8', 'Updated', '2016-10-04 10:49:09', '', '');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
