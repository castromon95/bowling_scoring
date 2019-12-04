# Readme
## Introduction
Throughout this document we'll explain how to deploy in a local environment the Bowling scoring CLI APP. This is a Ruby project.

**Note**: This guide is specific for an Ubuntu operating system. However, you can follow the same steps looking for the respective commands for your operating system.

## Table of contents

1. [Install rbenv](#install-rbenv)
2. [Project setup](#project-setup)

## Install rbenv
rbenv is a powerful ruby version manager that allows teams to be on the same page easily. You can install and change between ruby versions with a single command. It allows to specify the app Ruby version once, in a single file.

### Procedure
Clone rbenv into ~/.rbenvin
```bash
$ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
```

Add ~/.rbenv/bin to your $PATH for access to the rbenv command-line utility
```bash
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
```

Set up rbenv in your shell and follow the instructions given

**Note:** The instructions say to append ```eval "$(rbenv init -)"``` command to the ~/.bashrc or the ~/.bash_profile

```bash
$ ~/.rbenv/bin/rbenv init
```

Restart your terminal and install ruby-build to get access to the ``` rbenv install ``` command
```bash
$ mkdir -p "$(rbenv root)"/plugins
$ git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
```

Verify that rbenv is properly set up using this rbenv-doctor script

**Note:** Probably you will have none Ruby versions installed
```bash
$ curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
```

Install a ruby version

**Note:** You can find the projects current ruby version in the .ruby-version file in the projects root directory
```bash
$ rbenv install x.x.x
```

To verify the current installed ruby versions
```bash
$ rbenv versions
```

To set a global ruby version for your system
```bash
$ rbenv global x.x.x
```

To verify the current global ruby version for your system
```bash
$ rbenv global
```

To verify the current local ruby version for an specific path

**Note:** Verify that the local ruby version of the project is the one set in the .ruby-version file
```bash
$ rbenv local
```

### Reference
* [https://github.com/rbenv/rbenv](https://github.com/rbenv/rbenv)
* [https://github.com/rbenv/ruby-build#readme](https://github.com/rbenv/ruby-build#readme)

---

## Project setup
Clone this project to your local machine and open a terminal in its root directory.

### Procedure

Install bundler
```bash
$ gem install bundle
```

Install the project dependencies
```bash
$ bin/setup
```

Run the CLI APP

**Note:** You can find sample .txt files in the ```spec/samples/``` directory with their respective results in the ```spec/results/``` directory
```bash
$ bin/start
```

To run the CLI APP tests, run the following command from the projects root directory

**Note:** After running the tests, you can see the projects coverage by openning the ```coverage/index.html``` file in your favorite browser
```bash
$ rspec
```

### Reference
* [https://bundler.io/](https://bundler.io/)
* [https://rspec.info/](https://rspec.info/)
* [https://github.com/colszowka/simplecov](https://github.com/colszowka/simplecov)