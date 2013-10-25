
git "/tmp/tmate-slave" do
  repository "https://github.com/nviennot/tmate-slave.git"
  action :sync
  user "root"
  group "root"
end

script "compile_tmate-slave_part1" do
    interpreter "bash"
      user "root"
      cwd "/tmp/tmate-slave"
      code <<-EOH
        STATUS=0
        bash create_keys.sh > /root/tmate-slave-footprints.txt || STATUS=1
        cp -r /tmp/tmat-slave/keys /root/keys/
      EOH
end

cookbook_file "/root/tmate-slave/tmate.h" do
  source "tmate.h"
  user "root"
  group "root"
  mode 0644
end


script "compile_tmate-slave_part2" do
    interpreter "bash"
      user "root"
      cwd "/tmp/tmate-slave"
      code <<-EOH
        STATUS=0
        sed -i 's/#define TMATE_DOMAIN "tmate.io"/#define TMATE_DOMAIN "node[:tmate-slave][:domain]"/' tmate.h || STATUS=1
        cd /tmp/tmate-slave
        ./autogen.sh || STATUS=1
        ./configure || STATUS=1
        make || STATUS=1
        exit $STATUS
      EOH
end
