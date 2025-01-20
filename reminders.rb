require_relative 'database'

module ReminderManager
  def self.menu
    puts "\n--- Configuração de Lembretes ---"
    puts "1. Adicionar Lembrete"
    puts "2. Listar Lembretes"
    puts "3. Remover Lembrete"
    puts "4. Voltar"
    choice = gets.chomp.to_i

    case choice
    when 1
      add_reminder
    when 2
      list_reminders
    when 3
      remove_reminder
    when 4
      return
    else
      puts "Opção inválida. Tente novamente."
    end
  end

  def self.add_reminder
    TaskManager.list_tasks
    puts "Digite o ID da tarefa para configurar o lembrete:"
    task_id = gets.chomp.to_i
    puts "Digite o horário do lembrete (HH:MM):"
    time = gets.chomp

    db = Database.connection
    db.execute("INSERT INTO reminders (task_id, time) VALUES (?, ?)", [task_id, time])
    puts "Lembrete configurado com sucesso!"
  end

  def self.list_reminders
    db = Database.connection
    reminders = db.execute("SELECT r.id, t.topic, r.time FROM reminders r JOIN tasks t ON r.task_id = t.id")
    puts "\n--- Lembretes Configurados ---"
    reminders.each do |reminder|
      puts "ID: #{reminder[0]} | Tópico: #{reminder[1]} | Horário: #{reminder[2]}"
    end
  end

  def self.remove_reminder
    list_reminders
    puts "Digite o ID do lembrete que deseja remover:"
    id = gets.chomp.to_i

    db = Database.connection
    db.execute("DELETE FROM reminders WHERE id = ?", [id])
    puts "Lembrete removido com sucesso!"
  end
end