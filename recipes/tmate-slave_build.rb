
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
        cp -r /tmp/tmate-slave/keys /root/keys/
        cd /tmp/tmate-slave
        ./autogen.sh || STATUS=1
        ./configure || STATUS=1
        make || STATUS=1
        exit $STATUS
      EOH
end
