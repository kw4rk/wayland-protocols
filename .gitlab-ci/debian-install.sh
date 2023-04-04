#!/bin/sh -eux

# Note: don't forget to bump FDO_DISTRIBUTION_TAG when editing this file!

pip3 install --user git+https://github.com/mesonbuild/meson.git@0.58.0

git clone --branch 1.20.0 --depth=1 https://gitlab.freedesktop.org/wayland/wayland
cd wayland/
git show -s HEAD
meson build/ -Dtests=false -Ddocumentation=false
ninja -j${FDO_CI_CONCURRENT:-4} -C build/ install
cd ..
rm -rf wayland/

echo "/usr/local/lib" >/etc/ld.so.conf.d/local.conf
ldconfig
