#!/usr/bin/bash


#variables
#Getting the current data
CURRENT_DATA=$(date +%d%m%Y)

#Create the currect name of the report with present data
REPORT_NAME=backup_report_${CURRENT_DATA}.txt

#Variable with correct name of tar.gz file containing correct data
BACKUP_WITH_DATA=backup_${CURRENT_DATA}.tar.gz

#Getting storage directory
STORAGE_BACKUP_DIR=/tmp/

#Getting target directory
TARGET_FILE_DIR=/var/log/

# Function to with test to check if target file exist and storage directory exist if yes backup and report will be create
function create_report_and_pack_the_files() {
    TOTAL_PACKED_FILES=0
    if [[ -s "$TARGET_FILE_DIR" ]] && [[ -d "$STORAGE_BACKUP_DIR" ]]
    then
        find ${TARGET_FILE_DIR}*.gz > $STORAGE_BACKUP_DIR/$REPORT_NAME
        tar -cvf $STORAGE_BACKUP_DIR/$BACKUP_WITH_DATA ${TARGET_FILE_DIR}*.gz
    else
        echo "Target files or home directory dosn't exist"
    fi
}

# Function to run buckup in while loop if backup will be created succesfully then counter will be increment to 11 to break while loop, function fill be loop 10 if something break backup process
function run_backup_script() {
    COUNTER=0
    while [ $COUNTER -le 10 ]
    do
        create_report_and_pack_the_files
        if [[ -e $STORAGE_BACKUP_DIR/$BACKUP_WITH_DATA ]]
        then
            COUNTER=11
            echo "***********************************************************************************"
            echo "Backup has been done sucesfully with report ${REPORT_NAME} and file ${BACKUP_WITH_DATA}"
        
        else
            ((COUNTER++))
        fi
    done
}


run_backup_script



<<Block_comment
===========>  Restore procedure  <===========
1 Download the file backup_data.tar.gz e.g. backup_24082021.tar.gz along with the report backup_report_data.txt e.g. backup_raport_24082021.txt

2 Using the tar -xvf command, extract the file backup_data.tar.gz to any location you specify. 
e.g. tar -xvf backup_24082021.tar.gz

3 Log in to your admin / root account and move the extracted files using the mv command according to the paths specified in the file backup_report_data.txt
Block_comment