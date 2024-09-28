#!/bin/bash
set -e

# List of adlists to be added
ADLISTS=(
    "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
    "https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt"
    "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt"
    "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt"
    "https://v.firebog.net/hosts/Prigent-Ads.txt"
    "https://v.firebog.net/hosts/Easyprivacy.txt"
    "https://v.firebog.net/hosts/Admiral.txt"
    "https://adaway.org/hosts.txt"
    "https://v.firebog.net/hosts/static/w3kbl.txt"
    "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts"
    "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt"
    "https://blocklistproject.github.io/Lists/ads.txt"	
    "https://blocklistproject.github.io/Lists/alt-version/ads-nl.txt"		
    "https://blocklistproject.github.io/Lists/dnsmasq-version/ads-dnsmasq.txt"		
    "https://blocklistproject.github.io/Lists/adguard/ads-ags.txt"
    "https://blocklistproject.github.io/Lists/alt-version/ads-nl.txt"
    "https://blocklistproject.github.io/Lists/dnsmasq-version/ads-dnsmasq.txt"
    "https://blocklistproject.github.io/Lists/dnsmasq-version/tiktok-dnsmasq.txt"
    "https://blocklistproject.github.io/Lists/alt-version/tiktok-nl.txt"
    "https://blocklistproject.github.io/Lists/tiktok.txt"
    "https://blocklistproject.github.io/Lists/dnsmasq-version/redirect-dnsmasq.txt"
    "https://blocklistproject.github.io/Lists/alt-version/redirect-nl.txt"
    "https://blocklistproject.github.io/Lists/redirect.txt"
)

# Function to add adlist
add_adlist() {
    local url=$1
    if ! sqlite3 /etc/pihole/gravity.db "SELECT address FROM adlist WHERE address = '$url';" | grep -q "$url"; then
        sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address) VALUES ('$url');"
    fi
}

# Add each adlist
for url in "${ADLISTS[@]}"; do
    add_adlist "$url"
done

# Update gravity to apply the new adlists
pihole -g
