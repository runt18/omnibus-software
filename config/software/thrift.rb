name 'thrift'
version '0.5.0'

dependency 'python'
dependency 'libevent'
dependency 'boost'
dependency 'zlib'

source(
  url: 'http://archive.apache.org/dist/incubator/thrift/0.5.0-incubating/thrift-0.5.0.tar.gz',
  md5: '14c97adefb4efc209285f63b4c7f51f2'
)

relative_path "#{name}-#{version}"

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
      './configure',
      "--prefix=#{embedded}",
      "--with-boost=#{embedded}",
      "--with-libevent=#{embedded}",
      "--with-zlib=#{embedded}",
      '--with-python',
      '--with-cpp',
      '--without-csharp',
      '--without-java',
      '--without-erlang',
      '--without-perl',
      '--without-php',
      '--without-php_extension',
      '--without-ruby',
      '--without-haskell'
    ].join(' '),
    env: env
  )
  command "make -j #{max_build_jobs}", env: env
  command 'make install'
end
