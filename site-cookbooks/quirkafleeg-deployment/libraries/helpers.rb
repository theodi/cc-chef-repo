module ODI
  module Quirkafleeg
    module Helpers
      def get_domain
        domain = node['govuk']['app_domain']
        if node.chef_environment !~ /production/ then
          domain = "%s.xip.io" % [
              node["ipaddress"]
          ]
        end
        domain
      end

      def env_extras
        domain = get_domain
        ruby_block "env extras" do
          block do
            extras = {
                'DEV_DOMAIN'       => domain,
                'GOVUK_APP_DOMAIN' => domain,
                'GDS_SSO_STRATEGY' => 'real',
                'STATIC_DEV'       => "http://static.%s" % [
                    domain
                ],
                'GOVUK_ASSET_ROOT' => "static.%s" % [
                    domain
                ]
            }
            f = File.open "/home/#{node['user']}/env", "a"
            extras.each_pair do |key, value|
              f.write "%s=%s\n" % [
                  key,
                  value
              ]
            end
            f.close
          end
        end
      end

      def find_a thing
        box_ip = nil
        if Chef::Config[:solo] then
          Chef::Log.warn("This recipe uses search. Chef Solo does not support search.")
        else
          search_string = "name:*%s-%s* AND chef_environment:%s" % [
              thing,
              node[:project],
              node.chef_environment
          ]
          box = search(:node, search_string)[0]
          box_ip        = box['ipaddress']
          if box['rackspace']
            box_ip = box['rackspace']['private_ip']
          end
        end
        box_ip
      end
    end
  end
end