
git "/root/tmate-slave" do
  repository "https://github.com/nviennot/tmate-slave.git"
  action :sync
  user "root"
  group "root"
end

script "compile_tmate-slave_part1" do
    interpreter "bash"
      user "root"
      cwd "/root/tmate-slave"
      code <<-EOH
        STATUS=0
        bash create_keys.sh > /root/tmate-slave-footprints.txt || STATUS=1
        cp -r /root/tmate-slave/keys /root/keys/
        cd /root/tmate-slave
        ./autogen.sh || STATUS=1
        ./configure || STATUS=1
        make || STATUS=1
        cp tmate-slave /usr/bin/
        chmod 755 /usr/bin/tmate-slave
        exit $STATUS
      EOH
end

case node["platform"]
when "debian", "ubuntu"

  cookbook_file '/etc/default/tmate-slave' do
    source 'tmate-slave'
    owner 'root'
    group 'root'
    mode '0644'
  end

  cookbook_file '/etc/init/tmate-slave.conf' do
    source 'init'
    owner 'root'
    group 'root'
    mode '0644'
  end

  link '/etc/init.d/tmate-slave' do
    to '/lib/init/upstart-job'
  end

  service 'tmate-slave' do
    supports :status => true
    action [ :enable, :start ]
  end

end
