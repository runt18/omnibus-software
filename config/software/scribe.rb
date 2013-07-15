name 'scribe'
version '2.2.0.20120106git63e4824'

dependency 'openssl'
dependency 'python'
dependency 'boost'
dependency 'libevent'
dependency 'thrift'
dependency 'fb303'

source(
  url: 'https://github.com/facebook/scribe/tarball/63e4824838bf84e35da6a0817d8a72a6ec0b9fb3/facebook-scribe-63e4824.tar.gz',
  md5: '158d84d77fd53b1fd472ea331250689d'
)

relative_path 'facebook-scribe-63e4824'

embedded = File.join(install_dir, 'embedded')
lib_dir = File.join(embedded, 'lib')
include_dir = File.join(embedded, 'include')

env = {
  'LDFLAGS' => "-L#{lib_dir} -I#{include_dir}",
  'CFLAGS' => "-L#{lib_dir} -I#{include_dir}",
  'LD_RUN_PATH' => lib_dir,
  'PYTHON' => File.join(embedded, 'bin', 'python'),
  'PY_PREFIX' => embedded,
  'CPPFLAGS' => '-DHAVE_INTTYPES_H -DHAVE_NETINET_IN_H',
  'LIBS' => '-lboost_system -lboost_filesystem'
}

build do
  patch source: '0001-scribe-fix-boost-filesystem.patch', plevel: 1
  patch source: '0002-libscribe-shared-objects.patch', plevel: 1
  command(
    [
      './bootstrap.sh',
      "--prefix=#{embedded}",
      '--disable-static',
      "--with-thriftpath=#{embedded}",
      "--with-fb303path=#{embedded}",
      "--with-ssl=#{embedded}",
      "--with-zlib=#{embedded}",
      "--with-boost=#{embedded}",
      '--with-boost-system=boost_system',
      '--with-boost-filesystem=boost_filesystem'
    ].join(' '),
    env: env
  )
  command "make -j #{max_build_jobs}", env: env
  command 'make install'
end
