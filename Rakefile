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
