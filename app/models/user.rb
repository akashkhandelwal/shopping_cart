class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation, :old_password
  attr_accessor :old_password
  validates :name, presence: true, uniqueness: true
  has_secure_password

  after_destroy :ensure_an_admin_remains

  def renew_password(password, confirm_password)
    if password == confirm_password
      self.password = password
      self.password_confirmation = confirm_password
      self.save!
    end
  end

  private
  
  	def ensure_an_admin_remains
  		if User.count.zero?
  			raise "Can't delete last user"
  		end
  	end
end
