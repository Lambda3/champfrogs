class Answer < ActiveRecord::Base
  attr_accessible :ordering, :user
  
  MOTIVATOR_DESC = [
    "Curiosidade: Eu tenho uma porção de coisas para investigar e pensar a respeito",
    "Honra: Sinto orgulho que meu valores pessoais são refletidos na forma como trabalho",
    "Aceitação: As pessoas ao redor de mim aprovam o que faço e quem sou",
    "Maestria: Meu trabalho desafia minha competência, dentro das minha capacidades",
    "Poder: Existe espaço suficiente para que eu possa influenciar o ambiente ao meu redor",
    "Liberdade: Sou independente dos demais através de meu trabalho e responsabilidades",
    "Relacionamento: Eu tenho bom contato social com as pessoas vinculadas ao trabalho",
    "Ordem: Existem regras e políticas suficientes para manter o ambiente estável",
    "Propósito: Meu propósito de vida é refletido no trabalho que faço",
    "Status: Minha posição é boa e reconhecida pelas pessoas que trabalham comigo"
  ]
  
  def motivators
    ordering.split(',')
  end
  
  class << self
    
    def create_or_update! user, ordering
      answer = Answer.find_by_user(user)
      if answer
        answer.ordering = ordering
        answer.save!
      else
        Answer.create!(user: user, ordering: ordering)
      end
    end
    
  end
end
