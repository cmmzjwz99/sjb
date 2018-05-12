class UserTree
  attr_accessor :children, :user

  @@root = nil
  @@user_nodes = {}
  def initialize(u)
    @user = u
    @children = []
  end

  def self.init_tree
    agents = User.where(profile_id: 2)
    agents.each do |agent|
      @@user_nodes[agent.id] = UserTree.new(agent)
    end

    @@user_nodes.each do |user_node|
      father_id = user_node[1].user.father_id
      if father_id.blank?
        @@root = user_node[1]
      end
      @@user_nodes[father_id].children << user_node
    end

    return @@user_nodes
  end

  def self.update_tree(user)
    if @@root.blank? and @@user_nodes.blank?
      @@root = user
      @@user_nodes[user.id] = user
      return
    end

    if user.father_id.blank?

    end

    @@user_nodes[user.id] = user
    @@user_nodes[user.father_id].children << user

    return @@root
  end
end