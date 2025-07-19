Launchctl Job Template
======================
_Lowering the bar to schedule little scripts on Mac._

### The Problem
You've got a little script that's meant to run on a schedule - maybe a data export, maybe a validation, maybe a download.

The script works and you've pushed it to Github... but now you and your users have to get it scheduled.

If you leave it to your users, they have to create and manage the plist file themselves.

If you put it in your Github repo

And how to deal with config values?









Maybe a data download, a 


It's annoying to build projects that are intended to run in `launchctl`.
This is a template for building scripts that run on schedules in Mac's `launchctl`.

It gives you:

- A placeholder script with `.plist` file to start from, with logging configured
- Placeholder config for your script, already hooked up
- A workflow to walk your users through creating the config file if one doesn't exist
- Idempotent `install.sh` and `uninstall.sh` scripts for un/installing to `launchd`
- Error-checking

Why?

Because

How it works
----------
1. You [create a new repository using this template](https://github.com/new?template_name=launchctl-automation-template&template_owner=mieubrisse)
1. You clone your new repo
1. You run the `bootstrap.sh` script and fill in the name for your script you want to run on a schedule (e.g. `safebrew.sh`)

This will set up the repository with:

- A script with the name you gave (e.g. `safebrew.sh`)
- A config file template at `config.env.example`
- An idempotent `install.sh` script that will:
    - Walk your user through filling out the `config.env.example`
    - Create a `.plist` file in `~/Library/LaunchAgents`, and load it into `launchctl`
- An idempotent `uninstall.sh` script that undoes everything in `install.sh`

(You can see exact changes with `git status`)

You can then:

- Test your new script
- Test the `install.sh`

the script you named (e.g. , ready for your use. To see a summary of the changes, do a `git status`.

After bootstrapping, you'll need to:

- Modify the entrypoint script (e.g. `safebrew.sh`)
- Modify `config.env.example`
- Modify the .plist file getting generated in `install.sh` to contain the run schedule you want (it's currently set to run every day at noon)
- Delete the `bootstrap.sh` script (it's no longer needed)

When you're ready to install your script into launchd, you can use `install.sh`. you need.It's idempotent; you can re-run it as many times as 

Your script can be uninstalled from `launchd` wiht `uninstall.sh`.

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
