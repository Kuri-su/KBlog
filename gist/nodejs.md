

**Node.js v12.x:**
```shell
# Using Ubuntu
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install -y nodejs

# Using Debian, as root
curl -sL https://deb.nodesource.com/setup_12.x | bash -
apt install -y nodejs

# Using rpm
curl -sL https://rpm.nodesource.com/setup_12.x | bash -

# Using Snapcraft
sudo snap install node --classic --channel=12
```

**Other versions only need to modify the version number, like 10.x 11.x**


> via:
> <https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions>


**yarn**
```shell
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

// using Ubuntu or Debian
sudo apt update && sudo apt-get install yarn
```