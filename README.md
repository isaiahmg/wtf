# Word Translation—Fast

Command line access to wordreference.com translations

## Installation

Install gem: navigate to this folder from the command line and type

`gem install pkg/wtf-0.2.gem`

Run locally without installing gem as spelled out in the usage section below.

An API key must be obtained from [wordreference.com](http://www.wordreference.com/docs/api.aspx) and included in the configuration file ~/.wordtranslationfast.rc.yml or supplied as an option when running the command.

## Usage

If you installed the gem, in the command line simply type

`wtf [options] searchterm`

If running from the folder, navigate to the \bin folder from the command line and either type

`ruby wtf [options] searchterm`

or

`./wtf [options] searchterm`

The default dictionary used is the Spanish-English dictionary, thereby `wtf hola` should work off the bat (once you've supplied your WordReference API key). Default options can be specified/changed in the configuration file ~/.wordtranslationfast.rc.yml

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

## History

A fun project to help me quickly translate words while working through a Spanish translation of one of the Harry Potter books.

## Author

Isaiah Goertz (isaiahmg@gmail.com)

## License

Released under the MIT License (MIT). See LICENSE