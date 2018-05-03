require 'sqlite3'
require 'singleton'


class QuestionsDatabase < SQLite3::Database
  include Singleton
  
  
  def initialize
    super('aa_questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end
  
  
  
  
  
  
  
class User
  attr_accessor :fname, :lname
  
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * From users")
    data.map {|datum| User.new(datum)}
  end
  
  def self.find_by_fname(fname)
    my_user = QuestionsDatabase.instance.execute(<<-SQL,fname)
      SELECT
      *
      FROM
      users
      WHERE
      fname = ?
      SQL
      return nil if my_user.length == 0 
    User.new(my_user.first)  
  end
  
  def self.find_by_lname(lname)
    my_user = QuestionsDatabase.instance.execute(<<-SQL,lname)
      SELECT
      *
      FROM
      users
      WHERE
      lname = ?
      SQL
      return nil if my_user.length == 0 
    User.new(my_user.first)
  end
  
  
  
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
  
  
  def create
    raise "#{self} already in database" if @id  #id exists as truthy value
    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        users (fname,lname)
      VALUES
        (?, ?)
      SQL
    
    @id = QuestionsDatabase.instance.last_insert_row_id
  end
    
  def update(fname, lname)
    # id = id || @id
    raise "#{self} not in database" unless @id  #id exists as truthy value
    QuestionsDatabase.instance.execute(<<-SQL, fname, lname, @id)
      update
        users
      set
        fname = ?, lname = ?
      where 
      id = ?
    SQL
    
    User.find_by_fname(fname)
  end
  
  def authored_questions
    raise "#{self} doesnt exist" unless @id
    Question.find_by_author_id(@id)
  end
  
  def authored_replies
    raise "#{self} doesnt exist" unless @id
    Reply.find_by_user_id(@id)
  end
  
  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)  
  end
  
  
end

class Question
  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end
  
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * From questions")
    data.map {|datum| Question.new(datum)}
  end
  
  def self.find_by_author_id(author_id)
    data = QuestionsDatabase.instance.execute(<<-SQL,author_id)
      SELECT
      *
      FROM
      questions
      WHERE
      author_id = ?
      SQL
      return nil if data.length == 0 
      data.map {|datum| Question.new(datum)}
  end
  
  def author
    data = QuestionsDatabase.instance.execute(<<-SQL,@author_id)
      SELECT
      *
      FROM
      users
      WHERE
      id = ?
    SQL
    return nil if data.length == 0 
  User.new(data.first)
  end
  
  def replies
    raise "question doesnt exist" unless @id 
    Reply.find_by_question_id(@id)
  end
  
  def followers
    QuestionFollow.followers_for_question_id(@id)
  end
  
end


class Reply
  
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * From replies")
    data.map {|datum| Reply.new(datum)}
  end
  
  def initialize(options)
    @reply_id = options['reply_id']
    @question_id = options['question_id']
    @parent_reply_id = options['parent_reply_id']
    @replier_id  = options['replier_id']
    @body  = options['body']
  end
  
  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL,user_id)
      SELECT
      *
      FROM
      replies
      WHERE
      replier_id = ?
    SQL
    return nil if data.length == 0 
    data.map {|datum| Reply.new(datum)}
  end
  
  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL,question_id)
      SELECT
      *
      FROM
      replies
      WHERE
      question_id = ?
    SQL
    return nil if data.length == 0 
    data.map {|datum| Reply.new(datum)}
  end
  
  def author
    data = QuestionsDatabase.instance.execute(<<-SQL,@replier_id)
      SELECT
      *
      FROM
      users
      WHERE
      id = ?
    SQL
    return nil if data.length == 0 
  User.new(data.first)
  end
  
  def question
    data = QuestionsDatabase.instance.execute(<<-SQL,@question_id)
      SELECT
      *
      FROM
      questions
      WHERE
      id = ?
    SQL
    return nil if data.length == 0 
  Question.new(data.first)
  end
  
  def parent_reply
    raise "No parent reply" if @parent_reply_id.nil?
    data = QuestionsDatabase.instance.execute(<<-SQL,@parent_reply_id)
      SELECT
      *
      FROM
      replies
      WHERE
      reply_id = ?
    SQL
    return nil if data.length == 0 
  data.map {|datum| Reply.new(datum)}  
  end
  
  def child_replies

    data = QuestionsDatabase.instance.execute(<<-SQL,@reply_id)
      SELECT
      *
      FROM
      replies
      WHERE
      parent_reply_id = ?
    SQL
    return nil if data.length == 0 
  data.map {|datum| Reply.new(datum)} 
  end
end

class QuestionFollow
  
  def initialize(options)
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
  
  
  def self.followers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL,question_id)
      SELECT
      *
      FROM
      users 
      JOIN question_follows ON users.id = question_follows.user_id
      JOIN questions ON questions.id = question_follows.question_id
      WHERE
      questions.id = ?
    SQL
    return nil if data.length == 0 
    data.map {|datum| User.new(datum)} 
  end
  
  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL,user_id)
      SELECT
      questions.id,questions.title,questions.body,questions.author_id
      FROM
      questions 
      JOIN question_follows ON questions.id = question_follows.question_id  
      JOIN users ON users.id = question_follows.user_id
      WHERE
      users.id = ?
    SQL
    return nil if data.length == 0 
    data.map {|datum| Question.new(datum)} 
  end
  
  def self.most_followed_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL,limit: n)
      SELECT
      questions.id,questions.title,questions.body,questions.author_id
      FROM
      questions 
      JOIN question_follows ON questions.id = question_follows.question_id  

      GROUP BY questions.id
      ORDER BY COUNT(questions.id) DESC
      LIMIT :limit
    SQL
    return nil if data.length == 0 
    data.map {|datum| Question.new(datum)} 
  end
  
  
  
end

