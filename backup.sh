#!/bin/bash
######################################################
##
## Author: Fawad
## Date: 09-07-2024
## Work: Automating Backup Task
## Usage: ./backup.sh <source_path> <backupdir_path>
##
######################################################

LOG_FILE="/home/champ/testscripts/backup.log"

function log {
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

function check_command {
        log "Incorrect usage"
        echo "To Run the file properly use this command ./backup.sh <source_path> <backupdir_path>"
        exit 1
}

if [ $# -ne 2 ]; then
        check_command
fi

source=$1
destination=$2
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')

if [ ! -d "$source" ]; then
        log "Source path $source does not exist or is not a directory."
        echo "Source path $source does not exist or is not a directory."
        exit 1
fi

if [ ! -d "$destination" ]; then
        log "Backup destination path $destination does not exist or is not a directory."
        echo "Backup destination path $destination does not exist or is not a directory."
        exit 1
fi

function take_backup {
        zip -r $destination/backup_$timestamp.zip $source >> /dev/null
        if [ $? -eq 0 ]; then
                log "Backup generated successfully of ${source} on ${timestamp}"
                echo "Backup Generated Successfully of ${source} on ${timestamp}"
        else
                log "Backup failed for ${source} on ${timestamp}"
                echo "Backup Failed for ${source} on ${timestamp}"
                exit 1
        fi
}

function back_rotation {
        backups=($(ls -t "${destination}/backup_"*.zip 2>/dev/null))

        if [ "${#backups[@]}" -gt 5 ]; then
                log "Performing log rotation"

                file_to_remove=("${backups[@]:5}")

                for backup in "${file_to_remove[@]}"; do
                        rm -rf $backup
                        log "Removed old backup: $backup"
                done
        fi
}

take_backup
back_rotation

log "Backup script executed successfully"
