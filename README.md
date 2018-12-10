## wordpress

[![Build Status](https://travis-ci.org/Oefenweb/ansible-wordpress.svg?branch=master)](https://travis-ci.org/Oefenweb/ansible-wordpress) [![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-wordpress-blue.svg)](https://galaxy.ansible.com/Oefenweb/wordpress)

Set up (multiple) wordpress installations in Debian-like systems (using `wp-cli`).

#### Requirements

* `php` (5.3.2+)
* `mysql` (5.0+)
* `apache2` (with `mod_rewrite` enabled)

This role assumes a working virtual host (that handles `wordpress_url`).

#### Variables

* `wordpress_wp_cli_install_dir` [default: `/usr/local/bin`]: Install directory for `wp-cli`

* `wordpress_installs`: [default: `[]`]: Installation declarations
* `wordpress_installs.{n}.name`: [required]: Install name (not used for anything, just an identifier)
* `wordpress_installs.{n}.dbname`: [required]: Database name
* `wordpress_installs.{n}.dbuser`: [required]: Database username
* `wordpress_installs.{n}.dbpass`: [required]: Database password (**make sure to change**)
* `wordpress_installs.{n}.dbhost`: [default: `localhost`, optional]: Database host
* `wordpress_installs.{n}.dbprefix`: [default: `wp_`, optional]: Prefix for database tables
* `wordpress_installs.{n}.path`: [required]: Install directory for wordpress
* `wordpress_installs.{n}.locale`: [default: `en_US`, optional]: Language of the downloaded Wordpress
* `wordpress_installs.{n}.owner`: [default: `www-data`]: The name of the user that should own the install
* `wordpress_installs.{n}.group`: [default: `owner`, `www-data`]: The name of the group that should own the install
* `wordpress_installs.{n}.url`: [required]: Wordpress url
* `wordpress_installs.{n}.title`: [required]: Wordpress title
* `wordpress_installs.{n}.admin_name`: [default: `admin`, optional]: Wordpress admin (user)name
* `wordpress_installs.{n}.admin_email`: [required]: Wordpress admin email address
* `wordpress_installs.{n}.admin_password`: [required]: Wordpress admin password (**make sure to change**)

* `wordpress_installs.{n}.cron`: [optional]: Cron declaration
* `wordpress_installs.{n}.cron.use_crond`: [default: `false`]: Whether or not to use `crond` instead of wp-cron
* `wordpress_installs.{n}.cron.user`: [default: `www-data`]: User to run job as
* `wordpress_installs.{n}.cron.schedule`: [optional]: Cron schedule declaration
* `wordpress_installs.{n}.cron.schedule.day`: [default: `*`]: Day when the job should run
* `wordpress_installs.{n}.cron.schedule.hour`: [default: `*`]: Hour when the job should run
* `wordpress_installs.{n}.cron.schedule.minute`: [default: `*`]: Minute when the job should run
* `wordpress_installs.{n}.cron.schedule.month`: [default: `*`]: Month when the job should run
* `wordpress_installs.{n}.cron.schedule.weekday`: [default: `*`]: Weekday when the job should run

* `wordpress_installs.{n}.themes`: [required]: (Additional) themes to install (and activate)
* `wordpress_installs.{n}.themes.{n}.name`: [required]: Name of the theme
* `wordpress_installs.{n}.themes.{n}.activate`: [default: `false`, optional]: Whether or not to activate the theme

* `wordpress_installs.{n}.plugins`: [required]: (Additional) plugins to install (and activate)
* `wordpress_installs.{n}.plugins.{n}.name`: [required]: Name of the plugin
* `wordpress_installs.{n}.plugins.{n}.zip`: [optional]: Zip of the plugin
* `wordpress_installs.{n}.plugins.{n}.url`: [optional]: Url of the plugin
* `wordpress_installs.{n}.plugins.{n}.activate`: [default: `true`, optional]: Whether to activate or to deactivate the plugin
* `wordpress_installs.{n}.plugins.{n}.force`: [default: `false`, optional]: Whether or not to add the `--force` option during install

* `wordpress_installs.{n}.users`: [optional]: User declarations
* `wordpress_installs.{n}.users.src`: [required]: The local path of the [csv file](http://wp-cli.org/commands/user/import-csv/) to import, can be absolute or relative (e.g. `../../../files/wordpress/users.csv`)
* `wordpress_installs.{n}.users.skip_update`: [default: `true`, optional]: Whether or not to update users that already exist

* `wordpress_installs.{n}.options`: [required]: Options to add, update or delete
* `wordpress_installs.{n}.options.{n}.command`: [required]: Add, update or delete
* `wordpress_installs.{n}.options.{n}.name`: [required]: Name of the option
* `wordpress_installs.{n}.options.{n}.value`: [required]: Value of the option
* `wordpress_installs.{n}.options.{n}.autoload`: [default: `true`, optional]: Whether this option should be automatically loaded (only supported for add command)

* `wordpress_installs.{n}.queries`: [default: `[]`, optional]: A list of queries to execute

## Dependencies

None

## Examples 

### Quickstart

```yaml
---
- hosts: all
  roles:
  - wordpress
  vars:
    wordpress_installs:
      - name: wordpress
        dbname: wordpress
        dbuser: wordpress
        dbpass: 'heCrE7*d2KEs'
        dbhost: localhost
        path: /var/www
        url: http://localhost
        title: wordpress
        admin_name: admin
        admin_email: root@localhost.localdomain
        admin_password: 'tuFr8=aPra@a'
        themes:
          - name: twentytwelve
            activate: true
          - name: twentythirteen
        plugins:
          - name: contact-form-7
            activate: false
          - name: simple-fields
        users: {}
        options: []
        queries: []
```

### Using options:


```yaml
---
- hosts: all
  roles:
  - wordpress
  vars:
    wordpress_installs:
      - name: wordpress
        dbname: wordpress
        dbuser: wordpress
        dbpass: 'heCrE7*d2KEs'
        dbhost: localhost
        path: /var/www
        url: http://localhost
        title: wordpress
        admin_name: admin
        admin_email: root@localhost.localdomain
        admin_password: 'tuFr8=aPra@a'
        themes:
          - name: twentytwelve
            activate: true
          - name: twentythirteen
        plugins:
          - name: contact-form-7
            activate: false
          - name: simple-fields
        users: {}
        options: 
          - name: woocommerce_api_enabled
            command: update
            value: yes
          - name: swoocommerce_email_from_name
            command: update
            vakue: payments@mycompany.com
          - name: woocommerce_currency
            command: update
            vakue: MXN
        queries: []
```

#### License

MIT

#### Author Information

Mischa ter Smitten

#### Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/Oefenweb/ansible-wordpress/issues)!
