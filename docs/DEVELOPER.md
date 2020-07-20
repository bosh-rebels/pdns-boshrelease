## Updating Releases

```
export OLD_VERSION=4.1.8
export VERSION=4.2.2
cd ~/Downloads
curl -OL https://downloads.powerdns.com/releases/pdns-${VERSION}.tar.bz2
cd ~/workspace/pdns-release
git pull -r
find packages/pdns -type f -print0 |
  xargs -0 perl -pi -e \
  "s/pdns-${OLD_VERSION}/pdns-${VERSION}/g"
 # FIXME: update README.md's download URL
bosh add-blob \
  ~/Downloads/pdns-${VERSION}.tar.bz2 \
  pdns/pdns-${VERSION}.tar.bz2
vim config/blobs.yml
  # delete `pdns/pdns-${OLD_VERSION}.tar.bz2` stanza
bosh create-release --force
export BOSH_ENVIRONMENT=vsphere # or vbox
bosh upload-release
bosh -n -d pdns \
  deploy manifests/pdns-vsphere.yml --recreate # or deploy manifests/pdns-lite.yml --recreate
bosh -n -d pdns ssh
dig +short ns example.com @8.8.8.8
dig +short ns example.com @localhost # should be different
exit
bosh upload-blobs
bosh create-release \
  --final \
  --tarball ~/Downloads/pdns-release-${VERSION}.tgz \
  --version ${VERSION} --force
git add -N releases/
git add -p
git ci -v
git tag $VERSION
git push
git push --tags
```
