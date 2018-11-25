-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Ноя 23 2018 г., 15:30
-- Версия сервера: 10.1.34-MariaDB
-- Версия PHP: 7.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `se_project`
--

-- --------------------------------------------------------

--
-- Структура таблицы `admin`
--

CREATE TABLE `admin` (
  `id` int(200) NOT NULL,
  `adname` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Дамп данных таблицы `admin`
--

INSERT INTO `admin` (`id`, `adname`, `password`) VALUES
(1, 'abylay', '12345');

-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

CREATE TABLE `posts` (
  `id` int(15) NOT NULL,
  `user_id` int(15) NOT NULL,
  `title` varchar(100) NOT NULL,
  `body` text NOT NULL,
  `time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Дамп данных таблицы `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `title`, `body`, `time`) VALUES
(1, 1, 'first post', 'first post body', '2018-11-23 03:21:00'),
(2, 1, 'first post33', 'first post33', '2018-11-23 03:26:36'),
(3, 1, 'first post44', 'first post44', '2018-11-23 03:34:57'),
(4, 1, 'post4', 'post4', '2018-11-23 04:06:19'),
(5, 6, 'my post', 'My first post. ', '2018-11-23 12:30:34'),
(6, 6, 'Second post', 'My second post today', '2018-11-23 12:35:36'),
(14, 1, 'Another post', 'another post body', '2018-11-23 13:04:21'),
(15, 1, 'dq wfwf wad', 'da qsw dew aw sge ', '2018-11-23 13:07:03'),
(16, 1, 'Post', 'Post..', '2018-11-23 15:16:24'),
(17, 1, 'title of post', 'body of post', '2018-11-23 15:24:43'),
(18, 7, 'My post', 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters', '2018-11-23 15:43:31'),
(19, 7, 'Another post', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.', '2018-11-23 15:43:47');

-- --------------------------------------------------------

--
-- Структура таблицы `profile`
--

CREATE TABLE `profile` (
  `id` int(15) NOT NULL,
  `user_id` int(15) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `age` int(15) NOT NULL,
  `education` varchar(255) NOT NULL,
  `major` varchar(255) NOT NULL,
  `profession` varchar(255) NOT NULL,
  `experience` varchar(255) NOT NULL,
  `skills` varchar(255) NOT NULL,
  `links` varchar(255) NOT NULL,
  `bio` text NOT NULL,
  `photo` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Дамп данных таблицы `profile`
--

INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `age`, `education`, `major`, `profession`, `experience`, `skills`, `links`, `bio`, `photo`) VALUES
(1, 1, 'Abylay', 'Tastanbekov', 20, 'Nazarbayev university', 'cs', 'developer', '2 years', 'java', 'https://github.com/abyl25', 'My bio', 'NULL'),
(2, 11, 'test', 'test', 20, 'Nazarbayev university', 'cs', 'developer', '1 year', 'java', 'https://github.com/abyl25', 'sdafsdfsefwsefewfwfwefwef', 'NULL'),
(3, 7, 'Abylay', 'Tastanbekov', 21, 'NU', 'CS', 'Web Development', '6 months', 'Python, Django, Java', 'https://github.com/Abylay019', 'Was born in Jezkazgan. Loves programming', NULL),
(4, 6, 'Yerassyl', 'Danay', 21, 'NU', 'CS', 'Web scraping', '1 year', 'Python, Flask, Java', 'https://github.com/YerassylDanay', 'Yerassyl\'s bio', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(15) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`) VALUES
(1, 'Abylay', 'Tastanbekov', 'abylay.tastanbekov@nu.edu.kz', 'abylay25'),
(5, 'Nurdaulet', 'Yeltayev', 'nurdaulet.yeltayev@nu.edu.kz', 'nurdaulet'),
(6, 'Yerassyl', 'Danay', 'yerassyl.danay@nu.edu.kz', 'yerassyl'),
(7, 'Abylay', 'Zhanbek', 'abylay.zhanbek@nu.edu.kz', 'zhanbek123'),
(8, 'Fatima', 'Nabidollaeyeva', 'fatima.nabidollaeyeva@nu.edu.kz', 'fatima123'),
(9, 'Daniyar', 'Maksatov', 'daniyar.maksatov@nu.edu.kz', 'maksatov123'),
(10, 'Dias', 'Duisembayev', 'dias.duisembayev@nu.edu.kz', 'dias123'),
(11, 'test', 'test', 'test@nu.edu.kz', 'test123'),
(12, 'test1', 'test1', 'test1@nu.edu.kz', 'test123');

-- --------------------------------------------------------

--
-- Структура таблицы `vacancies`
--

CREATE TABLE `vacancies` (
  `id` int(10) NOT NULL,
  `vacancy_type` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `contacts` varchar(255) NOT NULL,
  `created_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Дамп данных таблицы `vacancies`
--

INSERT INTO `vacancies` (`id`, `vacancy_type`, `title`, `description`, `company_name`, `address`, `contacts`, `created_date`) VALUES
(1, 'Engineering', 'Mechanical engineer', 'Seeking progressive mechanical designer or engineer with 4+ years post-academic building engineering experience. You understand how buildings and systems are put together and thrive on educating colleagues about how passive design improves occupant comfort and reduces heating and cooling loads. You have demonstrated creativity and technical excellence in providing mechanical and plumbing design for a variety of building types. You are also skilled with project management, design review and construction administration tasks.', 'BeEffective', 'Berkeley, CA, USA', 'beffective@bf.com', '2018-11-01 08:20:11'),
(2, 'Education', 'Preschool and Toddler Teachers', 'Due to our recent building expansion and increase in enrollment, Bright Beginnings: Ferguson\'s Child Development Center is seeking caring, friendly teachers with positive attitudes. Teachers must have a high school diploma and experience is preferred. We offer competitive pay and a great environment, Bright Beginnings is an opportunity you don\'t want to pass up. Please send your resume to Sharon at Bright Beginnings. We look forward to hearing from you!', 'Bright Beginnings', 'Beavercreek, OH, USA', 'brigthbeginnings@gmail.com', '2018-10-08 03:26:09'),
(3, 'Information Technology', 'Python developer', 'Required:\r\n\r\nApplicant MUST have two solid years of Django application development.\r\nApplicant MUST have solid knowledge of Python.\r\nSolid knowledge of the principles of class-based object-oriented programming.\r\nSolid knowledge of standard web technology (HTTP, HTTPS, HTML5, client/server model)\r\nTwo years of issue management via a ticketing system (JIRA, Trac, etc.).\r\nTwo years use of software control management.\r\nSolid communication skills.\r\nPreferred:\r\n\r\nExperience with git and the Gitflow workflow.\r\nExperience reading SQL.\r\nExperience using RDMS.\r\nExperience with continuous integration/continuous deployment environment.\r\nExperience with automated testing.\r\nJavaScript development beyond jQuery.', 'Quotent Inc', 'Bethesda, MD, USA', 'qinc.hr@gmail.com', '2018-11-08 20:41:29'),
(4, 'Sales', 'Insurance Agent', 'We are looking to expand our team with driven, enthusiastic agents who desire unlimited earning potential in a supportive and successful company environment. Come see why our agents love being part of the family at Strong Family Financial. \r\n\r\nHighlights include: \r\n\r\n- flexible schedule \r\n\r\n- exceptional paid training program \r\n\r\n- average first year agents make $40,000+ \r\n\r\n- fun and supportive work culture', 'Family financial', 'Jenks, OK, USA', 'family.financial@gmail.com', '2018-11-08 08:23:20'),
(5, 'Arts and Design', 'Animator', 'Character Animator (Mid-Level or Higher)\r\n\r\nAre you super passionate about hand animating characters and truly breathing life into them? Can you bring out their quirky personalities and make it emotionally resonate with players while delivering innovative gameplay mechanics?\r\n\r\nVelan Studios is a growing independent game developer focused on bringing ground-breaking new game experiences to existing and emerging game platforms. We are building a world-class development studio of developers who can blow game-players away with work that is both innovative and unconventional.\r\n\r\nWe are looking for an experienced and passionate animator to join our team. If you’re brimming with curiosity and ready to create the best work of your career, we want to hear from you!\r\n\r\n\r\nResponsibilities\r\n\r\nThe ideal candidate is a versatile animator with strong hand-keyed animation skills and an eye for humor and energy in their animation work. The Animator will work in a small production team with the Game Director, Art Director, Character Artists, Animators and Gameplay Programmers to create eye-opening, visually-captivating experiences.\r\n\r\n\r\nQualifications\r\n\r\n3+ years of game/film industry experience\r\nExpert in character animation and motion\r\nExpert in rigging, skinning, and point-weighting\r\nExperience working in Unreal, Unity, or other AAA engines.\r\nStrong working knowledge in 3D Studio Max or Maya\r\nSelf-driven and proactive in problem solving\r\nYou must be an excellent team player, passionate, scrappy, and deeply curious.\r\nBig Plusses\r\n\r\nScripting experience\r\nCharacter modeling expertise\r\nStoryboarding and animatic development experience\r\nMotion-matching or other modern techniques for character animation in games\r\nStrong Game Design sensibilities\r\nTo apply for this position, please your send resume, cover letter and a portfolio with descriptions of the work showcased to jobs@velanstudios.com. Be sure to reference the position you’re applying for in the subject line.', 'Velan Studios', 'Troy, NY', 'vstudio@gmail.com', '2018-09-11 07:19:20'),
(6, 'Finance', 'Actuarial Specialist', 'IAT has an immediate opening for an Actuarial Analyst supporting our Corporate Actuarial Department. The position may be located in Raleigh, NC or Alpharetta, GA depending on the qualifications of the applicant. \r\n\r\n\r\nIAT Actuaries can enroll in IAT’s Actuarial Development Program -designed to support staff with the time and resources need to prepare for every exam.\r\n\r\nResponsibilities:\r\n\r\nDevelops tools to measure and monitor profitability by business unit and product.\r\nIdentifies trends in claim frequency and claim severity and communicate results to underwriting and claims management.\r\nDevelops reports to measure rate action taken and its impact on retention and new business growth.\r\nDevelops and maintains capital allocation model to measure the risk-adjusted performance of each business unit.\r\nEstimates and recommends loss reserves to be carried in the company’s financial statements.\r\nDevelops rate-making templates and provide support for state-by-state rate filings.\r\nCollaborates with underwriting, claims, IT and senior management to develop plans for new products or improvements to existing products and procedures.\r\nGathers data, analyzes information, and makes recommendations/decisions to solve problems. Interprets the meaning of information for others within the organization.\r\n\r\nQualifications:\r\n\r\nBachelor’s degree in actuarial sciences, statistics or analytics or equivalent.\r\nEquivalent experience is defined as having 4 years of relevant actuarial experience in the P&C Insurance environment.\r\nGPA of 3.0 or above is preferred.\r\n2 or more Actuary Exams completed & passed preferred\r\nWorking Knowledge of EXCEL VBA, SQL or R is preferred\r\nMust be able to work independently and have superb oral and written communication capabilities\r\nAbility to proactively identify opportunities or problems and the ability to facilitate understanding and solution development.\r\nHighly skilled analytical and conceptual thinking.\r\nAbility to work effectively in a highly collaborative team environment.\r\nAbility to build and maintain a network of relationships.\r\nStrong work ethic, commitment to meeting deadlines.\r\nDemonstrated initiative, self-starter, with strong analytical and problem solving skills.\r\nResults oriented, this person must have the ability and experience to quickly gain the respect of others within IAT Insurance Group, the industry, and the community in which they exist.\r\nTo qualify, all applicants must be authorized to work in the United States and must not require, now or in the future, VISA sponsorship for employment purposes.\r\nWe are proud to be an EEO/AA employer M/F/D/V. We maintain a drug-free workplace and perform pre-employment substance abuse testing. We participate in E-Verify.\r\n\r\n\r\n\r\nTo be formally considered one must apply online through the IAT Career Site\r\n\r\nIAT Recruiter: \r\n\r\nSteve Morley | Senior Recruiter\r\n\r\nsteve.morley@iatinsurance.com\r\n\r\nwww.linkedin.com/in/stevemorley916\r\n\r\n\r\nIAT Overview:\r\n\r\nIAT Insurance Group (“IAT”) is a privately held global insurance Company, headquartered in Raleigh, North Carolina, providing a wide range of property and casualty insurance products meeting the needs of individuals and businesses. IAT consists of six operating divisions, each sharing the same quality standards, commitment to service and innovation, and an overall mission of excellence. As an organization, we leverage our experienced leadership, sound analytics, proven operating platforms and extensive risk capabilities across the entire enterprise to deliver specialized, sustainable solutions for our customers.\r\n\r\nWith multiple locations throughout the United States, IAT has a large footprint throughout the United States. As a privately owned organization, consisting of more than six hundred employees, we are able to act strategically within an ever-changing marketplace. We are large enough to make a difference in the industry but small enough to be agile and nimble. Our focus includes meeting customer needs and fostering an exceptional agent and broker network to serve clients.', 'KAT Insurance Group', 'Raleigh, NC, US', 'katigroup@usmail.com', '2018-10-10 09:22:22'),
(7, 'Administrative', 'Data Entry Clerk', 'TradeWinds is looking for a Full Time Data Entry Clerk. This person will be responsible for entering reservations from online booking companies and handling any questions that come from them.\r\n*LOCAL RESIDENCY ONLY, PLEASE**\r\nMinimum Requirements:\r\nDemonstrated experience with data entry\r\nProven ability to handle conflict resolution with a pleasant disposition\r\nHotel/Resort experience is preferred\r\nAble to multi task, detail oriented, and strong organizational skills\r\nMust have open availability, including evenings, weekends and holidays, as they are our busiest times\r\nPlease learn more about our beautiful beach resorts at http://www.justletgo.com. \r\n\r\nDFWP/EOE \r\n\r\nEqual Opportunity Employer Minorities/Women/Protected Veterans/Disabled', 'Tradewild Island Resorts', 'Saint Pete Beach, FL, US', 'tiresort@gmail.com', '2018-10-17 15:14:10'),
(8, 'Infromation Technology', 'Senior Java Developer', 'COMPANY OVERVIEW \r\n\r\nTRUSTID helps companies reduce contact center costs, improve the customer experience and increase the efficiency of fraud-fighting efforts\r\n\r\nPOSITION SUMMARY \r\n\r\nTRUSTID is looking for a Java software engineer with experience in building highing, sca technical level role will report directly \r\nDUTIES AND RESPONSIBILITIES\r\nContribute in all phases of the deve in cus impror architectural \r\nBS/MS degree in Computer Science, Engi\r\nHan quecompany\r\nLOCATION\r\nFlexible including working from home', 'TRUSTIT INC.', 'Lake Oswego, OR, US', 'trustit@gmail.com', '2018-08-15 04:13:17'),
(9, 'Engineering', 'Electrical Engineer', 'Sanimax offers relocation packages\r\n\r\nEach day, our Transportation and Logistics teams travel more than 25,000 miles to  year, Sanimax reclaims and brings to its various plants nearly 2 b\r\n\r\nWould you ? Following is the expertise that we are currently looking for.\r\n\r\nSanimax is looking for an Electrical Engineer for all its plants located in the (Green Bay, DeForest and South Saint-Paul) that is based in Green Bay.\r\n\r\nJob summary:\r\n\r\nWe are looking for a very motivated and i systems and industrial instrumentation. The candidate must demonstratrcefulness in order to evolve in a rapidly expanding environment. The candidate will work hao maintain our infrastructure.\r\n\r\n', 'Sanimax', 'Green Bay, US', 'apply@sanimax.com', '2018-11-07 08:51:17'),
(10, 'Media and Communication', 'Boston Celtics Reporter', 'MassLive.com, serving 4.1 million monthly unique visitors and a leading digital media property in Massachusetts, is looking for a full-time Boston Celtics reporter.\r\n\r\nThe Boston Celtics beat reporter will work closely with MassLive\'s sports manager and fellow Celtics reporter to maximize audience growth and community engagement. Specifically, the reporter will be responsible for all aspects of original reporting and packaging digital content: writing, editing, as well as shooting photos & video. In addition, the reporter will be expected to maintain a consistent presence in the community, both in person and on major social media channels such as Facebook and Twitter. You will lead discussions with the audience, answer questions, respond to comments, engage with social media and represent the company on TV or radio.\r\n\r\nJob requirements also include: \r\n\r\n*A Bachelor\'s degree in Journalism, Communications or a related field, or equivalent experience \r\n\r\n*1-2 years of journalism experience with a proven ability in breaking news of significance\r\n*Ability to write iteratively and often;\r\n*Proven ability to report, write clean copy and copy edit (AP style);\r\n*Solid understanding of news writing, journalistic standards and story structure;\r\n*Ability to aggregate from credible sources;\r\n*Ability to work under deadline pressure and prioritize tasks appropriately;\r\n*Experience with SEO best practices;\r\n*Comfort level producing multimedia including digital photography and video; \r\n*Willingness to consistently engage audience on social media and MassLive comment streams;\r\n*Ability to work independently and remotely, while maintaining operational communication with editor.\r\n*Exceptional writing skills and familiarity with AP Style;\r\n*Proficiency in MS Office Suite;\r\n*Experience in Movable Type or equivalent blogging software;\r\n*Early adopter of new technologies, new processes and best practices for creating and maintaining digital content to grow audience;\r\n*Results driven, with experience in a deadline-oriented environment;\r\n*Excellent organizational and critical thinking skills; and\r\n*Ability to work a flexible schedule, including nights, holidays, and weekends. \r\n\r\nEqual Opportunity Employer Minorities/Women/Protected Veterans/Disabled', 'Advance Local', 'Boston, MA, US', 'almedia@gmail.com', '2018-11-02 18:12:28'),
(11, 'Information Technology', 'Android developer', 'dsa fesd fes fe fs dfsd ', 'BTSDigital', 'Respublica avenue, 12', 'btsg@gmail.com', '2018-11-23 13:10:00');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `profile`
--
ALTER TABLE `profile`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `vacancies`
--
ALTER TABLE `vacancies`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(200) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT для таблицы `profile`
--
ALTER TABLE `profile`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT для таблицы `vacancies`
--
ALTER TABLE `vacancies`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `profile`
--
ALTER TABLE `profile`
  ADD CONSTRAINT `profile_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
