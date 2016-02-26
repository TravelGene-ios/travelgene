CREATE TABLE IF NOT EXISTS users2 (
         userid MEDIUMINT NOT NULL AUTO_INCREMENT,
         name VARCHAR(100)  NOT NULL DEFAULT 'john',
         email VARCHAR(100)  NOT NULL,
         gender VARCHAR(10) NOT NULL DEFAULT 'male',
         age     INT UNSIGNED  NOT NULL DEFAULT 0,
         imgurl VARCHAR(2083) NOT NULL DEFAULT '',
         password VARCHAR(100)  NOT NULL,
         PRIMARY KEY  (userid)
       );

INSERT INTO users (name, email) VALUES ('QiQi Shi', 'qiqi.cmu@gmail.com');
INSERT INTO users (email,password) VALUES ('john@example.com', SHA2('123456',256));

CREATE TABLE IF NOT EXISTS friendlist (
         userid INT UNSIGNED  NOT NULL,
         followee INT UNSIGNED  NOT NULL,
         INDEX  (userid)
       );

CREATE TABLE IF NOT EXISTS tripdetail (
         tripid MEDIUMINT NOT NULL AUTO_INCREMENT,
         email VARCHAR(100)  NOT NULL,
         date_start DATE NOT NULL,
         date_end DATE NOT NULL,
         destination VARCHAR(100)  NOT NULL,
         activity JSON NOT NULL,
         PRIMARY KEY  (tripid)
       );

INSERT INTO tripdetail (email, date_start, date_end, destination, activity) VALUES('qiqi.cmu@gmail.com','2015-12-04','2015-12-05','{"activity": ["The National 9/11 Memorial & Museum, New York City", "CityRover Walks NY, New York City","Times Square, New York City","Staten Island Ferry, New York City"]}');
