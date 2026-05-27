class RecreateSolidCableMessages < ActiveRecord::Migration[8.0]
  def change
    drop_table :solid_cable_messages, if_exists: true

    create_table :solid_cable_messages do |t|
      t.binary :channel, null: false
      t.binary :payload, null: false
      t.datetime :created_at, null: false
      t.bigint :channel_hash, null: false
    end

    add_index :solid_cable_messages, :channel_hash
    add_index :solid_cable_messages, :created_at
  end
end