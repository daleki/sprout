include_recipe "sprout-osx-apps::java"
include_recipe 'sprout-osx-base::bash_it'

directory "/Users/#{node['current_user']}/aws-cli/mon" do
  recursive true
  owner node['current_user']
end

remote_file "/tmp/CloudWatch.zip" do
  source "http://ec2-downloads.s3.amazonaws.com/CloudWatch-2010-08-01.zip"
  action :create_if_missing
end

execute "unzip /tmp/CloudWatch.zip -d /tmp/CloudWatch" do
  action :run
  not_if { File.exists?("/tmp/CloudWatch") }
end

execute "mv /tmp/CloudWatch/* ~/aws-cli/mon; rm -rf /tmp/CloudWatch" do
  action :run
  not_if { File.exists?("~/aws-cli/mon/README.TXT") }
end

sprout_osx_base_bash_it_custom_plugin 'bash_it/custom/aws-cli-mon.bash' do
    cookbook 'sprout-osx-apps'
end
