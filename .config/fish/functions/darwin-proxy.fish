function darwin-proxy --description 'Set Wi-Fi proxy to localhost'
    argparse 's/socks' -- $argv
    or return

    set -l port $argv[1]
    if test -z "$port"
        set port 9090
    end

    if not string match -qr '^\d+$' -- $port
        echo "Error: $port is not a valid port number" >&2
        return 1
    end

    if test $port -lt 1024 -o $port -gt 65535
        echo "Error: $port is not a valid port number" >&2
        return 1
    end

    echo "Set Wi-Fi proxy to localhost:$port"

    networksetup -setwebproxystate "Wi-Fi" on
    networksetup -setwebproxy "Wi-Fi" "localhost" $port
    networksetup -setsecurewebproxystate "Wi-Fi" on
    networksetup -setsecurewebproxy "Wi-Fi" "localhost" $port

    if set -q _flag_socks
        networksetup -setsocksfirewallproxystate "Wi-Fi" on
        networksetup -setsocksfirewallproxy "Wi-Fi" "localhost" $port
    end
end
