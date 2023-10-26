#!/usr/bin/env bash
set -e

ENV=production
OUTPUT_TARGET=firefox
OUTPUT_FOLDER="./build/$OUTPUT_TARGET/$ENV"
OUTPUT_FILE="$OUTPUT_TARGET.xpi"

rm -f "./$OUTPUT_FILE"

yarn
yarn test-ci
NODE_ENV=production yarn "build-$OUTPUT_TARGET"
cd "$OUTPUT_FOLDER"
zip -r "../../../$OUTPUT_FILE" ./*
cd -

#VERSION=$(jq -r .version < "$OUTPUT_FOLDER/manifest.json")
#zip -r firefox_source_$VERSION.zip src utils ./.babelrc package.json README.md webpack.config.js yarn.lock

echo ""
echo "Upload: https://addons.mozilla.org/en-US/developers/addons"
