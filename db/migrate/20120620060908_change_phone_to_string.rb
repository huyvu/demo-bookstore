class ChangePhoneToString < ActiveRecord::Migration
  def up
  	change_column(:orders,:phone,:string, :limit => 11)
  end

  def down
  end
end
