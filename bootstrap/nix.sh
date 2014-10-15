#! /bin/sh
#
# This script creates a working nix in $HOME, as described on
# https://nixos.org/wiki/How_to_install_nix_in_home_%28on_another_distribution%29

export nix=$HOME/nix
export root=$HOME/root

export PATH=$root/bin:$PATH
export PKG_CONFIG_PATH=$root/lib/pkgconfig:$PKG_CONFIG_PATH
export LDFLAGS="-L$root/lib $LDFLAGS"
export CPPFLAGS="-I$root/include $CPPFLAGS"
export PERL5OPT="-I$root/lib/perl -I$root/lib64/perl5"

install="spkg/bin/spkg -i"
$install bzip
$install curl
$install sqlite-autoconf
$install perl_curl
$install perl_dbi
$install perl_sqlite
$install nix

cd $root
boot_nix
$root/bin/nix-env --version
[ $? -ne 0 ] && exit 1

nix-channel --add http://nixos.org/channels/nixpkgs-unstable
nix-channel --update
nix-env -i nix
