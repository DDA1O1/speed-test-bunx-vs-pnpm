#!/bin/bash

echo "🚀 Setting up development environment..."

# Update package lists
apt-get update

# Install PostgreSQL
echo "📦 Installing PostgreSQL..."
apt-get install -y postgresql postgresql-contrib

# Start PostgreSQL service
service postgresql start

# Configure PostgreSQL
echo "🔧 Configuring PostgreSQL..."
su - postgres -c "psql -c \"ALTER USER postgres PASSWORD '1234';\""
su - postgres -c "createdb medusa_test"

# Install Bun
echo "📦 Installing Bun..."
curl -fsSL https://bun.sh/install | bash

# Add Bun to PATH for all users
echo 'export BUN_INSTALL="/root/.bun"' >> /root/.bashrc
echo 'export PATH="$BUN_INSTALL/bin:$PATH"' >> /root/.bashrc

# Source bashrc to make bun available immediately
source /root/.bashrc

# Install pnpm (if not already installed)
echo "📦 Installing pnpm..."
npm install -g pnpm

# Make PostgreSQL start automatically
echo "🔄 Configuring PostgreSQL to start automatically..."
echo "service postgresql start" >> /root/.bashrc

# Create a startup script for PostgreSQL
cat > /usr/local/bin/start-postgres.sh << 'EOF'
#!/bin/bash
service postgresql start
EOF

chmod +x /usr/local/bin/start-postgres.sh

echo "✅ Development environment setup complete!"
echo "📋 PostgreSQL Configuration:"
echo "   - Host: localhost"
echo "   - Port: 5432"
echo "   - Username: postgres"
echo "   - Password: 1234"
echo "   - Test Database: medusa_test"
