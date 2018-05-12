class AgentTreeController < Admin::BaseController
  def index
    cache = Redis.read(RedisConfigs::USER_TREE_CACHE)
    return cache if cache.present?

    # init user tree
    @user_nodes = UserTree.init_tree
    Redis.write(RedisConfigs::USER_TREE_CACHE, @user_nodes)
  end
end