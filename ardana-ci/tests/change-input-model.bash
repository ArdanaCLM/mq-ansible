#!/bin/bash
#
# (c) Copyright 2016 Hewlett Packard Enterprise Development LP
# (c) Copyright 2017 SUSE LLC
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#

cd ~/ardana-ci-tests

if [ -d ardana-input-model ]; then
cd ardana-input-model
git checkout $1
cd ../
else
git clone -b $1 http://git.suse.provo.cloud/ardana/ardana-input-model
fi

cp -r ardana-input-model/2.0/services/ ~/openstack/ardana/services/

cd ~/ardana
git add -A
git commit -m "My config"
cd ~/openstack/ardana/ansible/

ansible-playbook -i hosts/localhost config-processor-run.yml -e encrypt="" \
                     -e rekey=""

ansible-playbook -i hosts/localhost ready-deployment.yml
cd ~/scratch/ansible/next/ardana/ansible
