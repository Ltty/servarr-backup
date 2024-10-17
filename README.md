# servarr-backup
Backs up radarr, sonarr, lidarr, prowlarr and bazarr and syncs them to a cloud storage provider every 24 hours.

## Setup
1. Clone the repository to `/opt/`
2. [Install rclone](https://rclone.org/install/), a command line tool to manage files on cloud storage
3. [Conigure rclone](https://rclone.org/docs/) to sync backup files with your cloud storage provider of choice
4. Run `sudo crontab -e` and add one of the following options to create a cronjob that runs the backup once a day and pipes log output to a log file

   Backup all services
   ```
   0 0 * * * /opt/servarr-backup/sync.sh -a >> /var/log/servarr-backup.log  2>&1
   ```
5. Run the following command to give all users execution rights to the script.
    ```
    sudo chmod +x /opt/servarr-backup/sync.sh
    ```

## Resources
- servarr docs: https://wiki.servarr.com/
