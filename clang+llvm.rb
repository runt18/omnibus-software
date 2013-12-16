name 'clang+llvm'
version '3.3'

architecture = OHAI.kernel['machine']
arch = case architecture
       when 'x86_64'
         'amd64'
       end

distro = OHAI.lsb['id']
version_with_patch = OHAI.lsb['description']
  .match(/^\w+ (\d+\.\d+\.?\d?).*$/)[1]

unless arch == 'amd64' &&
    distro == 'Ubuntu' &&
    version_with_patch =~ /12.04/
  raise 'Unsupported Platform'
end

# TODO: This recipe only supports Ubuntu 12.04+ amd64, we could
# enhance it with support for multiple urls?
def clang_llvm_url(arch, distro, version_with_patch)
  v = version
  a = arch
  d = distro
  vwp = version_with_patch
  "http://llvm.org/releases/#{v}/clang+llvm-#{v}-#{a}-#{d}-#{vwp}.tar.gz"
end

dependency 'zlib'
dependency 'libxml2'

source(
  url: 'http://llvm.org/releases/3.3/clang+llvm-3.3-amd64-Ubuntu-12.04.2.tar.gz',
  md5: '1059f3232b2eef6f0bee7000a99694a7'
)

relative_path "#{name}-#{version}-amd64-Ubuntu-12.04.2"
embedded = File.join(install_dir, 'embedded')

build do
  command "find ./ -type d -exec mkdir -p #{embedded}/{} \\;", cwd: project_dir
  command(
    "find ./ ! -type d -exec install --preserve-timestamps --verbose --strip {} #{embedded}/{} \\;",
    cwd: project_dir
  )

  # TODO: Un-fuck this situation
  {
    bin: '755',
    lib: '644',
    include: '644'
  }.each do |dir, mode|
    embedded_dir = File.join(embedded, dir.to_s)
    command(
      "find ./ -type f -exec chmod #{mode} {} \\;",
      cwd: embedded_dir
    )
  end
end
