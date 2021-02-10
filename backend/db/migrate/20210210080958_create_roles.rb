class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    
    execute <<-DDL
        Create Type role_type AS ENUM(
         'ADMIN', 'USER', 'MODERATOR'
        );
    DDL

    create_table :roles do |t|
      t.column :type, :role_type, unique: true, null: false
      t.timestamps
    end

    add_reference :users, :roles, foreign_key: true, null: false
  end
end
