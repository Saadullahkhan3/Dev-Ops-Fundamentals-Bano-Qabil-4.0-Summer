#!/bin/bash

# WANT THIS OUTPUT!!!!!!

# ===== LOG FILE ANALYSIS REPORT =====
# File: /var/log/application.log
# Analyzed on: Fri Jul 12 14:32:15 EDT 2025
# Size: 15.4MB (16,128,547 bytes)

# MESSAGE COUNTS:
# ERROR: 328 messages
# WARNING: log_file,253 messages
# INFO: 8,792 messages

# TOP 5 ERROR MESSAGES:
# 182 - Database connection failed: timeout
# 56 - Invalid authentication token provided
# 43 - Failed to write to disk: Permission denied
# 29 - API rate limit exceeded
# 18 - Uncaught exception: Null pointer reference

# ERROR TIMELINE:
# First error: [2025-07-10 02:14:32] Database connection failed: timeout
# Last error:  [2025-07-12 14:03:27] Failed to write to disk: Permission denied

# Error frequency by hour:
# 00-04: ███████ (72)
# 04-08: ██ (23)
# 08-12: ████████████ (120)
# 12-16: ██████ (63)
# 16-20: ███ (34)
# 20-24: ████ (16)

# Report saved to: log_analysis_20250712_143215.txt



# log_file = $1 # When path given by CLI as arg
log_file="demo_logs/application.log"

report_file="log_analysis_$(date +%Y%m%d).txt"


# >> Appened, to the file, at the end of old data
# > Write, remove old data, be caution!
echo -e "\n===== LOG FILE ANALYSIS REPORT =====" > $report_file
echo "File: $log_file" >> $report_file
echo "Analyzed on: $( date )" >> $report_file
echo -e "Size: $( du -h $log_file | cut -f1 ) | $( stat -c %s $log_file ) bytes" >> $report_file


calculate_tag_count(){
    local tag=$1
    echo "$( grep -c $tag $log_file )"
}

total_errors="$(calculate_tag_count "error")"

echo -e "\nMESSAGE COUNTS:" >> $report_file
echo "ERROR: $total_erros messages" >> $report_file
echo "WARNING: $(calculate_tag_count "warn") messages" >> $report_file
echo "INFO: $(calculate_tag_count "info") messages" >> $report_file


echo -e "\nTOP 5 ERROR MESSAGES:" >> $report_file
# grep "info" $log_file | awk '{$1=$2=""; print $0}' | cut -d: -f1 | sort | uniq -c | sort -nr | head -n 5
# grep " " $log_file | awk '{$1=$2=""; print $0}' | cut -d: -f1 | sort | uniq -c | sort -nr | head -n 5
echo "$( grep " " $log_file | awk '{$1=$2=""; print $0}' | cut -d: -f1 | sort | uniq -c | sort -nr | head -n 5 )" >> $report_file


echo -e "\nERROR TIMELINE" >> $report_file
echo "First error: $(cat $log_file | head -n 1 )" >> $report_file
echo "Last error: $(cat $log_file | tail -n 1 )" >> $report_file


# This gives every hour frequency
# grep "error" $log_file | awk -F: '{$1=""; print $2}' | sort -r | uniq -c | sort -r

# Show the logs every hour frequency, sort -r if want highest frequency rather than sorted by hour
# grep "error" $log_file | awk '{print $2}' | awk -F: '{print $1}' | sort | uniq -c

echo -e "\nError frequency by hour:" >> $report_file
hour_error_frequency="$( grep "error" $log_file | awk '{print $2}' | awk -F: '{print $1}' | sort | uniq -c )" >> $report_file


# TODO: Create a Bar chart, koi Mahan Insaan hi banae ga, lagta hai mujhe hi bana na pare ga, me Saadullah Khan Son/of Muhammad Ali Shahzad!
char="█"
# Expected Chart
# 00-04: ███████ (72)
# 04-08: ██ (23)
# 08-12: ████████████ (120)
# 12-16: ██████ (63)
# 16-20: ███ (34)
# 20-24: ████ (16)

frequency=0
index=0
for i in $hour_error_frequency; do
    # Frequency
    if [ $index -eq 0 ]; then
        ((index++))
        frequency=$i
    else
        ((index--))

        # Shell doesn't directly supported floating numbers or I may say, 
        # floating arthimetic operations, `bc` is a magic that solved it.
        # It isn't available by default everywhere
        percentage="$( bc <<< "$(bc -l <<< "$frequency/$total_errors") * 100")"
        echo "$i hour: Frequency -> ($frequency) | Percentage -> $percentage % errors" >> $report_file
    fi
done


echo -e "\nReport saved to: $report_file" >> $report_file

# Puri raat laggai, aj class bhi hai, raat se jag raha hon, 8:40 AM ho gae hai, nahi soya
# 2 PM per class bhi hai, aur net bhi chala gaya k upload hi karlon :):