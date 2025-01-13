#!/bin/bash

while getopts aoip flag
do
    case "${flag}" in
        a) backupAll=true;;
        r) backupRadarr=true;;
        s) backupSonarr=true;;
	l) backupLidarr=true;;
	p) backupProwlarr=true;;
	b) backupBazarr=true;;
        n) backupNotifiarr=true;;
    esac
done

declare -A listOfDirs

rcloneConfig=/home/florian/.config/rclone/rclone.conf
rcloneOptions="-v --ignore-checksum --ignore-size --local-no-check-updated"

echo  $(date +"%Y-%m-%d %H:%M:%S") starting backup

if [[ $backupAll = true || $backupRadarr = true ]]; then
  echo  $(date +"%Y-%m-%d %H:%M:%S") setting radarr backup folder to ${listOfDirs[radarr]}
  listOfDirs[radarr]=/var/lib/radarr/Backups/scheduled
fi

if [[ $backupAll = true || $backupSonarr = true ]]; then
  echo  $(date +"%Y-%m-%d %H:%M:%S") setting sonarr backup folder to ${listOfDirs[sonarr]}
  listOfDirs[sonarr]=/var/lib/sonarr/Backups/scheduled
fi

if [[ $backupAll = true || $backupLidarr = true ]]; then
  echo  $(date +"%Y-%m-%d %H:%M:%S") setting lidarr backup folder to ${listOfDirs[lidarr]}
  listOfDirs[lidarr]=/var/lib/lidarr/Backups/scheduled
fi

if [[ $backupAll = true || $backupProwlarr = true ]]; then
  echo  $(date +"%Y-%m-%d %H:%M:%S") setting prowlarr backup folder to ${listOfDirs[prowlarr]}
  listOfDirs[prowlarr]=/var/lib/prowlarr/Backups/scheduled
fi

if [[ $backupAll = true || $backupBazarr = true ]]; then
  echo  $(date +"%Y-%m-%d %H:%M:%S") setting bazarr backup folder to ${listOfDirs[bazarr]}
  listOfDirs[bazarr]=/opt/docker/.config/bazarr/config/backup
fi

if [[ $backupAll = true || $backupNotifiarr = true ]]; then
  echo  $(date +"%Y-%m-%d %H:%M:%S") setting notifiarr backup folder to ${listOfDirs[notifiarr]}
  listOfDirs[notifiarr]=/opt/docker/.config/notifiarr/config/backup
fi

for dir in "${!listOfDirs[@]}"
do
   :
   echo  $(date +"%Y-%m-%d %H:%M:%S") backing up $dir - ${listOfDirs[$dir]}
   rclone $rcloneOptions --config=$rcloneConfig sync ${listOfDirs[$dir]} gdrive:/backups/$dir
done

echo  $(date +"%Y-%m-%d %H:%M:%S") backup completed
