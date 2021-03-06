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
# Usage: test-rmq-access.bash cp1 rmq_keystone_user mynewpassword
set -vx
echo " $1 $2 $3"
cnfstatus=0
if [[ $(hostname) == *"$1"* ]]
then
  sudo rabbitmqctl authenticate_user $2 $3 | grep Success
  if [[ $? == 1 ]]
  then
    cnfstatus=1
  fi
fi
# This test currently doesnt actually run but its
# setup to assume  if user is on a different cp
# it wont have the same creds. (may not be what we want)
if [[ $(hostname) != *"$1"* ]]
then
  sudo rabbitmqctl authenticate_user $2 $3 | grep Success
  if [[ $? == 0 ]]
  then
    cnfstatus=1
  fi
fi
exit $cnfstatus


