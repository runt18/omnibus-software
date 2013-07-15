name 'fb303'
version '0.5.0'

source(
  url: 'http://archive.apache.org/dist/incubator/thrift/0.5.0-incubating/thrift-0.5.0.tar.gz',
  md5: '14c97adefb4efc209285f63b4c7f51f2'
)

dependency 'thrift'

relative_path File.join(
  "thrift-#{version}",
  'contrib',
  name
)
embedded = File.join(install_dir, 'embedded')
lib_dir = File.join(embedded, 'lib')
include_dir = File.join(embedded, 'include')

env = {
  'LDFLAGS' => "-L#{lib_dir} -I#{include_dir}",
  'CFLAGS' => "-L#{lib_dir} -I#{include_dir}",
  'LD_RUN_PATH' => lib_dir,
  'PYTHON' => File.join(embedded, 'bin', 'python'),
  'PY_PREFIX' => embedded,
  'CPPFLAGS' => '-DHAVE_INTTYPES_H -DHAVE_NETINET_IN_H'
}
build do
  command(
    [
      './bootstrap.sh',
      '--enable-static=no',
      "--prefix=#{embedded}",
      "--with-thriftpath=#{embedded}",
      "--with-boost=#{embedded}"
    ].join(' '), env: env
  )
  command "make -j #{max_build_jobs}", env: env
  command 'make install'
end
