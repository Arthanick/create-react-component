#!/bin/bash

# this script is used for creation a component folder
# with default import and export and as default style file ${name}.scss
# usage: 
# 1) add in your package.json
#     "scripts": {
#       "crcomp": "bash createComponent.sh"     -- you can use any script name what you want, it's just example
#     }
# 2) after that print in your console: npm run crcomp
# 3) Also you can just print command: bash ./createComponent.sh
# 4) If you won't put this script in your project folder you can put it in the folder above and call:
#     bash ../createComponent.sh
# If you won't use it you can install https://www.npmjs.com/package/create-react-component-folder

function askcmd() {
  while read -r -n 1 answer; do
  if [[ $answer = [YyNn] ]]; then
    [[ $answer = [Yy] ]] && retval='true'
    [[ $answer = [Nn] ]] && retval='false'
    break
  fi
  done
  echo $retval
}

extension="js"
tsType=""
#Red error
ERROR="\x1B[31mERROR\x1B[0m"
inFolder='\t\t \xE1\xB4\xB8'
testFlag='false'
tsFlag='false'

#CLI
read -e -p "Enter path to your component folder: " path
read -p "Enter component name: " componentName
echo -n "Do you want to create a test file (Y/N)? "
testFlag=$(askcmd)
echo ''
echo -n "Do you want to use a .ts extension (Y/N)? "
tsFlag=$(askcmd)
echo ''

#First letter to upper case
componentName="$(tr a-z A-Z <<< ${componentName:0:1})${componentName:1}"

#Parse args
if [ $tsFlag = 'true' ]; then
  tsType=": React.FC"
  extension="ts"
fi

#fill templates with variables above
ComponentTemplate=$"import React from 'react';\n\nimport './$componentName.scss';\n\nconst
$componentName$tsType = () => {\n\treturn <div />;\n};\n\nexport default $componentName;"
indexTemplate=$"import $componentName from './$componentName';\n\nexport default $componentName;"
testTemplate=$"import React from 'react';\nimport ReactDOM from 'react-dom'\nimport $componentName from './$componentName'
\n\nit('renders without crashes', () => {\n  const div = document.createElement('div');
\n  ReactDOM.render(<$componentName />, div);\n  ReactDOM.unmountComponentAtNode(div);\n});"

if [ ! -z "$path" ]; then
  cd $path
fi

if [ -z "$componentName" ]; then
  echo -e "$ERROR: Missed component name!"
elif [ -e $componentName ]; then
  echo -e "$ERROR: '$componentName' component already exists! Choose another name"
else
  echo "Create component $componentName"
  mkdir $componentName
  cd $componentName
  echo "Created files in $path/$componentName:"
  echo -e $indexTemplate >> index.$extension
  echo -e ${inFolder}index.$extension
  echo -e $ComponentTemplate >> $componentName.${extension}x
  echo -e ${inFolder}$componentName.${extension}x
  echo >> $componentName.scss
  echo -e ${inFolder}$componentName.scss
  if [ $testFlag = 'true' ]; then
    echo -e $testTemplate >> $componentName.test.js
    echo -e ${inFolder}$componentName.test.js
  fi
  echo -e "\x1B[32mDone\x1B[0m"
fi