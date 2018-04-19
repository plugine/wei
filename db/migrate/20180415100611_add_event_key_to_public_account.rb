class AddEventKeyToPublicAccount < ActiveRecord::Migration
  def change
    add_column :activities, :event_key, :string, default: ''
  end
end
