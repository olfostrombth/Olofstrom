class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.string :frequent_questions
      t.string :frequent_answers

      t.timestamps null: false
    end
  end
end
