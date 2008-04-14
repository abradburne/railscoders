class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User', :foreign_key => 'friend_id'
  
  def xfn_friendship=(friendship_type)
    self.xfn_friend = false
    self.xfn_acquaintance = false
    self.xfn_contact = false
    case friendship_type
    when 'xfn_friend' : self.xfn_friend = true
    when 'xfn_acquaintance' : self.xfn_acquaintance = true
    when 'xfn_contact' : self.xfn_contact = true
    end
  end
  
  def xfn_friendship
    return 'xfn_friend' if self.xfn_friend == true
    return 'xfn_acquaintance' if self.xfn_acquaintance == true
    return 'xfn_contact' if self.xfn_contact == true
    false
  end

  def xfn_geographical=(geo_type)
    self.xfn_coresident = false
    self.xfn_neighbor = false
    case geo_type
    when 'xfn_coresident' : self.xfn_coresident = true
    when 'xfn_neighbor' : self.xfn_neighbor = true
    end
  end

  def xfn_geographical
    return 'xfn_coresident' if self.xfn_coresident
    return 'xfn_neighbor' if self.xfn_neighbor
    false
  end
  
  def xfn_family=(family_type)
    self.xfn_child = false
    self.xfn_parent = false
    self.xfn_sibling = false
    self.xfn_spouse = false
    self.xfn_kin = false
    case family_type
    when 'xfn_child' : self.xfn_child = true
    when 'xfn_parent' : self.xfn_parent = true
    when 'xfn_sibling' : self.xfn_sibling = true
    when 'xfn_spouse' : self.xfn_spouse = true
    when 'xfn_kin' : self.xfn_kin = true
    end
  end
  
  def xfn_family
    return 'xfn_child' if self.xfn_child
    return 'xfn_parent' if self.xfn_parent
    return 'xfn_sibling' if self.xfn_sibling
    return 'xfn_spouse' if self.xfn_spouse
    return 'xfn_kin' if self.xfn_kin
    false
  end
end