# CLI Node commands for Inprovise
#
# Author::    Martin Corino
# License::   Distributes under the same license as Ruby

class Inprovise::Cli

  desc 'Manage infrastructure nodes'
  command :node do |cnod|

    cnod.desc 'Add an infrastructure node'
    cnod.arg_name 'NODE'
    cnod.command :add do |cnod_add|

      cnod_add.flag [:a, :address], :arg_name => 'ADDRESS', :desc => 'Set the node address (hostname or IP). If not set node name is used as hostname.'
      cnod_add.flag [:c, :config], :arg_name => 'CFGKEY=CFGVAL', :multiple => true, :desc => 'Specify a configuration setting for the node.'
      cnod_add.flag [:C, :credential], :arg_name => 'CFGKEY=CFGVAL', :multiple => true, :desc => 'Specify a security credential setting for the node.'
      cnod_add.switch [:sniff], :default_value => true, :desc => 'Enable or disable running sniffers'
      cnod_add.flag [:g, :group], :arg_name => 'GROUP', :multiple => true, :desc => 'Existing infrastructure group to add new node to.'

      cnod_add.action do |global,options,args|
        raise ArgumentError, 'Missing or too many arguments!' unless args.size == 1
        ctl = Inprovise::Controller.new(global)
        ctl.run(:add, options, :node, *args)
      end

    end

    cnod.desc 'Remove (an) infrastructure node(s)'
    cnod.arg_name 'NODE[ NODE [...]]'
    cnod.command :remove do |cnod_del|

      cnod_del.action do |global,options,args|
        raise ArgumentError, 'Missing argument!' if args.empty?
        ctl = Inprovise::Controller.new(global)
        ctl.run(:remove, options, :node, *args)
      end

    end

    cnod.desc 'Update node configuration for the given infrastructure node(s) or group(s).'
    cnod.arg_name 'NAME[ NAME [...]]'
    cnod.command :update do |cnod_update|

      cnod_update.flag [:c, :config], :arg_name => 'CFGKEY=CFGVAL', :multiple => true, :desc => 'Specify a configuration setting for the node(s)'
      cnod_update.flag [:C, :credential], :arg_name => 'CFGKEY=CFGVAL', :multiple => true, :desc => 'Specify a security credential setting for the node.'
      cnod_update.switch [:r, :reset], negatable: false, :desc => 'Reset configuration before update (default is to merge updates)'
      cnod_update.switch [:sniff], :default_value => true, :desc => 'Enable or disable running sniffers'
      cnod_update.flag [:g, :group], :arg_name => 'GROUP', :multiple => true, :desc => 'Existing infrastructure group to add node(s) to.'

      cnod_update.action do |global,options,args|
        raise ArgumentError, 'Missing argument!' if args.empty?
        ctl = Inprovise::Controller.new(global)
        ctl.run(:update, options, :node, *args)
      end
    end

    cnod.default_desc 'List infrastructure nodes'
    cnod.action do |global_options,options,args|
      $stderr.puts
      $stderr.puts "\tINFRASTRUCTURE NODES"
      $stderr.puts "\t===================="
      $stdout.puts *Inprovise::Infrastructure.list(Inprovise::Infrastructure::Node).collect {|n| "\t#{n.to_s}" }
    end

  end

end