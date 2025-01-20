require_relative 'database'

module TaskManager
  def self.menu
    loop do
      puts "\n--- Gerenciamento de Tarefas ---"
      puts "1. Adicionar Tarefa"
      puts "2. Listar Tarefas"
      puts "3. Atualizar Progresso"
      puts "4. Remover Tarefa"
      puts "5. Voltar"
      print "Escolha uma opção: "
      choice = gets.chomp.to_i

      case choice
      when 1
        add_task
      when 2
        list_tasks
      when 3
        update_progress
      when 4
        remove_task
      when 5
        break
      else
        puts "Opção inválida. Tente novamente."
      end
    end
  end

  def self.add_task
    puts "Digite o tópico de estudo:"
    topic = gets.chomp
    puts "Digite a categoria (ex.: Matemática, Programação):"
    category = gets.chomp
    puts "Quantos minutos por dia você quer dedicar?"
    time = gets.chomp.to_i

    db = Database.connection
    db.execute("INSERT INTO tasks (topic, category, time, progress) VALUES (?, ?, ?, ?)", [topic, category, time, 0])
    puts "Tarefa '#{topic}' adicionada com sucesso!"
  end

  def self.list_tasks
    db = Database.connection
    tasks = db.execute("SELECT id, topic, category, time, progress FROM tasks")
    if tasks.empty?
      puts "Nenhuma tarefa cadastrada!"
    else
      puts "\n--- Tarefas Cadastradas ---"
      tasks.each do |task|
        puts "ID: #{task[0]} | Tópico: #{task[1]} | Categoria: #{task[2]} | Tempo: #{task[3]} min/dia | Progresso: #{task[4]}%"
      end
    end
  end

  def self.update_progress
    list_tasks
    puts "Digite o ID da tarefa para atualizar o progresso:"
    id = gets.chomp.to_i
    puts "Digite o novo progresso (em %):"
    progress = gets.chomp.to_i

    db = Database.connection
    db.execute("UPDATE tasks SET progress = ? WHERE id = ?", [progress, id])
    puts "Progresso atualizado com sucesso!"
  end

  def self.remove_task
    list_tasks
    puts "Digite o ID da tarefa que deseja remover:"
    id = gets.chomp.to_i

    db = Database.connection
    db.execute("DELETE FROM tasks WHERE id = ?", [id])
    puts "Tarefa removida com sucesso!"
  end

  def self.show_progress_report
    db = Database.connection
    tasks = db.execute("SELECT topic, progress FROM tasks")
    puts "\n--- Relatório de Progresso ---"
    tasks.each do |task|
      puts "Tópico: #{task[0]} | Progresso: #{task[1]}%"
    end
  end
end