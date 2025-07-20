# **Log Analyzer Script - README**  
*A simple Bash script to analyze log files and generate reports.*

---

## **📌 Overview**
This script analyzes log files (in the format `[timestamp] message (level)`) and generates a report containing:
- Message counts (ERROR, WARNING, INFO)
- Top 5 error messages  
- First & last error timestamps  
- Error frequency by hour  

---

## **🛠️ Requirements**
- **Bash** (Linux/macOS/WSL)  
- **Basic Unix tools**: `grep`, `awk`, `sort`, `uniq`, `cut`, `stat`, `du`  
- **`bc`** (for percentage calculations - install via `sudo apt install bc` if missing)  

---

## **📂 File Structure**
```
log_analyzer.sh      # Main script
demo_logs/           # Sample log directory
   └── application.log  # Example log file

# Script will Generated this
analyzed_log/           
   └── log_analysis_XXXXXXXX.txt
   └──...
```

---

## **🚀 How to Run**
1. **Make the script executable**:
   ```bash
   chmod +x log_analyzer.sh
   ```
2. **Run it**:

    **Note:** Script should have access to:
    1. Execute itself.
    2. Read the logs 
    3. Create the folder and file - For analyzed logs

   ```bash
   ./log_analyzer.sh
   ```
   - By default, it analyzes `demo_logs/application.log`.  
   - To analyze a custom log file, change `log_file` variable to your desired path
     ```bash
     ./log_analyzer.sh /path/to/your/logfile.log
     ```

---

## **📊 Report Output**
The script generates a report file named `log_analysis_YYYYMMDD.txt` with:
1. **Basic Info**  
   - Log file path  
   - Analysis timestamp  
   - File size  

2. **Message Counts**  
   - Total `ERROR`, `WARNING`, `INFO` messages  

3. **Top 5 Errors**  
   - Most frequent error messages  

4. **Error Timeline**  
   - First and last error timestamps  

5. **Hourly Error Frequency**  
   - Errors grouped by hour (with counts)  

---

## **🔧 Customization**
- **Change the default log path**:  
  Modify `log_file="demo_logs/application.log"` in the script.  
- **Adjust time ranges**:  
  Edit the hour/time bins in the `Error frequency by hour` section.  

---

## **⚠️ Notes**
- The script **overwrites** the report file on each run.  
- Ensure log format matches:  
  ```log
  [YYYY-MM-DD HH:MM:SS] Message (error/warning/info)
  ```


---

**🎉 Happy Log Analyzing! Go and Debug your errors ^-^**  
*— Saadullah Khan*