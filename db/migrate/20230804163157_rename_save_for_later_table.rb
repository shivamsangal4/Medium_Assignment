# db/migrate/20230806123456_rename_save_for_later_table.rb

class RenameSaveForLaterTable < ActiveRecord::Migration[7.0]
  def change
    rename_table :save_for_later, :save_for_laters
  end
end
