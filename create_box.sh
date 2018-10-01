#!/bin/sh

rm centos7-cinnamon.box
vagrant package --output centos7-cinnamon.box
vagrant box add --force centos7-cinnamon centos7-cinnamon.box