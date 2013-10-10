include_recipe "sprout-osx-apps::java"

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

# use template and bashit
#
#file "#{node['sprout']['home']}/.profile.aws.mon" do
#  content <<-EOS
#  export AWS_CLOUDWATCH_HOME=~/aws-cli/mon
#  export PATH=$PATH:$AWS_CLOUDWATCH_HOME/bin
#  EOS
#  mode 0644
#end
