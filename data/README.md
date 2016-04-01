The `*.list` files have been procuded by hand with

```rb
cd .../yast/yast-ruby-bindings
yard doc --quiet --list | cut -d' ' -f2 > yast-ruby-bindings.list
```
