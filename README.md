chef-tmate-slave Cookbook
=========================

http://tmate.io

This is to be able to spin up and build a tmate-slave vm easily. The theory being run chef-solo with this and boom, you have a tmate-slave running so you can pair program.

WIP TODO
--------
1. complete chef-solo run
2. move away from 10.04 ubuntu


Requirements
------------
Developed and Tested on Ubuntu 10.04


Usage
-----
#### tmate-slave::default

1\. Be sure to change the domain in the [defaults.rb](attributes/default.rb) file.

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

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: JJ Asghar
