# Ruhax

[![Join the chat at https://gitter.im/Peekmo/ruhax](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/Peekmo/ruhax?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Pur ruby code compiled into haxe code

## Example

You can play examples from "examples" folder e.g :
```bin/console build --src examples/hello_world.rb```

And... magic ! You should see something like that
```haxe
class Main{
public static function main() {
trace("Hello World");
}

}
```

Add ```--debug``` flag to get AST of the file

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/peekmo/ruhax.
