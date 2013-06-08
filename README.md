# Pixtory [![Build Status](https://travis-ci.org/Sutto/pixtory.png)](https://travis-ci.org/Sutto/pixtory)


This provides the pixtory API used in the the [Pixtory iOS app](https://github.com/Sutto/pixtory-ios).

See [ourpixtory.com](http://ourpixtory.com/) for more information.

## Setup

Note that pixtory requires Ruby 2.0, Bundler and Postgres to be installed.

```bash
git clone git://github.com/Sutto/pixtory.git
cd pixtory
bundle install
createuser pixtory
createdb pixtory_test -O pixtory
createdb pixtory_development -O pixtory
rake db:migrate
rails runner 'DumpImporter.import! "data/dump.csv"'
```

## Manual Data

The data in `data/dump.csv` is pulled from our initial data set on [Google Docs](https://docs.google.com/spreadsheet/pub?key=0AjnwWreDoXUKdDRDakRfQmRuVEQ0Rlo3M2F1ci1oUWc&output=html), pulled from the State Library of WA.

This data is licensed under [Creative Commons BY-NC-SA](http://creativecommons.org/licenses/by-nc-sa/3.0/au/).

## Code

All code for Pixtory is released under the MIT License. Please see `LICENSE` in this repository.

Copyright the Pixtory Team, 2013.