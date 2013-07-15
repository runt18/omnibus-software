name 'libevent'
version '2.1.3-alpha'
source(
  url: 'http://downloads.sourceforge.net/project/levent/libevent/libevent-2.1/libevent-2.1.3-alpha.tar.gz?r=&ts=1373353388&use_mirror=hivelocity',
  md5: '294e67a631cdb0ebfda0db7939a361b3'
)
relative_path "#{name}-#{version}"

embedded = File.join(install_dir, 'embedded')
lib_dir = File.join(embedded, 'lib')
include_dir = File.join(embedded, 'include')

env = {
  'LDFLAGS' => "-L#{lib_dir} -I#{include_dir}",
  'CFLAGS' => "-L#{lib_dir} -I#{include_dir}",
  'LD_RUN_PATH' => lib_dir,
}
build do
  command(
    [
      './configure',
      "--prefix=#{embedded}",
    ].join(' '), env: env
  )
  command "make install -j #{max_build_jobs}", env: env
end

