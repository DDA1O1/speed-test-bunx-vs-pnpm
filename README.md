# Medusa Installation Speed Test: bunx vs. pnpm

This repository contains a benchmarking setup to compare the installation speed of a new Medusa store using `bunx` versus `pnpm create`.

The test runs in a preconfigured dev container environment with Bun and PostgreSQL already installed and configured, ensuring consistent and reliable results.

## Quick Start

1. **Open in GitHub Codespace**: 
   - Click the "Code" button on this repository's GitHub page
   - Go to the "Codespaces" tab 
   - Click "Create codespace on main"
   - Wait for the dev container to build (this may take a few minutes on first run)

2. **Run the speed test**:
   ```bash
   chmod +x speed-test.sh
   ./speed-test.sh
   ```

That's it! The dev container automatically sets up everything you need.

## What's Pre-configured

The dev container includes:
- **Node.js 18** - Base JavaScript runtime
- **Bun** - Fast JavaScript runtime and package manager
- **pnpm** - Efficient Node.js package manager
- **PostgreSQL** - Database server with default configuration:
  - Host: `localhost`
  - Port: `5432` 
  - Username: `postgres`
  - Password: `1234`
  - Test databases: `bun_medusa_test` and `pnpm_medusa_test` (created/deleted automatically)

## How the Test Works

The `speed-test.sh` script performs the following steps:

1. **Environment Check**: Verifies that Bun and PostgreSQL are available and running
2. **Bun Test**: 
   - Creates a PostgreSQL database named `bun_medusa_test`
   - Times the execution of `bunx create-medusa-app@latest bun-medusa-store`
   - Uses PostgreSQL as the database backend
   - Cleans up the project directory and database
3. **pnpm Test**:
   - Creates a PostgreSQL database named `pnpm_medusa_test` 
   - Times the execution of `pnpm create create-medusa-app@latest pnpm-medusa-store`
   - Uses PostgreSQL as the database backend
   - Cleans up the project directory and database
4. **Results**: Displays timing information for both package managers

## Understanding the Results

The test outputs three timing metrics for each package manager:
- **real** - The actual wall-clock time (most important for comparison)
- **user** - CPU time spent in user mode
- **sys** - CPU time spent in system/kernel mode

Focus on the **real** time to determine which package manager is faster for creating Medusa applications.

## Dev Container Details

The development environment is defined in `.devcontainer/`:
- `devcontainer.json` - Container configuration and VS Code settings
- `setup.sh` - Initialization script that installs Bun and configures PostgreSQL

This ensures that every test runs in an identical, clean environment regardless of your local setup.