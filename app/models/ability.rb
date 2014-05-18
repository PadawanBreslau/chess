class Ability
  include CanCan::Ability

  def initialize(site_user)
    site_user ||= SiteUser.new
    if site_user.role == 'admin' || Rails.env == 'test'
      can :manage, :all
    elsif site_user.role == 'moderator'
      can :add,:all
      can :manage, [Article, BlogEntry,SiteComment]
    elsif  site_user.role == 'common_user'
      can :read, :all
      can :manage, [Article, BlogEntry,SiteComment], :site_user_id => site_user.id
      can :manage, Player, :site_user_id => site_user.id
    elsif  site_user.role == 'common_user'
      can :read, :all
      can :manage, [Article, BlogEntry,SiteComment], :site_user_id => site_user.id
    elsif  site_user.role == 'suspended'
      can :read, :all
    elsif site_user.role == 'banned'
      can :read, SiteUserInformation
    else
      can [:statistics, :player_stats], Player
      can :read, :all
    end
  end
end
