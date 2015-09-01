## wordpress

[![Build Status](https://travis-ci.org/Oefenweb/ansible-wordpress.svg?branch=master)](https://travis-ci.org/Oefenweb/ansible-wordpress) [![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-wordpress-blue.svg)](https://galaxy.ansible.com/list#/roles/2600)

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
* `wordpress_installs.{n}.path`: [required]: Install directory for wordpress
* `wordpress_installs.{n}.owner`: [default: `www-data`]: The name of the user that should own the install
* `wordpress_installs.{n}.group`: [default: `owner`, `www-data`]: The name of the group that should own the install
* `wordpress_installs.{n}.url`: [required]: Wordpress url
* `wordpress_installs.{n}.title`: [required]: Wordpress title
* `wordpress_installs.{n}.admin_name`: [default: `admin`, optional]: Wordpress admin (user)name
* `wordpress_installs.{n}.admin_email`: [required]: Wordpress admin email address
* `wordpress_installs.{n}.admin_password`: [required]: Wordpress admin password (**make sure to change**)
* `wordpress_installs.{n}.themes`: [required]: (Additional) themes to install (and activate)
* `wordpress_installs.{n}.plugins`: [required]: (Additional) plugins to install (and activate)
* `wordpress_installs.{n}.users`: [optional]: User declarations
* `wordpress_installs.{n}.users.src`: [required]: The local path of the [csv file](http://wp-cli.org/commands/user/import-csv/) to import, can be absolute or relative (e.g. `../../../files/wordpress/users.csv`)
* `wordpress_installs.{n}.users.skip_update`: [default: `true`, optional]: Whether or not to update users that already exist
* `wordpress_installs.{n}.options`: [required]: Options to add, update or delete
* `wordpress_installs.{n}.options.{n}.command`: [required]: Add, update or delete
* `wordpress_installs.{n}.options.{n}.name`: [required]: Name of the option
* `wordpress_installs.{n}.options.{n}.value`: [required]: Value of the option

## Dependencies

None

#### Example

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
        themes: []
        plugins: []
        users: {}
        options: []
```

#### License

MIT

#### Author Information

Mischa ter Smitten

#### Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/Oefenweb/ansible-wordpress/issues)!
