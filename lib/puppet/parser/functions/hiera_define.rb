module Puppet::Parser::Functions
  newfunction(:hiera_define, :type => :statement) do |args|
    raise Puppet::Error, "hiera_define requires 1 argument; got #{args.length}" if args.length != 1
    lookup_name = args[0]
    res_class = "::"+args[0]
    res_hashes = function_hiera_hash([lookup_name, {}])
    res_hashes.each do | res_name, res_params |
      #puts "define: "+res_class
      #puts "name: "+res_name
      #puts "params: "+res_params.to_s
      #puts "hash: "+{res_name => res_params}.to_s
      if function_defined_with_params(["#{lookup_name}[#{res_name}]", res_params])
        Puppet.debug("Resource #{lookup_name}[#{res_name}] with params #{res_params} not created because it already exists")
      else
        function_create_resources([res_class, {res_name => res_params}])
      end
    end
  end
end

