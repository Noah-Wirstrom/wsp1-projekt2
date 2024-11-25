require 'sqlite3'
require 'bcrypt'
class Seeder




  def self.seed!
    drop_tables
    create_tables
    populate_tables
  end

  def self.drop_tables
    db.execute('DROP TABLE IF EXISTS todos')
    db.execute('DROP TABLE IF EXISTS users')
  end


  def self.create_tables
    db.execute('CREATE TABLE todos (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                description TEXT,
                completed BOOLEAN DEAFAULT FALSE)')

    db.execute('CREATE TABLE users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT NOT NULL,
                password TEXT NOT NULL 
                )')
  end

  def self.populate_tables
    db.execute('INSERT INTO todos (name, description, completed) VALUES ("Städa",   "Städa hela huset", 0)')
    db.execute('INSERT INTO todos (name, description, completed) VALUES ("Handla",    "Handla mat", 0)')
    db.execute('INSERT INTO todos (name, description, completed) VALUES ("Sova",  "Gå å lägg dig", 0)')
    db.execute('INSERT INTO todos (name, description, completed) VALUES ("Träna",  "BÄNK", 0)')
    db.execute('INSERT INTO users (username, password) VALUES ("admin", "1234")')
  end

  private
  def self.db
    return @db if @db
    @db = SQLite3::Database.new('db/todos.sqlite')
    @db.results_as_hash = true
    @db
  end

end

Seeder.seed!