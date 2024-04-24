#!/bin/bash
export DATE=$(date +"%Y-%m-%d")

config_path=/sync/cloudquery/aws

gomplate -f "${config_path}/config.yml.template" -o "${config_path}/out/config_aws.yml"

cloudquery sync "${config_path}/out/aws_config.yml"