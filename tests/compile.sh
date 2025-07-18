#!/bin/sh
TEST_DIR=$(pwd)
for file in `ls src/*.typ`; do
  echo "Compiling $file"
  typst compile --root `dirname $TEST_DIR` --format png "$TEST_DIR/$file" "$TEST_DIR/ref/$(basename "$file" .typ).png"
done