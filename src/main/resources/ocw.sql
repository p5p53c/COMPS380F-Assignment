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

CREATE TABLE courses (
    courseid INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    coursename VARCHAR(50) NOT NULL,
    PRIMARY KEY(courseid)
);

CREATE TABLE material (
    materialid INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    courseid INTEGER NOT NULL,
    materialname VARCHAR(50) NOT NULL,
    materialbody VARCHAR(50) NOT NULL,
    PRIMARY KEY(materialid),
    FOREIGN KEY(courseid) REFERENCES courses(courseid)
);

CREATE TABLE attachment (
    attachmentid INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    materialid INTEGER DEFAULT NULL,
    filename VARCHAR(255) DEFAULT NULL,
    content_type VARCHAR(255) DEFAULT NULL,
    content BLOB DEFAULT NULL,
    PRIMARY KEY (attachmentid),
    FOREIGN KEY (materialid) REFERENCES material(materialid)
);

CREATE TABLE comments (
    commentid INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    courseid INTEGER NOT NULL,
    username VARCHAR(50) NOT NULL,
    commentbody VARCHAR(50) NOT NULL,
    PRIMARY KEY (commentid),
    FOREIGN KEY (courseid) REFERENCES courses(courseid),
    FOREIGN KEY (username) REFERENCES users(username)
);

CREATE TABLE polls (
    pollid INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    pollquestion VARCHAR(50) NOT NULL,
    pollMC1 VARCHAR(50) NOT NULL,
    pollMC2 VARCHAR(50) DEFAULT NULL,
    pollMC3 VARCHAR(50) DEFAULT NULL,
    pollMC4 VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (pollid)
);

CREATE TABLE votes (
    pollid INTEGER NOT NULL,
    username VARCHAR(50) NOT NULL,
    vote INTEGER NOT NULL,
    PRIMARY KEY(pollid, username),
    FOREIGN KEY (pollid) REFERENCES polls(pollid),
    FOREIGN KEY (username) REFERENCES users(username)
);

INSERT INTO users VALUES ('peter', '{noop}peterpw', 'peter', 'address', 'phone');
INSERT INTO user_roles(username, role) VALUES ('peter', 'ROLE_USER');

INSERT INTO users(username, password) VALUES ('keith', '{noop}keithpw');
INSERT INTO user_roles(username, role) VALUES ('keith', 'ROLE_ADMIN');

INSERT INTO courses(coursename) VALUES ('JSP');
INSERT INTO material(courseid, materialname, materialbody) VALUES (1, 'Test 1', 'Test 1');

INSERT INTO comments(courseid, username, commentbody) VALUES (1, 'peter', 'Test 1');
