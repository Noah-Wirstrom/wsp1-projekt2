class App < Sinatra::Base

    def db
        return @db if @db
  
        @db = SQLite3::Database.new("db/todos.sqlite")
        @db.results_as_hash = true
  
        return @db
    end
   
    get '/' do 
        @todos = db.execute('SELECT * FROM todos')
        erb(:"index")
    end

    post '/todos/:id/delete' do | id |
        db.execute("DELETE FROM todos WHERE id = ?" , [id])
        redirect "/"
    end

    post '/todos/:id/:completed' do | id, completed |
        if completed == '0'
            db.execute("UPDATE todos SET completed == 1 WHERE id = ?", [id])
        elsif completed == '1'
            db.execute("UPDATE todos SET completed == 0 WHERE id = ?", [id])
        end
        redirect "/"
    end

end
