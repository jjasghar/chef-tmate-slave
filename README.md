# chef-tmate-slave Cookbook
[![Build Status](https://travis-ci.org/jjasghar/chef-tmate-slave.png)](https://travis-ci.org/jjasghar/chef-tmate-slave)


Based off of: http://tmate.io

This is to be able to spin up and build a tmate-slave vm easily. The theory being run chef-solo with this and boom, you have a tmate-slave running so you can pair program.


## Suggested Requirements

I suggest something like [Digital Ocean](http://digitalocean.com/) and [knife-solo](http://matschaffer.github.io/knife-solo/) to provision the box. 


## Usage

#### tmate-slave::default

e.g.
Just include `chef-tmate-slave` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chef-tmate-slave]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors
Authors: Jonathan "JJ" Asghar
