function darwin-unproxy --description 'Unset Wi-Fi proxy'
    echo "Unset Wi-Fi proxy"
    networksetup -setwebproxystate "Wi-Fi" off
    networksetup -setsecurewebproxystate "Wi-Fi" off
    networksetup -setsocksfirewallproxystate "Wi-Fi" off
end
