#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
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

name "chefdk"

dependency "chef"
dependency "berkshelf"

build do
  auxiliary_gems = []

  auxiliary_gems << "chefspec"
  auxiliary_gems << "test-kitchen"
  auxiliary_gems << "rubocop"
  auxiliary_gems << "foodcritic"
  auxiliary_gems << "strainer"
  auxiliary_gems << "knife-spork"

  gem ["install",
       auxiliary_gems.join(" "),
       "-n #{install_dir}/bin",
       "--no-rdoc --no-ri"].join(" "), :env => {"PATH" => "#{install_dir}/embedded/bin:#{ENV['PATH']}"}
end

