[![Build Status](https://travis-ci.org/DecibelInsight/ansible-atop.svg?branch=master)](https://travis-ci.org/DecibelInsight/ansible-atop)

Role Name
=========

Install and configure `atop` service.

In the setup step, the default `/etc/init.d/atop` file is replaced by an upstart
configuration file that keeps atop running and resets it every 12 hours.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    ---
      - hosts: all
        roles:
          - atop

License
-------

BSD
