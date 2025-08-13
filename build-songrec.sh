export DEBFULLNAME="alive4ever"
export DEBEMAIL="alive4ever@users.noreply.github.com"
export PKG_VERSION=0.4.3
export PPA_CODENAME="noble"
export SIGNING_KEY="https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x86a389b4b401fab17a0168506888550b2fc77d09"
mkdir -p ~/build
cd ~/build
echo "deb-src [signed-by=/etc/apt/keyrings/songrec-ppa.asc] https://ppa.launchpadcontent.net/marin-m/songrec/ubuntu noble main" | sudo tee /etc/apt/sources.list.d/songrec.list
curl -L "$SIGNING_KEY" | sudo tee /etc/apt/keyrings/songrec-ppa.asc
sudo apt update
apt source --download-only songrec
dpkg-source -x songrec_${PKG_VERSION}${PPA_CODENAME}.dsc
cd songrec-${PKG_VERSION}${PPA_CODENAME}
sudo apt build-dep -y .
dch -b --newversion ${PKG_VERSION}${PPA_CODENAME}-1bpo0 --distribution trixie "Rebuild for trixie"
debuild -us -uc
cd ..
mkdir -p /tmp/hosttmp/songrec_deb
cp -v *deb /tmp/hosttmp/songrec_deb/
