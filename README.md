Launchctl Automation Template
=============================
This is a template for building a project that gets installed in Mac launchctl.

Why?

There's a bit of boilerplate to building a project intended to run `launchctl`: the plist syntax, configuration, remembering to `launchctl load` and `unload`, etc.

This project provides an opinionated template to get you started.

How To Use
----------
1. Cloen this

Projects built on this template:

- [safebrew](https://github.com/mieubrisse/safebrew)
- [activitywatch-screentime-webhook-loader](https://github.com/mieubrisse/activitywatch-screentime-webhook-loader)

What you'll get
---------------
1. An idempotent `install.sh` script that takes the user through a nice config-filling flow and loads your script into `launchctl`
2. An idempotent `uninstall.sh` script that removes your script from `launchctl`
3. An example config file

Design Choices
--------------
The command run inside a `.plist` file by `launchd` can't have environment variables, and doesn't source `.bashrc`, `.zshrc`, etc.

But you'll very likely need your users to set configuration values.

This project's stance is that we should create a dotfile in the user's home directory, which gets read when `launchd` executes your script.



How it works
------------
1. `install.sh` will

A tiny automation system for regularly doing `brew bundle dump` to a Git repo, and `git push`ing it.

Why this repo?

Automated Homebrew backup is in an odd state. Everybody has the problem - I found multiple blog posts and several personal repos - but all the solutions are bespoke. Nobody seems to provide an off-the-shelf solution for doing it.

Maybe it's considered too small to be worth the time?

But I figured there was enough complexity to build something generally usable, so here it is.

Installation
------------
1. Clone this repo somewhere:
   ```
   git clone git@github.com:mieubrisse/safebrew.git
   ```
1. Run the installation:
   ```
   bash install.sh
   ```
1. Follow the prompts to fill in the config values. You can use `$HOME`.

Usage
-----
A backup will be taken every day at noon.

You can run the backup manually with `safebrew.sh`.

Automated backup logs get written to `/tmp/safebrew.sh.out` and `/tmp/safebrew.sh.err`.

💡 You might want to set up alerting to ensure the backups are still running (e.g. in n8n).

Uninstall
---------
Run the `uninstall.sh` script.
