CREATE TABLE tbl_member (
	userid VARCHAR(50) NOT NULL,
  userpw VARCHAR(50) NOT NULL,
  username VARCHAR(50) NOT NULL,
  email VARCHAR(100),
  regdate TIMESTAMP DEFAULT NOW(),
  updatedate TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY(userid)
);

CREATE TABLE tbl_board (
	bno INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(200) NOT NULL,
  content TEXT NULL,
  writer VARCHAR(50) NOT NULL,
  regdate TIMESTAMP NOT NULL DEFAULT NOW(),
  viewcnt INT DEFAULT 0,
  PRIMARY KEY(bno)
);

CREATE TABLE tbl_reply (
	rno INT NOT NULL AUTO_INCREMENT,
  bno INT NOT NULL DEFAULT 0,
  replytext VARCHAR(1000) NOT NULL,
  replyer VARCHAR(50) NOT NULL,
  regdate TIMESTAMP NOT NULL DEFAULT NOW(),
  updatedate TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY(rno)
);

CREATE TABLE tbl_message (
	mno INT NOT NULL AUTO_INCREMENT,
  targetid VARCHAR(50) NOT NULL,
  sender VARCHAR(50) NOT NULL,
  message TEXT NOT NULL,
  opendate TIMESTAMP,
  senddate TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY(mno)
);

CREATE TABLE tbl_user (
	uid VARCHAR(50) NOT NULL,
  upw VARCHAR(50) NOT NULL,
  uname VARCHAR(100) NOT NULL,
  upoint INT(11) DEFAULT 0,
  PRIMARY KEY(uid)
);

CREATE TABLE tbl_attach (
	fullName VARCHAR(150) NOT NULL,
    bno INT NOT NULL,
    regdate TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY(fullName)
);

ALTER TABLE tbl_reply ADD CONSTRAINT fk_borad
FOREIGN KEY(bno) REFERENCES tbl_board(bno);

ALTER TABLE tbl_message ADD CONSTRAINT fk_usertarget
FOREIGN KEY(targetid) REFERENCES tbl_user(uid);

ALTER TABLE tbl_message ADD CONSTRAINT fk_usersender
FOREIGN KEY(sender) REFERENCES tbl_user(uid);

ALTER TABLE tbl_attach ADD CONSTRAINT fk_board_attach
FOREIGN KEY(bno) REFERENCES tbl_board(bno);

ALTER TABLE tbl_user ADD COLUMN sessionkey VARCHAR(50) NOT NULL DEFAULT 'none';
ALTER TABLE tbl_user ADD COLUMN sessionlimit timestamp;

INSERT INTO tbl_board(title, content, writer) VALUES('제목 테스트1', '내용 테스트1', '작성자1');
INSERT INTO tbl_board(title, content, writer) VALUES('제목 테스트2', '내용 테스트2', '작성자2');
INSERT INTO tbl_board(title, content, writer) VALUES('제목 테스트3', '내용 테스트3', '작성자3');
INSERT INTO tbl_board(title, content, writer) VALUES('제목 테스트4', '내용 테스트4', '작성자4');
INSERT INTO tbl_board(title, content, writer) VALUES('제목 테스트5', '내용 테스트5', '작성자5');
INSERT INTO tbl_board(title, content, writer) VALUES('제목 테스트6', '내용 테스트6', '작성자6');
INSERT INTO tbl_board(title, content, writer) VALUES('제목 테스트7', '내용 테스트7', '작성자7');
INSERT INTO tbl_board(title, content, writer) VALUES('제목 테스트8', '내용 테스트8', '작성자8');
INSERT INTO tbl_board(title, content, writer) VALUES('제목 테스트9', '내용 테스트9', '작성자9');
INSERT INTO tbl_board(title, content, writer) VALUES('제목 테스트10', '내용 테스트10', '작성자10');
INSERT INTO tbl_board(title, content, writer) VALUES('제목 테스트11', '내용 테스트11', '작성자11');
INSERT INTO tbl_board(title, content, writer) VALUES('제목 테스트12', '내용 테스트12', '작성자12');
INSERT INTO tbl_board(title, content, writer) VALUES('제목 테스트13', '내용 테스트13', '작성자13');
INSERT INTO tbl_board(title, content, writer) VALUES('제목 테스트14', '내용 테스트14', '작성자14');
INSERT INTO tbl_board(title, content, writer) VALUES('제목 테스트15', '내용 테스트15', '작성자15');

insert into tbl_reply(bno, replytext, replyer) values(5, '댓글을 추가합니다.1', 'user00');
insert into tbl_reply(bno, replytext, replyer) values(5, '댓글을 추가합니다.2', 'user00');
insert into tbl_reply(bno, replytext, replyer) values(5, '댓글을 추가합니다.3', 'user00');
insert into tbl_reply(bno, replytext, replyer) values(5, '댓글을 추가합니다.4', 'user00');
insert into tbl_reply(bno, replytext, replyer) values(5, '댓글을 추가합니다.5', 'user00');
insert into tbl_reply(bno, replytext, replyer) values(5, '댓글을 추가합니다.6', 'user00');
insert into tbl_reply(bno, replytext, replyer) values(5, '댓글을 추가합니다.7', 'user00');
insert into tbl_reply(bno, replytext, replyer) values(5, '댓글을 추가합니다.8', 'user00');
insert into tbl_reply(bno, replytext, replyer) values(5, '댓글을 추가합니다.9', 'user00');
insert into tbl_reply(bno, replytext, replyer) values(5, '댓글을 추가합니다.10', 'user00');

INSERT INTO tbl_user(uid, upw, uname) VALUES('user00', 'user00', 'IRON MAN');
INSERT INTO tbl_user(uid, upw, uname) VALUES('user01', 'user01', 'CAPTAIN');
INSERT INTO tbl_user(uid, upw, uname) VALUES('user02', 'user02', 'HULK');
INSERT INTO tbl_user(uid, upw, uname) VALUES('user03', 'user03', 'Thor');
INSERT INTO tbl_user(uid, upw, uname) VALUES('user10', 'user10', 'Quick Silver');