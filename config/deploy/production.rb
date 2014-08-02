# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{soapp@92.222.181.64}
role :web, %w{soapp@92.222.181.64}
role :db,  %w{soapp@92.222.181.64}


# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server '92.222.181.64', user: 'soapp', roles: %w{web app db}, primary: true

set :ssh_options, {
    keys: %w(/Users/kdas/.ssh/high),
    forward_agent: true,
    auth_methods: %w(publickey password),
}