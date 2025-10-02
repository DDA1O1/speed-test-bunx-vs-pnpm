# Medusa Installation Speed Test: bunx vs. pnpm

This repository contains a simple shell script to benchmark the installation time of a new Medusa store using `bunx` versus `pnpm create`.

The test is designed to be run in a clean environment like a GitHub Codespace to ensure consistent results.

## How to Run the Test

You can easily run this benchmark yourself in a GitHub Codespace.

1.  **Open in Codespace**: Click the "Code" button on this repository's GitHub page, go to the "Codespaces" tab, and click "Create codespace on main". This will launch a new, clean development environment in your browser.

2.  **Make the script executable**: Once the Codespace is loaded and the terminal is available, run the following command to give the script permission to execute:
    ```bash
    chmod +x speed-test.sh
    ```

3.  **Run the test**: Now, you can execute the script:
    ```bash
    ./speed-test.sh
    ```

## What the Script Does

The script will:
1.  Start a timer and use `bunx create-medusa-app@latest` to scaffold a new Medusa project named `my-medusa-store-bun`. It automatically accepts the default prompts (SQLite database, no demo data).
2.  Stop the timer and display the time taken for the `bunx` installation.
3.  Delete the `my-medusa-store-bun` directory.
4.  Start a new timer and use `pnpm create create-medusa-app@latest` to scaffold a project named `my-medusa-store-pnpm`.
5.  Stop the timer and display the time taken for the `pnpm` installation.
6.  Delete the `my-medusa-store-pnpm` directory.

At the end, you will see the `real`, `user`, and `sys` time outputs for both package managers, allowing you to compare their performance directly. The `real` time is the most relevant metric for this comparison.