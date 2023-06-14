class Student < ActiveRecord::Base
    def change
        add_column :students, :name, :string
    end

end
