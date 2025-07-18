#!/bin/sh
TEST_DIR=$(pwd)
SKIPS_FILE="$TEST_DIR/skips.txt"
find "$TEST_DIR/src" -name "*.typ" -type f | while read -r file; do
  FILE_NAME=$(basename "$file")
  if grep -Fxq "$FILE_NAME" "$SKIPS_FILE"; then
    echo "Skipping $file"
    continue
  fi
  echo "Compiling $file"
  typst compile --root `dirname $TEST_DIR` --format png "$file" "$TEST_DIR/ref/$(basename "$FILE_NAME" .typ).png"
done