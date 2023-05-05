drop table IsGoodAt;
drop table Ban;
drop table Pick;
drop table PlayerContract1;
drop table PlayerContract2;
drop table CoachContract1;
drop table CoachContract2;
drop table SupportSkill;
drop table ControlSkill;
drop table DamageSkill;
drop table ChampionSkill;
drop table Champion;
drop table Record;
drop table Championship;
drop table Player;
drop table Coach;
drop table Team;




CREATE TABLE Team (
    teamName char(10) PRIMARY KEY, 
    region char(3) 
);
grant select on Team to public;

CREATE TABLE Coach (
    coachName char(50) PRIMARY KEY
);
grant select on Coach to public;

CREATE TABLE Player(
    playerID char(50) PRIMARY KEY
);
grant select on Player to public;

CREATE TABLE Championship(
    championshipSeason char(50) not null, 
    championshipName char(50) not null, 
    teamName char(10) null, 
    bonus INT null,
    PRIMARY KEY(championshipName, championshipSeason),
    FOREIGN KEY(teamName) REFERENCES Team(teamName) ON DELETE SET NULL
);
grant select on Championship to public;

CREATE TABLE Record(
    recordID int,
    championshipSeason char(50),
    championshipName char(50),
    teamName char(10),
    winner char(10),
    PRIMARY KEY(recordID, championshipName, championshipSeason),
    FOREIGN KEY(championshipName,championshipSeason) REFERENCES Championship(championshipName,championshipSeason) ON DELETE CASCADE,
    FOREIGN KEY(teamName) REFERENCES Team ON DELETE CASCADE
);
grant select on Record to public;

CREATE TABLE Champion(
    championName char(20) PRIMARY KEY,
    mainLane char(20)
);
grant select on Champion to public;

CREATE TABLE ChampionSkill(
    skillName char(50) PRIMARY KEY,
    championName char(20) not null,
    FOREIGN KEY (championName) REFERENCES Champion ON DELETE CASCADE
);
grant select on ChampionSkill to public;
CREATE TABLE DamageSkill(
    skillName char(50) PRIMARY KEY,
    championName char(20),
    damageAmount int,
    FOREIGN KEY(skillName) REFERENCES ChampionSkill(skillName) ON DELETE CASCADE,
    FOREIGN KEY(championName) REFERENCES Champion ON DELETE CASCADE
);

CREATE TABLE ControlSkill(
    skillName char(50) PRIMARY KEY,
    championName char(20),
    controlEffect char(500),
    controlTime INT,
    FOREIGN KEY(skillName) REFERENCES ChampionSkill(skillName) ON DELETE CASCADE,
    FOREIGN KEY(championName) REFERENCES Champion ON DELETE CASCADE
);

CREATE TABLE SupportSkill(
    skillName char(50) PRIMARY KEY,
    championName char(20),
    heal int,
    shield INT,
    FOREIGN KEY(skillName) REFERENCES ChampionSkill(skillName) ON DELETE CASCADE,
    FOREIGN KEY(championName) REFERENCES Champion ON DELETE CASCADE
    );

CREATE TABLE CoachContract2(
    coachRole char(50),
    coachSalary int null,
    PRIMARY KEY(coachRole)
);
grant select on CoachContract2 to public;

CREATE TABLE PlayerContract2(
    tier int,
    contractFee int UNIQUE,
    PRIMARY KEY(tier)
);

CREATE TABLE CoachContract1(
    teamName char(10),
    coachName char(50),
    coachingSeason char(20),
    coachRole char(50) not null,
    PRIMARY KEY(teamName, coachName, coachRole),
    FOREIGN KEY(teamName) REFERENCES Team ON DELETE CASCADE,
    FOREIGN KEY (coachRole) REFERENCES CoachContract2 ON DELETE SET NULL,
    FOREIGN KEY(coachName) REFERENCES Coach ON DELETE CASCADE
);
grant select on CoachContract1 to public;


CREATE TABLE PlayerContract1(
    playerID char(50),
    teamName char(10),
    contractSeason char(50),
    lane char(3),
    tier int,
    PRIMARY KEY(playerID, teamName, tier),
    FOREIGN KEY(playerID) REFERENCES Player ON DELETE CASCADE,
    FOREIGN KEY(tier) REFERENCES PlayerContract2(tier) ON DELETE SET NULL,
    FOREIGN KEY(teamName) REFERENCES Team ON DELETE CASCADE
);



CREATE TABLE Pick (
    playerID char(50) NOT NULL,
    championName char(20) NOT NULL,
    recordID int NOT NULL,
    championshipSeason char(50) NOT NULL,
    championshipName char(50) NOT NULL, 
    kda char(20),
    totalDamage int,
    lane char(3),
    PRIMARY KEY(playerID,championName, recordID, championshipSeason,championshipName),
    FOREIGN KEY(championName) REFERENCES Champion ON DELETE CASCADE,
    FOREIGN KEY(playerID) REFERENCES Player ON DELETE CASCADE,
    FOREIGN KEY(championshipName,championshipSeason,recordID) REFERENCES 
    Record(championshipName,championshipSeason,recordID)  ON DELETE CASCADE
);

CREATE TABLE Ban(
    coachName char(50) NOT NULL,
    championName char(20) NOT NULL,
    recordID int NOT NULL,
    championshipSeason char(50) NOT NULL,
    championshipName char(50) NOT NULL,
    choiceNumber int,
    banRate float, 
    PRIMARY KEY(coachName,championName,recordID,championshipSeason,championshipName),
    FOREIGN KEY(coachName) REFERENCES Coach ON DELETE CASCADE,
    FOREIGN KEY(championName) REFERENCES Champion ON DELETE CASCADE,
    FOREIGN KEY(championshipName,championshipSeason,recordID)
     REFERENCES Record(championshipName,championshipSeason,recordID) ON DELETE CASCADE
);

CREATE TABLE IsGoodAt(
    playerID char(50) NOT NULL,
    championName char(20) NOT NULL,
    preferenceOrder int,
    winRate float,
    PRIMARY KEY(playerID,championName),
    FOREIGN KEY(playerID) REFERENCES Player ON DELETE CASCADE,
    FOREIGN KEY(championName) REFERENCES Champion ON DELETE CASCADE
);



insert into Team values("RNG",'LPL');
insert into Team values('TES','LPL');
insert into Team values('JDG','LPL');
insert into Team values('EDG','LPL');
insert into Team values('GENG','LCK');
insert into Team values('DRX','LCK');
insert into Team values('T1','LCK');
insert into Team values('DK','LCK');
insert into Team values('G2','LEC');
insert into Team values('RGE','LEC');
insert into Team values('MAD','LEC');
insert into Team values('FNC','LEC');
insert into Team values('100T','LCS');
insert into Team values('C9','LCS');
insert into Team values('EG','LCS');
insert into Team values('CFO','PCS');
insert into Team values('BYG','PCS');
insert into Team values('SGB','VCS');
insert into Team values('GAM','VCS');
insert into Team values('DFM','LJL');
insert into Team values('ISG','LLA');
insert into Team values('LLL','CBL');
insert into Team values('IW','TCL');
insert into Team values('CHF','LCO');

insert into Player values('Breathe');
insert into Player values('Wei');
insert into Player values('XiaoHu');
insert into Player values('Gala');
insert into Player values('Ming');
insert into Player values('Wayward');
insert into Player values('Tian');
insert into Player values('Knight');
insert into Player values('Jackeylove');
insert into Player values('Mark');
insert into Player values('369');
insert into Player values('Kanavi');
insert into Player values('Yagao');
insert into Player values('Hope');
insert into Player values('Missing');
insert into Player values('Flandre');
insert into Player values('Jiejie');
insert into Player values('Scout');
insert into Player values('Viper');
insert into Player values('Meiko');
insert into Player values('Doran');
insert into Player values('Peanut');
insert into Player values('Chovy');
insert into Player values('Ruler');
insert into Player values('Lehends');
insert into Player values('Zeus');
insert into Player values('Oner');
insert into Player values('Faker');
insert into Player values('Gumayusi');
insert into Player values('Keria');
insert into Player values('Nuguri');
insert into Player values('Canyon');
insert into Player values('Showmaker');
insert into Player values('Deokdam');
insert into Player values('Kellin');
insert into Player values('Kingen');
insert into Player values('Pyosik');
insert into Player values('Zeka');
insert into Player values('Deft');
insert into Player values('BeryL');
insert into Player values('BrokenBlade');
insert into Player values('Jankos');
insert into Player values('caPs');
insert into Player values('Flakked');
insert into Player values('Targamas');
insert into Player values('Odoamne');
insert into Player values('Malrang');
insert into Player values('Larssen');
insert into Player values('Comp');
insert into Player values('Trymbi');
insert into Player values('Armut');
insert into Player values('Elyoya');
insert into Player values('Nisqy');
insert into Player values('UNF0RGIVEN');
insert into Player values('Kaiser');
insert into Player values('Wunder');
insert into Player values('Razork');
insert into Player values('Humanoid');
insert into Player values('Upset');
insert into Player values('Hylissang');
insert into Player values('Ssumday');
insert into Player values('Closer');
insert into Player values('Abbedagge');
insert into Player values('FBI');
insert into Player values('huhi');
insert into Player values('Fudge');
insert into Player values('Blaber');
insert into Player values('Jensen');
insert into Player values('Berserker');
insert into Player values('Zven');
insert into Player values('Impact');
insert into Player values('Inspired');
insert into Player values('Jojopyun');
insert into Player values('Kaori');
insert into Player values('Vulcan');
insert into Player values('Rest');
insert into Player values('Gemini');
insert into Player values('M1ssion');
insert into Player values('Shunn');
insert into Player values('Koala');
insert into Player values('Liang');
insert into Player values('Husha');
insert into Player values('Minji');
insert into Player values('Wako');
insert into Player values('Kino');
insert into Player values('Hasmed');
insert into Player values('Bean J');
insert into Player values('Froggy');
insert into Player values('Shogun');
insert into Player values('Taki');
insert into Player values('Kiaya');
insert into Player values('Levi');
insert into Player values('Kati');
insert into Player values('Style');
insert into Player values('Bie');
insert into Player values('Evi');
insert into Player values('Steal');
insert into Player values('Yaharong');
insert into Player values('Yutapon');
insert into Player values('Harp');
insert into Player values('ADD');
insert into Player values('Grell');
insert into Player values('Seiya');
insert into Player values('Gavotto');
insert into Player values('Jelly');
insert into Player values('Robo');
insert into Player values('Croc');
insert into Player values('tinowns');
insert into Player values('Brance');
insert into Player values('Ceos');
insert into Player values('StarScreen');
insert into Player values('Ferret');
insert into Player values('Serin');
insert into Player values('HolyPhoenix');
insert into Player values('Farfetch');
insert into Player values('Topoon');
insert into Player values('Arthur');
insert into Player values('Tally');
insert into Player values('Raes');
insert into Player values('Dragku');


insert into Coach values('KenZhu');
insert into Coach values('Xiaobai');
insert into Coach values('Tabe');
insert into Coach values('Sin');
insert into Coach values('Crescent');
insert into Coach values('BZ');
insert into Coach values('Homme');
insert into Coach values('Aaron');
insert into Coach values('Maokai');
insert into Coach values('Score');
insert into Coach values('SSONG');
insert into Coach values('Bengi');
insert into Coach values('Daeny');
insert into Coach values('Dylan Falco');
insert into Coach values('Raf');
insert into Coach values('fredy122');
insert into Coach values('Arces');
insert into Coach values('Mac');
insert into Coach values('Pad');
insert into Coach values('YamatoCannon');
insert into Coach values('Jeremias Knehr');
insert into Coach values('Reapered');
insert into Coach values('JungleJuice');
insert into Coach values('Max Waldo');
insert into Coach values('Tran');
insert into Coach values('Rigby');
insert into Coach values('Achie');
insert into Coach values('Benny');
insert into Coach values('Ren');
insert into Coach values('JackieWind');
insert into Coach values('Kazu');
insert into Coach values('Ukkyr');
insert into Coach values('Escalante');
insert into Coach values('Robogod');
insert into Coach values('Cuden');


insert into Championship values('S12','WorldChampionship',null,1);
insert into Championship values('S12','Mid-Season Invitational',null,2);
insert into Championship values('S11','WorldChampionship',null,3);
insert into Championship values('S11','Mid-Season Invitational',,4);
insert into Championship values('S11','LPL summer',null,5);

insert into Record values(1,'S12','WorldChampionship','ISG','MAD');
insert into Record values(2,'S12','WorldChampionship','EG','FNC');
insert into Record values(3,'S12','WorldChampionship','LLL','BYG');
insert into Record values(4,'S12','WorldChampionship','IW','MAD');
insert into Record values(5,'S12','WorldChampionship','CHF','FNC');
insert into Record values(6,'S12','WorldChampionship','DFM','LLL');
insert into Record values(7,'S12','WorldChampionship','IW','SGB');
insert into Record values(8,'S12','WorldChampionship','RNG','DRX');
insert into Record values(9,'S12','WorldChampionship','DFM','FNC');
insert into Record values(10,'S12','WorldChampionship','LLL','EG');
insert into Record values(11,'S12','WorldChampionship','ISG','SGB');
insert into Record values(12,'S12','WorldChampionship','CHF','DFM');
insert into Record values(13,'S12','WorldChampionship','BYG','EG');
insert into Record values(14,'S12','WorldChampionship','SGB','DRX');
insert into Record values(15,'S12','WorldChampionship','MAD','RNG');
insert into Record values(16,'S12','WorldChampionship','FNC','LLL');
insert into Record values(17,'S12','WorldChampionship','SGB','MAD');
insert into Record values(18,'S12','WorldChampionship','BYG','DFM');
insert into Record values(19,'S12','WorldChampionship','CHF','EG');
insert into Record values(20,'S12','WorldChampionship','ISG','RNG');
insert into Record values(21,'S12','WorldChampionship','CHF','BYG');
insert into Record values(22,'S12','WorldChampionship','IW','RNG');
insert into Record values(23,'S12','WorldChampionship','BYG','FNC');
insert into Record values(24,'S12','WorldChampionship','CHF','LLL');
insert into Record values(25,'S12','WorldChampionship','EG','DFM');
insert into Record values(26,'S12','WorldChampionship','IW','ISG');
insert into Record values(27,'S12','WorldChampionship','MAD','DRX');
insert into Record values(28,'S12','WorldChampionship','SGB','RNG');
insert into Record values(29,'S12','WorldChampionship','SGB','MAD');
insert into Record values(30,'S12','WorldChampionship','MAD','EG');
insert into Record values(31,'S12','WorldChampionship','DFM','RNG');
insert into Record values(32,'S12','WorldChampionship','C9','FNC');
insert into Record values(33,'S12','WorldChampionship','G2','DK');
insert into Record values(34,'S12','WorldChampionship','100T','CFO');
insert into Record values(35,'S12','WorldChampionship','EG','JDG');
insert into Record values(36,'S12','WorldChampionship','EDG','T1');
insert into Record values(37,'S12','WorldChampionship','DRX','RGE');
insert into Record values(38,'S12','WorldChampionship','EG','G2');
insert into Record values(39,'S12','WorldChampionship','T1','FNC');
insert into Record values(40,'S12','WorldChampionship','C9','EDG');
insert into Record values(41,'S12','WorldChampionship','GAM','TES');
insert into Record values(42,'S12','WorldChampionship','DK','JDG');
insert into Record values(43,'S12','WorldChampionship','GAM','RGE');
insert into Record values(44,'S12','WorldChampionship','FNC','EDG');
insert into Record values(45,'S12','WorldChampionship','C9','T1');
insert into Record values(46,'S12','WorldChampionship','CFO','RNG');
insert into Record values(47,'S12','WorldChampionship','TES','DRX');
insert into Record values(48,'S12','WorldChampionship','G2','JDG');
insert into Record values(49,'S12','WorldChampionship','TES','RGE');
insert into Record values(50,'S12','WorldChampionship','EG','DK');
insert into Record values(51,'S12','WorldChampionship','CFO','GENG');
insert into Record values(52,'S12','WorldChampionship','GAM','DRX');
insert into Record values(53,'S12','WorldChampionship','FNC','C9');
insert into Record values(54,'S12','WorldChampionship','FNC','T1');
insert into Record values(55,'S12','WorldChampionship','C9','EDG');
insert into Record values(56,'S12','WorldChampionship','C9','T1');
insert into Record values(57,'S12','WorldChampionship','FNC','EDG');
insert into Record values(58,'S12','WorldChampionship','G2','EG');
insert into Record values(59,'S12','WorldChampionship','EG','JDG');
insert into Record values(60,'S12','WorldChampionship','G2','DK');
insert into Record values(61,'S12','WorldChampionship','G2','JDG');
insert into Record values(62,'S12','WorldChampionship','EG','DK');
insert into Record values(63,'S12','WorldChampionship','JDG','DK');
insert into Record values(64,'S12','WorldChampionship','GAM','RGE');
insert into Record values(65,'S12','WorldChampionship','RGE','DRX');
insert into Record values(66,'S12','WorldChampionship','GAM','DRX');
insert into Record values(67,'S12','WorldChampionship','RGE','TES');
insert into Record values(68,'S12','WorldChampionship','DRX','TES');
insert into Record values(69,'S12','WorldChampionship','CFO','100T');
insert into Record values(70,'S12','WorldChampionship','CFO','GENG');
insert into Record values(71,'S12','WorldChampionship','100T','RNG');
insert into Record values(72,'S12','WorldChampionship','CFO','RNG');
insert into Record values(73,'S12','WorldChampionship','RNG','GENG');
insert into Record values(74,'S12','WorldChampionship','RNG','GENG');
insert into Record values(75,'S12','WorldChampionship','RNG','T1');
insert into Record values(76,'S12','WorldChampionship','RNG','T1');
insert into Record values(77,'S12','WorldChampionship','RNG','T1');
insert into Record values(78,'S12','WorldChampionship','DK','GENG');
insert into Record values(79,'S12','WorldChampionship','DK','GENG');
insert into Record values(80,'S12','WorldChampionship','GENG','DK');
insert into Record values(81,'S12','WorldChampionship','GENG','DK');
insert into Record values(82,'S12','WorldChampionship','DK','GENG');
insert into Record values(83,'S12','WorldChampionship','DRX','EDG');
insert into Record values(84,'S12','WorldChampionship','DRX','EDG');
insert into Record values(85,'S12','WorldChampionship','EDG','DRX');
insert into Record values(86,'S12','WorldChampionship','EDG','DRX');
insert into Record values(87,'S12','WorldChampionship','EDG','DRX');
insert into Record values(88,'S12','WorldChampionship','T1','JDG');
insert into Record values(89,'S12','WorldChampionship','JDG','T1');
insert into Record values(90,'S12','WorldChampionship','JDG','T1');
insert into Record values(91,'S12','WorldChampionship','JDG','T1');
insert into Record values(92,'S12','WorldChampionship','DRX','GENG');
insert into Record values(93,'S12','WorldChampionship','GENG','DRX');
insert into Record values(94,'S12','WorldChampionship','GENG','DRX');
insert into Record values(95,'S12','WorldChampionship','GENG','DRX');
insert into Record values(96,'S12','WorldChampionship','DRX','T1');
insert into Record values(97,'S12','WorldChampionship','T1','DRX');
insert into Record values(98,'S12','WorldChampionship','DRX','T1');
insert into Record values(99,'S12','WorldChampionship','T1','DRX');
insert into Record values(100,'S12','WorldChampionship','T1','DRX');


insert into Champion values('Aatrox','top');
insert into Champion values('Fiora','top');
insert into Champion values('Camille','top');
insert into Champion values('Darius','top');
insert into Champion values('Shen','top');
insert into Champion values('Riven','top');
insert into Champion values('Nasus','top');
insert into Champion values('Mordekaiser','top');
insert into Champion values('Jax','top');
insert into Champion values('Sett','top');
insert into Champion values('Gangplank','top');
insert into Champion values('Garen','top');
insert into Champion values('Urgot','top');
insert into Champion values('Irelia','top');
insert into Champion values('Renekton','top');
insert into Champion values('Illaoi','top');
insert into Champion values('Gwen','top');
insert into Champion values('Ornn','top');
insert into Champion values('KSante','top');
insert into Champion values('Kled','top');
insert into Champion values('Wukong','top');
insert into Champion values('Singed','top');
insert into Champion values('Tryndamere','top');
insert into Champion values('Teemo','top');
insert into Champion values('Quinn','top');
insert into Champion values('Dr. Mundo','top');
insert into Champion values('Yorick','top');
insert into Champion values('Sion','top');
insert into Champion values('Kayle','top');
insert into Champion values('Jayce','top');
insert into Champion values('Yone','top');
insert into Champion values('Sejuani','top');
insert into Champion values('Gnar','top');
insert into Champion values('ChoGath','top');
insert into Champion values('Tahm Kench','top');
insert into Champion values('Malphite','top');
insert into Champion values('Kennen','top');
insert into Champion values('Maokai','top');
insert into Champion values('Gragas','top');
insert into Champion values('Rumble','top');
insert into Champion values('Ekko','jungle');
insert into Champion values('Evelynn','jungle');
insert into Champion values('Hecarim','jungle');
insert into Champion values('Master Yi','jungle');
insert into Champion values('Graves','jungle');
insert into Champion values('Elise','jungle');
insert into Champion values('Shyvana','jungle');
insert into Champion values('Wukong','jungle');
insert into Champion values('Vi','jungle');
insert into Champion values('Udyr','jungle');
insert into Champion values('Lee Sin','jungle');
insert into Champion values('BelVeth','jungle');
insert into Champion values('KhaZix','jungle');
insert into Champion values('Warwick','jungle');
insert into Champion values('Kayn','jungle');
insert into Champion values('Rengar','jungle');
insert into Champion values('Lillia','jungle');
insert into Champion values('XinZhao','jungle');
insert into Champion values('Mordekaiser','jungle');
insert into Champion values('Fiddlesticks','jungle');
insert into Champion values('Viego','jungle');
insert into Champion values('Trundle','jungle');
insert into Champion values('Diana','jungle');
insert into Champion values('Nocturne','jungle');
insert into Champion values('Sejuani','jungle');
insert into Champion values('RekSai','jungle');
insert into Champion values('Kindred','jungle');
insert into Champion values('Karthus','jungle');
insert into Champion values('Zac','jungle');
insert into Champion values('Nunu_Willump','jungle');
insert into Champion values('JarvanIV','jungle');
insert into Champion values('Volibear','jungle');
insert into Champion values('Talon','jungle');
insert into Champion values('Shaco','jungle');
insert into Champion values('Nidalee','jungle');
insert into Champion values('Rammus','jungle');
insert into Champion values('Taliyah','jungle');
insert into Champion values('Gragas','jungle');
insert into Champion values('Skarner','jungle');
insert into Champion values('Poppy','jungle');
insert into Champion values('Ivern','jungle');
insert into Champion values('Olaf','jungle');
insert into Champion values('Syndra','mid');
insert into Champion values('Zed','mid');
insert into Champion values('Vex','mid');
insert into Champion values('Yone','mid');
insert into Champion values('Viktor','mid');
insert into Champion values('Malzahar','mid');
insert into Champion values('Katarina','mid');
insert into Champion values('Sylas','mid');
insert into Champion values('Talon','mid');
insert into Champion values('Akali','mid');
insert into Champion values('Akshan','mid');
insert into Champion values('VelKoz','mid');
insert into Champion values('Rumble','mid');
insert into Champion values('Irelia','mid');
insert into Champion values('Vladimir','mid');
insert into Champion values('Anivia','mid');
insert into Champion values('Fizz','mid');
insert into Champion values('Pantheon','mid');
insert into Champion values('Ahri','mid');
insert into Champion values('Kassadin','mid');
insert into Champion values('Yasuo','mid');
insert into Champion values('Swain','mid');
insert into Champion values('Cassiopeia','mid');
insert into Champion values('Veigar','mid');
insert into Champion values('Galio','mid');
insert into Champion values('Xerath','mid');
insert into Champion values('Qiyana','mid');
insert into Champion values('Zoe','mid');
insert into Champion values('Twisted Fate','mid');
insert into Champion values('Corki','mid');
insert into Champion values('Aurelion Sol','mid');
insert into Champion values('Lissandra','mid');
insert into Champion values('Annie','mid');
insert into Champion values('Ziggs','mid');
insert into Champion values('Orianna','mid');
insert into Champion values('Neeko','mid');
insert into Champion values('Brand','mid');
insert into Champion values('Ryze','mid');
insert into Champion values('LeBlanc','mid');
insert into Champion values('Azir','mid');
insert into Champion values('KaiSa','bot');
insert into Champion values('Jhin','bot');
insert into Champion values('Caitlyn','bot');
insert into Champion values('Samira','bot');
insert into Champion values('Nilah','bot');
insert into Champion values('Twitch','bot');
insert into Champion values('Varus','bot');
insert into Champion values('Lucian','bot');
insert into Champion values('Ezreal','bot');
insert into Champion values('Tristana','bot');
insert into Champion values('Jinx','bot');
insert into Champion values('Draven','bot');
insert into Champion values('MissFortune','bot');
insert into Champion values('Ashe','bot');
insert into Champion values('Vayne','bot');
insert into Champion values('Sivir','bot');
insert into Champion values('KogMaw','bot');
insert into Champion values('Xayah','bot');
insert into Champion values('Aphelios','bot');
insert into Champion values('Kalista','bot');
insert into Champion values('Zeri','bot');
insert into Champion values('Nami','sup');
insert into Champion values('Janna','sup');
insert into Champion values('Blitzcrank','sup');
insert into Champion values('lux','sup');
insert into Champion values('Lulu','sup');
insert into Champion values('Sona','sup');
insert into Champion values('Thresh','sup');
insert into Champion values('Zilean','sup');
insert into Champion values('Renata Glasc','sup');
insert into Champion values('Heimerdinger','sup');
insert into Champion values('Karma','sup');
insert into Champion values('Nautilus','sup');
insert into Champion values('Yuumi','sup');
insert into Champion values('Soraka','sup');
insert into Champion values('Pyke','sup');
insert into Champion values('Zyra','sup');
insert into Champion values('Bard','sup');
insert into Champion values('Taric','sup');
insert into Champion values('Morgana','sup');
insert into Champion values('Rakan','sup');
insert into Champion values('Amumu','sup');
insert into Champion values('Rell','sup');
insert into Champion values('Senna','sup');
insert into Champion values('Seraphine','sup');
insert into Champion values('Leona','sup');
insert into Champion values('Alistar','sup');
insert into Champion values('Braum','sup');



insert into ChampionSkill values('THE DARKIN BLADE','Aatrox');
insert into ChampionSkill values('INFERNAL CHAINS','Aatrox');
insert into ChampionSkill values('UMBRAL DASH','Aatrox');
insert into ChampionSkill values('WORLD ENDER','Aatrox');
insert into ChampionSkill values('CHAIN LASH','Sylas');
insert into ChampionSkill values('KINGSLAYER','Sylas');
insert into ChampionSkill values('ABSCOND / ABDUCT','Sylas');
insert into ChampionSkill values('HIJACK','Sylas');
insert into ChampionSkill values('PIERCE','Kalista');
insert into ChampionSkill values('SENTINEL','Kalista');
insert into ChampionSkill values('REND','Kalista');
insert into ChampionSkill values('FATES CALL','Kalista');
insert into ChampionSkill values('BRAMBLE SMASH','Maokai');
insert into ChampionSkill values('TWISTED ADVANCE','Maokai');
insert into ChampionSkill values('SAPLING TOSS','Maokai');
insert into ChampionSkill values('NATURES GRASP','Maokai');
insert into ChampionSkill values('ARCTIC ASSAULT','Sejuani');
insert into ChampionSkill values('WINTERS WRATH','Sejuani');
insert into ChampionSkill values('PERMAFROST','Sejuani');
insert into ChampionSkill values('GLACIAL PRISON','Sejuani');
insert into ChampionSkill values('RAMPAGE','Hecarim');
insert into ChampionSkill values('SPIRIT OF DREAD','Hecarim');
insert into ChampionSkill values('DEVASTATING CHARGE','Hecarim');
insert into ChampionSkill values('ONSLAUGHT OF SHADOWS','Hecarim');
insert into ChampionSkill values('PILTOVER PEACEMAKER','Caitlyn');
insert into ChampionSkill values('YORDLE SNAP TRAP','Caitlyn');
insert into ChampionSkill values('90 CALIBER NET','Caitlyn');
insert into ChampionSkill values('ACE IN THE HOLE','Caitlyn');
insert into ChampionSkill values('ICATHIAN RAIN','KaiSa');
insert into ChampionSkill values('Looming Darkness','KaiSa');
insert into ChampionSkill values('VOID SEEKER','KaiSa');
insert into ChampionSkill values('KILLER INSTINCT','KaiSa');
insert into ChampionSkill values('BANDAGE TOSS','Amumu');
insert into ChampionSkill values('DESPAIR','Amumu');
insert into ChampionSkill values('TANTRUM','Amumu');
insert into ChampionSkill values('CURSE OF THE SAD MUMMY','Amumu');
insert into ChampionSkill values('DOUBLE UP','MissFortune');
insert into ChampionSkill values('STRUT','MissFortune');
insert into ChampionSkill values('MAKE IT RAIN','MissFortune');
insert into ChampionSkill values('BULLET TIME','MissFortune');
insert into ChampionSkill values('CONQUERING SANDS','Azir');
insert into ChampionSkill values('ARISE','Azir');
insert into ChampionSkill values('SHIFTING SANDS','Azir');
insert into ChampionSkill values('EMPERORS DIVIDE','Azir');
insert into ChampionSkill values('END OF THE LINE','Graves');
insert into ChampionSkill values('SMOKE SCREEN','Graves');
insert into ChampionSkill values('QUICKDRAW','Graves');
insert into ChampionSkill values('COLLATERAL DAMAGE','Graves');
insert into ChampionSkill values('BOOMERANG THROW / BOULDER TOSS','Gnar');
insert into ChampionSkill values('HYPER / WALLOP','Gnar');
insert into ChampionSkill values('HOP / CRUNCH','Gnar');
insert into ChampionSkill values('GNAR!','Gnar');
insert into ChampionSkill values('WEAPON ABILITES','Aphelios');
insert into ChampionSkill values('PHASE','Aphelios');
insert into ChampionSkill values('WEAPON QUEUE SYSTEM','Aphelios');
insert into ChampionSkill values('MOONLIGHT VIGIL','Aphelios');
insert into ChampionSkill values('SIGIL OF MALICE','LeBlanc');
insert into ChampionSkill values('DISTORTION','LeBlanc');
insert into ChampionSkill values('ETHEREAL CHAINS','LeBlanc');
insert into ChampionSkill values('MIMIC','LeBlanc');
insert into ChampionSkill values('SHIELD OF DAYBREAK','Leona');
insert into ChampionSkill values('ECLIPSE','Leona');
insert into ChampionSkill values('ZENITH BLADE','Leona');
insert into ChampionSkill values('SOLAR FLARE','Leona');
insert into ChampionSkill values('PROWLING PROJECTILE','Yuumi');
insert into ChampionSkill values('YOU AND ME!','Yuumi');
insert into ChampionSkill values('ZOOMIES','Yuumi');
insert into ChampionSkill values('FINAL CHAPTER','Yuumi');
insert into ChampionSkill values('DREDGE LINE','Nautilus');
insert into ChampionSkill values('TITANS WRATH','Nautilus');
insert into ChampionSkill values('RIPTIDE','Nautilus');
insert into ChampionSkill values('DEPTH CHARGE','Nautilus');
insert into ChampionSkill values('FIVE POINT STRIKE','Akali');
insert into ChampionSkill values('TWILIGHT SHROUD','Akali');
insert into ChampionSkill values('SHURIKEN FLIP','Akali');
insert into ChampionSkill values('PERFECT EXECUTION','Akali');
insert into ChampionSkill values('THREADED VOLLEY','Taliyah');
insert into ChampionSkill values('SEISMIC SHOVE','Taliyah');
insert into ChampionSkill values('UNRAVELED EARTH','Taliyah');
insert into ChampionSkill values('WEAVERS WALL','Taliyah');
insert into ChampionSkill values('PULVERIZE','Alistar');
insert into ChampionSkill values('HEADBUTT','Alistar');
insert into ChampionSkill values('TRAMPLE','Alistar');
insert into ChampionSkill values('UNBREAKABLE WILL','Alistar');
insert into ChampionSkill values('CHOMP','Trundle');
insert into ChampionSkill values('FROZEN DOMAIN','Trundle');
insert into ChampionSkill values('PILLAR OF ICE','Trundle');
insert into ChampionSkill values('SUBJUGATE','Trundle');
insert into ChampionSkill values('SPINNING AXE','Draven');
insert into ChampionSkill values('BLOOD RUSH','Draven');
insert into ChampionSkill values('STAND ASIDE','Draven');
insert into ChampionSkill values('WHIRLING DEATH','Draven');
insert into ChampionSkill values('SIPHON POWER','Viktor');
insert into ChampionSkill values('GRAVITY FIELD','Viktor');
insert into ChampionSkill values('DEATH RAY','Viktor');
insert into ChampionSkill values('CHAOS STORM','Viktor');
insert into ChampionSkill values('HIGH NOTE','Seraphine');
insert into ChampionSkill values('SURROUND SOUND','Seraphine');
insert into ChampionSkill values('BEAT DROP','Seraphine');
insert into ChampionSkill values('ENCORE','Seraphine');
insert into ChampionSkill values('VOLCANIC RUPTURE','Ornn');
insert into ChampionSkill values('BELLOWS BREATH','Ornn');
insert into ChampionSkill values('SEARING CHARGE','Ornn');
insert into ChampionSkill values('CALL OF THE FORGE GOD','Ornn');
insert into ChampionSkill values('LUNGE','Fiora');
insert into ChampionSkill values('RIPOSTE','Fiora');
insert into ChampionSkill values('BLADEWORK','Fiora');
insert into ChampionSkill values('GRAND CHALLENGE','Fiora');
insert into ChampionSkill values('HAMMER SHOCK','Poppy');
insert into ChampionSkill values('STEADFAST PRESENCE','Poppy');
insert into ChampionSkill values('HEROIC CHARGE','Poppy');
insert into ChampionSkill values('KEEPERS VERDICT','Poppy');
insert into ChampionSkill values('RAPID FIRE','Tristana');
insert into ChampionSkill values('ROCKET JUMP','Tristana');
insert into ChampionSkill values('EXPLOSIVE CHARGE','Tristana');
insert into ChampionSkill values('BUSTER SHOT','Tristana');
insert into ChampionSkill values('THUNDERING SHURIKEN','Kennen');
insert into ChampionSkill values('ELECTRICAL SURGE','Kennen');
insert into ChampionSkill values('LIGHTNING RUSH','Kennen');
insert into ChampionSkill values('SLICING MAELSTROM','Kennen');
insert into ChampionSkill values('SONIC WAVE / RESONATING STRIKE','Lee Sin');
insert into ChampionSkill values('SAFEGUARD / IRON WILL','Lee Sin');
insert into ChampionSkill values('TEMPEST / CRIPPLE','Lee Sin');
insert into ChampionSkill values('DRAGONS RAGE','Lee Sin');
insert into ChampionSkill values('TONGUE LASH','Tahm Kench');
insert into ChampionSkill values('ABYSSAL DIVE','Tahm Kench');
insert into ChampionSkill values('THICK SKIN','Tahm Kench');
insert into ChampionSkill values('DEVOUR','Tahm Kench');
insert into ChampionSkill values('WINDS OF WAR','Galio');
insert into ChampionSkill values('SHIELD OF DURAND','Galio');
insert into ChampionSkill values('JUSTICE PUNCH','Galio');
insert into ChampionSkill values('HEROS ENTRANCE','Galio');
insert into ChampionSkill values('ICE SHARD','Lissandra');
insert into ChampionSkill values('RING OF FROST','Lissandra');
insert into ChampionSkill values('GLACIAL PATH','Lissandra');
insert into ChampionSkill values('FROZEN TOMB','Lissandra');
insert into ChampionSkill values('CULL THE MEEK','Renekton');
insert into ChampionSkill values('RUTHLESS PREDATOR','Renekton');
insert into ChampionSkill values('SLICE AND DICE','Renekton');
insert into ChampionSkill values('DOMINUS','Renekton');
insert into ChampionSkill values('VAULT BREAKER','Vi');
insert into ChampionSkill values('DENTING BLOWS','Vi');
insert into ChampionSkill values('RELENTLESS FORCE','Vi');
insert into ChampionSkill values('CEASE AND DESIST','Vi');
insert into ChampionSkill values('MYSTIC SHOT','Ezreal');
insert into ChampionSkill values('ESSENCE FLUX','Ezreal');
insert into ChampionSkill values('ARCANE SHIFT','Ezreal');
insert into ChampionSkill values('TRUESHOT BARRAGE','Ezreal');
insert into ChampionSkill values('LEAP STRIKE','Jax');
insert into ChampionSkill values('EMPOWER','Jax');
insert into ChampionSkill values('COUNTER STRIKE','Jax');
insert into ChampionSkill values('GRANDMASTERS MIGHT','Jax');
insert into ChampionSkill values('WINTERS BITE','Braum');
insert into ChampionSkill values('STAND BEHIND ME','Braum');
insert into ChampionSkill values('UNBREAKABLE','Braum');
insert into ChampionSkill values('GLACIAL FISSURE','Braum');
insert into ChampionSkill values('BLADE OF THE RUINED KING','Viego');
insert into ChampionSkill values('SPECTRAL MAW','Viego');
insert into ChampionSkill values('HARROWED PATH','Viego');
insert into ChampionSkill values('HEARTBREAKER','Viego');
insert into ChampionSkill values('SNIP SNIP!','Gwen');
insert into ChampionSkill values('HALLOWED MIST','Gwen');
insert into ChampionSkill values('SKIP N SLASH','Gwen');
insert into ChampionSkill values('NEEDLEWORK','Gwen');
insert into ChampionSkill values('MISTRAL BOLT','Vex');
insert into ChampionSkill values('PERSONAL SPACE','Vex');
insert into ChampionSkill values('LOOMING DARKNESS','Vex');
insert into ChampionSkill values('SHADOW SURGE','Vex');
insert into ChampionSkill values('COMET SPEAR','Pantheon');
insert into ChampionSkill values('SHIELD VAULT','Pantheon');
insert into ChampionSkill values('AEGIS ASSAULT','Pantheon');
insert into ChampionSkill values('GRAND STARFALL','Pantheon');
insert into ChampionSkill values('PRECISION PROTOCOL','Camille');
insert into ChampionSkill values('TACTICAL SWEEP','Camille');
insert into ChampionSkill values('HOOKSHOT','Camille');
insert into ChampionSkill values('THE HEXTECH ULTIMATUM','Camille');
insert into ChampionSkill values('DOUBLE DAGGERS','Xayah');
insert into ChampionSkill values('DEADLY PLUMAGE','Xayah');
insert into ChampionSkill values('BLADECALLER','Xayah');
insert into ChampionSkill values('FEATHERSTORM','Xayah');
insert into ChampionSkill values('SHATTERING STRIKE','Rell');
insert into ChampionSkill values('FERROMANCY: CRASH DOWN','Rell');
insert into ChampionSkill values('ATTRACT AND REPEL','Rell');
insert into ChampionSkill values('MAGNET STORM','Rell');
insert into ChampionSkill values('ORB OF DECEPTION','Ahri');
insert into ChampionSkill values('FOX-FIRE','Ahri');
insert into ChampionSkill values('CHARM','Ahri');
insert into ChampionSkill values('SPIRIT RUSH','Ahri');
insert into ChampionSkill values('DEATHS HAND','Swain');
insert into ChampionSkill values('VISION OF EMPIRE','Swain');
insert into ChampionSkill values('NEVERMOVE','Swain');
insert into ChampionSkill values('DEMONIC ASCENSION','Swain');
insert into ChampionSkill values('KNUCKLE DOWN','Sett');
insert into ChampionSkill values('HAYMAKER','Sett');
insert into ChampionSkill values('FACEBREAKER','Sett');
insert into ChampionSkill values('THE SHOW STOPPER','Sett');
insert into ChampionSkill values('HANDSHAKE','Renata Glasc');
insert into ChampionSkill values('BAILOUT','Renata Glasc');
insert into ChampionSkill values('LOYALTY PROGRAM','Renata Glasc');
insert into ChampionSkill values('HOSTILE TAKEOVER','Renata Glasc');
insert into ChampionSkill values('VOID SURGE','BelVeth');
insert into ChampionSkill values('ABOVE AND BELOW','BelVeth');
insert into ChampionSkill values('ROYAL MAELSTROM','BelVeth');
insert into ChampionSkill values('ENDLESS BANQUET','BelVeth');
insert into ChampionSkill values('BOOMERANG BLADE','Sivir');
insert into ChampionSkill values('RICOCHET','Sivir');
insert into ChampionSkill values('SPELL SHIELD','Sivir');
insert into ChampionSkill values('ON THE HUNT','Sivir');
insert into ChampionSkill values('BLOOMING BLOWS','Lillia');
insert into ChampionSkill values('WATCH OUT! EEP!','Lillia');
insert into ChampionSkill values('SWIRLSEED','Lillia');
insert into ChampionSkill values('LILTING LULLABY','Lillia');
insert into ChampionSkill values('MORTAL STEEL','Yone');
insert into ChampionSkill values('SPIRIT CLEAVE','Yone');
insert into ChampionSkill values('SOUL UNBOUND','Yone');
insert into ChampionSkill values('FATE SEALED','Yone');
insert into ChampionSkill values('DRAGON STRIKE','JarvanIV');
insert into ChampionSkill values('GOLDEN AEGIS','JarvanIV');
insert into ChampionSkill values('DEMACIAN STANDARD','JarvanIV');
insert into ChampionSkill values('CATACLYSM','JarvanIV');
insert into ChampionSkill values('OBLITERATE','Mordekaiser');
insert into ChampionSkill values('INDESTRUCTIBLE','Mordekaiser');
insert into ChampionSkill values('DEATHS GRASP','Mordekaiser');
insert into ChampionSkill values('REALM OF DEATH','Mordekaiser');
insert into ChampionSkill values('UNDERTOW','Olaf');
insert into ChampionSkill values('TOUGH IT OUT','Olaf');
insert into ChampionSkill values('RECKLESS SWING','Olaf');
insert into ChampionSkill values('RAGNAROK','Olaf');
insert into ChampionSkill values('DEATH SENTENCE','Thresh');
insert into ChampionSkill values('DARK PASSAGE','Thresh');
insert into ChampionSkill values('FLAY','Thresh');
insert into ChampionSkill values('THE BOX','Thresh');
insert into ChampionSkill values('PIERCING ARROW','Varus');
insert into ChampionSkill values('BLIGHTED QUIVER','Varus');
insert into ChampionSkill values('HAIL OF ARROWS','Varus');
insert into ChampionSkill values('CHAIN OF CORRUPTION','Varus');

insert into DamageSkill values('THE DARKIN BLADE','Aatrox',12000);
insert into DamageSkill values('CHAIN LASH','Sylas',10000);
insert into DamageSkill values('KINGSLAYER','KINGSLAYER',13000);
insert into DamageSkill values('BRAMBLE SMASH','Maokai',15000);
insert into DamageSkill values('RAMPAGE','Hecarim',15000);
insert into DamageSkill values('PILTOVER PEACEMAKER','Caitlyn',13000);
insert into DamageSkill values('ACE IN THE HOLE','Caitlyn',15000);
insert into DamageSkill values('ICATHIAN RAIN','KaiSa',13000);
insert into DamageSkill values('Looming Darkness','KaiSa',15000);
insert into DamageSkill values('END OF THE LINE','Graves',13000);
insert into DamageSkill values('COLLATERAL DAMAGE','Graves',15000);
insert into DamageSkill values('SIGIL OF MALICE','LeBlanc',13000);
insert into DamageSkill values('DISTORTION','LeBlanc',15000);

insert into ControlSkill values('INFERNAL CHAINS','Aatrox','enemies will be dragged to the center', 0.2);
insert into ControlSkill values('ABSCOND / ABDUCT','Sylas','pulling himself to an enemy he hits',1);
insert into ControlSkill values('TWISTED ADVANCE','Maokai','contorts into a mass of moving roots, becoming untargetable and dashing to the target. Upon arrival, he roots the target',1);
insert into ControlSkill values('NATURES GRASP','Maokai','summons a colossal wall of brambles and thorns that slowly advances forwards, damaging and rooting any enemies in the path',2);
insert into ControlSkill values('ARCTIC ASSAULT','Sejuani','knocking enemies into the air',1);
insert into ControlSkill values('PERMAFROST','Sejuani','freezes and stuns an enemy champion that has maximum Frost stacks',1);
insert into ControlSkill values('GLACIAL PRISON','Sejuani','freezes and stuns the first champion hit and creates an ice storm that slows other enemies',1);
insert into ControlSkill values('DEVASTATING CHARGE','Hecarim','next attack knocks the target back',1);
insert into ControlSkill values('ONSLAUGHT OF SHADOWS','Hecarim','creates a shockwave when he finishes his charge, causing nearby enemies to flee in terror',1);
insert into ControlSkill values('YORDLE SNAP TRAP','Caitlyn',' when sprung, reveals and immobilizes the enemy champion for 1.5 seconds',1);
insert into ControlSkill values('BANDAGE TOSS','Amumu',' Amumu tosses a sticky bandage at a target, stunning and damaging the target while he pulls himself to them',1);
insert into ControlSkill values('CURSE OF THE SAD MUMMY','Amumu',' entangles surrounding enemy units in bandages, applying his Curse, damaging and stunning them',1);
insert into ControlSkill values('END OF THE LINE','Azir',' entangles surrounding enemy units in bandages, applying his Curse, damaging and stunning them',1);
insert into ControlSkill values('GNAR!','Gnar',' enemy that hits a wall is stunned and takes bonus damage',1);
insert into ControlSkill values('ETHEREAL CHAINS','LeBlanc',' If the target remains shackled for 1.5 seconds, LeBlanc roots them and deals additional damage.',1);
insert into ControlSkill values('SHIELD OF DAYBREAK','Leona','Leona uses her shield to perform her next basic attack, dealing bonus magic damage and stunning the target.',1);
insert into ControlSkill values('ZENITH BLADE','Leona','When the image fades, the last enemy champion struck will be briefly immobilized and Leona will dash to them.',1);
insert into ControlSkill values('SOLAR FLARE','Leona','Enemies in the center of the area are stunned, while enemies on the outside are slowed.',1);
insert into ControlSkill values('FINAL CHAPTER','Yuumi','Yuumi channels seven waves of damage, rooting anyone hit by three or more. Yuumi can move, attach, and cast Zoomies! while channeling.',1);
insert into ControlSkill values('DREDGE LINE','Nautilus','Nautilus hurls his anchor forward. Colliding with an enemy pulls them and Nautilus together, dealing magic damage. Colliding with terrain pulls Nautilus towards it.',1);
insert into ControlSkill values('DEPTH CHARGE','Nautilus','Nautilus fires a shockwave into the earth that chases an opponent. This shockwave rips up the earth above it, knocking enemies into the air. When it reaches the opponent, the shockwave erupts, knocking his target into the air and stunning them.',1);


insert into SupportSkill values('DARK PASSAGE','Thresh',0,200);
insert into SupportSkill values('Tidecaller Blessing','Nami',200,300);
insert into SupportSkill values('Ebb and Flow','Nami',300,200);
insert into SupportSkill values('Eye Of The Storm','Janna',500,300);
insert into SupportSkill values('Zephyr','Janna',200,400);
insert into SupportSkill values('ZOOMIES','Yuumi',200,400);

insert into CoachContract2 values('head coach',1000000);
insert into CoachContract2 values('assistant coach',200000);
insert into CoachContract2 values('leader',500000);
insert into CoachContract2 values('manager',1200000);
insert into CoachContract2 values('analyst',600000);

insert into CoachContract1 values('RNG','KenZhu','S12','head coach');
insert into CoachContract1 values('RNG','Xiaobai','S12','assistant coach');
insert into CoachContract1 values('RNG','Tabe','S12','analyst');
insert into CoachContract1 values('RNG','Sin','S12','analyst');
insert into CoachContract1 values('TES','Crescent','S12','head coach');
insert into CoachContract1 values('TES','BZ','S12','analyst');
insert into CoachContract1 values('JDG','Homme','S12','head coach');
insert into CoachContract1 values('JDG','Huge','S12','analyst');
insert into CoachContract1 values('EDG','Aaron','S12','leader');
insert into CoachContract1 values('EDG','Maokai','S12','head coach');
insert into CoachContract1 values('GENG','Score','S12','head coach');
insert into CoachContract1 values('DRX','SSONG','S12','head coach');
insert into CoachContract1 values('T1','Bengi','S12','head coach');
insert into CoachContract1 values('T1','Gisepa','S12','analyst');
insert into CoachContract1 values('DK','Daeny','S12','head coach');
insert into CoachContract1 values('G2','Dylan Falco','S12','head coach');
insert into CoachContract1 values('G2','Raf','S12','manager');
insert into CoachContract1 values('RGE','fredy122','S12','head coach');
insert into CoachContract1 values('RGE','Arces','S12','analyst');
insert into CoachContract1 values('MAD','Mac','S12','head coach');
insert into CoachContract1 values('MAD','Pad','S12','analyst');
insert into CoachContract1 values('FNC','YamatoCannon','S12','head coach');
insert into CoachContract1 values('FNC','Jeremias Knehr','S12','leader');
insert into CoachContract1 values('100T','Reapered','S12','head coach');
insert into CoachContract1 values('100T','JungleJuice','S12','manager');
insert into CoachContract1 values('C9','Max Waldo','S12','head coach');
insert into CoachContract1 values('C9','Tran','S12','manager');
insert into CoachContract1 values('EG','Rigby','S12','head coach');
insert into CoachContract1 values('CFO','Achie','S12','head coach');
insert into CoachContract1 values('BYG','Benny','S12','head coach');
insert into CoachContract1 values('SGB','Ren','S12','head coach');
insert into CoachContract1 values('GAM','JackieWind','S12','head coach');
insert into CoachContract1 values('DFM','Kazu','S12','head coach');
insert into CoachContract1 values('ISG','Ukkyr','S12','head coach');
insert into CoachContract1 values('LLL','Escalante','S12','head coach');
insert into CoachContract1 values('IW','Robogod','S12','head coach');
insert into CoachContract1 values('CHF','Cuden','S12','head coach');



insert into PlayerContract2 values(1,5000000);
insert into PlayerContract2 values(2,1000000);
insert into PlayerContract2 values(3,500000);
insert into PlayerContract2 values(4,200000);
insert into PlayerContract2 values(5,100000);

insert into PlayerContract1 values('Breathe','RNG','S12','top',2);
insert into PlayerContract1 values('Wei','RNG','S12','jungle',1);
insert into PlayerContract1 values('XiaoHu','RNG','S12','mid',1);
insert into PlayerContract1 values('Gala','RNG','S12','bot',1);
insert into PlayerContract1 values('Ming','RNG','S12','sup',2);
insert into PlayerContract1 values('Wayward','TES','S12','top',3);
insert into PlayerContract1 values('Tian','TES','S12','jungle',1);
insert into PlayerContract1 values('Knight','TES','S12','mid',1);
insert into PlayerContract1 values('Jackeylove','TES','S12','bot',1);
insert into PlayerContract1 values('Mark','TES','S12','sup',2);
insert into PlayerContract1 values('369','JDG','S12','top',1);
insert into PlayerContract1 values('Kanavi','JDG','S12','jungle',1);
insert into PlayerContract1 values('Yagao','JDG','S12','mid',1);
insert into PlayerContract1 values('Hope','JDG','S12','bot',3);
insert into PlayerContract1 values('Missing','JDG','S12','sup',2);
insert into PlayerContract1 values('Flandre','EDG','S12','top',2);
insert into PlayerContract1 values('Jiejie','EDG','S12','jungle',2);
insert into PlayerContract1 values('Scout','EDG','S12','mid',1);
insert into PlayerContract1 values('Viper','EDG','S12','bot',1);
insert into PlayerContract1 values('Meiko','EDG','S12','sup',2);
insert into PlayerContract1 values('Doran','GENG','S12','top',2);
insert into PlayerContract1 values('Peanut','GENG','S12','jungle',1);
insert into PlayerContract1 values('Chovy','GENG','S12','mid',1);
insert into PlayerContract1 values('Ruler','GENG','S12','bot',1);
insert into PlayerContract1 values('Lehends','GENG','S12','sup',1);
insert into PlayerContract1 values('Zeus','T1','S12','top',1);
insert into PlayerContract1 values('Oner','T1','S12','jungle',1);
insert into PlayerContract1 values('Faker','T1','S12','mid',1);
insert into PlayerContract1 values('Gumayusi','T1','S12','bot',1);
insert into PlayerContract1 values('Keria','T1','S12','sup',1);
insert into PlayerContract1 values('Nuguri','DK','S12','top',2);
insert into PlayerContract1 values('Canyon','DK','S12','jungle',1);
insert into PlayerContract1 values('Showmaker','DK','S12','mid',1);
insert into PlayerContract1 values('Deokdam','DK','S12','bot',2);
insert into PlayerContract1 values('Kellin','DK','S12','sup',3);
insert into PlayerContract1 values('Kingen','DRX','S12','top',1);
insert into PlayerContract1 values('Pyosik','DRX','S12','jungle',1);
insert into PlayerContract1 values('Zeka','DRX','S12','mid',1);
insert into PlayerContract1 values('Deft','DRX','S12','bot',1);
insert into PlayerContract1 values('BeryL','DRX','S12','sup',1);
insert into PlayerContract1 values('BrokenBlade','G2','S12','top',2);
insert into PlayerContract1 values('Jankos','G2','S12','jungle',1);
insert into PlayerContract1 values('caPs','G2','S12','mid',1);
insert into PlayerContract1 values('Flakked','G2','S12','bot',2);
insert into PlayerContract1 values('Targamas','G2','S12','sup',2);
insert into PlayerContract1 values('Odoamne','RGE','S12','top',2);
insert into PlayerContract1 values('Malrang','RGE','S12','jungle',2);
insert into PlayerContract1 values('Larssen','RGE','S12','mid',1);
insert into PlayerContract1 values('Comp','RGE','S12','bot',1);
insert into PlayerContract1 values('Trymbi','RGE','S12','sup',2);
insert into PlayerContract1 values('Armut','MAD','S12','top',1);
insert into PlayerContract1 values('Elyoya','MAD','S12','jungle',1);
insert into PlayerContract1 values('Nisqy','MAD','S12','mid',2);
insert into PlayerContract1 values('UNF0RGIVEN','MAD','S12','bot',3);
insert into PlayerContract1 values('Kaiser','MAD','S12','sup',2);
insert into PlayerContract1 values('Wunder','MAD','S12','top',1);
insert into PlayerContract1 values('Razork','MAD','S12','jungle',2);
insert into PlayerContract1 values('Humanoid','MAD','S12','mid',2);
insert into PlayerContract1 values('Upset','MAD','S12','bot',1);
insert into PlayerContract1 values('Hylissang','MAD','S12','sup',2);
insert into PlayerContract1 values('Ssumday','100T','S12','top',2);
insert into PlayerContract1 values('Closer','100T','S12','jungle',3);
insert into PlayerContract1 values('Abbedagge','100T','S12','mid',3);
insert into PlayerContract1 values('FBI','100T','S12','bot',1);
insert into PlayerContract1 values('huhi','100T','S12','sup',3);
insert into PlayerContract1 values('Fudge','C9','S12','top',2);
insert into PlayerContract1 values('Blaber','C9','S12','jungle',2);
insert into PlayerContract1 values('Jensen','C9','S12','mid',1);
insert into PlayerContract1 values('Berserker','C9','S12','bot',3);
insert into PlayerContract1 values('Zven','C9','S12','sup',2);
insert into PlayerContract1 values('Impact','EG','S12','top',2);
insert into PlayerContract1 values('Inspired','EG','S12','jungle',3);
insert into PlayerContract1 values('Jojopyun','EG','S12','mid',2);
insert into PlayerContract1 values('Kaori','EG','S12','bot',3);
insert into PlayerContract1 values('Vulcan','EG','S12','sup',3);
insert into PlayerContract1 values('Rest','CFO','S12','top',4);
insert into PlayerContract1 values('Gemini','CFO','S12','jungle',3);
insert into PlayerContract1 values('M1ssion','CFO','S12','mid',4);
insert into PlayerContract1 values('Shunn','CFO','S12','bot',3);
insert into PlayerContract1 values('Koala','CFO','S12','sup',3);
insert into PlayerContract1 values('Likai','BYG','S12','top',4);
insert into PlayerContract1 values('Husha','BYG','S12','jungle',4);
insert into PlayerContract1 values('Minji','BYG','S12','mid',4);
insert into PlayerContract1 values('Wako','BYG','S12','bot',3);
insert into PlayerContract1 values('Kino','BYG','S12','sup',4);
insert into PlayerContract1 values('Hasmed','SGB','S12','top',4);
insert into PlayerContract1 values('Bean J','SGB','S12','jungle',4);
insert into PlayerContract1 values('Froggy','SGB','S12','mid',4);
insert into PlayerContract1 values('Shogun','SGB','S12','bot',3);
insert into PlayerContract1 values('Taki','SGB','S12','sup',4);
insert into PlayerContract1 values('Kiaya','GAM','S12','top',3);
insert into PlayerContract1 values('Levi','GAM','S12','jungle',1);
insert into PlayerContract1 values('Kati','GAM','S12','mid',3);
insert into PlayerContract1 values('Style','GAM','S12','bot',2);
insert into PlayerContract1 values('Bie','GAM','S12','sup',2);
insert into PlayerContract1 values('Evi','DFM','S12','top',1);
insert into PlayerContract1 values('Steal','DFM','S12','jungle',3);
insert into PlayerContract1 values('Yaharong','DFM','S12','mid',2);
insert into PlayerContract1 values('Yutapon','DFM','S12','bot',1);
insert into PlayerContract1 values('Harp','DFM','S12','sup',3);
insert into PlayerContract1 values('ADD','ISG','S12','top',1);
insert into PlayerContract1 values('Grell','ISG','S12','jungle',4);
insert into PlayerContract1 values('Seiya','ISG','S12','mid',3);
insert into PlayerContract1 values('Gavotto','ISG','S12','bot',4);
insert into PlayerContract1 values('Jelly','ISG','S12','sup',3);
insert into PlayerContract1 values('Robo','LLL','S12','top',4);
insert into PlayerContract1 values('Croc','LLL','S12','jungle',4);
insert into PlayerContract1 values('tinowns','LLL','S12','mid',3);
insert into PlayerContract1 values('Brance','LLL','S12','bot',4);
insert into PlayerContract1 values('Ceos','LLL','S12','sup',3);
insert into PlayerContract1 values('StarScreen','IW','S12','top',4);
insert into PlayerContract1 values('Ferret','IW','S12','jungle',4);
insert into PlayerContract1 values('Serin','IW','S12','mid',5);
insert into PlayerContract1 values('HolyPhoenix','IW','S12','bot',4);
insert into PlayerContract1 values('Farfetch','IW','S12','sup',5);
insert into PlayerContract1 values('Topoon','CHF','S12','top',4);
insert into PlayerContract1 values('Arthur','CHF','S12','jungle',4);
insert into PlayerContract1 values('Tally','CHF','S12','mid',5);
insert into PlayerContract1 values('Raes','CHF','S12','bot',4);
insert into PlayerContract1 values('Dragku','CHF','S12','sup',5);

insert into Pick values('ADD','Ornn',1,'S12','WorldChampionship','1.0',7842,'top');
insert into Pick values('Grell','Graves',1,'S12','WorldChampionship','2.0',26855,'jungle');
insert into Pick values('Seiya','Lissandra',1,'S12','WorldChampionship','5.0',12814,'mid');
insert into Pick values('Gavotto','MissFortune',1,'S12','WorldChampionship','4.0',15985,'bot');
insert into Pick values('Jelly','Amumu',1,'S12','WorldChampionship','1.2',5359,'sup');
insert into Pick values('Armut','Gnar',1,'S12','WorldChampionship','3.0',19480,'top');
insert into Pick values('Elyoya','Hecarim',1,'S12','WorldChampionship','3.0',16094,'jungle');
insert into Pick values('Nisqy','Taliyah',1,'S12','WorldChampionship','3.0',23358,'mid');
insert into Pick values('UNF0RGIVEN','Seraphine',1,'S12','WorldChampionship','3.0',13970,'bot');
insert into Pick values('Kaiser','Leona',1,'S12','WorldChampionship','3.0',2661,'sup');
insert into Pick values('Wunder','Aatrox',2,'S12','WorldChampionship','2.0',13804,'top');
insert into Pick values('Razork','Graves',2,'S12','WorldChampionship','6.0',11203,'jungle');
insert into Pick values('Humanoid','Viktor',2,'S12','WorldChampionship','4.0',19837,'mid');
insert into Pick values('Upset','MissFortune',2,'S12','WorldChampionship','8.0',12694,'bot');
insert into Pick values('Rhuckz','Leona',2,'S12','WorldChampionship','8.0',3262,'sup');
insert into Pick values('Impact','Renekton',2,'S12','WorldChampionship','1.0',6632,'top');
insert into Pick values('Inspired','Viego',2,'S12','WorldChampionship','1.0',4836,'jungle');
insert into Pick values('Jojopyun','Sylas',2,'S12','WorldChampionship','0.7',6894,'mid');
insert into Pick values('Kaori','Caitlyn',2,'S12','WorldChampionship','0.5',6798,'bot');
insert into Pick values('Kaiser','Lux',2,'S12','WorldChampionship','0.3',6535,'sup');
insert into Pick values('Robo','Jax',3,'S12','WorldChampionship','2.0',9017,'top');
insert into Pick values('Croc','Hecarim',3,'S12','WorldChampionship','0.5',6147,'jungle');
insert into Pick values('tinowns','Azir',3,'S12','WorldChampionship','0.5',13378,'mid');
insert into Pick values('Ceos','Seraphine',3,'S12','WorldChampionship','1.0',14093,'bot');
insert into Pick values('Rhuckz','Nautilus',3,'S12','WorldChampionship','0.6',4535,'sup');
insert into Pick values('Husha','Fiora',3,'S12','WorldChampionship','11.0',14656,'top');
insert into Pick values('Inspired','Sejuani',3,'S12','WorldChampionship','18.0',9596,'jungle');
insert into Pick values('Minji','LeBlanc',3,'S12','WorldChampionship','19.0',23800,'mid');
insert into Pick values('Wako','KaiSa',3,'S12','WorldChampionship','17.0',15937,'bot');
insert into Pick values('Kino','Amumu',3,'S12','WorldChampionship','8.5',5353,'sup');
insert into Pick values('Zeus','Camille',88,'S12','WorldChampionship','1.6',13712,'top');
insert into Pick values('Oner','Vi',88,'S12','WorldChampionship','2.0',7639,'jungle');
insert into Pick values('Faker','Galio',88,'S12','WorldChampionship','1.6',19930,'mid');
insert into Pick values('Gumayusi','Lucian',88,'S12','WorldChampionship','3.0',38225,'bot');
insert into Pick values('Keria','Nami',88,'S12','WorldChampionship','14.0',10484,'sup');
insert into Pick values('369','Jax',88,'S12','WorldChampionship','3.0',21027,'top');
insert into Pick values('Kanavi','Viego',88,'S12','WorldChampionship','4.0',13736,'jungle');
insert into Pick values('Yagao','Taliyah',88,'S12','WorldChampionship','15.0',21794,'mid');
insert into Pick values('Hope','Aphelios',88,'S12','WorldChampionship','4.0',30221,'bot');
insert into Pick values('Missing','Lulu',88,'S12','WorldChampionship','4.0',5897,'sup');
insert into Pick values('Zeus','Yone',89,'S12','WorldChampionship','4.0',20199,'top');
insert into Pick values('Oner','Poppy',89,'S12','WorldChampionship','4.5',8663,'jungle');
insert into Pick values('Faker','Ryze',89,'S12','WorldChampionship','2.0',17884,'mid');
insert into Pick values('Gumayusi','Lucian',89,'S12','WorldChampionship','4.0',32312,'bot');
insert into Pick values('Keria','Nami',89,'S12','WorldChampionship','11.0',7215,'sup');
insert into Pick values('369','Malphite',89,'S12','WorldChampionship','1.0',14471,'top');
insert into Pick values('Kanavi','BelVeth',89,'S12','WorldChampionship','7.0',14471,'jungle');
insert into Pick values('Yagao','Sylas',89,'S12','WorldChampionship','2.0',10962,'mid');
insert into Pick values('Hope','Aphelios',89,'S12','WorldChampionship','1.5',17981,'bot');
insert into Pick values('Missing','Lulu',89,'S12','WorldChampionship','2.0',5678,'sup');
insert into Pick values('Zeus','Gangplank',90,'S12','WorldChampionship','3.0',29979,'top');
insert into Pick values('Oner','Nocturne',90,'S12','WorldChampionship','3.5',11559,'jungle');
insert into Pick values('Faker','Ryze',90,'S12','WorldChampionship','4.0',20247,'mid');
insert into Pick values('Gumayusi','Lucian',90,'S12','WorldChampionship','7.0',25240,'bot');
insert into Pick values('Keria','Nami',90,'S12','WorldChampionship','4.5',8710,'sup');
insert into Pick values('369','Renekton',90,'S12','WorldChampionship','2.4',23530,'top');
insert into Pick values('Kanavi','Viego',90,'S12','WorldChampionship','1.5',10511,'jungle');
insert into Pick values('Yagao','Azir',90,'S12','WorldChampionship','3.0',17842,'mid');
insert into Pick values('Hope','Aphelios',90,'S12','WorldChampionship','1.2',12266,'bot');
insert into Pick values('Missing','Lulu',90,'S12','WorldChampionship','2.0',5063,'sup');
insert into Pick values('Zeus','Gragas',91,'S12','WorldChampionship','20.0',12614,'top');
insert into Pick values('Oner','Viego',91,'S12','WorldChampionship','24.0',18838,'jungle');
insert into Pick values('Faker','Azir',91,'S12','WorldChampionship','4.0',19773,'mid');
insert into Pick values('Gumayusi','Varus',91,'S12','WorldChampionship','33.0',23308,'bot');
insert into Pick values('Keria','Renata Glasc',91,'S12','WorldChampionship','25.0',6374,'sup');
insert into Pick values('369','Sejuani',91,'S12','WorldChampionship','1.0',12693,'top');
insert into Pick values('Kanavi','BelVeth',91,'S12','WorldChampionship','1.0',9789,'jungle');
insert into Pick values('Yagao','Sylas',91,'S12','WorldChampionship','0.4',9013,'mid');
insert into Pick values('Hope','Jhin',91,'S12','WorldChampionship','1.1',12818,'bot');
insert into Pick values('Missing','Karma',91,'S12','WorldChampionship','0.9',11625,'sup');
insert into Pick values('Doran','Fiora',92,'S12','WorldChampionship','6.0',13525,'top');
insert into Pick values('Peanut','Viego',92,'S12','WorldChampionship','7.0',5150,'jungle');
insert into Pick values('Chovy','Sylas',92,'S12','WorldChampionship','6.0',7686,'mid');
insert into Pick values('Ruler','Varus',92,'S12','WorldChampionship','8.0',15710,'bot');
insert into Pick values('Lehends','Tahm Kench',92,'S12','WorldChampionship','9.0',6038,'sup');
insert into Pick values('Kingen','Camille',92,'S12','WorldChampionship','1.0',5171,'top');
insert into Pick values('Pyosik','Sejuani',92,'S12','WorldChampionship','1.0',6478,'jungle');
insert into Pick values('Zeka','Azir',92,'S12','WorldChampionship','0.0',10246,'mid');
insert into Pick values('Deft','MissFortune',92,'S12','WorldChampionship','0.3',15250,'bot');
insert into Pick values('BeryL','Soraka',92,'S12','WorldChampionship','0.0',4995,'sup');
insert into Pick values('Doran','Ornn',93,'S12','WorldChampionship','0.0',9485,'top');
insert into Pick values('Peanut','Graves',93,'S12','WorldChampionship','0.3',9242,'jungle');
insert into Pick values('Chovy','Sylas',93,'S12','WorldChampionship','1.0',15706,'mid');
insert into Pick values('Ruler','Varus',93,'S12','WorldChampionship','1.0',28506,'bot');
insert into Pick values('Lehends','Karma',93,'S12','WorldChampionship','1.0',6035,'sup');
insert into Pick values('Kingen','Gragas',93,'S12','WorldChampionship','6.0',14988,'top');
insert into Pick values('Pyosik','Kindred',93,'S12','WorldChampionship','4.0',10521,'jungle');
insert into Pick values('Zeka','Ahri',93,'S12','WorldChampionship','8.0',16628,'mid');
insert into Pick values('Deft','Caitlyn',93,'S12','WorldChampionship','8.0',19536,'bot');
insert into Pick values('BeryL','Lux',93,'S12','WorldChampionship','8.0',7889,'sup');
insert into Pick values('Doran','Sejuani',94,'S12','WorldChampionship','0.2',8580,'top');
insert into Pick values('Peanut','Trundle',94,'S12','WorldChampionship','0.8',5247,'jungle');
insert into Pick values('Chovy','Ryze',94,'S12','WorldChampionship','0.7',17349,'mid');
insert into Pick values('Ruler','Ezreal',94,'S12','WorldChampionship','1.0',16251,'bot');
insert into Pick values('Lehends','Karma',94,'S12','WorldChampionship','1.0',6645,'sup');
insert into Pick values('Kingen','Ornn',94,'S12','WorldChampionship','10.0',12520,'top');
insert into Pick values('Pyosik','Viego',94,'S12','WorldChampionship','13.0',10939,'jungle');
insert into Pick values('Zeka','Akali',94,'S12','WorldChampionship','9.0',14872,'mid');
insert into Pick values('Deft','Varus',94,'S12','WorldChampionship','3.5',16176,'bot');
insert into Pick values('BeryL','Tahm Kench',94,'S12','WorldChampionship','7.5',6779,'sup');
insert into Pick values('Doran','Renekton',95,'S12','WorldChampionship','2.3',9020,'top');
insert into Pick values('Peanut','Viego',95,'S12','WorldChampionship','1.0',6478,'jungle');
insert into Pick values('Chovy','Ryze',95,'S12','WorldChampionship','2.5',10543,'mid');
insert into Pick values('Ruler','Xayah',95,'S12','WorldChampionship','7.0',23202,'bot');
insert into Pick values('Lehends','Nautilus',95,'S12','WorldChampionship','0.8',3503,'sup');
insert into Pick values('Kingen','Gragas',95,'S12','WorldChampionship','5.0',16106,'top');
insert into Pick values('Pyosik','Kindred',95,'S12','WorldChampionship','6.0',21842,'jungle');
insert into Pick values('Zeka','Galio',95,'S12','WorldChampionship','5.5',13736,'mid');
insert into Pick values('Deft','Varus',95,'S12','WorldChampionship','11.0',21260,'bot');
insert into Pick values('BeryL','Braum',95,'S12','WorldChampionship','7.5',8477,'sup');
insert into Pick values('Zeus','Yone',96,'S12','WorldChampionship','9.0',18703,'top');
insert into Pick values('Oner','Lee Sin',96,'S12','WorldChampionship','10.0',9721,'jungle');
insert into Pick values('Faker','Azir',96,'S12','WorldChampionship','10.0',26017,'mid');
insert into Pick values('Gumayusi','Varus',96,'S12','WorldChampionship','6.0',12819,'bot');
insert into Pick values('Keria','Renata Glasc',96,'S12','WorldChampionship','4.5',5119,'sup');
insert into Pick values('Kingen','Aatrox',96,'S12','WorldChampionship','2.0',12763,'top');
insert into Pick values('Pyosik','Viego',96,'S12','WorldChampionship','1.0',6425,'jungle');
insert into Pick values('Zeka','Sylas',96,'S12','WorldChampionship','1.0',11599,'mid');
insert into Pick values('Deft','Sivir',96,'S12','WorldChampionship','0.6',12734,'bot');
insert into Pick values('BeryL','Heimerdinger',96,'S12','WorldChampionship','1.0',9832,'sup');
insert into Pick values('Zeus','Aatrox',97,'S12','WorldChampionship','1.6',20795,'top');
insert into Pick values('Oner','Graves',97,'S12','WorldChampionship','3.8',26059,'jungle');
insert into Pick values('Faker','Viktor',97,'S12','WorldChampionship','1.2',43895,'mid');
insert into Pick values('Gumayusi','Ashe',97,'S12','WorldChampionship','3.0',14569,'bot');
insert into Pick values('Keria','Lux',97,'S12','WorldChampionship','4.2',12589,'sup');
insert into Pick values('Kingen','Camille',97,'S12','WorldChampionship','4.5',19714,'top');
insert into Pick values('Pyosik','Viego',97,'S12','WorldChampionship','3.8',10773,'jungle');
insert into Pick values('Zeka','Sylas',97,'S12','WorldChampionship','3.5',22273,'mid');
insert into Pick values('Deft','Varus',97,'S12','WorldChampionship','12.0',41044,'bot');
insert into Pick values('BeryL','Heimerdinger',97,'S12','WorldChampionship','2.2',16779,'sup');
insert into Pick values('Zeus','Gragas',98,'S12','WorldChampionship','9.0',15762,'top');
insert into Pick values('Oner','Graves',98,'S12','WorldChampionship','0.6',16202,'jungle');
insert into Pick values('Faker','Azir',98,'S12','WorldChampionship','0.8',21759,'mid');
insert into Pick values('Gumayusi','Varus',98,'S12','WorldChampionship','3.5',17365,'bot');
insert into Pick values('Keria','Karma',98,'S12','WorldChampionship','11.0',12164,'sup');
insert into Pick values('Kingen','Ornn',98,'S12','WorldChampionship','2.0',16294,'top');
insert into Pick values('Pyosik','Viego',98,'S12','WorldChampionship','4.0',12023,'jungle');
insert into Pick values('Zeka','Sylas',98,'S12','WorldChampionship','4.0',20734,'mid');
insert into Pick values('Deft','Kalista',98,'S12','WorldChampionship','3.0',9965,'bot');
insert into Pick values('BeryL','Renata Glasc',98,'S12','WorldChampionship','6.0',7121,'sup');
insert into Pick values('Zeus','Fiora',99,'S12','WorldChampionship','1.0',10307,'top');
insert into Pick values('Oner','Sejuani',99,'S12','WorldChampionship','1.0',6916,'jungle');
insert into Pick values('Faker','Akali',99,'S12','WorldChampionship','0.0',8983,'mid');
insert into Pick values('Gumayusi','Kalista',99,'S12','WorldChampionship','1.0',8283,'bot');
insert into Pick values('Keria','Soraka',99,'S12','WorldChampionship','1.3',5923,'sup');
insert into Pick values('Kingen','Maokai',99,'S12','WorldChampionship','10.0',24992,'top');
insert into Pick values('Pyosik','Viego',99,'S12','WorldChampionship','10.0',9600,'jungle');
insert into Pick values('Zeka','Azir',99,'S12','WorldChampionship','6.0',16564,'mid');
insert into Pick values('Deft','Varus',99,'S12','WorldChampionship','2.3',18095,'bot');
insert into Pick values('BeryL','Renata Glasc',99,'S12','WorldChampionship','7.0',6497,'sup');
insert into Pick values('Zeus','Gwen',100,'S12','WorldChampionship','1.7',27484,'top');
insert into Pick values('Oner','Viego',100,'S12','WorldChampionship','4.5',18048,'jungle');
insert into Pick values('Faker','Viktor',100,'S12','WorldChampionship','1.2',22455,'mid');
insert into Pick values('Gumayusi','Varus',100,'S12','WorldChampionship','1.3',25819,'bot');
insert into Pick values('Keria','Karma',100,'S12','WorldChampionship','0.8',10850,'sup');
insert into Pick values('Kingen','Aatrox',100,'S12','WorldChampionship','4.0',27394,'top');
insert into Pick values('Pyosik','Hecarim',100,'S12','WorldChampionship','3.3',12378,'jungle');
insert into Pick values('Zeka','Azir',100,'S12','WorldChampionship','6.0',23386,'mid');
insert into Pick values('Deft','Caitlyn',100,'S12','WorldChampionship','9.0',19287,'bot');
insert into Pick values('BeryL','Bard',100,'S12','WorldChampionship','10.0',5521,'sup');



insert into Ban values('Ukkyr','Viktor',1,'S12','WorldChampionship',1,0.157);
insert into Ban values('Ukkyr','Swain',1,'S12','WorldChampionship',2,0.039);
insert into Ban values('Ukkyr','Sylas',1,'S12','WorldChampionship',3,0.385);
insert into Ban values('Ukkyr','Aatrox',1,'S12','WorldChampionship',4,0.622);
insert into Ban values('Ukkyr','Draven',1,'S12','WorldChampionship',5,0.173);
insert into Ban values('Mac','Caitlyn',1,'S12','WorldChampionship',1,0.677);
insert into Ban values('Mac','Kalista',1,'S12','WorldChampionship',2,0.338);
insert into Ban values('Mac','Sejuani',1,'S12','WorldChampionship',3,0.448);
insert into Ban values('Mac','Leblanc',1,'S12','WorldChampionship',4,0.228);
insert into Ban values('Mac','Azir',1,'S12','WorldChampionship',5,0.338);
insert into Ban values('YamatoCannon','Lee Sin',2,'S12','WorldChampionship',1,0.094);
insert into Ban values('YamatoCannon','JarvanIV',2,'S12','WorldChampionship',2,0.086);
insert into Ban values('YamatoCannon','Ornn',2,'S12','WorldChampionship',3,0.188);
insert into Ban values('YamatoCannon','Akali',2,'S12','WorldChampionship',4,0.259);
insert into Ban values('YamatoCannon','Draven',2,'S12','WorldChampionship',5,0.173);
insert into Ban values('Rigby','Yuumi',2,'S12','WorldChampionship',1,0.669);
insert into Ban values('Rigby','Kalista',2,'S12','WorldChampionship',2,0.338);
insert into Ban values('Rigby','Sejuani',2,'S12','WorldChampionship',3,0.448);
insert into Ban values('Rigby','Karma',2,'S12','WorldChampionship',4,0.039);
insert into Ban values('Rigby','Nautilus',2,'S12','WorldChampionship',5,0.188);
insert into Ban values('Escalante','Taliyah',3,'S12','WorldChampionship',1,0.133);
insert into Ban values('Escalante','Akali',3,'S12','WorldChampionship',2,0.259);
insert into Ban values('Escalante','Kalista',3,'S12','WorldChampionship',3,0.338);
insert into Ban values('Escalante','Aatrox',3,'S12','WorldChampionship',4,0.622);
insert into Ban values('Escalante','Sylas',3,'S12','WorldChampionship',5,0.385);
insert into Ban values('Benny','Yuumi',3,'S12','WorldChampionship',1,0.669);
insert into Ban values('Benny','Caitlyn',3,'S12','WorldChampionship',2,0.677);
insert into Ban values('Benny','Olaf',3,'S12','WorldChampionship',3,0.031);
insert into Ban values('Benny','Galio',3,'S12','WorldChampionship',4,0.055);
insert into Ban values('Benny','Leona',3,'S12','WorldChampionship',5,0.062);
insert into Ban values('Homme','Caitlyn',88,'S12','WorldChampionship',1,0.677);
insert into Ban values('Homme','Yuumi',88,'S12','WorldChampionship',2,0.669);
insert into Ban values('Homme','Graves',88,'S12','WorldChampionship',3,0.141);
insert into Ban values('Homme','Viktor',88,'S12','WorldChampionship',4,0.157);
insert into Ban values('Homme','Akali',88,'S12','WorldChampionship',5,0.259);
insert into Ban values('Bengi','Renekton',88,'S12','WorldChampionship',1,0.277);
insert into Ban values('Bengi','Ornn',88,'S12','WorldChampionship',2,0.188);
insert into Ban values('Bengi','Aatrox',88,'S12','WorldChampionship',3,0.622);
insert into Ban values('Bengi','Sylas',88,'S12','WorldChampionship',4,0.385);
insert into Ban values('Bengi','Sejuani',88,'S12','WorldChampionship',5,0.448);
insert into Ban values('Homme','Caitlyn',89,'S12','WorldChampionship',1,0.677);
insert into Ban values('Homme','Yuumi',89,'S12','WorldChampionship',2,0.669);
insert into Ban values('Homme','Graves',89,'S12','WorldChampionship',3,0.141);
insert into Ban values('Homme','Lee Sin',89,'S12','WorldChampionship',4,0.094);
insert into Ban values('Homme','Fiora',89,'S12','WorldChampionship',5,0.228);
insert into Ban values('Bengi','Renekton',89,'S12','WorldChampionship',1,0.277);
insert into Ban values('Bengi','Vi',89,'S12','WorldChampionship',2,0.086);
insert into Ban values('Bengi','Aatrox',89,'S12','WorldChampionship',3,0.622);
insert into Ban values('Bengi','Viego',89,'S12','WorldChampionship',4,0.141);
insert into Ban values('Bengi','Sejuani',89,'S12','WorldChampionship',5,0.448);
insert into Ban values('Homme','Jayce',90,'S12','WorldChampionship',1,0.015);
insert into Ban values('Homme','Lee Sin',90,'S12','WorldChampionship',2,0.094);
insert into Ban values('Homme','Sejuani',90,'S12','WorldChampionship',3,0.448);
insert into Ban values('Homme','Yone',90,'S12','WorldChampionship',4,0.055);
insert into Ban values('Homme','Caitlyn',90,'S12','WorldChampionship',5,0.677);
insert into Ban values('Bengi','Yuumi',90,'S12','WorldChampionship',1,0.669);
insert into Ban values('Bengi','Aatrox',90,'S12','WorldChampionship',2,0.622);
insert into Ban values('Bengi','Graves',90,'S12','WorldChampionship',3,0.141);
insert into Ban values('Bengi','Taliyah',90,'S12','WorldChampionship',4,0.133);
insert into Ban values('Bengi','Galio',90,'S12','WorldChampionship',5,0.055);
insert into Ban values('Homme','Fiora',91,'S12','WorldChampionship',1,0.228);
insert into Ban values('Homme','Tahm Kench',91,'S12','WorldChampionship',2,0.055);
insert into Ban values('Homme','Lucian',91,'S12','WorldChampionship',3,0.228);
insert into Ban values('Homme','Ryze',91,'S12','WorldChampionship',4,0.062);
insert into Ban values('Homme','Caitlyn',91,'S12','WorldChampionship',5,0.677);
insert into Ban values('Bengi','Yuumi',91,'S12','WorldChampionship',1,0.669);
insert into Ban values('Bengi','Aatrox',91,'S12','WorldChampionship',2,0.622);
insert into Ban values('Bengi','Graves',91,'S12','WorldChampionship',3,0.141);
insert into Ban values('Bengi','Taliyah',91,'S12','WorldChampionship',4,0.133);
insert into Ban values('Bengi','Ashe',91,'S12','WorldChampionship',5,0.055);
insert into Ban values('SSONG','Yuumi',92,'S12','WorldChampionship',1,0.669);
insert into Ban values('SSONG','Lucian',92,'S12','WorldChampionship',2,0.228);
insert into Ban values('SSONG','Caitlyn',92,'S12','WorldChampionship',3,0.677);
insert into Ban values('SSONG','Renekton',92,'S12','WorldChampionship',4,0.277);
insert into Ban values('SSONG','Renata Glasc',92,'S12','WorldChampionship',5,0.181);
insert into Ban values('Score','Karma',92,'S12','WorldChampionship',1,0.039);
insert into Ban values('Score','Ashe',92,'S12','WorldChampionship',2,0.055);
insert into Ban values('Score','Aatrox',92,'S12','WorldChampionship',3,0.622);
insert into Ban values('Score','Akali',92,'S12','WorldChampionship',4,0.259);
insert into Ban values('Score','Heimerdinger',92,'S12','WorldChampionship',5,0.102);
insert into Ban values('SSONG','Camille',93,'S12','WorldChampionship',1,0.669);
insert into Ban values('SSONG','Gnar',93,'S12','WorldChampionship',2,0.102);
insert into Ban values('SSONG','Ryze',93,'S12','WorldChampionship',3,0.062);
insert into Ban values('SSONG','Singed',93,'S12','WorldChampionship',4,0.007);
insert into Ban values('SSONG','Lucian',93,'S12','WorldChampionship',5,0.228);
insert into Ban values('Score','Heimerdinger',93,'S12','WorldChampionship',1,0.102);
insert into Ban values('Score','Aatrox',93,'S12','WorldChampionship',2,0.622);
insert into Ban values('Score','Yuumi',93,'S12','WorldChampionship',3,0.669);
insert into Ban values('Score','Akali',93,'S12','WorldChampionship',4,0.259);
insert into Ban values('Score','Azir',93,'S12','WorldChampionship',5,0.338);
insert into Ban values('SSONG','Yuumi',94,'S12','WorldChampionship',1,0.669);
insert into Ban values('SSONG','Lucian',94,'S12','WorldChampionship',2,0.228);
insert into Ban values('SSONG','Caitlyn',94,'S12','WorldChampionship',3,0.677);
insert into Ban values('SSONG','Renekton',94,'S12','WorldChampionship',4,0.277);
insert into Ban values('SSONG','Gnar',94,'S12','WorldChampionship',5,0.102);
insert into Ban values('Score','Gragas',94,'S12','WorldChampionship',1,0.023);
insert into Ban values('Score','Camille',94,'S12','WorldChampionship',2,0.669);
insert into Ban values('Score','Aatrox',94,'S12','WorldChampionship',3,0.622);
insert into Ban values('Score','Sylas',94,'S12','WorldChampionship',4,0.385);
insert into Ban values('Score','Heimerdinger',94,'S12','WorldChampionship',5,0.102);
insert into Ban values('SSONG','Yuumi',95,'S12','WorldChampionship',1,0.669);
insert into Ban values('SSONG','Lucian',95,'S12','WorldChampionship',2,0.228);
insert into Ban values('SSONG','Caitlyn',95,'S12','WorldChampionship',3,0.677);
insert into Ban values('SSONG','Aphelios',95,'S12','WorldChampionship',4,0.157);
insert into Ban values('SSONG','Sivir',95,'S12','WorldChampionship',5,0.015);
insert into Ban values('Score','Karma',95,'S12','WorldChampionship',1,0.039);
insert into Ban values('Score','Renata Glasc',95,'S12','WorldChampionship',2,0.181);
insert into Ban values('Score','Aatrox',95,'S12','WorldChampionship',3,0.622);
insert into Ban values('Score','Akali',95,'S12','WorldChampionship',4,0.259);
insert into Ban values('Score','Heimerdinger',95,'S12','WorldChampionship',5,0.102);
insert into Ban values('SSONG','Yuumi',96,'S12','WorldChampionship',1,0.669);
insert into Ban values('SSONG','Lucian',96,'S12','WorldChampionship',2,0.228);
insert into Ban values('SSONG','Caitlyn',96,'S12','WorldChampionship',3,0.677);
insert into Ban values('SSONG','Ryze',96,'S12','WorldChampionship',4,0.062);
insert into Ban values('SSONG','Graves',96,'S12','WorldChampionship',5,0.141);
insert into Ban values('Bengi','EZreal',96,'S12','WorldChampionship',1,0.055);
insert into Ban values('Bengi','Rell',96,'S12','WorldChampionship',2,0.047);
insert into Ban values('Bengi','Ashe',96,'S12','WorldChampionship',3,0.055);
insert into Ban values('Bengi','Akali',96,'S12','WorldChampionship',4,0.259);
insert into Ban values('Bengi','Sejuani',96,'S12','WorldChampionship',5,0.448);
insert into Ban values('SSONG','Azir',97,'S12','WorldChampionship',1,0.338);
insert into Ban values('SSONG','Nocturne',97,'S12','WorldChampionship',2,0.023);
insert into Ban values('SSONG','Renata Glasc',97,'S12','WorldChampionship',3,0.181);
insert into Ban values('SSONG','Ryze',97,'S12','WorldChampionship',4,0.062);
insert into Ban values('SSONG','Lucian',97,'S12','WorldChampionship',5,0.228);
insert into Ban values('Bengi','Yuumi',97,'S12','WorldChampionship',1,0.669);
insert into Ban values('Bengi','Caitlyn',97,'S12','WorldChampionship',2,0.677);
insert into Ban values('Bengi','Sejuani',97,'S12','WorldChampionship',3,0.448);
insert into Ban values('Bengi','Akali',97,'S12','WorldChampionship',4,0.259);
insert into Ban values('Bengi','Kindred',97,'S12','WorldChampionship',5,0.031);
insert into Ban values('SSONG','Yuumi',98,'S12','WorldChampionship',1,0.669);
insert into Ban values('SSONG','Lucian',98,'S12','WorldChampionship',2,0.228);
insert into Ban values('SSONG','Caitlyn',98,'S12','WorldChampionship',3,0.677);
insert into Ban values('SSONG','Yone',98,'S12','WorldChampionship',4,0.055);
insert into Ban values('SSONG','Lee Sin',98,'S12','WorldChampionship',5,0.094);
insert into Ban values('Bengi','Kindred',98,'S12','WorldChampionship',1,0.031);
insert into Ban values('Bengi','Aatrox',98,'S12','WorldChampionship',2,0.622);
insert into Ban values('Bengi','Ashe',98,'S12','WorldChampionship',3,0.055);
insert into Ban values('Bengi','Sejuani',98,'S12','WorldChampionship',4,0.448);
insert into Ban values('Bengi','Akali',98,'S12','WorldChampionship',5,0.259);
insert into Ban values('SSONG','Yone',99,'S12','WorldChampionship',1,0.055);
insert into Ban values('SSONG','Viktor',99,'S12','WorldChampionship',2,0.157);
insert into Ban values('SSONG','Ryze',99,'S12','WorldChampionship',3,0.062);
insert into Ban values('SSONG','Ashe',99,'S12','WorldChampionship',4,0.055);
insert into Ban values('SSONG','Lucian',99,'S12','WorldChampionship',5,0.228);
insert into Ban values('Bengi','Caitlyn',99,'S12','WorldChampionship',1,0.677);
insert into Ban values('Bengi','Yuumi',99,'S12','WorldChampionship',2,0.669);
insert into Ban values('Bengi','Heimerdinger',99,'S12','WorldChampionship',3,0.102);
insert into Ban values('Bengi','Kindred',99,'S12','WorldChampionship',4,0.031);
insert into Ban values('Bengi','Viego',99,'S12','WorldChampionship',5,0.141);
insert into Ban values('SSONG','Yuumi',100,'S12','WorldChampionship',1,0.669);
insert into Ban values('SSONG','Lucian',100,'S12','WorldChampionship',2,0.228);
insert into Ban values('SSONG','Lux',100,'S12','WorldChampionship',3,0.015);
insert into Ban values('SSONG','Yone',100,'S12','WorldChampionship',4,0.055);
insert into Ban values('SSONG','Lee Sin',100,'S12','WorldChampionship',5,0.094);
insert into Ban values('Bengi','Kindred',100,'S12','WorldChampionship',1,0.031);
insert into Ban values('Bengi','Sejuani',100,'S12','WorldChampionship',2,0.448);
insert into Ban values('Bengi','Heimerdinger',100,'S12','WorldChampionship',3,0.102);
insert into Ban values('Bengi','Renata Glasc',100,'S12','WorldChampionship',4,0.181);
insert into Ban values('Bengi','Akali',100,'S12','WorldChampionship',5,0.259);



insert into IsGoodAt values('Breathe','Fiora',1,0.6);
insert into IsGoodAt values('Breathe','Jax',2,0.7);
insert into IsGoodAt values('Breathe','Gnar',3,0.5);
insert into IsGoodAt values('Upset','Fiora',1,0.5);
insert into IsGoodAt values('Upset','Kalista',2,0.5);
insert into IsGoodAt values('Upset','Lucian',3,0.5);
insert into IsGoodAt values('Knight','Ahri',1,0.5);
insert into IsGoodAt values('Knight','Akali',2,1.0);
insert into IsGoodAt values('Knight','Sylas',3,1.0);
insert into IsGoodAt values('Liang','Aatrox',1,1.0);
insert into IsGoodAt values('Gumayusi','Varus',1,0.8);
insert into IsGoodAt values('Gumayusi','Lucian',2,0.75);
insert into IsGoodAt values('Gumayusi','Sivir',3,1.0);
insert into IsGoodAt values('Keria','Nami',1,0.75);
insert into IsGoodAt values('Keria','Renata Glasc',2,1.0);
insert into IsGoodAt values('Keria','Yuumi',3,1.0);
insert into IsGoodAt values('Gala','Aphelios',1,0.6);
insert into IsGoodAt values('Gala','KaiSa',2,0.5);
insert into IsGoodAt values('Gala','Tristana',3,0.75);
insert into IsGoodAt values('Inspired','Hecarim',1,0.667);
insert into IsGoodAt values('Inspired','Maokai',2,1.0);
insert into IsGoodAt values('Inspired','Lee Sin',3,1.0);
insert into IsGoodAt values('Larssen','Azir',1,0.4);
insert into IsGoodAt values('Larssen','Leblanc',2,0.0);
insert into IsGoodAt values('Larssen','Orianna',3,1.0);
insert into IsGoodAt values('Zeka','Sylas',1,0.8);
insert into IsGoodAt values('Zeka','Akali',2,0.667);
insert into IsGoodAt values('Zeka','Azir',3,0.667);
