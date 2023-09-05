Lookup documentation for YaST APIs

Getting started:

```console
export RACK_ENV=production # if you want to expose the server outside localhost
bundle install
bundle exec bin/yastdoc &
xdg-open http://localhost:4567/?q=beer
```

Updating the index:

```console
github-mirror # external dependency, updates $HOME/github-checkout
(cd data; ./update)
```
