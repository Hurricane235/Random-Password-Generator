#!/bin/bash
# Name: Random password generator
# Author: Tom Clay

pw_min="8"
pw_max="128"
pw_num=("1" "2" "2" "4" "5" "6" "7" "8" "9" "0")
pw_lower=("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")
pw_upper=("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")
pw_special=("!" "\"" "£" "$" "%" "^" "&" "*" "(" ")")

type_value=0
# Set the help message function
Help() {
  echo "Random password generator:"
  echo ""
  echo "Length must be specified."
  echo "If no options are set for types a default of upper lower and numbers will be used (no specials)"
  echo "The minimum length is $pw_min and the maximum length is $pw_max"
  echo ""
  echo "h     Prints this help message"
  echo "n     Set the password length (required)"
  echo "u     Sets if upper case letters should be used"
  echo "l     Sets if lower case letters should be used"
  echo "s     Sets if special characters should be used"
  echo "N     Sets if numbers should be used"
  echo ""
  echo "Example usage:"
  echo "./pwgen.sh -n 15 -ulN"
  echo "FkA9ew2XHWuBrX8"
}

generate() {
  cur_len=1
  passwd=
  while [[ "$cur_len" -le "$pw_len" ]]
  do
    # Select the char type
    random=$((1 + $RANDOM % 5000))
    type=${opts[$random % ${#opts[@]}]}
    if [[ "$type" == "spe" ]]
    then
      random=$((1 + $RANDOM % 5000))
      new_char=${pw_special[$random % ${#pw_special[@]}]}
      passwd=$(echo $passwd$new_char)
    elif [[ "$type" == "num" ]]
    then
      random=$((1 + $RANDOM % 5000))
      new_char=${pw_num[$random % ${#pw_num[@]}]}
      passwd=$(echo $passwd$new_char)
    elif [[ "$type" == "low" ]]
    then
      random=$((1 + $RANDOM % 5000))
      new_char=${pw_lower[$random % ${#pw_lower[@]}]}
      passwd=$(echo $passwd$new_char)
    elif [[ "$type" == "up" ]]
    then
      random=$((1 + $RANDOM % 5000))
      new_char=${pw_upper[$random % ${#pw_upper[@]}]}
      passwd=$(echo $passwd$new_char)
    fi
    let cur_len=$cur_len+1
  done
}

# Test if there are any options to the command
if [[ -z "$@" ]]
then
  Help
  exit 1
fi


while getopts "hn:ulsN" option; do
   case $option in
      h) # display Help
        Help
        exit;;
      n) # Set the password length
        pw_len=$OPTARG;;
      u) # Set upper to enabled
        let type_value=$type_value+8;;
      l) # Set lower to enabled
        let type_value=$type_value+4;;
      N) # Set number to enabled
        let type_value=$type_value+2;;
      s) # Set special to true
        let type_value=$type_value+1;;
      *)
        echo "Invalid option"
        Help
        exit;;
   esac
done

# Check if the password is too big/small
if [[ -z "$pw_len" ]]
then
  echo "Please specify a password length"
  exit 1
elif [[ "$pw_len" -lt "$pw_min" ]]
then
  echo "Password too short, minimum length is $pw_min"
  exit 1
elif [[ "$pw_len" -gt "$pw_max" ]]
then
  echo "Password too long, maximum length is $pw_max"
  exit 1
fi


case $type_value in
  1)
    opts=("spe")
    generate;;
  2)
    opts=("num")
    generate;;
  3)
    opts=("spe" "num")
    generate;;
  4)
    opts=("low")
    generate;;
  5)
    opts=("spe" "low")
    generate;;
  6)
    opts=("num" "low")
    generate;;
  7)
    opts=("spe" "num" "low")
    generate;;
  8)
    opts=("up")
    generate;;
  9)
    opts=("spe" "up")
    generate;;
  10)
    opts=("num" "up")
    generate;;
  11)
    opts=("num" "up" "spe")
    generate;;
  12)
    opts=("low" "up")
    generate;;
  13)
    opts=("spe" "low" "up")
    generate;;
  14)
    opts=("num" "low" "up")
    generate;;
  15)
    opts=("spe" "num" "low" "up")
    generate;;
  *)
    opts=("num" "low" "up")
    generate;;
esac

echo $passwd
