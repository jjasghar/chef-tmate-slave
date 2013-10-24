
git "/tmp/tmate-slave" do
  repository "https://github.com/nviennot/tmate-slave.git"
  action :sync
  user "root"
  group "root"
end

script "compile_tmate-slave" do
    interpreter "bash"
      user "root"
      cwd "/tmp/tmate-slave"
      code <<-EOH
        STATUS=0
        ./create_keys.sh | tee /root/tmate-slave-footprints.txt || STATUS=1
        sed -i s%#define TMATE_DOMAIN "tmate.io"%#define TMATE_DOMAIN "node[:tmate-slave][:domain]"% tmate.h || STATUS=1
        cd /tmp/tmate-slave
        ./autgen.sh || STATUS=1
        ./configure || STATUS=1
        make || STATUS=1
        exit $STATUS
      EOH
end

