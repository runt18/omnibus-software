name 'etcd'
version '0.1.1'
source(
  url: 'https://github.com/coreos/etcd/releases/download/v0.1.1/etcd-v0.1.1-Linux.tar.gz',
  md5: '44ad520c4153e532afbedfd1e5f02546'
)

relative_path "#{name}-v#{version}"

bin_dir = File.join(
  install_dir,
  'embedded',
  'bin'
)

build do
  %w(etcd etcdctl).each do |etcd_binary|
    command "install -sv #{etcd_binary} #{bin_dir}/"
  end
end
  
