#!/bin/bash
export LANG=C.UTF-8

# Copyright (c) 2024 kawacoder@duck.com

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


# QUIT FUNCTION
function quit() {
  echo "THANK YOU FOR USING THIS TOOL"
  exit 2
}

function add_banner {
  echo -n "  -Copying banner....."
  if sed -i '/banner_text_here/r banner.txt' "$script_name".sh; then
    echo "ok"
  else
    echo "sed command failed"
  fi
  echo -n "  -Removing tag....."
  if sed -i '/banner_text_here/d' "$script_name".sh; then
    echo "ok"
  else
    echo "sed command failed"
  fi

}

function banner {
  clear
  echo -e "

  \e[32m █████████  █████       █████\e[0m  By KawaCoder (DR34M-M4K3R)   ████            
\e[32m███░░░░░███░░███        ░░███\e[0m                               ░░███                   ##
 \e[32m███     ░░░  ░███        ░███\e[0m     █████████████    ██████   ███████    ██████        ##
\e[32m░███          ░███        ░███\e[0m   ░░███░░███░░███  ░░░░░███ ░░░███░    ███░░███          ##
  \e[32m░███         ░███        ░███\e[0m   ░███ ░███ ░███   ███████   ░███    ░███████             ##
\e[32m░░███     ███ ░███      █ ░███\e[0m    ░███ ░███ ░███  ███░░███   ░███ ███░███░░░            ##
 \e[32m░░█████████  ███████████ █████\e[0m    █████░███ █████░░████████  ░░█████ ░░██████        ##
  \e[32m░░░░░░░░░  ░░░░░░░░░░░ ░░░░░\e[0m    ░░░░░ ░░░ ░░░░░  ░░░░░░░░    ░░░░░   ░░░░░░       ##      \e[5m############\e[0m
  "
  echo -e "\e[32m                       CLI mate: Build, Deploy, Enjoy\e[0m"
  echo -e "\e[1;31m                      !!!  TYPE h TO SEE COMMANDS  !!!\e[0m"
  echo -e "\e[1;31m                      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  \e[0m"

  echo ""
}
banner

# CATCH CTRL
trap "quit" 2

function help {
  echo -e "
\e[1;31mCLI mate\e[0m
  [\e[32mh\e[0m]  \e[31m show_help \e[0m             Shows this prompt.
  [\e[32mc\e[0m]  \e[31m compile \e[0m               End the configuration and create the script template

\e[1;32mRequired configuration\e[0m
  [\e[32m1\e[0m]  \e[32m set_invokable \e[0m         Sets if your script will be \e[34minvokable in a terminal\e[0m or \e[34mframework-like\e[0m
  [\e[32m2\e[0m]  \e[32m add_function \e[0m          Adds a function to your script and also adds it in the help menu.

\e[1;34mOptional configuration\e[0m
  [\e[32m3\e[0m]  \e[34m set_banner \e[0m            Sets the banner for your script.
  [\e[32m4\e[0m]  \e[34m set_prompt \e[0m            Sets the prompt message if the script is framework-like.
  [\e[32m5\e[0m]  \e[34m set_name \e[0m            Sets the prompt message if the script is framework-like.

  "
  echo ""
}

echo -e "Create user-friendly Command Line Interface with CLI mate."
echo ""
echo "This script is under the Mozilla Public License 2. https://www.mozilla.org/en-US/MPL/2.0/"
echo ""

is_framework=null
input_prompt=">"
script_name="Wonderful_program"

option_help='h'
option_compile='c'

option_invokable='1'
option_function='2'
option_banner='3'
option_prompt='4'
option_name='5'

# Adding default help option
if ! [ -e "help_menu.txt" ]; then
  echo "[\e[32mh\e[0m]  \e[1;31mhelp\e[0m ............... Displays this help prompt" >help_menu.txt

fi

while true; do

  input="\e[31m[\e[32mCLI\e[0m mate\e[31m]\n|\n└──$\e[0m"
  echo -e -n "$input"

  read -r x

  case $x in

  "$option_help")
    help
    ;;

  "$option_invokable")
    echo -e "\e[34m-- SET SCRIPT INVOKABILITY --\e[0m"
    echo -e "Choose the type of your script:"
    echo -e "\n \e[32m[-]\e[0m Option 1 (command-line):

      \e[34m~$\e[0m./your_script.sh -t test"
    echo ""
    echo -e "\n \e[32m[-]\e[0m Option 2 (framework-like):

      \e[34m~$\e[0m./your_script.sh
      [yourscript] -->test"
    echo ""
    echo -e -n "1/2 \n>"
    read -r x
    if [ "$x" == "2" ]; then
      is_framework=true
      echo -e "\e[32m[-]\e[0m Your script will be \e[34mframework-like\e[0m\n"
    else
      is_framework=false
      echo -e "\e[32m[-]\e[0m Your script will be \e[34minvoked by command line\e[0m\n"
    fi
    ;;

  "$option_banner")
    echo -e "\e[34m-- SET BANNER --\e[0m"
    echo "
    If you want, you can add a banner in the file 'banner.txt'. It will be added to your script.
    If nothing is found, then there will be no banner.
    "
    ;;

  "$option_function")
    echo -e "\e[34m-- NEW FUNCTION --\e[0m"
    echo "Notice: The help menu is present by default ('h')."

    echo -e -n "1. Enter function name (example: \"showMenu\"):\n>"
    read -r functionName
    echo -e -n "2. Enter function description (example: "Displays the menu"):\n>"
    read -r functionDescription
    echo -e -n "3. Enter function flag (examples: \"m\", \"5\"):\n>"
    read -r functionFlag
    new_line="[\e[32m$functionFlag\e[0m]  \e[1;31m$functionName\e[0m ............... $functionDescription"
    echo "$new_line" >>help_menu.txt
    file_content=$(cat help_menu.txt)

    new_line="$functionFlag;$functionName;$functionDescription"
    echo "$new_line" >>functions_description.txt

    echo "
    Current Functions:
    "
    echo -e "$file_content"
    echo ""
    ;;

  "$option_prompt")
    echo -e "\e[34m-- SET PROMPT --\e[0m"
    if [ "$is_framework" == true ]; then
      echo -e "1. Enter input prompt (example: \">\"):"
      read -r prompt
      input_prompt=$prompt
    else
      echo -e "[!] You first have to set your script as framework-like. (Please type 1)"
    fi
    ;;

  "$option_name")
    echo -e "\e[34m-- SET NAME --\e[0m"
    echo -e -n "1. Enter the name of your script:\n>"
    read -r name
    script_name=$name
    ;;

  "$option_compile")
    echo -e "\e[34m-- CREATING SCRIPT TEMPLATE --\e[0m"

    if [ "$is_framework" == null ]; then

      echo "Please set the type of your script:

      Regular CLI script or framework script (like this one)
      
      Please type 1:"

    fi

    # Common actions

    if [ "$is_framework" == false ]; then

      echo "skibidi bop bop"

    elif [ "$is_framework" == true ]; then

      echo "[*] PREPARING..."
      # adding function flag
      while IFS=';' read -r function_number function_name function_description; do
        # Output the extracted fields
        echo -e -n "  -Preparing \e[32m$function_name\e[0m....."

        echo "
  \"\$option_$function_name\")
  echo \"$function_description\"
  # Your code here
  ;;
      " >>functions.txt
        echo "ok"
        echo -e -n "  -Setting variable: \e[32m$function_name\e[0m....."
        echo "option_$function_name=\"$function_number\"" >>argument_variables.txt
        echo "ok"

      done <"functions_description.txt"
      echo "[*] WRITING..."

      # Functions
      echo -n "  -Copying functions....."
      if sed -e '/options_here/r functions.txt' framework_template.txt >"$script_name".sh; then
        echo "ok"
      else
        echo "sed command failed"
      fi
      echo -n "  -Removing tag....."
      if sed -i '/options_here/d' "$script_name".sh; then
        echo "ok"
      else
        echo "sed command failed"
      fi

      # Banner
      add_banner

      # Help Menu
      echo -n "  -Copying help menu....."
      if sed -i '/help_menu_here/r help_menu.txt' "$script_name".sh; then
        echo "ok"
      else
        echo "sed command failed"
      fi
      echo -n "  -Removing tag....."
      if sed -i '/help_menu_here/d' "$script_name".sh; then
        echo "ok"
      else
        echo "sed command failed"
      fi

      # Variables
      echo -n "  -Copying variables....."
      if sed -i '/argument_variables_here/r argument_variables.txt' "$script_name".sh; then
        echo "ok"
      else
        echo "sed command failed"
      fi
      echo -n "  -Removing tag....."
      if sed -i '/argument_variables_here/d' "$script_name".sh; then
        echo "ok"
      else
        echo "sed command failed"
      fi

      # Input prompt
      echo -n "  -Setting input prompt....."
      if sed -i "s/input_here/$input_prompt/g" "$script_name".sh; then
        echo "ok"
      else
        echo "command failed"
      fi

      # Execution rights
      echo "[*] FINISHING..."
      echo -n "  -Setting execution right....."

      if chmod +x "$script_name".sh; then
        echo "ok"
      else
        echo "command failed"
      fi

      echo -n "  -Removing tempfiles....."
      if rm functions.txt argument_variables.txt; then
        echo "ok"
      else
        echo "command failed"
      fi

      echo -e "\e[32mDONE\e[0m"

    fi

    ;;

  *)
    echo -e -n "unknown\n"
    ;;
  esac
done
