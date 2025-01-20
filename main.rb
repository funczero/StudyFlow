require_relative 'database'
require_relative 'tasks'
require_relative 'reminders'

Database.setup

def menu
  loop do
    puts "\n--- StudyFlow: Sistema de Automação para Estudo ---"
    puts "1. Gerenciar Tarefas de Estudo"
    puts "2. Ver Relatórios de Progresso"
    puts "3. Configurar Lembretes"
    puts "4. Sair"
    print "Escolha uma opção: "
    choice = gets.chomp.to_i

    case choice
    when 1
      TaskManager.menu
    when 2
      TaskManager.show_progress_report
    when 3
      ReminderManager.menu
    when 4
      puts "Saindo... Bons estudos!"
      break
    else
      puts "Opção inválida. Tente novamente."
    end
  end
end

menu