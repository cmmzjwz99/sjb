# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

# Ruby version
    2.4.3
# System dependencies
    Linux, mysql
# Configuration

# Database creation

# Database initialization

# How to run the test suite

# Services (job queues, cache servers, search engines, etc.)

# Deployment instructions
## rails
    pumactl restart|phased-restart|start|stats|status|stop|...
## sidekiq
    sidekiqctl quiet tmp/pids/sidekiq.pid 
    sidekiqctl stop tmp/pids/sidekiq.pid 
    sidekiq -d -e development(production)

