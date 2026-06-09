#!/bin/bash

# 1. DEFINE FUNCTIONS FIRST
timestamp() {
    date "+%Y-%m-%d %H:%M:%S"
}

check_root(){
    if [ $USERID -ne 0 ]; then
        echo -e "$R [$(timestamp)] Please run this script with root user access $N" | tee -a $LOGS_FILE
        exit 1
    fi
}

VALIDATE(){
    # Changed $time_stamp to $(timestamp) to dynamically grab the current time
    if [ $1 -ne 0 ]; then
        echo -e "[$(timestamp)] | $2 ... $R FAILURE $N" | tee -a $LOGS_FILE
        exit 1
    else
        echo -e "[$(timestamp)] | $2 ... $G SUCCESS $N" | tee -a $LOGS_FILE
    fi
}

print_total_time(){
    END_TIME="$(date +%s)"
    TOTAL_TIME="$(( $END_TIME - $START_TIME ))"
    echo -e "[$(timestamp)] | Total Execution Time: $TOTAL_TIME seconds" | tee -a $LOGS_FILE
}

# 2. VARIABLES & INITIALIZATION
USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-roboshop"
# Using basename ensures the log file is named "script.sh.log" instead of "./script.sh.log"
SCRIPT_NAME=$(basename "$0")
LOGS_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

mkdir -p $LOGS_FOLDER

START_TIME=$(date +%s)

# 3. ACTUAL SCRIPT EXECUTION
echo "Script start time at $(timestamp)" | tee -a $LOGS_FILE

# Run root check
check_root

# --- Your installations/tasks go here ---
# Example:
# dnf install nginx -y
# VALIDATE $? "Installing Nginx"
# ----------------------------------------

# Call this at the very end of your script to log the total time
