CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER Not NULL,
  
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  
  FOREIGN KEY (question_id) references questions(id),
  FOREIGN KEY (user_id) references users(id)
);

CREATE TABLE replies (
  reply_id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  replier_id Integer NOT NULL,
  body text not null,
  
  FOREIGN KEY (question_id) references questions(id),
  FOREIGN KEY (replier_id) references users(id)
  -- self reference???
);

CREATE TABLE question_likes (
  likes Boolean NOT NULL,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  
  FOREIGN KEY (question_id) references questions(id),
  FOREIGN KEY (user_id) references users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
    ('Archana','Kannan'),
    ('Robin','Sunny'),
    ('Bryan', 'Lin'),
    ('Farah','Quader'),
    ('Melissa','Ho');
  
INSERT INTO
      questions (title, body, author_id)
  VALUES    
      ('sql','dont understand it', (SELECT id FROM users WHERE fname = 'Robin')),
      ('RUBY','What can i do?', (SELECT id FROM users WHERE fname = 'Melissa')),
      ('rails','What is rails?', (SELECT id FROM users WHERE fname = 'Archana')),
      ('react','What is react?', (SELECT id FROM users WHERE fname = 'Bryan')),
      ('javascript','what is javascrip?dont understand it', (SELECT id FROM users WHERE fname = 'Farah'));
      
INSERT INTO 
  replies (question_id, parent_reply_id, replier_id,body)
Values
  ((Select questions.id from questions where title = 'sql'),NULL ,(SELECT id FROM users WHERE fname = 'Robin'), 'slq is for databases'),
  ((Select questions.id from questions where title = 'RUBY'),3,(SELECT id FROM users WHERE fname = 'Bryan'), 'ruby is awesome'),
  ((Select questions.id from questions where title = 'rails'),4,(SELECT id FROM users WHERE fname = 'Farah'), 'rails is a framework'),
  ((Select questions.id from questions where title = 'react'),5,(SELECT id FROM users WHERE fname = 'Melissa'), 'react is cool'),
  ((Select questions.id from questions where title = 'javascript'),6,(SELECT id FROM users WHERE fname = 'Archana'), 'java sucks');
    
INSERT INTO
question_follows (question_id,user_id)
VALUES
(1,3),
(2,4),
(3,5),
(4,1),
(5,2),
(5,3);
  
