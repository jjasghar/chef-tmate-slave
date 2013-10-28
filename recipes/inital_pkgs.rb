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

when "redhat", "centos", "fedora"
    case node["platform_version"]
    when "5.9"
      %w{cmake gcc gcc-c++ kernel-devel make curl-devel expat-devel gettext-devel openssl-devel zlib-devel ncurses ncurses-devel}.each do |pkg|
      package pkg do
        action :install
      end
      end
    when "6.4"
      %w{perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker cmake gcc gcc-c++ kernel-devel make curl-devel expat-devel gettext-devel openssl-devel zlib-devel ncurses ncurses-devel}.each do |pkg|
      package pkg do
        action :install
      end
      end
    end

    remote_file "/tmp/v1.8.4.1.tar.gz" do
      source "https://github.com/git/git/archive/v1.8.4.1.tar.gz"
      action :create_if_missing
      owner 'root'
      group 'root'
    end

    script "build_git" do
      interpreter "bash"
      user "root"
      cwd "/tmp/"
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


##    remote_file "/tmp/ExtUtils-MakeMaker-6.31.tar.gz" do
#      source "http://files.directadmin.com/services/9.0/ExtUtils-MakeMaker-6.31.tar.gz"
#      action :create_if_missing
#      owner 'root'
#      group 'root'
#    end
#
#    script "build_MakeMaker" do
#        interpreter "bash"
#          user "root"
#          cwd "/tmp/"
#          code <<-EOH
#            STATUS=0
#            tar xvzf ExtUtils-MakeMaker-6.31.tar.gz || STATUS=1
#            cd ExtUtils-MakeMaker-6.31|| STATUS=1
#            perl Makefile.PL || STATUS=1
#            make || STATUS=1
#            make install || STATUS=1
#            exit $STATUS
#          EOH
#    end
#

#    remote_file "/tmp/v1.8.4.1.tar.gz" do
#      source "https://github.com/git/git/archive/v1.8.4.1.tar.gz"
#      action :create_if_missing
#      owner 'root'
#      group 'root'
#    end
#
#    script "build_git" do
#        interpreter "bash"
#          user "root"
#          cwd "/tmp/"
#          code <<-EOH
#            STATUS=0
#            tar xvzf v1.8.4.1.tar.gz || STATUS=1
#            cd git-1.8.4.1 || STATUS=1
#            make prefix=/usr/local all || STATUS=1
#            make prefix=/usr/local install || STATUS=1
#            exit $STATUS
#          EOH
#    end
