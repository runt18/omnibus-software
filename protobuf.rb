name 'protobuf'
version '2.5.0'

source(
  url: 'https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.bz2',
  md5: 'a72001a9067a4c2c4e0e836d0f92ece4'
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

