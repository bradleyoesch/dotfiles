# USAGE
# ./scripts/npm-init.sh <path> <readme title> <description>

# mkdir and cd into new directory
mkdir $1
cd $1

# basic set up
git init
npx license MIT
npx gitignore node
npx covgen bradley.oesch@gmail.com
npm init -y
node -v > .nvmrc

# create README
cat > README.md <<- EOF
# $2

$3

## Running locally

\`\`\`bash
nvm use
npm i
npm run main
\`\`\`

EOF

# make directories
mkdir src
mkdir resources

# make basic main file
echo "console.log('Success!');" > src/main.js

# update package.json and install
json -I -f package.json -e "this.main=\"src/main.js\""
json -I -f package.json -e "this.description=\"$3\""
npx npm-add-script -k "main" -v "node src/main.js"
npx sort-package-json
npx sort-npm-scripts
npm i
