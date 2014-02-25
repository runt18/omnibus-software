name 'scons'
version '2.3.0'

dependency 'python'

source(
  url: 'http://prdownloads.sourceforge.net/scons/scons-2.3.0.tar.gz',
  md5: '083ce5624d6adcbdaf2526623f456ca9'
)

embedded = File.join(install_dir, 'embedded')
lib_dir = File.join(embedded, 'lib')
include_dir = File.join(embedded, 'include')
python = File.join(embedded, 'bin', 'python')

env = {
  'LDFLAGS' => "-Wl,-rpath,#{lib_dir} -L#{lib_dir} -I#{include_dir}",
  'CFLAGS' => "-L#{lib_dir} -I#{include_dir}",
  'LD_RUN_PATH' => lib_dir,
  'PYTHON' => python,
  'PY_PREFIX' => embedded
}

relative_path "#{name}-#{version}"

build do
  command "#{python} setup.py install --prefix=#{embedded}"
end
