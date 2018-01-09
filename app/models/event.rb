# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  start_time  :datetime
#  end_time    :datetime
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#

class Event < ApplicationRecord
  validates :title, :description, presence: true

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
end
