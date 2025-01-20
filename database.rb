require 'sqlite3'

module Database
  DB_FILE = 'study_data.db'

  def self.setup
    @db = SQLite3::Database.new(DB_FILE)
    @db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS tasks (
        id INTEGER PRIMARY KEY,
        topic TEXT,
        category TEXT,
        time INTEGER,
        progress INTEGER
      );
    SQL
    @db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS reminders (
        id INTEGER PRIMARY KEY,
        task_id INTEGER,
        time TEXT,
        FOREIGN KEY(task_id) REFERENCES tasks(id)
      );
    SQL
    puts "[LOG] Banco de dados configurado!"
  end

  def self.connection
    @db ||= SQLite3::Database.new(DB_FILE)
  end
end