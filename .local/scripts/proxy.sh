proxy_host=${1:-'localhost:7890'}
echo "Set proxy to $proxy_host."
export https_proxy=socks5://$proxy_host;export http_proxy=socks5://$proxy_host;export all_proxy=socks5://$proxy_host
