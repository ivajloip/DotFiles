#!/bin/bash

set -e

sudo modprobe -r hid_multitouch 
sudo modprobe hid_multitouch
