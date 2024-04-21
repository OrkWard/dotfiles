<<<<<<< HEAD
alias setproxy='export https_proxy=http://127.0.0.1:7890;export http_proxy=http://127.0.0.1:7890;export all_proxy=socks5://127.0.0.1:7890'
alias unproxy='unset http_proxy https_proxy all_proxy'
export https_proxy=http://127.0.0.1:7890;export http_proxy=http://127.0.0.1:7890;export all_proxy=socks5://127.0.0.1:7890
||||||| 3f84fbe
echo $1

alias setproxy='export https_proxy=http://127.0.0.1:7890;export http_proxy=http://127.0.0.1:7890;export all_proxy=socks5://127.0.0.1:7890'
alias unproxy='unset http_proxy https_proxy all_proxy'
export https_proxy=http://127.0.0.1:7890;export http_proxy=http://127.0.0.1:7890;export all_proxy=socks5://127.0.0.1:7890
=======
proxy_host=${1:-'127.0.0.1:7890'}
echo "Set proxy to $proxy_host."
export https_proxy=http://$proxy_host;export http_proxy=http://$proxy_host;export all_proxy=socks5://$proxy_host
>>>>>>> d7bdcb0dfb534ff5427f547f04224b0aaef89ee8
