proxy_host=${1:-'127.0.0.1:7890'}
echo "Set proxy to $proxy_host."
export https_proxy=http://$proxy_host;export http_proxy=http://$proxy_host;export all_proxy=socks5://$proxy_host
