# ansible-yaml-parser

## Introduction

This repository is created with the unique purpose of allow the use of environment variables "inside" of YAML files,
using [Jinja2 templates](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_templating.html) and
[Ansible](https://docs.ansible.com/core.html).

## Requirements

- Docker

## How it works

Basically, you will be creating regular yml/yaml files with a Jinja2 extension (j2), for example `portainer.yml.j2`,
inside of the file you will need to do some extra syntax work to make it work, changing the static values you want to
replace with a environment variable lookup from Ansible, something like
`"{{ lookup('ansible.builtin.env', "MY_AWESOME_ENV_VAR", default=Undefined ) }}"`.

We use the `default=Undefined` part to ensure the environment variable is set, if that's not the case, Ansible will throw an error. If you want to modify this behavior, you can remove it.

You can find both examples on the **examples** folder.

## How to implement it

Playbook will initially look information on a folder called `templates`, and will created the new files in a folder called `rendered` (once they are processed), so basically you just need to mount two volumes to the image, add the environment variables that you will be using and that is enough.

### Example

```yaml
version: "3.8"
services:
init_container:
  image: ansible-yaml-parser
  volumes:
    - "./my-template-folder:/app/templates"
    - "./my-rendered-folder:/app/rendered"
  environment:
    MY_AWESOME_ENV_VAR_ONE: One
    MY_SECOND_ENV_VAR_TWO: Two
    COOL_ENV_VAR: Three
    LAST_ONE: Four
```
