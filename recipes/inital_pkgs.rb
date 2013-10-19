#
# package installs
#
case node["platform"]
  when "debian", "ubuntu"
   execute "apt-get update"
   %w{git-core build-essential pkg-config libtool libevent-dev libncurses-dev zlib1g-dev automake libssh-dev cmake ruby vim}.each do |pkg|
   package pkg do
     action :install
   end
end

when "redhat", "centos", "fedora"
  execute "echo 'stupid redhat'"
end
