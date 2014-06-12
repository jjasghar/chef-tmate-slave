#!/usr/bin/env rake

@cookbook = "chef-redis"

desc "Runs foodcritic linter"
task :foodcritic do
  if Gem::Version.new("1.9.2") <= Gem::Version.new(RUBY_VERSION.dup)
    sandbox = File.join(File.dirname(__FILE__), %w{tmp foodcritic}, @cookbook)
    prepare_foodcritic_sandbox(sandbox)

    sh "foodcritic --epic-fail any #{File.dirname(sandbox)}"
  else
    puts "WARN: foodcritic run is skipped as Ruby #{RUBY_VERSION} is < 1.9.2."
  end
end

task :default => 'foodcritic'

desc "Runs knife cookbook test"
task :knife do
  Rake::Task[:prepare_sandbox].execute
  sh "bundle exec knife cookbook test cookbook -c test/.chef/knife.rb  -o #{sandbox_path}/../"
end

task :prepare_sandbox do
  files = %w{*.md *.rb attributes definitions files libraries providers recipes resources templates}

  rm_rf sandbox_path
  mkdir_p sandbox_path
 cp_r Dir.glob("{#{files.join(',')}}"), sandbox_path
end

desc "Cleanup Vendor directory"
task :cleanup_vendor do
  sh 'rm -rf vendor/cookbooks/*'
end

desc "Build AMI"
task :packer_ami => [:cleanup_vendor, :packer_build_ami]

task :packer_build_ami do
  sh 'berks install --path vendor/cookbooks; packer build -only=amazon-ebs template.json'
end

desc "Build Droplet"
task :packer_droplet => [:cleanup_vendor, :packer_build_droplet]

task :packer_build_droplet do
  sh 'berks install --path vendor/cookbooks; packer build -only=digitalocean template.json'
end

desc "Build Openstack"
task :packer_openstack => [:cleanup_vendor, :packer_build_openstack]

task :packer_build_openstack do
  sh 'berks install --path vendor/cookbooks; packer build -only=openstack template.json'
end

desc 'Usage: rake knife_solo user={user} ip={ip.address.goes.here}'
task :knife_solo do
  sh 'rm -rf cookbooks && rm -rf nodes'
  sh 'mkdir cookbooks && berks install --path cookbooks'
  sh "mkdir nodes && echo '{\"run_list\":[\"tmate-slave::default\"]}' > nodes/#{ENV['ip']}.json"
  sh "bundle exec knife solo bootstrap #{ENV['user']}@#{ENV['ip']}"
end

private

def prepare_foodcritic_sandbox(sandbox)
  files = %w{*.md *.rb attributes definitions files providers
recipes resources templates}

  rm_rf sandbox
  mkdir_p sandbox
  cp_r Dir.glob("{#{files.join(',')}}"), sandbox
  puts "\n\n"
end

def sandbox_path
    File.join(File.dirname(__FILE__), %w(tmp cookbooks cookbook))
end
