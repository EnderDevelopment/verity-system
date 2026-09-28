# Verity System

A FiveM script for managing player verity status with cooldown and cost.

## Features

- Set verity status with a cost and cooldown
- Check verity status

## Requirements

- FiveM server
- ESX framework
- MySQL database

## Installation

1. Download the script files.
2. Place them in your FiveM server's resources folder.
3. Import the `database.sql` file into your MySQL database.
4. Add `start verity_system` to your server.cfg file.

## Usage

### Commands

- `/verity` - Opens the verity menu

### Permissions

- Players need to have enough money to set verity status.

## Configuration

- `Config.VerityPrice` - The cost to set verity status (default: 5000)
- `Config.VerityCooldown` - The cooldown in seconds (default: 3600)
- `Config.DatabaseName` - The name of the database (default: verity_system)
- `Config.DatabaseTable` - The name of the table (default: verity_data)

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=verity-system&utm_content=bottom) — describe it in one sentence and get the full source code.