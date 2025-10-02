#!/bin/bash

# This script benchmarks the installation time of a Medusa store
# using bunx vs pnpm. It automates the process by accepting the
# default prompts from create-medusa-app.echo "🚀 Starting Medusa installation speed test..."
echo "This will create and then delete two Medusa projects."
echo "The script will automatically accept the default prompts (SQLite database, no seed data)."
echo ""

# --- Test for bunx ---
echo "----------------------------------------"
echo "🧪 Testing with bunx..."
echo "----------------------------------------"

# Time the create-medusa-app command with bunx.
# The `echo -e '\n\n'` pipes two 'Enter' presses to the command,
# accepting the default database (SQLite) and declining seed data.
time (echo -e '\n\n' | bunx create-medusa-app@latest my-medusa-store-bun)

echo "🧹 Cleaning up bunx installation..."
rm -rf my-medusa-store-bun
echo "🗑️  Bun project deleted."
echo ""


# --- Test for pnpm ---
echo "----------------------------------------"
echo "🧪 Testing with pnpm..."
echo "----------------------------------------"

# Time the create-medusa-app command with pnpm.
time (echo -e '\n\n' | pnpm create create-medusa-app@latest my-medusa-store-pnpm)

echo "🧹 Cleaning up pnpm installation..."
rm -rf my-medusa-store-pnpm
echo "🗑️  pnpm project deleted."
echo ""


echo "----------------------------------------"
echo "🏁 Speed test complete!"
echo "----------------------------------------"
