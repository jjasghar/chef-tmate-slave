#
# package installs
#
case node["platform"]
when "debian", "ubuntu"
    execute "apt-get update"
    %w{git-core build-essential pkg-config libtool libevent-dev libncurses-dev zlib1g-dev automake libssh-dev cmake vim}.each do |pkg|
    package pkg do
      action :install
    end
    end

when "redhat", "centos", "fedora","amazon","scientific"
    case node["platform_version"]
    when "5.9"
      %w{glibc glibc-devel pam-devel cmake gcc gcc-c++ kernel-devel make curl-devel expat-devel gettext-devel openssl-devel zlib-devel ncurses ncurses-devel}.each do |pkg|
      package pkg do
        action :install
      end
      end
    when "6.4"
      %w{glibc glibc-devel pam-devel perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker cmake gcc gcc-c++ kernel-devel make curl-devel expat-devel gettext-devel openssl-devel zlib-devel ncurses ncurses-devel}.each do |pkg|
      package pkg do
        action :install
      end
      end
    end

    remote_file "#{Chef::Config[:file_cache_path]}/v1.8.4.1.tar.gz" do
      source "https://github.com/git/git/archive/v1.8.4.1.tar.gz"
      action :create_if_missing
      owner 'root'
      group 'root'
    end

    script "build_git" do
      interpreter "bash"
      user "root"
      cwd "#{Chef::Config[:file_cache_path]}"
      code <<-EOH
        STATUS=0
        tar xvzf v1.8.4.1.tar.gz || STATUS=1
        cd git-1.8.4.1 || STATUS=1
        make prefix=/usr/local all || STATUS=1
        make prefix=/usr/local install || STATUS=1
        exit $STATUS
      EOH
    end
end

