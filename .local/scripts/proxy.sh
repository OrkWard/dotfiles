proxy_host=${1:-'localhost:9090'}
echo "Set proxy to http://$proxy_host."
export https_proxy=http://$proxy_host;export http_proxy=http://$proxy_host;export all_proxy=http://$proxy_host
