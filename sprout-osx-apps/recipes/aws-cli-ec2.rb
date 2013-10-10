include_recipe "sprout-osx-apps::java"

remote_file "/tmp/ec2-api-tools.zip" do
  source "http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip"
  action :create_if_missing
end

execute "unzip /tmp/ec2-api-tools.zip -d /tmp/ec2-api-tools" do
  action :run
  not_if { File.exists?("/tmp/ec2-api-tools") }
end

execute "mv /tmp/ec2-api-tools/* ~/aws-cli/ec2; rm -rf /tmp/ec2-api-tools" do
  action :run
  not_if { File.exists?("~/aws-cli/ec2/README.TXT") }
end

