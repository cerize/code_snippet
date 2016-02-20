class Kind < ActiveRecord::Base
  has_many :snippets, dependent: :nullify

  validates :name, presence: true,
                uniqueness: true
end
