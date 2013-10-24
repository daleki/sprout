include_recipe "sprout-osx-apps::java"
include_recipe 'sprout-osx-base::bash_it'

directory "/Users/#{node['current_user']}/aws-cli/ec2" do
  recursive true
  owner node['current_user']
end

remote_file "/tmp/ec2-api-tools.zip" do
  source "http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip"
  action :create_if_missing
end

execute "unzip /tmp/ec2-api-tools.zip -d /tmp/ec2-api-tools" do
  action :run
  not_if { File.exists?("/tmp/ec2-api-tools") }
end

execute "mv /tmp/ec2-api-tools/ec2-api-tools*/* ~/aws-cli/ec2; rm -rf /tmp/ec2-api-tools" do
  action :run
  not_if { File.exists?("~/aws-cli/ec2/README.TXT") }
end

sprout_osx_base_bash_it_custom_plugin 'bash_it/custom/aws-cli-ec2.bash' do
    cookbook 'sprout-osx-apps'
end

