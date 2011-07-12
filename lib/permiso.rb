require "permiso/version"

module Permiso
  module Ability

    def roles
      @roles ||= {}
    end

    def rules
      @ruls ||= {}
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

    def can?(role, action, args={})
      return false unless role_can?(role, action)
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
      roles.each {|role, abilities| puts "#{role} can #{abilities.inspect}"}
      rules.each {|rule| puts "rule #{rule}" }
    end
  end
end
