
#!/bin/bash

loggedInUser=$(scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }') 
echo $loggedInUser
path=( $(find /Users/$loggedInUser -type d -name "OneDrive\ -\ Walmart\ Inc" 2>/dev/null) )
echo ${path[@]}

#find /Users/$loggedInUser -type d -name "OneDrive - Walmart Inc" 2>/dev/null 
#IFS=" \n"
for i in "${path[@]}"; do
echo "$i"
if [ -e $i ]; then
	logic_before_space=$(find "$i" -depth -name ' *' -execdir bash -c 'f=${1#./}; mv "./$f" "./${f#"${f%%[![:space:]]*}"}"' Move {} \;)
	logic_after_space=$(find "$i" -depth -name '* ' -execdir bash -c 'mv "$1" "${1%"${1##*[^[:space:]]}"}"' Move {} \;)
	echo "Spaces are fixed"
else
	echo "Machine doesnt have OneDrive Installed"
fi
done