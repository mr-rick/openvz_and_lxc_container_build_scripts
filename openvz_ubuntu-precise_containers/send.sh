#!/bin/bash

rsync -av --progress -e ssh ubuntu-10.04-puppetized_10.04_amd64.tar.gz 10.3.5.17:/var/lib/vz/template/cache/
rsync -av --progress -e ssh ubuntu-10.04-puppetized_10.04_amd64.tar.gz 10.3.5.20:/var/lib/vz/template/cache/
rsync -av --progress -e ssh ubuntu-10.04-puppetized_10.04_amd64.tar.gz 10.4.5.10:/var/lib/vz/template/cache/
rsync -av --progress -e ssh ubuntu-10.04-puppetized_10.04_amd64.tar.gz 10.5.5.13:/var/lib/vz/template/cache/
rsync -av --progress -e ssh ubuntu-10.04-puppetized_10.04_amd64.tar.gz 10.14.5.11:/var/lib/vz/template/cache/
rsync -av --progress -e ssh ubuntu-10.04-puppetized_10.04_amd64.tar.gz openvz1.zag.net:/var/lib/vz/template/cache/
