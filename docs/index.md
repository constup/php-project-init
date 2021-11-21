## ProjectInit

**NOTE**: This page and the rest of the documentation is currently work in progress. Once the final version is 
published, this note will be removed. 

### Setup your next software project in seconds 

```shell
cd projectinit.sh/bin/php
sh init_generic.sh
```

[Check out the list of available tools here.](list_of_tools.md)

### Install, configure and run

Install by cloning the repository:

```shell
git clone git@github.com:constup/projectinit.sh.git
```

or by downloading the latest release from [https://github.com/constup/projectinit.sh/releases](https://github.com/constup/projectinit.sh/releases).

Configure ProjectInit.sh by running:

```shell
sh configure.sh
```

### Completely cross-platform

ProjectInit.sh is tested on Linux, Windows and macOS. For detailed instructions on how to install Bash and supporting
tools (like wget, curl,...) on your operating system, check out this Documentation section.

### Spend more time on actual work

If you are building, maintaining and/or contributing to multiple projects or git repositories, ProjectInit.sh can help 
you set up everything you need to start a new project or setup an existing one on a new computer.
All of your projects will also be set up in exactly the same way, just the way you like it.

### Make it your own

ProjectInit.sh comes with a default set of bash scripts separated into components. Each master script is a compilation
of individual component scripts.

You are free to mix the components or write your own to cover your perfect setup.

### Beginner? Learn with ProjectInit.sh

ProjectInit.sh is written in Bash and divided into individual components. Want to learn how to download Composer from
terminal? Take a look at `src/php/composer/composer.sh`:

```shell
download_latest_composer_phar () {
  echo ""
  wget -O composer.phar "https://getcomposer.org/composer.phar"
  chmod +x composer.phar
  php composer.phar self-update
  echo ""
  php composer.phar --version
}
```