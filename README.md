# MySQL Configuration Cookbook

This wrapper cookbook installs and configures MySQL while also optimizing the OS.
The attributes files is configured to be on a system with 4G of memory and uses separate disk for
data and logs for added performance and data integrity. This is intended to give a better out the box
install than a default rpm mysql install. You can fork this repo and edit the attributes files to take
better advantage of your system resources as well as add/subtract attributes.

The [MySQL Community Cookbook](https://github.com/chef-cookbooks/mysql) is the basis for the intial install.
You will use both the mysql_service and mysql_config resource. I suggest reading the [README](https://github.com/chef-cookbooks/mysql/blob/master/README.md) thoroughly before starting.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['mysql_config']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### mysql_config::default

Include `mysql_config` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[mysql_config::default]"
  ]
}
```

## License and Authors

Author:: YOUR_NAME (<YOUR_EMAIL>)
