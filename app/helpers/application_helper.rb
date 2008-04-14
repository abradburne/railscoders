# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def yes_no(bool)    
    if bool == true
      "yes"
    else
      "no"
    end
  end
  
  def tag_cloud(tags, classes)
    max, min = 0, 0
    tags.each do |tag|
      max = tag.count if tag.count > max
      min = tag.count if tag.count < min
    end
  
    divisor = ((max - min) / classes.size) + 1
    tags.each do |tag|
      yield tag.name, classes[(tag.count - min) / divisor]
    end
  end
  
  def xfn_rel_tag(user, friendship)
    rel_tag = []
    if user.id == friendship.friend.id
      # identity
      rel_tag << 'me'
    else
      # friendship
      rel_tag << 'friend' if friendship.xfn_friend
      rel_tag << 'acquaintance' if friendship.xfn_acquaintance
      rel_tag << 'contact' if friendship.xfn_contact
      
      # physical
      rel_tag << 'met' if friendship.xfn_met
      
      # professional
      rel_tag << 'co-worker' if friendship.xfn_coworker
      rel_tag << 'colleague' if friendship.xfn_colleague
      
      # geographical
      rel_tag << 'co-resident' if friendship.xfn_coresident
      rel_tag << 'neighbor' if friendship.xfn_neighbor
      
      # family
      rel_tag << 'child' if friendship.xfn_child
      rel_tag << 'parent' if friendship.xfn_parent
      rel_tag << 'sibling' if friendship.xfn_sibling
      rel_tag << 'spouse' if friendship.xfn_spouse
      rel_tag << 'kin' if friendship.xfn_kin
      
      # romantic
      rel_tag << 'muse' if friendship.xfn_muse
      rel_tag << 'crush' if friendship.xfn_crush
      rel_tag << 'date' if friendship.xfn_date
      rel_tag << 'sweetheart' if friendship.xfn_sweetheart
    end
    rel_tag.join(' ')
  end
end
