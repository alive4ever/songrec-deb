export DEBFULLNAME="alive4ever"
export DEBEMAIL="alive4ever@users.noreply.github.com"
mkdir -p ~/build
cd ~/build
songrec_dsc="https://launchpad.net/~marin-m/+archive/ubuntu/songrec/+sourcefiles/songrec/0.4.3jammy/songrec_0.4.3jammy.dsc"
songrec_srctarball="https://launchpad.net/~marin-m/+archive/ubuntu/songrec/+sourcefiles/songrec/0.4.3jammy/songrec_0.4.3jammy.tar.xz"

for url in "$songrec_dsc" "$songrec_srctarball" ; do
	curl -LO "$url"
done
echo "Installing latest rust..."
curl -Lo ~/rust-bootstrap.sh https://sh.rustup.rs
chmod +x ~/rust-bootstrap.sh
~/rust-bootstrap.sh -y -v
echo "Finished installing latest rust..."
export PATH="$HOME/.cargo/bin:$PATH"
rustc --version
dpkg-source -x "$(basename $songrec_dsc)"
cd songrec-0.4.3jammy
sudo apt build-dep -y .
cargo install cargo-deb
DEB_ARCH="$(dpkg --print-architecture)"
cargo deb --deb-version 0.4.3-1bpo1-"$DEB_ARCH"
mkdir -p /tmp/hosttmp/songrec_deb
cp -v ./target/debian/*deb /tmp/hosttmp/songrec_deb/
