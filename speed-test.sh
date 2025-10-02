#!/bin/bash

# This script benchmarks the installation time of a Medusa store
# using bunx vs pnpm with realistic interactive prompts.

echo "🚀 Starting Medusa installation speed test..."
echo "This will create and then delete two Medusa projects using PostgreSQL."
echo "The script will automatically answer the prompts:"
echo "- Next.js Storefront: No (press Enter for default)"
echo "- PostgreSQL username: postgres (press Enter for default)"
echo "- PostgreSQL password: 1234"
echo "- PostgreSQL database name: postgres (press Enter for default)"
echo ""

# Start PostgreSQL service (in case it's not running)
echo "🔧 Ensuring PostgreSQL is running..."
service postgresql start
echo ""

# Set up Bun environment variables
export BUN_INSTALL="/root/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Check if bun is available
if ! command -v bun &> /dev/null
then
    echo "❌ Bun not found. Please make sure the dev container setup completed successfully."
    exit 1
fi

echo "✅ Bun is available."
echo "✅ PostgreSQL is configured with postgres:1234@localhost:5432"
echo ""

# Install expect if not available
if ! command -v expect &> /dev/null; then
    echo "📦 Installing expect for interactive automation..."
    apt-get update && apt-get install -y expect
fi

# --- Test for bunx ---
echo "----------------------------------------"
echo "🧪 Testing with bunx..."
echo "----------------------------------------"

# Create expect script for bunx
cat > /tmp/bunx-test.exp << 'EOF'
#!/usr/bin/expect -f
set timeout 300
spawn bunx create-medusa-app@latest bun-medusa-store
expect "Would you like to install the Next.js Starter Storefront?" { send "\r" }
expect "Enter your Postgres username" { send "\r" }
expect "Enter your Postgres password" { send "1234\r" }
expect "Enter your Postgres user's database name" { send "\r" }
expect eof
EOF

chmod +x /tmp/bunx-test.exp

# Time the bunx command
time /tmp/bunx-test.exp

echo "🧹 Cleaning up bunx installation..."
rm -rf bun-medusa-store
# Clean up any database that might have been created
su - postgres -c "dropdb medusa-bun-medusa-store" 2>/dev/null || true
echo "🗑️  Bun project and database deleted."
echo ""

# --- Test for pnpm ---
echo "----------------------------------------"
echo "🧪 Testing with pnpm..."
echo "----------------------------------------"

# Create expect script for pnpm
cat > /tmp/pnpm-test.exp << 'EOF'
#!/usr/bin/expect -f
set timeout 300
spawn pnpm create create-medusa-app@latest pnpm-medusa-store
expect "Would you like to install the Next.js Starter Storefront?" { send "\r" }
expect "Enter your Postgres username" { send "\r" }
expect "Enter your Postgres password" { send "1234\r" }
expect "Enter your Postgres user's database name" { send "\r" }
expect eof
EOF

chmod +x /tmp/pnpm-test.exp

# Time the pnpm command
time /tmp/pnpm-test.exp

echo "🧹 Cleaning up pnpm installation..."
rm -rf pnpm-medusa-store
# Clean up any database that might have been created
su - postgres -c "dropdb medusa-pnpm-medusa-store" 2>/dev/null || true
echo "🗑️  pnpm project and database deleted."
echo ""

# Clean up expect scripts
rm -f /tmp/bunx-test.exp /tmp/pnpm-test.exp

echo "----------------------------------------"
echo "🏁 Speed test complete!"
echo "----------------------------------------"
echo ""
echo "📊 Compare the 'real' time values above to see which package manager is faster."
echo "The 'real' time represents the actual wall-clock time taken for each installation."
