class UpdateTable < ActiveRecord::Migration
  def up
  	
  	rename_column("cats", "description", "name")
    change_column("cats", "name", :string)
    add_column("books", "author", :string, :limit => 50)
    add_column("books", "price", :integer)
    add_column("books", "img_url", :string)
    add_column("books", "published_date", :date)
  end

  def down
  end
end
