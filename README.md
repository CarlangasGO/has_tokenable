Identify your active records with random tokens when you don't want your users to see a sequential ID.


------------------------------------------------------------------------------
Installation
------------------------------------------------------------------------------

Add has_tokenable to your Gemfile like so:

```ruby
gem 'has_tokenable', '~> 0.1.0'
```

Now run `bundle install` and you're good to go!


------------------------------------------------------------------------------
Usage
------------------------------------------------------------------------------

First, add a token to your model's table with a migration:

```ruby
# Upgrade and existing table
class AddTokenToItems < ActiveRecord::Migration
  add_column :items, :token, :string
end

# Add to a new table
class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.token
      t.string :name

      t.timestamps
    end
  end
end
```


Now make sure your model knows to use it's token by calling `has_tokenable`

```ruby
class Item < ActiveRecord::Base
  has_tokenable  
end
```

That's basically it! Your Items will now know to use their token as their identifier.

Try it out in your `rails console`

```ruby
@item = Item.create(name: "Tokenz!")
#<Item id: 1, token: "B5OvJvy6B2_DZg", name: "Tokenz!", created_at: "2020-01-26 20:17:13", updated_at: "2020-01-26 20:17:13">
@item.to_param
# B5OvJvy6B2_DZg
@item == Item.find("B5OvJvy6B2_DZg")
# true
```


------------------------------------------------------------------------------
Options
------------------------------------------------------------------------------

You can customize has_tokenable by setting a few options. Here's the defaults:

```ruby
{
  prefix:             nil, # if nil use first letter of class name
  length:             10,
  param_name:         'token',
  method_random:      'urlsafe_base64' #method random urlsafe_base64 hex alphanumeric random_number uuid
}
```


Options can be set globally by overwriting the `HasTokenable.default_token_options`

```ruby
# config/initializers/has_tokenable.rb

# for one option
HasTokenable.default_token_options[:prefix] = "OMG"

# for multiple options
HasTokenable.default_token_options.merge!(
  method_random:      'alphanumeric',
  length:         8
)
```

Options can also be set on a per-class level:

```ruby
class List < ActiveRecord::Base
  has_tokenable prefix: "LI", length: 10
end

class Item < ActiveRecord::Base
  has_tokenable prefix: "ITM"
end
```


------------------------------------------------------------------------------
Demo
------------------------------------------------------------------------------

Try out the demo to get a real clear idea of what has_tokenable does.

```bash
git clone git://github.com/CarlangasGO/has_tokenable.git
cd has_tokenable
bundle install
rails s
```

Now open your browser to [http://localhost:3000](http://localhost:3000)


------------------------------------------------------------------------------
License
------------------------------------------------------------------------------

Copyright (c) 2019 - 2020, released under the New BSD License All rights reserved.
