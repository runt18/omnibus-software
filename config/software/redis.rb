#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
# Copyright:: Copyright (c) 2013, MoPub, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name 'redis'
version '2.6.14'
source(
  url: 'http://redis.googlecode.com/files/redis-2.6.14.tar.gz',
  md5: '02e0c06e953413017ff64862953e2756'
)

relative_path [name, version].join('-')

embedded = File.join(install_dir, 'embedded')
lib_dir = File.join(embedded, 'lib')
include_dir = File.join(embedded, 'include')

env = {
  'PREFIX' => embedded,
  'CFLAGS' => "-L#{lib_dir} -I#{include_dir}",
  'LD_RUN_PATH' => lib_dir
}

build do
  command "make -j #{max_build_jobs}", env: env
  command 'make install', env: env
end
