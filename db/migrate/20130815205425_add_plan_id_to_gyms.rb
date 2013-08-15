class AddPlanIdToGyms < ActiveRecord::Migration
  def change
    add_column :gyms, :plan_id, :int
  end
end
