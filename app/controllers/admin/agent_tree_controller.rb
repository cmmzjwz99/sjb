class AgentTreeController < Admin::BaseController
  def index
    cache = Rails.cache.read(RedisConfigs::USER_TREE_CACHE)
    return cache if cache.present?

    # init user tree
    @user_nodes = UserTree.init_tree
    Rails.cache.write(RedisConfigs::USER_TREE_CACHE, @user_nodes)
  end
end