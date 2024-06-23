# Trinity Scripts

This directory contains scripts that exercise deployed witness functionality.

## Getting Started
Before running any of the scripts here, you need to source the file `setup.sh` into your current shell to set
the environment variables used to locate additional files needed during the execution of some commands.  The easiest way to
do this is:

`source setup.sh`

### Building config files

`./generate.sh` can be run for `--dev`, `--staging` and `--production` this will generate the necessary file from the top level config.yaml.

### Probing

`./probe.sh` can be run for `--dev`, `--staging` and `--production` this inititaes a sequence of oobi resolution and challenege / response to exercise a given witnesses mailbox.