require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "./spec/**/*_spec.rb"
  # Put spec opts in a file named .rspec in root
end

namespace :spork do
 desc "start spork in background"
 task :start do
   sh %{spork &}
 end

 desc "stop spork"
 task :stop do
   Process.kill(:TERM, `ps -ef | grep spork | grep -v grep | awk '{ print $2 }'`.to_i)
 end

 desc "restart spork"
 task :restart => [:stop, :start]
end

