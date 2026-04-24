#!/bin/bash
set -euo pipefail

SCRIPT_PATH="${BASH_SOURCE[0]:-$0}"
TEST_DIR="${TEST_DIR:-$(cd "$(dirname "$SCRIPT_PATH")" && pwd)}"
APP_FILE="${APP_DIR:-/app}/index.html"

export PLAYWRIGHT_BROWSERS_PATH="${PLAYWRIGHT_BROWSERS_PATH:-/ms-playwright}"

mkdir -p /logs/verifier

TEST_EXIT=0

# Check if we're in a valid working directory
if [ "$PWD" = "/" ]; then
  echo "Error: No working directory set." >&2
  TEST_EXIT=1
fi

if [ ! -f "$APP_FILE" ]; then
  echo "Error: $APP_FILE not found." >&2
  TEST_EXIT=1
else
  # Quick shell-level contract checks so the verifier is not just "file exists".
  grep -q "Misty Ridge Loop" "$APP_FILE" || TEST_EXIT=1
  grep -q "/trails/misty-ridge-loop" "$APP_FILE" || TEST_EXIT=1
  grep -q "North Cascades" "$APP_FILE" || TEST_EXIT=1
  grep -q "Best after early morning fog lifts" "$APP_FILE" || TEST_EXIT=1
  grep -q "images/trail-card.jpg" "$APP_FILE" || TEST_EXIT=1
  grep -q "text-overflow: ellipsis" "$APP_FILE" || TEST_EXIT=1
  grep -q "white-space: nowrap" "$APP_FILE" || TEST_EXIT=1
  grep -q "linear-gradient" "$APP_FILE" || TEST_EXIT=1
  grep -q 'role="meter"' "$APP_FILE" || TEST_EXIT=1

  cd "$TEST_DIR" || TEST_EXIT=1

  echo "Installing verifier dependencies..."
  npm install --no-fund --no-audit || TEST_EXIT=$?
fi

set +e
if [ "$TEST_EXIT" -eq 0 ]; then
  npm run test:unit && npm run test:e2e
else
  false
fi

if [ $? -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
