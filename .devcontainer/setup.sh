#!/bin/bash

echo "🚀 Setting up development environment..."

# Update package lists
sudo apt-get update

# Install PostgreSQL
echo "📦 Installing PostgreSQL..."
sudo apt-get install -y postgresql postgresql-contrib

# Start PostgreSQL service
sudo service postgresql start

# Configure PostgreSQL
echo "🔧 Configuring PostgreSQL..."
sudo -u postgres psql -c "ALTER USER postgres PASSWORD '1234';"
sudo -u postgres createdb medusa_test

# Install Bun
echo "📦 Installing Bun..."
curl -fsSL https://bun.sh/install | bash

# Add Bun to PATH for all users
echo 'export BUN_INSTALL="$HOME/.bun"' >> ~/.bashrc
echo 'export PATH="$BUN_INSTALL/bin:$PATH"' >> ~/.bashrc

# Source bashrc to make bun available immediately
source ~/.bashrc

# Install pnpm (if not already installed)
echo "📦 Installing pnpm..."
npm install -g pnpm

# Make PostgreSQL start automatically
echo "🔄 Configuring PostgreSQL to start automatically..."
echo "sudo service postgresql start" >> ~/.bashrc

echo "✅ Development environment setup complete!"
echo "📋 PostgreSQL Configuration:"
echo "   - Host: localhost"
echo "   - Port: 5432"
echo "   - Username: postgres"
echo "   - Password: 1234"
echo "   - Test Database: medusa_test"
