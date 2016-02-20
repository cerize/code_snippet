class Snippet < ActiveRecord::Base
  belongs_to :kind

  validates :title, presence: true,
                    uniqueness: true
  validates :work, presence: :true

end
