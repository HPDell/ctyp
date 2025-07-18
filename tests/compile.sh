#!/bin/sh
TEST_DIR=$(pwd)

skip_file="$TEST_DIR/skips.txt"
enable_skip=false
while [[ $# -gt 0 ]]; do
    case $1 in
        --skip)
            enable_skip=true
            shift
            ;;
        --skip-file)
            skip_file="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: ./compile.sh [options]"
            echo "Options:"
            echo "  --skip              Skip files listed in the file specified by --skip-file."
            echo "  --skip-file <FILE>  A file listing which tests are skipped (Default: skips.txt)"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

find "$TEST_DIR/src" -name "*.typ" -type f | while read -r file; do
  FILE_NAME=$(basename "$file")
  if [ "$enable_skip" = true ] && [ -f "$skip_file" ]; then
    if grep -Fxq "$FILE_NAME" "$skip_file"; then
      echo "Skipping $file"
      continue
    fi
  fi
  echo "Compiling $file"
  typst compile --root `dirname $TEST_DIR` --format png "$file" "$TEST_DIR/ref/$(basename "$FILE_NAME" .typ).png"
done