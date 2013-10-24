include_recipe "sprout-osx-apps::java"
include_recipe 'sprout-osx-base::bash_it'

directory "/Users/#{node['current_user']}/aws-cli/elb" do
  recursive true
  owner node['current_user']
end

remote_file "/tmp/ElasticLoadBalancing.zip" do
  source "http://ec2-downloads.s3.amazonaws.com/ElasticLoadBalancing.zip"
  action :create_if_missing
end

execute "unzip /tmp/ElasticLoadBalancing.zip -d /tmp/ElasticLoadBalancing" do
  action :run
  not_if { File.exists?("/tmp/ElasticLoadBalancing") }
end

execute "mv /tmp/ElasticLoadBalancing/ElasticLoadBalancing*/* ~/aws-cli/elb; rm -rf /tmp/ElasticLoadBalancing" do
  action :run
  not_if { File.exists?("~/aws-cli/elb/README.TXT") }
end

sprout_osx_base_bash_it_custom_plugin 'bash_it/custom/aws-cli-elb.bash' do
    cookbook 'sprout-osx-apps'
end
