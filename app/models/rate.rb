class Rate < ActiveRecord::Base

  GREEN = "#22%02s22"
  WHITE = "#000000"
  RED = "#%02s0000"

  belongs_to :rateable, polymorphic: true
  has_many :site_users_rates
  has_many :site_users, through: :site_users_rates


  def color
    return WHITE if self.likes + self.dislikes == 0

    self.general_rate = 100.0 if self.general_rate > 100.0
    self.general_rate = -100.0 if self.general_rate < -100.0

    if general_rate > 0.0
      green_hex = (225 - self.general_rate.to_i).to_s(16)
      GREEN % [green_hex]
    elsif general_rate == 0.0
      WHITE
    else
      red_hex = (255 - self.general_rate.to_i.abs).to_s(16)
      RED % [red_hex]
    end
  end

  def like(user, revert=false)
  	return if user.nil? || (self.rateable.respond_to?(:site_user) && self.rateable.site_user === user)
    ratio = revert ? 2 : 1
    self.likes += 1
    self.general_rate += user.reputation * ratio
    self.dislikes -= 1 if revert
    self.save!
    SiteUsersRate.find_or_create({:rate => self, :site_user => user, rate_action: 'like'})
  end

  def dislike(user, revert=false)
  	return if user.nil? || (self.rateable.respond_to?(:site_user) && self.rateable.site_user === user)
    ratio = revert ? 2 : 1
    self.dislikes += 1
    self.general_rate -= user.reputation * ratio
    self.likes -= 1 if revert
    self.save!
    SiteUsersRate.find_or_create({:rate => self, :site_user => user, rate_action: 'dislike'})
  end

  def active(action, user)
    return false unless user
    self.site_users_rates.find_by_site_user_id_and_rate_action(user.id, action).nil?
  end

end
