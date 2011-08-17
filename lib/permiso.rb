require "permiso/version"

module Permiso
  module Ability

    def roles
      @roles ||= {}
    end

    def rules
      @rules ||= {}
    end

    def can(ability, subject=nil)
      r = roles[@current_role] ||= []
      r << ability
    end

    def role(name, &block)
      @current_role = name
      block.call
    end

    def rule(name, &block)
      rules[name] = block
    end

    def can?(user_roles, action, args={})
      user_roles = [user_roles] unless user_roles.kind_of? Array
      return false unless user_roles.detect {|r| role_can?(r, action) }
      rule_allows?(action)
    end

    def rule_allows?(action)
      rule = rules[action]
      return true if rule.nil?
      rule.call
    end

    def role_can?(role, action)
      allowed_actions = roles[role]
      allowed_actions && allowed_actions.include?(action)
    end

    def inspect
      out = {}
      roles.each {|role, abilities| out[:roles] ||= [] << {role => abilities}}
      rules.keys.each {|rule| out[:rules] ||= [] << rule }
      out
    end
  end
end
