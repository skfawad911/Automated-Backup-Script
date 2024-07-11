# Automated Backup Script

## Overview

This script automates the process of backing up a specified directory to a given backup directory. It compresses the backup into a ZIP file, retains the latest five backups, and performs log rotation to manage disk space efficiently.

## Features

- **Automated Backups**: Backs up a specified directory to a designated backup directory.
- **Timestamped Backups**: Each backup is timestamped for easy identification.
- **Log Rotation**: Automatically deletes older backups, keeping only the latest five backups.
- **Logging**: Records the backup process and log rotation activities to a log file.
- **Error Handling**: Checks for valid source and destination directories and handles errors gracefully.
- **Notification**: Provides success and failure messages for better monitoring.

## Usage

### Script Usage

To use the script, run the following command:

```bash
./backup.sh <source_path> <backupdir_path>
```
- <source_path>: The directory you want to back up.
- <backupdir_path>: The directory where you want to store the backups.

### Example

```
./backup.sh /home/user/data /home/user/backups
```

## Crontab Setup

To automate the backup process, add the script to your crontab for daily execution. Open your crontab file by running crontab -e and add the following line:
```
0 6 * * * /path/to/backup.sh /path/to/source /path/to/backupdir
```
This configuration will run the backup script every day at 6:00 AM.

## Script Details

## Functions

- check_command: Ensures the script is run with the correct number of arguments.
- log: Records messages to a log file located at /var/log/backup.log.
- take_backup: Compresses the source directory into a ZIP file in the destination directory.
- back_rotation: Deletes older backups, retaining only the latest five backups.
