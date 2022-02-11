use LinkedinMoodle

create Table [user](
firstName varchar(15) NOT NULL,
lastName varchar(20) NOT NULL,
userID int NOT NULL IDENTITY(1,1),
sex varchar(20),
about varchar(150),
email varchar(50) NOT NULL UNIQUE,
phone varchar(13) NOT NULL UNIQUE,
[address] varchar(50),
birthDate date,
userType varchar(1) 
PRIMARY KEY (userId)
);
create Table sector(
sectorId int NOT NULL IDENTITY(1,1),
sectorName varchar(20) NOT NULL UNIQUE,
PRIMARY KEY (sectorId)
);
create Table [group](
groupId int NOT NULL IDENTITY(1,1),
[name] varchar(50) NOT NULL UNIQUE,
[description] varchar(1000) NOT NULL,
rules varchar(50),
[address] varchar(30),
userId int FOREIGN KEY REFERENCES [user](userId),
sectorId int 
PRIMARY KEY (groupId),
FOREIGN KEY (sectorId) references sector(sectorId)
);
create Table [page](
pageName varchar(50) NOT NULL UNIQUE,
[description] varchar(1000) NOT NULL,
pageId int NOT NULL IDENTITY(1,1),
[address] varchar(50),
size int NOT NULL,
pageType char(1) NOT NULL,
website varchar(30) UNIQUE,
sectorId int NOT NULL,
userId int NOT NULL,
PRIMARY KEY (pageId),
FOREIGN KEY (userId) references [user](userId),
FOREIGN KEY (sectorId) references sector(sectorId)
);
create Table company(
pageId int NOT NULL,
companyType varchar(20) NOT NULL,
PRIMARY KEY (pageId),
FOREIGN KEY (pageId) references [page](pageId),

);
create Table school(
pageId int NOT NULL ,
PRIMARY KEY (pageId),
FOREIGN KEY (pageId) references [page](pageId),
);

create Table [post](
postId  int NOT NULL IDENTITY(1,1),
[description] varchar(1000) NOT NULL,
[date] datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
groupId int,
userId int NOT NULL,
pageId int 
PRIMARY KEY (postId),
FOREIGN KEY (userId ) references [user](userId),
FOREIGN KEY (groupId) references [group](groupId), 
FOREIGN KEY (pageId) references [page](pageId),
);

create Table education(
educationId int NOT NULL IDENTITY(1,1),
major varchar(25),
startDate date,
finishDate date ,
degree varchar(10),
grade float,
userId int NOT NULL,
pageId int NOT NULL,
[description] varchar(1000),
activities varchar(500),
PRIMARY KEY (educationId),
FOREIGN KEY (userId) references [user](userId),
FOREIGN KEY (pageId) references page(pageId)
);
create Table job(
jobId int NOT NULL IDENTITY(1,1),
userId int NOT NULL,
pageId int NOT NULL,
[description] varchar(1000) NOT NULL,
title varchar(50) NOT NULL,
workPlaceType varchar(50) NOT NULL,
[location] varchar(30) NOT NULL,
employmentType varchar(30) NOT NULL,
created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
PRIMARY KEY (jobId),
FOREIGN KEY (userId) references [user](userId),
FOREIGN KEY (pageId) references [page](pageId)
);
create Table [event](
eventId int NOT NULL IDENTITY(1,1),
link varchar(50) UNIQUE,
timeZone varchar(50) NOT NULL,
startDate smalldatetime NOT NULL,
endDate smalldatetime,
[name] varchar(50) NOT NULL,
[description] varchar(1000),
eventType varchar(20) NOT NULL,
userId int NOT NULL
PRIMARY KEY (eventId),
FOREIGN KEY (userId) references [user](userId)
);
create Table myItems(
itemId int NOT NULL IDENTITY(1,1),
userId int NOT NULL
PRIMARY KEY (itemId),
FOREIGN KEY (userId) references [user](userId)
);
create Table tag(
tagId int NOT NULL IDENTITY(1,1),
[name] varchar(20) NOT NULL UNIQUE,
PRIMARY KEY (tagId)
);
create Table comment (
commentId int NOT NULL IDENTITY(1,1),
[date] datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
[description] varchar(1000) NOT NULL,
postId int NOT NULL,
userId int NOT NULL
PRIMARY KEY (commentId),
FOREIGN KEY (userId) references [user](userId),
FOREIGN KEY (postId) references post(postId)
);

create Table skill(
skillId int NOT NULL IDENTITY(1,1),
skillName varchar(20) NOT NULL UNIQUE,
PRIMARY KEY (skillId)
);
create Table experience (
expreienceId int NOT NULL IDENTITY(1,1),
[address] varchar(30),
[description] varchar(1000),
startDate date NOT NULL,
finishDate date,
header varchar(30) NOT NULL,
recruimentType varchar(30),
sectorId int NOT NULL,
userId int NOT NULL,
pageId int NOT NULL
PRIMARY KEY (expreienceId),
FOREIGN KEY (userId) references [user](userId),
FOREIGN KEY (pageId) references page(pageId),
FOREIGN KEY (sectorId) references sector(sectorId)
);
create Table department(
departmentId int NOT NULL IDENTITY(1,1),
pageId int NOT NULL,
[name] varchar(20) NOT NULL UNIQUE,
PRIMARY KEY (departmentId),
FOREIGN KEY (pageId) references page(pageId) 
)
create Table lesson(
lessonId int NOT NULL IDENTITY(1,1),
semester varchar(15) NOT NULL,
lessonName varchar(20) NOT NULL UNIQUE,
groupId int,
userId int NOT NULL,
departmentId int NOT NULL
PRIMARY KEY (lessonId),
FOREIGN KEY (userId) references [user](userId),
FOREIGN KEY (groupId) references [group](groupId),
FOREIGN KEY (departmentId) references department(departmentId)
);
create Table HasPostItem(
postId int NOT NULL,
itemId int NOT NULL
CONSTRAINT PK_HasPostItem PRIMARY KEY (postId,itemId),
FOREIGN KEY (itemId) references myItems(itemId),
FOREIGN KEY (postId) references post(postId)
);
create Table PostTag(
postId int NOT NULL,
tagId int NOT NULL
CONSTRAINT PK_PostTag PRIMARY KEY (postId,tagId),
FOREIGN KEY (tagId) references tag(tagId),
FOREIGN KEY (postId) references post(postId)
)
create Table commentTag(
commentId int NOT NULL,
tagId int NOT NULL
CONSTRAINT PK_commentTag PRIMARY KEY (commentId,tagId),
FOREIGN KEY (tagId) references tag(tagId),
FOREIGN KEY (commentId) references comment(commentId) 
)
create Table lessonDocuments(
lessonId int NOT NULL,
documentsId int NOT NULL IDENTITY(1,1)
CONSTRAINT PK_lessonDocuments PRIMARY KEY (lessonId,documentsId),
FOREIGN KEY (lessonId) references lesson(lessonId) 
)
create Table instructor(
userId int NOT NULL,
departmentId int NOT NULL
PRIMARY KEY (userId),
FOREIGN KEY (departmentId) references department(departmentId),
FOREIGN KEY (userId) references [user](userId)
)
create Table student(
userId int NOT NULL
PRIMARY KEY (userId),
FOREIGN KEY (userId) references [user](userId) 
)
--create Table employee(
--userId int NOT NULL
--PRIMARY KEY (userId),
--FOREIGN KEY (userId) references [user](userId) 
--)

create Table speak(
userId int NOT NULL,
eventId int NOT NULL
CONSTRAINT PK_speak PRIMARY KEY (userId,eventId),
FOREIGN KEY (userId) references [user](userId) ,
FOREIGN KEY (eventId) references event(eventId) 
)
create Table participate(
userId int NOT NULL,
eventId int NOT NULL
CONSTRAINT PK_participate PRIMARY KEY (userId,eventId),
FOREIGN KEY (userId) references [user](userId) ,
FOREIGN KEY (eventId) references event(eventId) 
)
create Table [send](
senderId int NOT NULL,
receiverId int NOT NULL,
[time] datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
content varchar(500) NOT NULL
CONSTRAINT PK_send PRIMARY KEY (senderId,receiverId,[time]),
FOREIGN KEY (senderId) references [user](userId) ,
FOREIGN KEY (receiverId) references [user](userId) 
)
create Table follows(
userId int NOT NULL,
followedUserId int NOT NULL,
CONSTRAINT PK_follows PRIMARY KEY (userId,followedUserId),
FOREIGN KEY (userId) references [user](userId) ,
FOREIGN KEY (followedUserId) references [user](userId) 
)
create Table connection(
userId int NOT NULL,
connectionUserId int NOT NULL,
CONSTRAINT PK_connection PRIMARY KEY (userId,connectionUserId),
FOREIGN KEY (userId) references [user](userId) ,
FOREIGN KEY (connectionUserId) references [user](userId) 
)
create Table followingTag(
userId int NOT NULL,
tagId int NOT NULL,
CONSTRAINT PK_followingTag PRIMARY KEY (userId,tagId),
FOREIGN KEY (userId) references [user](userId) ,
FOREIGN KEY (tagId) references tag(tagId) 
)
create Table likePost(
userId int NOT NULL,
postId int NOT NULL,
CONSTRAINT PK_likePost PRIMARY KEY (userId,postId),
FOREIGN KEY (userId) references [user](userId) ,
FOREIGN KEY (postId) references post(postId) 
)
create Table likeComment(
userId int NOT NULL,
commentId int NOT NULL,
CONSTRAINT PK_likeComment PRIMARY KEY (userId,commentId),
FOREIGN KEY (userId) references [user](userId) ,
FOREIGN KEY (commentId) references comment(commentId) 
)
create Table hasSkill(
userId int NOT NULL,
skillId int NOT NULL,
CONSTRAINT PK_hasSkill PRIMARY KEY (userId,skillId),
FOREIGN KEY (userId) references [user](userId) ,
FOREIGN KEY (skillId) references skill(skillId) 
)

create Table member(
userId int NOT NULL,
groupId int NOT NULL,
CONSTRAINT PK_member PRIMARY KEY (userId,groupId),
FOREIGN KEY (userId) references [user](userId) ,
FOREIGN KEY (groupId) references [group](groupId) 
)
create Table manager(
userId int NOT NULL,
groupId int NOT NULL,
CONSTRAINT PK_manager PRIMARY KEY (userId,groupId),
FOREIGN KEY (userId) references [user](userId) ,
FOREIGN KEY (groupId) references [group](groupId) 
)
create Table takes(
userId int NOT NULL,
lessonId int NOT NULL,
grade int NOT NULL
CONSTRAINT PK_takes PRIMARY KEY (userId,lessonId),
FOREIGN KEY (userId) references [user](userId) ,
FOREIGN KEY (lessonId) references lesson(lessonId) 
)
create Table worksFor(
userId int NOT NULL,
pageId int NOT NULL,
startDate  datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT PK_worksFor PRIMARY KEY (userId,pageId),
FOREIGN KEY (userId) references [user](userId) ,
FOREIGN KEY (pageId) references page(pageId) 
)

INSERT INTO [user]
VALUES 
('Mustafa','Seydaoðullarý','Erkek','abuot',
'mustafa.seydaogullari@hotmail.com','+905466146656','Mardin','1998-05-20','S'),
('Emre','Balkaya','Erkek','abuot',
'emre_balkaya@hotmail.com','+905546059500','Ankara','2000-04-20','S'),
('Ahmet','Karateke','Erkek','about','ahmet.karateke@outlook.com',
'+905350413839','Hatay','1998-02-14','S'),
('Kutay','Avcý','Erkek','about','kutay.avci.4870@gmail.com',
'+905542440736','Muðla','1999-11-20','S'),
('Murat Osman','Ünalýr','Erkek','about','unalir@gmail.com',
'+905325843535','Aydýn','1980-02-15','I'),
('Bill','Gates','Erkek','about','kill_bill@gmail.com',
'+13221512','Washington','1970-12-25',NULL);

INSERT INTO sector
VALUES('Comp Eng'),('Software Eng'),('BackEnd'),('FrontEnd'),
('Full Stack'),('Database');


INSERT INTO[group]
VALUES('Ege Ceng','Ege Computer Engineers',NULL,'Bornova ',1,
(SELECT sectorId FROM sector WHERE sectorName='Comp Eng')),
('Ege Software Eng','Ege Sofware Engineers',NULL,'Bornova ',2,
(SELECT sectorId FROM sector WHERE sectorName='Software Eng')),
('Full Stack Developers','Senior Full Stack Developers',NULL,'Konak ',3,
(SELECT sectorId FROM sector WHERE sectorName='Full Stack')),
('Ege Database Management','Ege Database',NULL,'Bornova ',4,
(SELECT sectorId FROM sector WHERE sectorName='Database')),
('Front-end','Front-end Developers',NULL,'Karþýyaka ',5,
(SELECT sectorId FROM sector WHERE sectorName='FrontEnd')),
('BackEnd Devoloper','Junior BackEnd Developers',NULL,'Karþýyaka ',6,
(SELECT sectorId FROM sector WHERE sectorName='BackEnd')
);



GO
create trigger [ownerTrigger]
on [page]
After insert
as
Begin
INSERT INTO worksFor
VALUES((SELECT TOP 1  userId FROM [page] ORDER BY pageId DESC),
(SELECT TOP 1  pageId FROM [page] ORDER BY pageId DESC),DEFAULT)
End
GO


--GO
--create trigger [employeeTrigger]
--on worksFor
--After insert
--as
--Begin
--INSERT INTO employee
--VALUES((SELECT TOP 1 userId FROM worksFor ORDER BY startDate DESC))
--End
--GO


GO
create trigger [userTypeTrigger]
on worksFor
After insert
as
Begin
if((SELECT userType FROM [user] WHERE userId=(SELECT TOP 1 userId FROM worksFor ORDER BY startDate DESC)) = 'I' )
Begin
UPDATE [user]
SET userType='X'
WHERE userId=(SELECT TOP 1 userId FROM worksFor ORDER BY startDate DESC);
End
else begin
UPDATE [user]
SET userType='E'
WHERE userId=(SELECT TOP 1 userId FROM worksFor ORDER BY startDate DESC);
End
End
GO

INSERT INTO [user]
VALUES('Jeff','Bezos','Erkek','about','jeff_bezos@gmail.com',
'+1324231','Texas','1974-09-21',NULL),
('Emine','Sezer','Kadýn','about','emine.sezer@ege.edu.tr',
'+902323399405','Ýzmir','1984-04-22','I');

INSERT INTO [page]
VALUES('Microsoft','Software Developer Company','USA',10000,'C',NULL,
(SELECT sectorId FROM sector WHERE sectorName='Software Eng'),
(SELECT userId FROM [user] WHERE userId=6));
INSERT INTO [page]
VALUES('Amazon','E-Commerce','USA',15000,'C','amazon.com',
(SELECT sectorId FROM sector WHERE sectorName='Comp Eng'),
(SELECT userId FROM [user] WHERE userId=7));
INSERT INTO [page]
VALUES('Ege Üniversitesi','Ege Üniversitesi Resmi Sayfasý','Ýzmir',5000,'S','ege.bil.müh',
(SELECT sectorId FROM sector WHERE sectorName='Comp Eng'),
(SELECT userId FROM [user] WHERE userId=5));
INSERT INTO [page]
VALUES('9 Eylül Üniversitesi','9 Eylül Üniversitesi Yazýlým Mühendisliði Resmi Sayfasý',
'Ýzmir',4000,'S','dokuzeylul.yazilim.müh',
(SELECT sectorId FROM sector WHERE sectorName='Software Eng'),
(SELECT userId FROM [user] WHERE userId=8));


INSERT INTO [group]
VALUES('Ege Bil Müh Yazýlýmcýlarý','Ege Üniversitesi 1. Sýnýf Yazýlým Öðrencileri Grubu',
'Kural Yok','Bornova',1,
(SELECT sectorId FROM sector WHERE sectorName='Software Eng')),
('Ege Yapay Zeka ','Ege Üniversitesi Yapay Zeka Grubu',
'Bina Ýçinde Maskesiz Dolaþýlmaz!','Konak',2,
(SELECT sectorId FROM sector WHERE sectorName='Comp Eng')),
('9 Eylül Veri Tabaný','9 Eylül Üniversitesi Database Grubu',
'Kural Çok','Týnaztepe',3,
(SELECT sectorId FROM sector WHERE sectorName='Database')),
('Microsoft Çalýþanlarý Türkiye Grubu','Microsoft Türkiye Grubu',
'Toplantýlarda Maske Takmak Zorunludur.','Ýstanbul',4,
(SELECT sectorId FROM sector WHERE sectorName='Software Eng'));


INSERT INTO [event]
VALUES('teams.com.tr','GMT+3','2022-05-20 14:00:00','2022-05-20 16:00:00',
'Mezunlarla Tanýþma','Bölümümüz Mezunlarý Öðrencilerimize Yol Gösteriyor','Online',
(SELECT userId FROM [user] WHERE userId=8)),
(NULL,'GMT+3','2022-02-22 10:00:00','2022-02-22 13:00:00',
'Toplantý','Þirket Toplantýsý, Þirket Binasý 201 Numaralý Toplantý Odasý','Yüz Yüze',
(SELECT userId FROM [user] WHERE userId=7)),
('teams.com','GMT+3','2022-02-03 10:30:00','2022-02-03 11:15:00',
'Proje Kontrolü','Database Proje Kontrolü','Online',
(SELECT userId FROM [user] WHERE userId=5)),
('zoom.com','GMT+3','2022-04-13 12:30:00','2022-04-13 17:15:00',
'Savunma Teknolojileri Semineri','Aselsan Mühendisleri Semineri','Online',
(SELECT userId FROM [user] WHERE userId=4));



INSERT INTO [post]
VALUES ('Hava bugün çok güzel','2022-02-01 09:30:00',NULL,
(SELECT userId FROM [user] WHERE userId=1),NULL),
('Aselsan Toplantýsý Çýkýþý','2022-04-13 17:30:00',
(SELECT groupId FROM [group] WHERE groupId=3),
(SELECT userId FROM [user] WHERE userId=5),
(SELECT pageId FROM [page] WHERE pageId=4)),
('Güzel bir toplantý oldu','2022-02-09 14:30:00',
(SELECT groupId FROM [group] WHERE groupId=6),
(SELECT userId FROM [user] WHERE userId=8),
(SELECT pageId FROM [page] WHERE pageId=5)),
('Amazondan gelen ürün kýrýk çýktý','2022-01-21 14:35:10',NULL,
(SELECT userId FROM [user] WHERE userId=4),
(SELECT groupId FROM [group] WHERE groupId=10));

INSERT INTO [comment]
VALUES('2022-02-01 09:45:00','Bizim burasý çok soðuk',
(SELECT postId FROM [post] WHERE postId=1),
(SELECT userId FROM [user] WHERE userId=2)),
('2022-02-01 09:55:35','Akþama proje için toplanýyoruz deðil mi?',
(SELECT postId FROM [post] WHERE postId=1),
(SELECT userId FROM [user] WHERE userId=4)),
('2022-02-09 15:30:11','Verimli bir toplantýydý.',
(SELECT postId FROM [post] WHERE postId=2),
(SELECT userId FROM [user] WHERE userId=5)),
('2022-02-09 14:30:00','Sonunda bitti.',
(SELECT postId FROM [post] WHERE postId=3),
(SELECT userId FROM [user] WHERE userId=5)),
('2022-01-21 14:35:10','Hemen maðduriyetinizi gideriyoruz.',
(SELECT postId FROM [post] WHERE postId=4),
(SELECT userId FROM [user] WHERE userId=7))

INSERT INTO[member]
VALUES((SELECT userId FROM [user] WHERE userId=1),
(SELECT groupId FROM [group] WHERE groupId=3)),

((SELECT userId FROM [user] WHERE userId=1),
(SELECT groupId FROM [group] WHERE groupId=4)),

((SELECT userId FROM [user] WHERE userId=1),
(SELECT groupId FROM [group] WHERE groupId=6)),

((SELECT userId FROM [user] WHERE userId=1),
(SELECT groupId FROM [group] WHERE groupId=10)),

((SELECT userId FROM [user] WHERE userId=3),
(SELECT groupId FROM [group] WHERE groupId=5)),

((SELECT userId FROM [user] WHERE userId=3),
(SELECT groupId FROM [group] WHERE groupId=7)),

((SELECT userId FROM [user] WHERE userId=4),
(SELECT groupId FROM [group] WHERE groupId=8)),

((SELECT userId FROM [user] WHERE userId=5),
(SELECT groupId FROM [group] WHERE groupId=6)),

((SELECT userId FROM [user] WHERE userId=2),
(SELECT groupId FROM [group] WHERE groupId=3)),

((SELECT userId FROM [user] WHERE userId=2),
(SELECT groupId FROM [group] WHERE groupId=2)),

((SELECT userId FROM [user] WHERE userId=6),
(SELECT groupId FROM [group] WHERE groupId=1)),

((SELECT userId FROM [user] WHERE userId=8),
(SELECT groupId FROM [group] WHERE groupId=9))



--CONNECTION TABLE DATA INSERTION
INSERT INTO connection
VALUES(1,3);
INSERT INTO connection
VALUES(4,3);
INSERT INTO connection
VALUES(2,1);
INSERT INTO connection
VALUES(5,4);
INSERT INTO connection
VALUES(1,8);
INSERT INTO connection
VALUES(1,4);
INSERT INTO connection
VALUES(3,5);
INSERT INTO connection
VALUES(2,3);
INSERT INTO connection
VALUES(4,2);
INSERT INTO connection
VALUES(4,6);
INSERT INTO connection
VALUES(4,2);
INSERT INTO connection
VALUES(7,2);

--FOLLOWS TABLE DATA INSERTION
INSERT INTO follows
VALUES(1,3);
INSERT INTO follows
VALUES(3,1);
INSERT INTO follows
VALUES(2,1);
INSERT INTO follows
VALUES(5,4);
INSERT INTO follows
VALUES(1,4);
INSERT INTO follows
VALUES(4,2);
INSERT INTO follows
VALUES(3,5);
INSERT INTO follows
VALUES(2,3);
INSERT INTO follows
VALUES(4,1);
INSERT INTO follows
VALUES(4,6);
INSERT INTO follows
VALUES(4,8);
INSERT INTO follows
VALUES(2,7);


-- USER DATA INSERTION 
ALTER  TABLE [user] ALTER COLUMN about varchar(150);
ALTER TABLE [user] ALTER COLUMN sex varchar(20);


insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Lillian', 'Philbrick', 'Male', 'metus vitae ipsum aliquam', 'lphilbrick0@netscape.com', '339 731 7401', '2 Gateway Trail', '1957-10-15', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Susanne', 'Skipp', 'Male', 'eu est', 'sskipp1@mysql.com', '191 628 3272', '452 Blackbird Junction', '1962-04-29', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Joycelin', 'Klugel', 'Female', null, 'jklugel2@edublogs.org', '619 746 9096', '5203 Dorton Lane', '1991-05-29', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Randolph', 'Hardwell', 'Male', 'vestibulum velit id', 'rhardwell3@dedecms.com', '996 483 6710', '943 Havey Lane', '1982-10-21', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Hanna', 'Adanet', 'Male', 'luctus nec molestie sed justo pellentesque viverra', 'hadanet4@csmonitor.com', '223 901 8626', '40864 Nova Drive', '2003-09-01', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Eberto', 'Pendleberry', 'Female', 'aliquet maecenas leo odio condimentum id luctus', 'ependleberry5@ycombinator.com', '783 593 1710', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Robinet', 'Ballsdon', 'Male', 'consequat', 'rballsdon6@github.com', '716 621 9296', '829 Eggendart Street', '1956-12-08', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Elsy', 'Godthaab', 'Male', null, 'egodthaab7@ibm.com', '105 510 1476', '7 North Avenue', '1998-05-14', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Ediva', 'Bendig', 'Female', 'sit amet nulla quisque', 'ebendig8@blogs.com', '969 433 7702', '8724 Meadow Vale Crossing', '1997-09-30', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Caty', 'Bryson', 'Female', 'nibh in lectus pellentesque at nulla', 'cbryson9@admin.ch', '978 246 0113', '31 Magdeline Pass', '1987-04-02', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Oralie', 'Ayers', 'Non-binary', 'ante ipsum primis in faucibus orci luctus et', 'oayersa@miibeian.gov.cn', '206 369 4284', '650 Glacier Hill Plaza', '1990-05-09', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Guy', 'Marder', 'Male', 'viverra pede ac diam cras', 'gmarderb@ucla.edu', '933 997 3059', '484 Bluestem Park', '1982-02-08', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Vicki', 'Bootes', 'Male', 'varius integer ac leo pellentesque ultrices', 'vbootesc@cloudflare.com', '173 549 0117', null, null, null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Domenico', 'Gladstone', 'Female', null, 'dgladstoned@newyorker.com', '678 728 8873', '0 Village Place', '1963-08-14', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Virginia', 'Tyas', 'Female', 'ipsum ac tellus semper', 'vtyase@tuttocitta.it', '596 840 1395', '48 Transport Junction', '1975-07-12', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Francine', 'Cullington', 'Male', 'sagittis dui vel nisl duis ac nibh fusce lacus', 'fcullingtonf@fema.gov', '953 921 0476', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Rebekah', 'Cockshut', 'Female', '', 'rcockshutg@cbsnews.com', '996 148 4442', '275 Merchant Junction', '1970-10-20', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Welby', 'Tomet', 'Male', 'tincidunt lacus at velit', 'wtometh@digg.com', '422 249 9307', '377 Bay Court', '1973-12-06', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Kirby', 'Bleibaum', 'Female', 'ac neque duis bibendum morbi non quam', 'kbleibaumi@prnewswire.com', '221 531 4593', '75288 Jay Drive', '1993-04-25', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Rosie', 'Cucuzza', 'Male', null, 'rcucuzzaj@networksolutions.com', '319 893 8374', '88613 Dennis Alley', '2001-08-26', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Harmon', 'Linke', 'Female', 'lacinia erat vestibulum sed magna at nunc commodo', 'hlinkek@accuweather.com', '410 658 5243', '237 Prairie Rose Avenue', '1979-10-26', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Mohandas', 'Pringuer', 'Female', 'morbi ut odio cras mi pede malesuada', 'mpringuerl@berkeley.edu', '910 395 4096', '28315 Hagan Pass', '1959-09-05', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Mignon', 'Rigg', 'Genderqueer', 'nisl duis bibendum', 'mriggm@un.org', '213 122 9177', null, null, null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Gregorio', 'Wey', 'Female', 'tellus', 'gweyn@imdb.com', '769 231 3556', '00877 Prairieview Avenue', '1969-05-21', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Marne', 'Sket', 'Male', '', 'msketo@cloudflare.com', '217 861 5659', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Rossy', 'Gawen', 'Female', 'non', 'rgawenp@eepurl.com', '863 114 2153', '26 West Lane', '1954-05-28', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Turner', 'Derisley', null, '', 'tderisleyq@wikipedia.org', '115 530 3655', '41326 Annamark Park', '1980-04-06', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Augustine', 'Drable', 'Non-binary', null, 'adrabler@google.cn', '381 812 6534', '5 Blackbird Pass', '1968-04-07', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Hilarius', 'Ghidetti', 'Female', 'odio consequat varius integer ac leo pellentesque', 'hghidettis@foxnews.com', '960 618 3565', '164 Shopko Drive', '1992-01-26', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Angelina', 'Whisker', 'Female', 'turpis adipiscing', 'awhiskert@hatena.ne.jp', '756 360 4934', '7 Welch Trail', '1986-11-07', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Torie', 'Bellhanger', 'Polygender', 'nisl duis bibendum felis sed', 'tbellhangeru@netlog.com', '435 899 4271', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Susan', 'Mc Meekan', 'Male', 'non sodales sed tincidunt eu felis fusce posuere', 'smcmeekanv@vinaora.com', '825 227 4791', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Jere', 'Cowdrey', 'Male', 'non sodales sed tincidunt eu felis fusce', 'jcowdreyw@vinaora.com', '588 884 6627', '523 Northridge Hill', '1986-10-12', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Luelle', 'Bertie', 'Male', 'pede lobortis ligula sit amet eleifend pede libero quis', 'lbertiex@wufoo.com', '223 372 3813', '25 Dryden Point', '1959-01-14', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Matthaeus', 'Feldstern', 'Female', 'quam sollicitudin vitae consectetuer eget rutrum at', 'mfeldsterny@discuz.net', '548 834 6396', null, null, null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Bastian', 'Querree', 'Female', 'luctus', 'bquerreez@etsy.com', '286 989 6067', '010 Goodland Pass', '2001-02-11', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Stepha', 'Wenger', 'Male', 'felis sed', 'swenger10@xinhuanet.com', '122 444 3835', '393 Badeau Center', '2001-07-24', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Ruddy', 'O''Hallihane', 'Female', 'dapibus dolor vel est donec odio justo sollicitudin', 'rohallihane11@google.cn', '998 955 3995', '5067 Kingsford Pass', '1981-03-05', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Berkeley', 'Petti', 'Male', 'blandit lacinia erat vestibulum', 'bpetti12@artisteer.com', '375 196 9257', '5919 Haas Lane', '1989-05-20', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Felic', 'Robinette', 'Female', 'at lorem integer tincidunt ante vel ipsum', 'frobinette13@symantec.com', '628 724 0513', '428 Montana Trail', '1973-11-29', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Barbi', 'Tamblyn', 'Male', 'habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam', 'btamblyn14@indiatimes.com', '767 732 8419', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Drud', 'Elderbrant', 'Female', 'nam dui proin leo', 'delderbrant15@icio.us', '375 173 7357', '92181 Main Plaza', '1992-09-09', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Hayyim', 'Cresser', 'Male', null, 'hcresser16@edublogs.org', '827 447 5495', '0265 Kropf Street', '1978-10-09', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Wilfrid', 'Vampouille', 'Female', null, 'wvampouille17@ebay.co.uk', '682 590 8000', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Frederica', 'Armsden', 'Male', 'ultrices aliquet maecenas leo odio condimentum id', 'farmsden18@chron.com', '964 719 5641', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Bambi', 'Devonish', 'Non-binary', 'enim in tempor turpis nec euismod', 'bdevonish19@nhs.uk', '202 246 3450', '9054 Briar Crest Pass', '1952-10-30', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Kahlil', 'Fulker', 'Female', 'elementum in hac habitasse platea dictumst morbi vestibulum', 'kfulker1a@toplist.cz', '636 268 4810', '80964 Burning Wood Avenue', '1995-08-11', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Orlan', 'Catterill', 'Female', 'quis turpis sed ante', 'ocatterill1b@constantcontact.com', '489 678 5465', '3 Schiller Court', '1983-09-04', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Freida', 'Attac', 'Polygender', 'lobortis convallis tortor risus dapibus', 'fattac1c@fotki.com', '233 758 0444', '6 Holmberg Parkway', '1956-03-22', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('York', 'Orbine', 'Genderqueer', '', 'yorbine1d@latimes.com', '700 469 4278', '41 Susan Junction', '1988-07-28', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Nesta', 'Hazel', 'Male', 'lobortis vel', 'nhazel1e@gov.uk', '332 889 5372', '4870 Springs Street', '1992-12-05', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Elihu', 'Ramirez', 'Female', 'amet eleifend pede libero quis orci nullam molestie', 'eramirez1f@fastcompany.com', '481 611 9512', null, null, null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Poul', 'Gudeman', 'Female', 'blandit mi in porttitor pede justo eu massa donec', 'pgudeman1g@bigcartel.com', '656 975 9690', '19 Westend Junction', '2004-10-06', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Pen', 'Pallas', null, 'mauris enim leo rhoncus sed vestibulum sit', 'ppallas1h@booking.com', '397 582 9283', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Cris', 'Iiannone', 'Male', 'metus aenean fermentum donec ut mauris eget massa', 'ciiannone1i@cnn.com', '848 934 7260', '570 Monica Drive', '1975-11-24', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Ronni', 'Alen', 'Female', 'cubilia', 'ralen1j@edublogs.org', '607 589 1077', '8236 Surrey Trail', '1982-10-15', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Luca', 'Verni', 'Female', 'at velit eu est congue elementum in', 'lverni1k@163.com', '328 895 5336', '203 Bayside Park', '2002-06-25', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Cristiano', 'Vasey', 'Male', null, 'cvasey1l@paypal.com', '868 210 2030', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Gerry', 'Drover', 'Female', '', 'gdrover1m@earthlink.net', '179 236 1477', '6 Meadow Valley Court', '1989-05-05', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Auberta', 'McEvay', 'Female', 'amet erat nulla tempus', 'amcevay1n@epa.gov', '481 117 1072', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Marcie', 'Dissman', 'Female', 'libero', 'mdissman1o@yolasite.com', '747 782 0393', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Niall', 'Crockatt', 'Female', 'ipsum primis in faucibus orci luctus et ultrices posuere', 'ncrockatt1p@biglobe.ne.jp', '240 787 1185', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Leanora', 'Salzburger', 'Male', 'at velit eu est', 'lsalzburger1q@nbcnews.com', '342 776 6870', '75 Del Sol Point', '1987-01-26', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Elia', 'Dorian', 'Male', 'consectetuer adipiscing elit proin risus praesent', 'edorian1r@mac.com', '586 893 9331', '1964 Florence Hill', '1969-09-11', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Norma', 'McIlroy', 'Male', null, 'nmcilroy1s@typepad.com', '714 756 3124', '0896 Northwestern Lane', '1968-12-29', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Heda', 'Curtis', 'Male', null, 'hcurtis1t@who.int', '927 206 2612', '73 Oneill Crossing', '1950-03-29', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Haywood', 'Axleby', 'Male', 'a nibh in quis justo maecenas rhoncus', 'haxleby1u@gizmodo.com', '131 514 0582', '347 Summer Ridge Alley', '1994-02-21', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Benoite', 'Sowman', 'Female', 'molestie hendrerit at vulputate vitae nisl aenean', 'bsowman1v@nbcnews.com', '294 778 0633', '2958 Talmadge Avenue', '1956-03-04', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Doti', 'Jahnig', 'Male', 'venenatis non sodales', 'djahnig1w@ow.ly', '977 812 4201', '098 Buhler Junction', '1964-10-03', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Bethanne', 'Hightown', 'Male', null, 'bhightown1x@pcworld.com', '622 514 5386', '05146 Thompson Avenue', '1983-07-20', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Tallie', 'Gallego', 'Male', 'dictumst maecenas ut massa', 'tgallego1y@dion.ne.jp', '563 945 8125', '09 Village Green Place', '1997-12-07', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Hali', 'Drover', 'Male', 'turpis', 'hdrover1z@oaic.gov.au', '190 592 3839', '0 Crowley Circle', '1955-02-14', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Sol', 'Pesak', 'Female', 'semper', 'spesak20@google.ru', '835 952 7576', null, null, null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Myrlene', 'Houston', 'Female', 'hac habitasse platea dictumst aliquam augue', 'mhouston21@ox.ac.uk', '540 680 0249', '7 Memorial Place', '2002-03-10', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Tam', 'Pruvost', null, null, 'tpruvost22@squarespace.com', '947 809 7726', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Toinette', 'Tetlow', 'Male', 'purus sit amet nulla quisque arcu libero rutrum ac', 'ttetlow23@macromedia.com', '957 723 6637', null, null, null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Alfi', 'Melluish', 'Male', 'lacinia sapien quis libero nullam sit amet turpis elementum', 'amelluish24@go.com', '433 950 6723', '59393 Fremont Parkway', '2006-04-10', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Koralle', 'Arnald', 'Female', '', 'karnald25@aboutads.info', '127 305 1865', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Sigfrid', 'Terren', 'Female', 'est congue elementum in hac habitasse platea dictumst', 'sterren26@opensource.org', '987 284 9885', '4 Ruskin Lane', '1979-09-04', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Biddie', 'Nendick', 'Male', 'sit amet nunc viverra dapibus nulla suscipit ligula', 'bnendick27@istockphoto.com', '598 472 0263', '71 Huxley Plaza', '1955-07-06', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Deerdre', 'Lillywhite', 'Male', 'pede', 'dlillywhite28@ameblo.jp', '103 431 4559', '73873 Little Fleur Park', '1987-06-13', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Zerk', 'O''Fielly', 'Polygender', 'curae nulla dapibus dolor vel', 'zofielly29@alexa.com', '509 829 3564', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Anabelle', 'Pavis', 'Male', 'hac habitasse', 'apavis2a@sciencedaily.com', '838 390 1622', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Hedda', 'Fredi', 'Male', 'tortor eu pede', 'hfredi2b@amazon.co.jp', '639 618 8033', '4 Aberg Plaza', '1995-06-05', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Erie', 'Robjohns', 'Female', 'eu mi nulla ac enim', 'erobjohns2c@si.edu', '481 685 3861', '99605 Mesta Terrace', '2002-01-09', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Berkly', 'Gillam', null, 'lorem quisque ut erat curabitur', 'bgillam2d@earthlink.net', '913 322 3640', '142 Ohio Court', '1986-01-31', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Dianna', 'Robertucci', 'Male', null, 'drobertucci2e@photobucket.com', '803 135 2971', '1453 Dunning Road', '2000-02-18', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Doria', 'Ommanney', 'Male', 'magnis dis parturient montes nascetur ridiculus mus etiam vel augue', 'dommanney2f@wisc.edu', '840 536 1501', null, null, null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Kassey', 'Gjerde', 'Male', null, 'kgjerde2g@tumblr.com', '827 196 6702', '00195 Everett Hill', '1953-11-01', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Tristan', 'Pochon', 'Genderqueer', null, 'tpochon2h@thetimes.co.uk', '128 721 5491', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Gill', 'Marvelley', 'Female', '', 'gmarvelley2i@sphinn.com', '543 743 0350', '5312 Old Shore Court', '2004-04-09', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Charissa', 'Elsop', 'Female', 'vestibulum eget vulputate ut ultrices', 'celsop2j@miitbeian.gov.cn', '364 680 8632', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Jasun', 'Connors', 'Male', null, 'jconnors2k@youtu.be', '237 611 3159', null, null, null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Lyndell', 'Tatlock', 'Male', 'suscipit ligula in lacus curabitur at ipsum', 'ltatlock2l@godaddy.com', '323 759 8292', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Harriot', 'Bragg', null, null, 'hbragg2m@livejournal.com', '361 482 4635', '8998 Messerschmidt Parkway', '1960-07-29', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Chaunce', 'Stickells', null, 'pede ac diam cras', 'cstickells2n@bravesites.com', '379 705 6694', '9 Kropf Junction', '1963-02-25', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Meredith', 'Standering', 'Male', 'turpis enim blandit mi', 'mstandering2o@dyndns.org', '785 565 0639', '4 Comanche Trail', '1991-10-17', 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Skylar', 'Beeck', 'Female', 'quis lectus suspendisse potenti in eleifend quam a odio in', 'sbeeck2p@forbes.com', '510 612 3194', '82689 Susan Hill', '1976-09-26', null);
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Melicent', 'Johansen', 'Male', 'varius integer ac leo pellentesque ultrices', 'mjohansen2q@cargocollective.com', '558 981 9998', null, null, 'I');
insert into [user] (firstName, lastName, sex, about, email, phone, address, birthDate, userType) values ('Juli', 'Razzell', 'Female', 'ut massa quis augue luctus tincidunt nulla mollis molestie', 'jrazzell2r@altervista.org', '642 800 2119', '9 Luster Junction', '1952-11-23', null);


-- PAGE DATA INSERTION


insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Demimbu', 'eget vulputate ut ultrices vel augue vestibulum ante ipsum', '29 Cody Park', 7280, 'C', 'http://fema.gov', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Demizz', 'ligula in lacus curabitur', '87493 Twin Pines Trail', 2199, 'C', 'http://sbwire.com', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userID FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Realcube', 'vivamus in felis eu sapien cursus vestibulum proin eu', null, 3489, 'C', null, (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Oyoba', 'orci luctus', '861 Bashford Crossing', 7320, 'C', 'https://mapy.cz', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Meezzy', 'nisl venenatis lacinia aenean sit amet justo morbi', null, 5847, 'C', 'http://shop-pro.jp', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Aimbo', 'curae duis faucibus accumsan odio curabitur convallis duis', '824 Dakota Circle', 1528, 'C', '', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Wordtune', 'amet diam in magna', '130 Londonderry Parkway', 5114, 'C', 'http://webs.com', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Wikizz', 'gravida', '409 Lawn Avenue', 9181, 'C', 'http://washingtonpost.com', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Yodoo', 'id consequat in consequat ut nulla sed accumsan felis', null, 2797, 'C', 'http://amazonaws.com', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Twitterbeat', 'quisque arcu libero rutrum ac lobortis vel dapibus', '7666 Katie Street', 8870, 'C','.', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] WHERE userType is null ));


insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Lander University', 'luctus rutrum', '20 Montana Hill', 4684, 'S', 'https://shutterfly.com',(SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()),(SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Universidad Popular de Nicaragua (UPONIC)', 'rhoncus dui vel sem sed sagittis', '3 Lunder Way', 745, 'S', 'https://toplist.cz',(SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()),(SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Escuela Politécnica de Chimborazo', 'turpis nec euismod scelerisque quam turpis adipiscing lorem', '526 Cherokee Crossing', 2204, 'S', 'http://narod.ru',(SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()),(SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Universidad Nacional Pedro Ruíz Gallo', 'eleifend quam a odio in', null, 5993, 'S', 'http://nhs.uk',(SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()),(SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Universidad La Salle', 'diam id', '3 Golden Leaf Court', 6638, 'S', 'https://1688.com',(SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()),(SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Guilford College', 'neque duis bibendum morbi non quam nec dui', '5 Pawling Way', 2002, 'S', 'http://nhs.uk',(SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()),(SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Dokkyo University School of Medicine', 'pulvinar sed', '899 Village Green Lane', 4382, 'S', 'http://un.org',(SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()),(SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('COMSATS Institute of Information Technology', '', null, 1042, 'S', 'https://techcrunch.com',(SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()),(SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('Detroit College of Law', 'enim lorem ipsum dolor sit amet consectetuer adipiscing', '4128 Pond Pass', 3475, 'S', 'https://istockphoto.com',(SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()),(SELECT TOP 1 userId FROM [user] WHERE userType is null ));
insert into [page] (pageName, description, address, size, pageType, website, sectorId, userId) values ('South China University of Technology', 'et ultrices posuere cubilia curae nulla', '0479 Banding Place', 9359, 'S', 'https://blogs.com',(SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()),(SELECT TOP 1 userId FROM [user] WHERE userType is null ));


--Education data insertion

insert into [education] (major, startDate, finishDate, degree, grade, userId, pageId, description, activities) values ('Accounting', '2004-12-09', null, 'Master', null, (SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] WHERE pageType = 'S' ORDER BY NEWID()), 'nibh quisque id justo sit amet', '');
insert into [education] (major, startDate, finishDate, degree, grade, userId, pageId, description, activities) values ('Accounting', '2009-04-01', '1997-01-19', 'Bachelors', null, (SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] WHERE pageType = 'S' ORDER BY NEWID()), 'maecenas leo odio condimentum id luctus nec', 'turpis nec euismod scelerisque quam');
insert into [education] (major, startDate, finishDate, degree, grade, userId, pageId, description, activities) values ('Accounting', '1980-05-10', null, 'Bachelors', 4, (SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] WHERE pageType = 'S' ORDER BY NEWID()), 'arcu libero rutrum ac lobortis vel dapibus', '');
insert into [education] (major, startDate, finishDate, degree, grade, userId, pageId, description, activities) values ('Marketing', '2019-03-24', '1999-12-27', null, 1, (SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] WHERE pageType = 'S' ORDER BY NEWID()), 'faucibus cursus urna ut tellus nulla ut erat', 'venenatis non sodales sed tincidunt eu felis fusce');
insert into [education] (major, startDate, finishDate, degree, grade, userId, pageId, description, activities) values ('Support', '2011-01-23', '1999-04-19', 'Master', 1, (SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] WHERE pageType = 'S' ORDER BY NEWID()), 'pellentesque quisque porta volutpat erat quisque erat eros viverra', 'eros vestibulum ac est lacinia');
insert into [education] (major, startDate, finishDate, degree, grade, userId, pageId, description, activities) values ('Engineering', '2000-11-08', '1988-04-12', 'Bachelors', 5, (SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT  TOP 1 pageId FROM [page] WHERE pageType = 'S' ORDER BY NEWID()), 'consequat lectus in est risus auctor sed tristique', '');
insert into [education] (major, startDate, finishDate, degree, grade, userId, pageId, description, activities) values ('Marketing', '1998-06-30', '1986-12-23', null, 6, (SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] WHERE pageType = 'S' ORDER BY NEWID()), 'ac nulla sed vel enim sit amet nunc', 'consequat in');
insert into [education] (major, startDate, finishDate, degree, grade, userId, pageId, description, activities) values ('Engineering', '2019-02-07', null, 'Bachelors', null, (SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] WHERE pageType = 'S' ORDER BY NEWID()), 'a libero nam', 'rutrum ac lobortis vel dapibus');
insert into [education] (major, startDate, finishDate, degree, grade, userId, pageId, description, activities) values ('Accounting', '2019-09-05', null, 'Master', null, (SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] WHERE pageType = 'S' ORDER BY NEWID()), 'eget', 'pretium nisl ut volutpat sapien arcu sed augue aliquam');
insert into [education] (major, startDate, finishDate, degree, grade, userId, pageId, description, activities) values ('Research and Development', '2015-04-12', null, 'Bachelors', 3, (SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] WHERE pageType = 'S' ORDER BY NEWID()), 'scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec', 'tincidunt eget tempus vel pede morbi porttitor lorem id');

--Post data insertion

insert into [post] ([description], [date], groupId, userId, pageId) values ('phasellus id sapien in',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('est et tempus semper est quam pharetra magna ac consequat',DEFAULT, (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()));
insert into [post] ([description], [date], groupId, userId, pageId) values ('',DEFAULT, (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()));
insert into [post] ([description], [date], groupId, userId, pageId) values ('curabitur convallis duis consequat dui',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('consequat in consequat ut nulla sed accumsan felis ut',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('tristique in tempus sit amet sem fusce consequat nulla nisl',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('cras pellentesque volutpat',DEFAULT, (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()));
insert into [post] ([description], [date], groupId, userId, pageId) values ('aliquam sit amet diam in magna bibendum imperdiet nullam orci',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('',DEFAULT, (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()));
insert into [post] ([description], [date], groupId, userId, pageId) values ('donec diam neque vestibulum eget vulputate ut ultrices',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('vivamus in',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('nulla sed vel enim sit amet nunc viverra dapibus nulla',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('augue vestibulum ante',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('habitasse platea dictumst maecenas ut massa quis augue',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('lectus aliquam sit amet',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('ut tellus nulla ut erat id mauris vulputate elementum nullam',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('rhoncus aliquam lacus morbi quis tortor id nulla',DEFAULT, (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()));
insert into [post] ([description], [date], groupId, userId, pageId) values ('commodo placerat praesent',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('dui luctus rutrum nulla',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('maecenas tristique est',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('lacus at turpis',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('metus vitae ipsum aliquam non mauris morbi non lectus',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('pretium quis lectus',DEFAULT, (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()));
insert into [post] ([description], [date], groupId, userId, pageId) values ('',DEFAULT, (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()));
insert into [post] ([description], [date], groupId, userId, pageId) values ('lobortis sapien sapien non mi',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('hac habitasse',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('mi in porttitor pede justo',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('sit amet consectetuer adipiscing elit proin interdum mauris non ligula',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('',DEFAULT, (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()));
insert into [post] ([description], [date], groupId, userId, pageId) values ('nibh in quis justo maecenas rhoncus aliquam lacus morbi',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('et commodo',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('accumsan odio curabitur convallis duis consequat dui nec nisi volutpat',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('pellentesque',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('eget nunc',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('nulla',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('quam fringilla rhoncus',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('ut massa',DEFAULT, (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()));
insert into [post] ([description], [date], groupId, userId, pageId) values ('imperdiet nullam orci pede venenatis',DEFAULT, (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()));
insert into [post] ([description], [date], groupId, userId, pageId) values ('mauris vulputate elementum nullam',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('venenatis',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('auctor',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('consectetuer adipiscing elit proin risus praesent lectus vestibulum quam',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('nibh in quis justo maecenas rhoncus aliquam lacus',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('volutpat convallis morbi odio odio elementum eu interdum eu tincidunt',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('odio donec vitae nisi nam ultrices libero non mattis',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('amet sapien dignissim vestibulum vestibulum ante ipsum primis in',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('posuere metus vitae ipsum aliquam non',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);
insert into [post] ([description], [date], groupId, userId, pageId) values ('neque libero convallis',DEFAULT, null, (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), null);


---Tag Data insertion
insert into [tag] (name) values ('nec');
insert into [tag] (name) values ('donec');
insert into [tag] (name) values ('libero');
insert into [tag] (name) values ('suscipit');
insert into [tag] (name) values ('massa');
insert into [tag] (name) values ('pede');
insert into [tag] (name) values ('interdum');
insert into [tag] (name) values ('arcu');
insert into [tag] (name) values ('integer');
insert into [tag] (name) values ('lacus');
insert into [tag] (name) values ('luctus');
insert into [tag] (name) values ('in');
insert into [tag] (name) values ('orci');
insert into [tag] (name) values ('diam');
insert into [tag] (name) values ('sit');
insert into [tag] (name) values ('ac');
insert into [tag] (name) values ('pede');
insert into [tag] (name) values ('vivamus');
insert into [tag] (name) values ('in');
insert into [tag] (name) values ('vulputate');
insert into [tag] (name) values ('pede');
insert into [tag] (name) values ('mauris');
insert into [tag] (name) values ('et');
insert into [tag] (name) values ('rhoncus');
insert into [tag] (name) values ('pharetra');
insert into [tag] (name) values ('nibh');
insert into [tag] (name) values ('nulla');
insert into [tag] (name) values ('adipiscing');
insert into [tag] (name) values ('elementum');
insert into [tag] (name) values ('hac');

--PostTag data insertion
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [postTag] (postId, tagId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));




--COMMENT DATA INSERTION

insert into [comment] (date, description, postId, userId) values (DEFAULT, 'id nulla ultrices aliquet maecenas leo odio', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'aliquam sit amet diam in magna bibendum imperdiet nullam', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'rutrum rutrum', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'duis aliquam convallis nunc proin at turpis a', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'duis bibendum felis', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'convallis nulla neque libero convallis eget eleifend', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'orci luctus et ultrices posuere', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'suspendisse ornare consequat lectus in est', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'vivamus in felis eu sapien cursus vestibulum', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'non velit donec diam neque', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'varius ut blandit non interdum in', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'varius integer ac', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'libero nam dui proin leo odio porttitor id consequat', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'cubilia curae', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'mauris lacinia sapien quis libero', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'massa id nisl venenatis', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'mollis molestie lorem quisque ut erat', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'blandit', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'vitae nisl aenean lectus pellentesque eget nunc donec quis orci', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'maecenas rhoncus aliquam lacus morbi quis tortor id', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'at nulla suspendisse potenti cras in purus', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'pede posuere nonummy', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'et ultrices posuere cubilia curae donec', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'amet', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'velit donec diam neque vestibulum eget vulputate ut ultrices vel', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'duis aliquam convallis nunc proin at turpis a', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'mauris morbi non lectus aliquam sit', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'ut mauris eget massa', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'id luctus nec', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [comment] (date, description, postId, userId) values (DEFAULT, 'risus semper porta volutpat quam pede lobortis ligula', (SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));





--COMMENT TAG DATA INSERTION

insert into [commentTag] (commentId, tagId) values ((SELECT TOP 1 commentId FROM [comment] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [commentTag] (commentId, tagId) values ((SELECT TOP 1 commentId FROM [comment] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [commentTag] (commentId, tagId) values ((SELECT TOP 1 commentId FROM [comment] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [commentTag] (commentId, tagId) values ((SELECT TOP 1 commentId FROM [comment] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [commentTag] (commentId, tagId) values ((SELECT TOP 1 commentId FROM [comment] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [commentTag] (commentId, tagId) values ((SELECT TOP 1 commentId FROM [comment] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [commentTag] (commentId, tagId) values ((SELECT TOP 1 commentId FROM [comment] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [commentTag] (commentId, tagId) values ((SELECT TOP 1 commentId FROM [comment] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [commentTag] (commentId, tagId) values ((SELECT TOP 1 commentId FROM [comment] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [commentTag] (commentId, tagId) values ((SELECT TOP 1 commentId FROM [comment] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [commentTag] (commentId, tagId) values ((SELECT TOP 1 commentId FROM [comment] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [commentTag] (commentId, tagId) values ((SELECT TOP 1 commentId FROM [comment] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [commentTag] (commentId, tagId) values ((SELECT TOP 1 commentId FROM [comment] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [commentTag] (commentId, tagId) values ((SELECT TOP 1 commentId FROM [comment] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [commentTag] (commentId, tagId) values ((SELECT TOP 1 commentId FROM [comment] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));


--DEPARTMENT DATA INSERTION


declare @Enumerator table (id int)

insert into @Enumerator
select pageId
from [page]
where pageType = 'S'  -- your query to select a list of ids goes here

declare @id int

while exists (select 1 from @Enumerator)
begin
     select top 1 @id = id from @Enumerator 

     --exec dbo.DoSomething @id
     -- your code to do something for a particular id goes here
	insert into [department] (pageId, name) values ( @id, 'Engineering');
	insert into [department] (pageId, name) values ( @id, 'Language');
	insert into [department] (pageId, name) values ( @id, 'Science');
	insert into [department] (pageId, name) values ( @id, 'Dentistry');
	insert into [department] (pageId, name) values ( @id, 'Law');

     delete from @Enumerator where id = @id
end

--DBCC CHECKIDENT('department',RESEED,0)  PRİMAY KEY 0'DAN BAŞLATMA

--EXPERIENCE DATA INSERTION


--declare @Enumerator2 table (id int, pageId int)

--insert into @Enumerator2
--select userId, pageId
--from [worksFor]
--  -- your query to select a list of ids goes here

--declare @id2 int
--declare @pageid int

--while exists (select 1 from @Enumerator2)
--begin
--     select top 1 @id2 = id , @pageid = pageId from @Enumerator2 

--     --exec dbo.DoSomething @id
--     -- your code to do something for a particular id goes here
--	insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('3 Westerfield Hill', null, '2009-12-31', null, 'Engineer', ''Part-time'', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), @id2, @pageid);

--     delete from @Enumerator2 where id = @id2
--end


insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, null, '2001-05-03', '2020-01-25', 'Accounting Assistant II', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('76 Haas Avenue', null, '2009-12-31', '2000-06-09', 'Web Developer IV', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, 'hac habitasse platea dictumst maecenas ut massa quis augue luctus', '1996-09-11', '1999-04-13', 'Senior Developer', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('243 Forest Run Lane', null, '2001-03-11', '2017-10-19', 'Paralegal', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, null, '2021-03-06', '2021-11-28', 'GIS Technical Architect', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, 'sagittis sapien cum', '2018-03-03', '2014-05-29', 'Administrative Assistant II', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('65 Northfield Junction', null, '2016-06-21', '1993-11-12', 'Product Engineer', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('11 Pond Point', 'pretium iaculis diam erat fermentum justo nec', '2009-05-14', '2000-08-17', 'Geologist I', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, 'tellus', '2018-06-27', '2019-01-28', 'Compensation Analyst', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('42134 Crowley Place', 'feugiat non pretium quis lectus suspendisse potenti in', '2002-05-12', '1991-08-29', 'Office Assistant IV', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('9256 Paget Street', 'elit ac nulla sed vel enim sit amet', '1992-01-01', '2004-05-08', 'Automation Specialist II', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, null, '2002-10-24', '1991-07-17', 'Web Designer II', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('0484 Arrowood Pass', 'aliquam convallis nunc proin at turpis a', '1993-07-14', '1994-09-16', 'Cost Accountant', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, 'ipsum primis in faucibus orci luctus et ultrices', '2011-09-08', '2015-10-30', 'Chemical Engineer', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('47 Sheridan Center', null, '2018-02-04', '2010-10-31', 'Nuclear Power Engineer', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('86 Mendota Junction', 'non mattis pulvinar nulla pede ullamcorper augue a', '1995-10-01', '2005-07-12', 'Financial Analyst', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, 'consequat in consequat ut nulla sed accumsan', '2010-09-03', '2004-12-15', 'Financial Analyst', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('4 Stuart Lane', 'platea dictumst maecenas ut massa quis augue', '2012-05-14', '2010-07-18', 'Staff Accountant I', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, null, '2020-01-01', '1993-10-09', 'Information Systems Manager', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('06705 Orin Drive', null, '2002-04-11', '2012-03-19', 'Quality Control Specialist', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('35 Nelson Lane', 'in porttitor pede justo eu massa donec dapibus duis at', '2005-12-27', '1999-07-15', 'Software Test Engineer I', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, 'mi pede malesuada in imperdiet et commodo vulputate justo', '1995-12-10', '1990-05-10', 'Engineer III', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('2993 Ridgeway Drive', 'donec ut dolor morbi vel lectus in quam fringilla', '1998-11-01', '1999-06-10', 'Help Desk Operator', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('317 4th Pass', null, '2013-10-20', '1990-11-23', 'Technical Writer', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, 'dui vel sem', '2016-06-14', '2020-06-08', 'Nurse Practicioner', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('2736 Dawn Court', null, '2012-03-14', '2020-07-13', 'Registered Nurse', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, null, '1999-04-21', '2013-10-15', 'Senior Sales Associate', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('8 Lien Pass', null, '2018-07-27', '2010-10-02', 'Senior Editor', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('839 Washington Avenue', 'nisi vulputate nonummy maecenas tincidunt lacus at velit', '1994-03-15', '2018-10-19', 'Accounting Assistant I', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, 'et commodo vulputate', '2020-01-14', '1993-12-26', 'Research Nurse', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('57 Doe Crossing Avenue', 'justo morbi ut odio cras', '1996-10-08', '2021-12-05', 'Research Nurse', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('6529 Judy Road', null, '1993-08-20', '2016-11-17', 'Account Coordinator', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('41299 Commercial Circle', null, '2012-12-17', '2002-12-26', 'Office Assistant IV', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('91747 Petterle Trail', 'nunc rhoncus dui vel sem sed sagittis', '1991-11-03', '1999-10-23', 'Budget/Accounting Analyst I', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('21 Mallory Plaza', 'convallis eget eleifend', '1993-02-03', '2002-06-23', 'Design Engineer', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, 'lorem integer tincidunt ante', '2007-03-25', '2002-05-19', 'Human Resources Assistant I', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, null, '2012-04-19', '2004-07-16', 'Community Outreach Specialist', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, null, '2010-11-15', '2008-03-13', 'Mechanical Systems Engineer', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('94791 Sundown Road', null, '1999-10-31', '2020-12-24', 'Graphic Designer', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('0 Hagan Court', 'tincidunt in leo maecenas pulvinar lobortis', '2002-08-26', '2010-07-26', 'Professor', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('1052 Canary Way', 'tristique', '2012-05-19', '2005-06-29', 'Editor', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('591 Holmberg Hill', null, '2012-09-16', '2008-03-25', 'Programmer IV', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('3770 Meadow Ridge Alley', null, '2007-05-26', '1995-09-16', 'Marketing Assistant', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, null, '1996-11-10', '2020-07-07', 'Chemical Engineer', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('5 Bunker Hill Pass', 'pharetra magna ac', '2019-10-02', '2005-10-23', 'Administrative Assistant IV', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('5 Vernon Street', 'augue vestibulum ante ipsum', '2007-07-20', '2018-09-21', 'Research Assistant I', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, 'nullam sit amet turpis elementum ligula vehicula consequat morbi a', '1995-06-30', '2006-04-27', 'Chief Design Engineer', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('50472 Colorado Alley', 'maecenas pulvinar lobortis est phasellus sit amet', '1998-05-22', '2020-10-13', 'Editor', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, null, '1995-12-11', '2016-08-03', 'Occupational Therapist', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('287 Northwestern Center', null, '2014-01-22', '1997-03-25', 'Assistant Manager', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('1103 Arkansas Center', null, '2002-06-17', '1997-04-01', 'Mechanical Systems Engineer', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, null, '2010-06-30', '2001-02-15', 'Pharmacist', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('042 Burrows Street', null, '2011-10-03', '2001-11-13', 'Quality Control Specialist', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, 'vestibulum eget', '2009-03-07', '2016-09-27', 'Pharmacist', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('7 Kensington Drive', null, '2017-01-03', '2015-01-01', 'Account Executive', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, 'eu sapien cursus vestibulum proin eu mi nulla', '2014-12-29', '1998-04-20', 'Administrative Officer', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('693 Mayer Lane', 'arcu', '2018-04-25', '2002-06-19', 'Structural Engineer', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('6 Hoffman Park', 'iaculis justo', '1994-07-08', '1998-01-21', 'Civil Engineer', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, null, '1994-04-04', '1995-02-15', 'Physical Therapy Assistant', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('998 Susan Drive', 'libero non mattis', '1998-02-10', '2002-10-13', 'Nurse', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, null, '1998-12-31', '1998-10-05', 'Professor', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('0529 Bartelt Lane', null, '1995-09-10', '2020-06-09', 'Registered Nurse', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('33 Boyd Road', 'pede ac diam cras pellentesque volutpat dui maecenas tristique', '2008-07-17', '2009-06-26', 'Financial Analyst', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('3697 Cody Lane', 'quam turpis adipiscing lorem vitae mattis nibh ligula', '2017-07-20', '2015-09-28', 'Food Chemist', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('928 Cherokee Court', null, '1996-09-14', '2004-02-12', 'Compensation Analyst', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, 'viverra eget congue eget semper rutrum nulla', '2000-01-25', '2017-10-19', 'Web Designer II', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('63 Everett Avenue', null, '1992-01-21', '1996-01-03', 'Human Resources Assistant II', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('65188 Bunting Terrace', 'pulvinar nulla pede ullamcorper', '1993-11-05', '2004-06-15', 'Assistant Manager', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('81 Macpherson Plaza', 'odio curabitur convallis duis consequat dui nec nisi volutpat eleifend', '1994-05-06', '2002-04-25', 'Mechanical Systems Engineer', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('02851 Bluestem Hill', null, '2008-10-30', '2010-05-21', 'Web Developer II', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('220 Ridgeway Park', null, '2000-12-03', '1990-07-22', 'Assistant Media Planner', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('4 Scoville Court', 'interdum mauris ullamcorper purus', '2005-04-16', '1996-11-04', 'Analog Circuit Design manager', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('6612 Pawling Trail', null, '2003-07-20', '2019-09-14', 'Quality Control Specialist', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('4 Amoth Street', null, '2004-07-10', '2014-01-30', 'Product Engineer', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, 'sapien sapien non mi', '2007-03-06', '2017-05-02', 'Computer Systems Analyst IV', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, 'arcu sed', '2017-09-09', '2003-10-07', 'Internal Auditor', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('74790 Norway Maple Plaza', 'nulla pede ullamcorper augue a suscipit nulla elit', '2000-02-16', '2009-04-02', 'Product Engineer', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('2405 Amoth Place', null, '2003-03-05', '2019-03-21', 'Nurse', 'Part-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values ('021 Mccormick Center', 'ipsum aliquam', '2005-04-20', '1992-01-09', 'Web Developer III', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));
insert into [experience] (address, description, startDate, finishDate, header, recruimentType, sectorId, userId, pageId) values (null, null, '2005-06-15', '1997-04-13', 'Paralegal', 'Full-time', (SELECT TOP 1 sectorId FROM [sector] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageID FROM [page] ORDER BY NEWID()));

--FollowingTag Data Insertion


insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));
insert into [followingTag] (userId, tagId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 tagId FROM [tag] ORDER BY NEWID()));

--Job Data Insertion
GO
CREATE TRIGGER job_owner
ON job
AFTER INSERT
AS
BEGIN
UPDATE job
SET userId = (SELECT userID From [page] Where pageId = (SELECT TOP 1 pageID from job ORDER BY jobID DESC))
WHERE created_at = (SELECT TOP 1 created_at From job ORDER BY created_at DESC)
END
GO

insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'eget vulputate ut', 'Data Coordiator', 'Hybrid', '37548 Fordem Alley', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'ligula sit amet eleifend pede', 'Accounting Assistant IV', 'Remote', '4 Mcbride Hill', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'sem fusce consequat nulla nisl', 'Human Resources Manager', 'On-site', '4 Melrose Street', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'eget nunc donec quis', 'Engineer III', 'Remote', '33907 Steensland Plaza', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'vestibulum sit amet cursus id', 'Dental Hygienist', 'Hybrid', '41109 Lake View Street', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'eu sapien cursus vestibulum', 'Senior Developer', 'On-site', '5441 Cordelia Street', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'phasellus sit amet', 'Analyst Programmer', 'On-site', '381 New Castle Center', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'tempor convallis nulla', 'Tax Accountant', 'Remote', '9 Talmadge Hill', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'arcu', 'Help Desk Operator', 'On-site', '57 Kim Crossing', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'tempus semper', 'Executive Secretary', 'Hybrid', '10067 Fordem Junction', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'a feugiat', 'Nuclear Power Engineer', 'Remote', '253 Lillian Junction', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'mauris lacinia sapien', 'Programmer III', 'On-site', '221 Loomis Park', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'augue a suscipit nulla elit', 'Health Coach I', 'Remote', '77 Acker Drive', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'porttitor lorem', 'Assistant Manager', 'Hybrid', '4 Crownhardt Terrace', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'nulla ut', 'Sales Associate', 'Remote', '6 Old Gate Center', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'aenean sit', 'Tax Accountant', 'Hybrid', '09 Twin Pines Lane', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'donec odio justo', 'Office Assistant II', 'On-site', '4 Summer Ridge Place', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'luctus et ultrices posuere', 'Director of Sales', 'Remote', '00 Brickson Park Alley', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'libero quis', 'GIS Technical Architect', 'Hybrid', '18 Oriole Trail', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'nisl nunc rhoncus dui', 'Legal Assistant', 'Hybrid', '087 Summer Ridge Road', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'adipiscing', 'Financial Advisor', 'Remote', '88489 Killdeer Place', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'eu felis', 'Accounting Assistant IV', 'Hybrid', '61 Mallory Junction', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'morbi non quam', 'Marketing Assistant', 'On-site', '236 Bluestem Drive', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'eget vulputate ut', 'Director of Sales', 'Remote', '247 Mayer Trail', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'donec vitae', 'Analog Circuit Design manager', 'On-site', '69211 Farmco Circle', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'lacus at turpis donec', 'Administrative Assistant III', 'On-site', '4 Bonner Street', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'cubilia curae duis faucibus accumsan', 'Desktop Support Technician', 'On-site', '635 Welch Center', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'quam a odio in hac', 'Help Desk Technician', 'On-site', '532 Lien Junction', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'tincidunt in leo maecenas', 'Accountant IV', 'Remote', '044 Vermont Trail', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'dapibus augue vel accumsan', 'Chemical Engineer', 'Hybrid', '4 Monterey Circle', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'posuere metus vitae ipsum', 'Media Manager III', 'On-site', '3480 Pierstorff Terrace', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'in blandit ultrices', 'Librarian', 'On-site', '23083 Tomscot Alley', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'convallis duis consequat dui nec', 'Recruiter', 'Remote', '67157 Starling Junction', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'ultricies eu nibh quisque', 'Analog Circuit Design manager', 'On-site', '6 Upham Alley', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'in faucibus', 'Web Developer I', 'On-site', '707 Kingsford Plaza', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'pharetra magna vestibulum aliquet ultrices', 'Software Consultant', 'Remote', '355 Marquette Pass', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'non mauris morbi non lectus', 'Web Designer II', 'Hybrid', '9 Tony Center', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'vitae quam suspendisse potenti nullam', 'VP Marketing', 'Hybrid', '73 Tony Way', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'mauris', 'Executive Secretary', 'Remote', '160 Dahle Way', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'purus phasellus in felis donec', 'Internal Auditor', 'On-site', '11873 Texas Lane', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'nisl nunc nisl duis', 'Help Desk Operator', 'On-site', '7 Kropf Junction', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'velit nec nisi vulputate', 'Electrical Engineer', 'Remote', '436 Veith Alley', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'pretium iaculis justo in hac', 'Financial Analyst', 'On-site', '1158 Toban Hill', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'in ante', 'Assistant Professor', 'Hybrid', '3 Hayes Parkway', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'ipsum primis in', 'Staff Scientist', 'On-site', '10357 Monterey Circle', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'mi', 'Nurse Practicioner', 'On-site', '67 Northfield Terrace', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'maecenas pulvinar lobortis', 'Speech Pathologist', 'On-site', '8718 Anderson Way', 'Full-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'id luctus', 'Research Assistant I', 'On-site', '66 Sunbrook Plaza', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'interdum mauris non ligula', 'Social Worker', 'On-site', '02096 Mayfield Way', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'lectus pellentesque', 'Safety Technician II', 'On-site', '40 Melby Crossing', 'Part-time', DEFAULT);
insert into [job] (userId, pageId, description, title, workPlaceType, location, employmentType, created_at) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 pageId FROM [page] ORDER BY NEWID()), 'vitae quam suspendisse potenti nullam', 'Programmer Analyst I', 'Hybrid', '5959 Bowman Drive', 'Part-time', DEFAULT);



--likeComment Data Insertion
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));
insert into [likeComment] (userId, commentId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 commentID FROM [comment] ORDER BY NEWID()));


--likePost Data Insertion
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));
insert into [likePost] (userId, postId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 postID FROM [post] ORDER BY NEWID()));

--Manager data insertion
ALTER TABLE manager
        ADD startDate datetime NOT NULL --Or NOT NULL.
 CONSTRAINT manager_startDate --When Omitted a Default-Constraint Name is autogenerated.
    DEFAULT CURRENT_TIMESTAMP--Optional Default-Constraint.
GO
CREATE TRIGGER managerToMember
on manager
AFTER INSERT
AS
BEGIN
INSERT INTO member
VALUES((SELECT TOP 1 userId FROM [manager] ORDER BY startDate DESC), (SELECT TOP 1 groupID FROM [manager] ORDER BY startDate DESC))
END
GO

insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);
insert into [manager] (userId, groupId, startDate) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 groupID FROM [group] ORDER BY NEWID()), DEFAULT);


--SKILL DATA INSERTION

ALTER TABLE skill ALTER COLUMN skillName varchar(50) NOT NULL

insert into [skill] (skillName) values ('Classroom');
insert into [skill] (skillName) values ('Art Exhibitions');
insert into [skill] (skillName) values ('Screening');
insert into [skill] (skillName) values ('XML Publisher');
insert into [skill] (skillName) values ('EEO/AA Compliance');
insert into [skill] (skillName) values ('XMLBeans');
insert into [skill] (skillName) values ('AP Style');
insert into [skill] (skillName) values ('Small Business Development');
insert into [skill] (skillName) values ('EWP');
insert into [skill] (skillName) values ('Canon XH-A1');
insert into [skill] (skillName) values ('Windows 7');
insert into [skill] (skillName) values ('Big Box');
insert into [skill] (skillName) values ('XAML');
insert into [skill] (skillName) values ('qRT-PCR');
insert into [skill] (skillName) values ('Rollout');
insert into [skill] (skillName) values ('EJB');
insert into [skill] (skillName) values ('OKI');
insert into [skill] (skillName) values ('OLED');
insert into [skill] (skillName) values ('Systems Engineering');
insert into [skill] (skillName) values ('CI');
insert into [skill] (skillName) values ('Benefits Negotiation');
insert into [skill] (skillName) values ('Zen Shiatsu');
insert into [skill] (skillName) values ('CDL');
insert into [skill] (skillName) values ('HTML Scripting');
insert into [skill] (skillName) values ('Lustre');
insert into [skill] (skillName) values ('Wills');
insert into [skill] (skillName) values ('GDI+');
insert into [skill] (skillName) values ('WPS');
insert into [skill] (skillName) values ('Irrigation Management');
insert into [skill] (skillName) values ('CTP');
insert into [skill] (skillName) values ('Planned Giving');
insert into [skill] (skillName) values ('Computer Network Operations');
insert into [skill] (skillName) values ('XDCAM');
insert into [skill] (skillName) values ('Ektron Content Management System');
insert into [skill] (skillName) values ('FBA');
insert into [skill] (skillName) values ('IP CCTV');
insert into [skill] (skillName) values ('Product Development');
insert into [skill] (skillName) values ('International Relations');
insert into [skill] (skillName) values ('TFT');
insert into [skill] (skillName) values ('BBEdit');
insert into [skill] (skillName) values ('RHIT');
insert into [skill] (skillName) values ('AQL');
insert into [skill] (skillName) values ('eCTD');
insert into [skill] (skillName) values ('Electrical Engineering');
insert into [skill] (skillName) values ('GSM');
insert into [skill] (skillName) values ('Corporate Governance');
insert into [skill] (skillName) values ('Human Resource Planning');
insert into [skill] (skillName) values ('SSIS');
insert into [skill] (skillName) values ('CNC Programing');
insert into [skill] (skillName) values ('PMM');

--HAS SKILL DATA INSERTION
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));
insert into [hasSkill] (userId, skillId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 skillId FROM [skill] ORDER BY NEWID()));

--INSTRUCTOR DATA INSERTION 
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))
INSERT INTO [instructor]
VALUES ((SELECT TOP 1 userId FROM [user] WHERE userType = 'I' or  userType = 'X' ORDER BY NEWID()) , (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()))

--LESSON DATA INSERTION

insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'GMAT', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'Segregation of Duties', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'Gift Tax', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'US GAAP', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'KXEN', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'XPAC', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'Post Production', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'Ducting', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'SWIFT Payments', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'IT Project &amp; Program Management', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'RoboHelp', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'Gynecologic Oncology', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'Green Building', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'Yardi', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'SAP EBP', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'DBWorks', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'Influence Others', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'DVCProHD', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'zLinux', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'NCover', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'Academic Tutoring', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'PXRD', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'Smoking Cessation', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'Healthcare Consulting', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'Pharmacy', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'EHR', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'EOR', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'CWS', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'LMS Test.Lab', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'Ntop', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'BBQ', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'Digital Illustration', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'FMOD', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'SQL*Plus', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'TBS', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'Tourism Management', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'SSH', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'Business Objects', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'nCode', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'ELISA', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'Brand Equity', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'Lymphoma', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'Portrait Photography', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'Flatbed', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'HSPD-12', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'TFF', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'Aftersales', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'Sketching', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Spring', 'TLM', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));
insert into [lesson] (semester, lessonName, groupId, userId, departmentId) values ('Fall', 'MVVM', (SELECT TOP 1 groupId FROM [group] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 departmentId FROM [department] ORDER BY NEWID()));

--LESSONDOCUMENTS DATA INSERTION
INSERT INTO lessonDocuments SELECT lessonId FROM lesson 



--PARTICIPATE DATA INSERTION

insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [participate] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));

--SPEAK DATA INSERTION

insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));
insert into [speak] (userId, eventId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 eventId FROM [event] ORDER BY NEWID()));

--TAKES DATA INSERTION
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 74);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 100);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 52);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 6);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 36);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 7);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 36);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 91);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 68);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 56);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 73);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 45);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 51);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 26);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 30);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 73);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 83);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 7);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 41);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 72);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 90);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 80);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 20);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 99);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 94);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 4);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 19);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 27);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 84);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 53);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 45);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 40);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 86);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 47);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 63);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 86);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 42);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 36);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 4);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 21);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 86);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 24);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 100);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 4);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 79);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 87);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 14);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 37);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 51);
insert into [takes] (userId, lessonId, grade) values ((SELECT TOP 1 userId FROM [user] WHERE userType = 'S' ORDER BY NEWID()), (SELECT TOP 1 lessonId FROM [lesson] ORDER BY NEWID()), 15);

--SEND DATA INSERTION

insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'nam');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'eros vestibulum ac est');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'lacus morbi');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'non');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'turpis sed ante vivamus tortor');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'quisque ut erat curabitur');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'justo eu');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'in');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'tempor');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'dapibus at diam');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'cubilia curae nulla dapibus dolor');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'potenti cras');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'nunc donec quis orci');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'donec vitae nisi nam');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'eget congue eget semper rutrum');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'duis faucibus accumsan odio curabitur');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'libero');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'sed interdum');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'ullamcorper purus sit amet nulla');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'rutrum nulla nunc purus');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'pellentesque ultrices phasellus id');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'tincidunt ante vel');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'parturient montes');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'odio in hac');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'et eros');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'nunc purus');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'ac');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'pretium iaculis justo in');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'nibh ligula nec sem duis');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'non mauris morbi non');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'interdum venenatis turpis enim blandit');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'vulputate vitae nisl');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'sed vestibulum sit amet cursus');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'massa');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'nunc rhoncus');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'cursus vestibulum proin');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'mauris non ligula pellentesque ultrices');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'adipiscing lorem');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'sed vestibulum sit amet');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'felis sed');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'nisi nam ultrices');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'nam tristique tortor eu pede');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'sed');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'porttitor id');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'mattis odio donec vitae');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'bibendum felis sed interdum');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'dolor quis odio consequat');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'tristique in tempus sit');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'ut rhoncus aliquet pulvinar');
insert into [send] (senderId, receiverId, time, content) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), (SELECT TOP 1 userId FROM [user] ORDER BY NEWID()), DEFAULT, 'quis odio consequat');

--MY ITEMS DATA INSERTION
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));
insert into [myItems] (userId) values ((SELECT TOP 1 userId FROM [user] ORDER BY NEWID()));

--HAS POST ITEM DATA INSERTION
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));
insert into [HasPostItem] (postId, itemId) values ((SELECT TOP 1 postId FROM [post] ORDER BY NEWID()), (SELECT TOP 1 itemId FROM [myItems] ORDER BY NEWID()));


--UPDATE 
UPDATE TOP (10) [user]  
SET userType = 'S'
WHERE userType is null 
UPDATE [post]
SET description = 'changed'
WHERE userId = 1
UPDATE [event]
SET description = 'filled'
WHERE description is null
--DELETE
DELETE FROM [speak] WHERE eventId = 1
DELETE FROM [commentTag] WHERE tagId = 2
DELETE FROM [connection] WHERE userId = 1


--SELECT OPERATIONS
SELECT * FROM [user] WHERE userType = 'S' 
SELECT * FROM [page] WHERE pageType = 'C' 
SELECT TOP 5 description, userId FROM [post] 

