# create-react-component

This script is used for creation a component folder
with default import and export and as default style file ${name}.scss
## Usage: 
  1. add in your package.json
  ```javascript
    "scripts": {
      "crcomp": "bash createComponent.sh" 
    }
  ```
    you can use any script name what you want, it's just example
  2. after that print in your console: npm run crcomp
  3. Also you can just print command: bash ./createComponent.sh
  4. If you won't put this script in your project folder you can put it in the folder above and call:
  
    bash ../createComponent.sh