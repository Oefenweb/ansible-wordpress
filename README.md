## wordpress

[![Build Status](https://travis-ci.org/Oefenweb/ansible-wordpress.svg?branch=master)](https://travis-ci.org/Oefenweb/ansible-wordpress) [![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-wordpress-blue.svg)](https://galaxy.ansible.com/list#/roles/2600)

Set up wordpress (using `wp-cli`).

#### Requirements

* `php` (5.3.2+)
* `mysql` (5.0+)
* `apache2` (with `mod_rewrite` enabled)

This role assumes a working virtual host (that handles `wordpress_url`).

#### Variables

* `wordpress_wp_cli_install_dir` [default: `/usr/local/bin`]: Install directory for `wp-cli`

* `wordpress_dbname`: [default: `wordpress`]: Database name
* `wordpress_dbuser`: [default: `wordpress`]: Database username
* `wordpress_dbpass`: [default: `'heCrE7*d2KEs'`]: Database password (make sure to change)
* `wordpress_dbhost`: [default: `localhost`]: Database host
* `wordpress_path`: [default: `/var/www`]: Install directory for wordpress
* `wordpress_url`: [default: `http://localhost`]: Wordpress url
* `wordpress_title`: [default: `wordpress`]: Wordpress title
* `wordpress_admin_name`: [default: `admin`]: Wordpress admin (user)name
* `wordpress_admin_email`: [default: `root@localhost`]: Wordpress admin email address
* `wordpress_password`: [default: `'tuFr8=aPra@a'`]: Wordpress admin password (make sure to change)

## Dependencies

None

#### Example

```yaml
---
- hosts: all
  roles:
  - wordpress
```

#### License

MIT

#### Author Information

Mischa ter Smitten

#### Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/Oefenweb/ansible-wordpress/issues)!
