class Identity < ActiveRecord::Base
	has_many :users

	validates_uniqueness_of :provider, scope: :user_id 
end
