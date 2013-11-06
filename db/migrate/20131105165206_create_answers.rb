class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :user
      t.string :ordering

      t.timestamps
    end
  end
  
  def down
    drop_table :answers
  end
end
