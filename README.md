# Random password generator

Foobar is a Python library for dealing with word pluralization.

## Installation

This script can be ran from the downloaded directory. It will need to have execute permission.

```shell
chmod +x pwgen.sh
```
It can also be installed to your path.
```
mv pwgen.sh /usr/bin/pwgen
```

## Usage
Length must be specified.
If no options are set for types a default of upper lower and numbers will be used (no specials)
The minimum length is 8 and the maximum length is 128

h     Prints this help message
n     Set the password length (required)
u     Sets if upper case letters should be used
l     Sets if lower case letters should be used
s     Sets if special characters should be used
N     Sets if numbers should be used

Example usage:\
./pwgen.sh -n 15 -ulN
FkA9ew2XHWuBrX8
