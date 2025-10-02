#!/bin/bash

# This script benchmarks the installation time of a Medusa store
# using bunx vs pnpm. It uses the pre-configured PostgreSQL database
# with credentials postgres:1234.

echo "🚀 Starting Medusa installation speed test..."
echo "This will create and then delete two Medusa projects using PostgreSQL."
echo ""

# Start PostgreSQL service (in case it's not running)
echo "🔧 Ensuring PostgreSQL is running..."
sudo service postgresql start
echo ""

# Check if bun is available
if ! command -v bun &> /dev/null
then
    echo "❌ Bun not found. Please make sure the dev container setup completed successfully."
    exit 1
fi

echo "✅ Bun is available."
echo "✅ PostgreSQL is configured with postgres:1234@localhost:5432"
echo ""

# --- Test for bunx ---
echo "----------------------------------------"
echo "🧪 Testing with bunx..."
echo "----------------------------------------"

# Create a unique database for the bun test
sudo -u postgres createdb bun_medusa_test 2>/dev/null || true

# Time the create-medusa-app command with bunx, using PostgreSQL
time (bunx create-medusa-app@latest bun-medusa-store \
  --db-url "postgres://postgres:1234@localhost:5432/bun_medusa_test" \
  --no-boilerplate \
  --skip-db)

echo "🧹 Cleaning up bunx installation..."
rm -rf bun-medusa-store
sudo -u postgres dropdb bun_medusa_test 2>/dev/null || true
echo "🗑️  Bun project and database deleted."
echo ""

# --- Test for pnpm ---
echo "----------------------------------------"
echo "🧪 Testing with pnpm..."
echo "----------------------------------------"

# Create a unique database for the pnpm test
sudo -u postgres createdb pnpm_medusa_test 2>/dev/null || true

# Time the create-medusa-app command with pnpm, using PostgreSQL
time (pnpm create create-medusa-app@latest pnpm-medusa-store \
  --db-url "postgres://postgres:1234@localhost:5432/pnpm_medusa_test" \
  --no-boilerplate \
  --skip-db)

echo "🧹 Cleaning up pnpm installation..."
rm -rf pnpm-medusa-store
sudo -u postgres dropdb pnpm_medusa_test 2>/dev/null || true
echo "🗑️  pnpm project and database deleted."
echo ""

echo "----------------------------------------"
echo "🏁 Speed test complete!"
echo "----------------------------------------"
echo ""
echo "📊 Compare the 'real' time values above to see which package manager is faster."
echo "The 'real' time represents the actual wall-clock time taken for each installation."
