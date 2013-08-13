name 'haproxy'
version '1.4.24'

dependency 'pcre'

source(
  url: 'http://haproxy.1wt.eu/download/1.4/src/haproxy-1.4.24.tar.gz',
  md5: '86422620faa9759907563d5e0524b98c'
)

relative_path [name, version].join('-')
embedded = File.join(install_dir, 'embedded')
# bin_dir = File.join(embedded, 'bin')
lib_dir = File.join(embedded, 'lib')
include_dir = File.join(embedded, 'include')

env = {
  'LDFLAGS' => "-Wl,-rpath,#{lib_dir} -L#{lib_dir} -I#{include_dir}",
  'CFLAGS' => "-L#{lib_dir} -I#{include_dir}",
  'LD_RUN_PATH' => lib_dir,
  'DEBUG' => ''
}

target = 'linux2628'

build do
  command(
    "make install TARGET=#{target} DESTDIR=#{embedded} PREFIX=''",
    env: env
  )
end
