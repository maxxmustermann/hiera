module Puppet::Parser::Functions
  newfunction(:hiera_class, :type => :statement) do |args|
    raise Puppet::Error, "hiera_createresource requires 1 argument; got #{args.length}" if args.length != 1
    lookup_name = args[0]
    res_name = "::"+args[0]
    res_params = function_hiera_hash([lookup_name, {}])
    #puts "name: "+res_name
    #puts "params: "+res_params.to_s
    #puts "hash: "+{res_name => res_params}.to_s
    function_create_resources(['class', {res_name => res_params}])
  end
end

