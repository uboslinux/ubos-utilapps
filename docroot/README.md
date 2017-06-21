# How to use:

* Install on a UBOS device with `ubos-admin createsite` or the like
* On the device, determine the appconfigid of the docroot installation, e.g. with `ubos-admin listsites`.
  For example:

     > ubos-admin listsites
     Site: testhost (sa930329346091ee4724d665ba52ef5b0eef110c8)
     Context:           /docs (ab3bb3b0116b7ba30db36ffb1b4643b5214d9a713): docroot

  In this example, ab3bb3b0116b7ba30db36ffb1b4643b5214d9a713 is the appconfigid.
* To upload files to be served by the webserver, use rssync over ssh like this:

     rsync -e "ssh -i <private-ssh-key>" <local-file(s)-to-upload> docroot@testhost:<appconfigid>/<path>

  where:
  * `<private-ssh-key>` is the name of the file containing the private key whose public key you specified
    during `ubos-admin createsite`.
  * `<local-file(s)-to-upload>` is the local file, or files, or directories that you wish to recursively
    upload to the web server
  * `<appconfigid>` is the appconfigid you determined earlier, so we know which installation of `docroot`
    you mean in case there are several on the same device
  * `<path>`: optionally, the name of the remote file or directory, just like standard `rsync`

  For example:

     rsync -e "ssh -i ~/.ssh/id_rsa" index.html docroot@testhost:ab3bb3b0116b7ba30db36ffb1b4643b5214d9a713/

