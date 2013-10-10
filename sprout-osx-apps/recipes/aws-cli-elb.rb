include_recipe "sprout-osx-apps::java"

remote_file "/tmp/ElasticLoadBalancing.zip" do
  source "http://ec2-downloads.s3.amazonaws.com/ElasticLoadBalancing.zip"
  action :create_if_missing
end

execute "unzip /tmp/ElasticLoadBalancing.zip -d /tmp/ElasticLoadBalancing" do
  action :run
  not_if { File.exists?("/tmp/ElasticLoadBalancing") }
end

execute "mv /tmp/ElasticLoadBalancing/* ~/aws-cli/elb; rm -rf /tmp/ElasticLoadBalancing" do
  action :run
  not_if { File.exists?("~/aws-cli/elb/README.TXT") }
end

