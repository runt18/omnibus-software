name 'boost'
version '1.46.1'

dependency 'bzip2'
dependency 'icu'
dependency 'python'

source(
  url: 'http://downloads.sourceforge.net/project/boost/boost/1.46.1/boost_1_46_1.tar.bz2?use_mirror=internode',
  md5: '7375679575f4c8db605d426fc721d506'
)
relative_path 'boost_1_46_1'

embedded = File.join(install_dir, 'embedded')
lib_dir = File.join(embedded, 'lib')
include_dir = File.join(embedded, 'include')

env = {
  'LDFLAGS' => "-L#{lib_dir} -I#{include_dir}",
  'CFLAGS' => "-L#{lib_dir} -I#{include_dir}",
  'LD_RUN_PATH' => lib_dir,
  'BZIP2_INCLUDE' => include_dir,
  'BZIP2_LIBPATH' => lib_dir,
  'ZLIB_INCLUDE' => include_dir,
  'ZLIB_LIBPATH' => lib_dir,
}
build do
  command(
    [
      './bootstrap.sh',
      "--prefix=#{embedded}",
      "--with-icu=#{embedded}",
      "--with-python-root=#{embedded}"
    ].join(' '),
    env: env
  )
  command "./bjam -j #{max_build_jobs} install", env: env
end
