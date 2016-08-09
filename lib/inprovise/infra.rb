# Infrastructure basics for Inprovise
#
# Author::    Martin Corino
# Copyright:: Copyright (c) 2016 Martin Corino
# License::   Distributes under the same license as Ruby

require 'json'

module Inprovise::Infrastructure

  class << self
    def targets
      @targets ||= {}
    end

    def find(name)
      return name if name.is_a?(Target)
      targets[name]
    end

    def names
      targets.keys.sort
    end

    def register(tgt)
      targets[tgt.name] = tgt
    end

    def deregister(tgt)
      targets.delete(Inprovise::Infrastructure::Target === tgt ? tgt.name : tgt.to_s)
      targets.each {|t| t.remove_target(tgt) }
    end

    def save
      data = []
      targets.each_value {|t| t.is_a?(Node) ? data.insert(0,t) : data.push(t) }
      File.open(Inprovise.infra, 'w') {|f| f << JSON.pretty_generate(data) }
    end

    def load
      JSON.load(IO.read(Inprovise.infra)) if File.readable?(Inprovise.infra)
    end
  end

  class Target
    attr_reader :name, :config

    def initialize(name, config = {})
      @name = name
      @config = config
      Inprovise::Infrastructure.register(self)
    end

    def get(option)
      config[option]
    end

    def set(option, value)
      config[option.to_sym] = value
    end

    def add_to(grp)
      grp.add_target(self)
    end

    def remove_from(grp)
      grp.remove_target(self)
    end

    def add_target(tgt)
      $stderr.puts "ERROR: cannot add #{tgt.to_s} to #{self.to_s}"
    end

    def remove_target(tgt)
      # ignore
    end

    def targets
      [self]
    end
  end

end

require_relative './node.rb'
require_relative './group.rb'