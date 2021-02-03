class CreateAdvertisements < ActiveRecord::Migration[6.1]
  def change

    execute <<-DDL
      CREATE Type advertisements_type AS ENUM (
        'free', 'exchange', 'pay'
      );
    DDL

    create_table :advertisements do |t|
      t.string :name
      t.column :type, :advertisements_type
      t.text :description
      t.string :place
      
      t.timestamps
    end
  end
end
