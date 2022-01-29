# USAGE
# ./scripts/npm-init.sh <path> <readme title> <description>

path=$1
description=$2
name="$(basename $path)"


# mkdir and cd into new directory
mkdir $path
cd $path

# basic set up
git init
npx license MIT
npx gitignore node
npx covgen bradley.oesch@gmail.com
npm init -y
node -v > .nvmrc

# update package.json
json -I -f package.json -e "this.description=\"$3\""
json -I -f package.json -e "this.type=\"module\""

# create README
cat > README.md <<- EOF
# $name

$description

## Running locally

Project is set up with the following features:
- babel, es6
- eslint
- prettier
- linting pre-commit hook
- jest testing

\`\`\`bash
nvm use
npm i
npm run main
\`\`\`

## Running tests locally

\`\`\`bash
npm run test
\`\`\`

EOF


# make directories
mkdir src
mkdir resources

# make basic main file, test
json -I -f package.json -e "this.main=\"src/main.js\""
npm set-script main "node src/main.js"
cat > src/main.js <<- EOF
export const foo = () => {
    return 'Success!';
}
console.log(foo());

EOF
cat > src/main.spec.js <<- EOF
import { foo } from './main.js';

describe('main', () => {
    it('succeeds a test', () => {
        expect(foo()).toBe('Success!');
    });
});

EOF

# install dev dependencies
dev_dependencies="
@babel/cli
@babel/core
@babel/preset-env
eslint
eslint-config-google
eslint-config-prettier
eslint-plugin-prettier
husky
jest
lint-staged
prettier
"
dev_dependencies="$dev_dependencies" | tr '\n' ' '
npm i --save-dev $dev_dependencies

# set up babel config
cat > .babelrc <<- EOF
{
  "presets": [
    "@babel/preset-env"
  ]
}

EOF

# set up prettier, linting, pre-commit
npm install --save-dev husky lint-staged
npx husky install
npm set-script prepare "husky install"
npx husky add .husky/pre-commit "npx lint-staged"
cat > .prettierrc.json <<- EOF
{
    "tabWidth": 4,
    "singleQuote": true
}

EOF
cat > .eslintrc.cjs <<- EOF
module.exports = {
  'env': {
    'browser': true,
    'es2021': true,
  },
  'extends': [
    'google',
    'prettier',
    'plugin:prettier/recommended'
  ],
  'parserOptions': {
    'ecmaVersion': 'latest',
    'sourceType': 'module',
  },
  'plugins': [
    'prettier'
  ],
};

EOF
npm set-script lint "npx eslint --max-warnings=0 --ext .tsx,.ts,.js,.jsx src/ --fix"
json -I -f package.json -e "this[\"lint-staged\"]={\"src/**/*\": \"npm run lint\"}"
echo "
# hack to sort and add changes to package.json
# does mean that it's committed on each commit though
npx sort-package-json
npx sort-npm-scripts
git add package.json
" >> .husky/pre-commit

# jest
npx jest --init

# update package.json
npx sort-package-json
npx sort-npm-scripts
