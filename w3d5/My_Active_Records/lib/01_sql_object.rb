require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # @column ||= 
    
    if @columns
      return @columns 
    else 
      @columns = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
      SQL
      
      @columns = columns.first.map(&:to_sym)
    end
    
  end

  def self.finalize!
    self.columns.each do |name|
      define_method name do
        attributes[name]
      end
      
      define_method "#{name}=" do |val|
        attributes[name] = val
      end
    end
    
    
  end

  def self.table_name=(table_name)
    @table_name = table_name
    # ...
  end

  def self.table_name
    @table_name || "#{self}".tableize
    
    # ...
  end

  def self.all
    all = DBConnection.execute(<<-SQL)
      SELECT
      *
      FROM
      #{self.table_name}
      SQL
    # ...
    self.parse_all(all)
  end

  def self.parse_all(results)
    results.map{|result| self.new(result)}
  end

  def self.find(id)
    value = DBConnection.execute(<<-SQL)
    SELECT
    *
    FROM
    #{self.table_name}
    
    SQL
    
    p value
    # ...
  end

  def initialize(params = {})
    params.each do |k,v|
      if self.class.columns.include?(k.to_sym)
        self.send("#{k}=", (v))
      else 
        raise "unknown attribute '#{k}'"
      end
    end  
    # ...
  end

  def attributes
    @attributes  ||= {}
    # ...
  end

  def attribute_values
    
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
