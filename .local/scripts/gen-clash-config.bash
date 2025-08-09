SOURCE_CONFIG=$1
TEMPLATE=$2

yq "load(\"${SOURCE_CONFIG}\").proxies as \$p | .proxies = \$p |
(.proxies | map(.name)) as \$n |
(.proxy-groups.[] | select(.name == \"Proxies\").proxies) = \$n |
(.proxy-groups.[] | select(.name == \"Bilibili\").proxies) += \$n |
(.proxy-groups.[] | select(.name == \"AI\").proxies) += \$n |
(.proxy-groups.[] | select(.name == \"Telegram\").proxies) += \$n |
(.proxy-groups.[] | select(.name == \"Download\").proxies) += \$n |
(.proxy-groups.[] | select(.name == \"Google\").proxies) += \$n |
(.proxy-groups.[] | select(.name == \"Final\").proxies) += \$n"  ${TEMPLATE}
