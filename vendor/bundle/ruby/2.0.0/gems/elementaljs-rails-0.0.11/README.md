# Elementaljs::Rails

A small wrapper around ElementalJS library to include in Rails projects.

## Installation

Add this line to your application's Gemfile:

    gem 'elementaljs-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elementaljs-rails

## Usage

To include in your Rails Javascript manifest 

	//= require elemental
	
To have Elemental load by default on document ready, include:

	//= require elemental-onload	
	
If you are also using the behaviours that come with the Gem, you can use by including:
	
	//= require elemental-reload
	//= require elemental-javascript_enabled
  //= require elemental-jquery_plugin

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
