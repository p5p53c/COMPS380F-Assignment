CREATE TABLE users (
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    fullname VARCHAR(50) DEFAULT NULL,
    address VARCHAR(50) DEFAULT NULL,
    phone VARCHAR(8)   DEFAULT NULL,
    PRIMARY KEY(username)
);

CREATE TABLE user_roles (
    user_role_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    username VARCHAR(50) NOT NULL,
    role VARCHAR(50)    NOT NULL,
    PRIMARY KEY(user_role_id),
    FOREIGN KEY(username) REFERENCES users(username)
);

CREATE TABLE course (
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    coursetitle VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE lecture (
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    lecturenumber INTEGER NOT NULL,
    lecturetitle VARCHAR(50) NOT NULL,
    courseid INTEGER,
    PRIMARY KEY (id),
    FOREIGN KEY (courseid) REFERENCES course(id)
);

CREATE TABLE material (
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    lectureid INTEGER DEFAULT NULL,
    materialname VARCHAR(50) NOT NULL,
    materialbody VARCHAR(50) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(lectureid) REFERENCES lecture(id)
);

CREATE TABLE attachment (
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    materialid INTEGER DEFAULT NULL,
    filename VARCHAR(255) DEFAULT NULL,
    content_type VARCHAR(255) DEFAULT NULL,
    content BLOB DEFAULT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (materialid) REFERENCES material(id)
);

CREATE TABLE comments (
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    username VARCHAR(50) NOT NULL,
    commentbody VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (username) REFERENCES users(username)
);

CREATE TABLE polls (
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    pollquestion VARCHAR(50) NOT NULL,
    pollMC1 VARCHAR(50) NOT NULL,
    pollMC2 VARCHAR(50) DEFAULT NULL,
    pollMC3 VARCHAR(50) DEFAULT NULL,
    pollMC4 VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE votes (
    pollid INTEGER NOT NULL,
    username VARCHAR(50) NOT NULL,
    votetarget VARCHAR(50) NOT NULL,
    PRIMARY KEY(pollid, username),
    FOREIGN KEY (pollid) REFERENCES polls(id) ON DELETE CASCADE,
    FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE
);

INSERT INTO users VALUES ('peter', '{noop}peterpw', 'peter', 'address', 'phone');
INSERT INTO user_roles(username, role) VALUES ('peter', 'ROLE_USER');

INSERT INTO users(username, password) VALUES ('keith', '{noop}keithpw');
INSERT INTO user_roles(username, role) VALUES ('keith', 'ROLE_ADMIN');

INSERT INTO users VALUES ('tatsunoko', '{noop}tatsunokopw', 'tatsunoko', 'address', 'phone');
INSERT INTO user_roles(username, role) VALUES ('tatsunoko', 'ROLE_USER');

INSERT INTO users(username, password) VALUES ('omegaalpha', '{noop}omegaalphapw');
INSERT INTO user_roles(username, role) VALUES ('omegaalpha', 'ROLE_ADMIN');

INSERT INTO course(coursetitle) VALUES ('JSP');
INSERT INTO lecture(lecturenumber, lecturetitle, courseid) VALUES (1, 'Overview of Web Application', 1);
INSERT INTO material(lectureid, materialname, materialbody) VALUES (1, 'Test 1', 'Test 1');

INSERT INTO lecture(lecturenumber, lecturetitle, courseid) VALUES (2, 'Servlet', 1);

INSERT INTO course(coursetitle) VALUES ('Mobile App');
INSERT INTO lecture(lecturenumber, lecturetitle, courseid) VALUES (1, 'Basics', 2);
INSERT INTO lecture(lecturenumber, lecturetitle, courseid) VALUES (2, 'Android - Fundamentals', 2);

INSERT INTO comments(username, commentbody) VALUES ('peter', 'Test 1');

INSERT INTO polls(pollquestion, pollMC1) VALUES ('Take attendance', 'Checked');
INSERT INTO polls(pollquestion, pollMC1, pollMC2) VALUES ('Choose the class you prefer to join', 'L01', 'L02');
INSERT INTO polls(pollquestion, pollMC1, pollMC2, pollMC3) VALUES ('Which date do you prefer for the mid-term test?', '1/5', '2/5', '3/5');
INSERT INTO polls(pollquestion, pollMC1, pollMC2, pollMC3, pollMC4) VALUES ('3 + 3 / 3 * 3 = ?', '2', '3', '6', '2/3');
INSERT INTO polls(pollquestion, pollMC1, pollMC2, pollMC3, pollMC4) VALUES ('Never gonna', 'Give you up', 'Let you down', 'Run around', 'Desert you');

INSERT INTO votes(pollid, username, votetarget) VALUES (1, 'keith', 'Checked');
INSERT INTO votes(pollid, username, votetarget) VALUES (2, 'keith', 'L01');
INSERT INTO votes(pollid, username, votetarget) VALUES (2, 'peter', 'L02');