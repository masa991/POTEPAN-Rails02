class AddTotalFeeToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :total_fee, :integer
  end
end
