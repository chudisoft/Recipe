class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :role, :string, default: 'default'
      
      t.timestamps
    end
  end
end
