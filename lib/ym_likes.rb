require 'ym_core'
require 'ym_users'
require "ym_likes/engine"

Dir[File.dirname(__FILE__) + '/ym_likes/models/*.rb'].each {|file| require file }

module YmLikes
end
