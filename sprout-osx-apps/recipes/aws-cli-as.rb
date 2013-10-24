include_recipe "sprout-osx-apps::java"
include_recipe 'sprout-osx-base::bash_it'

directory "/Users/#{node['current_user']}/aws-cli/as" do
  recursive true
  owner node['current_user']
end

remote_file "/tmp/AutoScaling.zip" do
  source "http://ec2-downloads.s3.amazonaws.com/AutoScaling-2011-01-01.zip"
  action :create_if_missing
end

execute "unzip /tmp/AutoScaling.zip -d /tmp/AutoScaling" do
  action :run
  not_if { File.exists?("/tmp/AutoScaling") }
end

execute "mv /tmp/AutoScaling/AutoScaling*/* ~/aws-cli/as; rm -rf /tmp/AutoScaling" do
  action :run
  not_if { File.exists?("~/aws-cli/as/README.TXT") }
end

sprout_osx_base_bash_it_custom_plugin 'bash_it/custom/aws-cli-as.bash' do
    cookbook 'sprout-osx-apps'
end
