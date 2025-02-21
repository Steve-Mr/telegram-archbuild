#!/bin/bash

PKGBUILD=pkgbuilds/ayugram-desktop-maary/PKGBUILD
aur_url="https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=ayugram-desktop"

# 从指定 URL 获取 PKGBUILD 内容
new_pkgbuild=$(curl -s $aur_url)

# 获取 PKGBUILD 中的 pkgver 和 newver
newver=$(echo "$new_pkgbuild" | grep -oP '^pkgver=\K[^\s]*')
pkgver=$(grep -oP '^pkgver=\K[^\s]*' $PKGBUILD)

if [ "$newver" != "$pkgver" ]; then
    # 拉取新的 PKGBUILD 内容
    echo "$new_pkgbuild" > $PKGBUILD

    # 修改 PKGBUILD 中的 pkgname 为 ayugram-desktop-maary
    sed -i 's/^pkgname=.*$/pkgname=ayugram-desktop-maary/' $PKGBUILD

    # 获取新的 tg_tar_link 和 sha512sums
    source $PKGBUILD
    tg_tar_link=${source[0]#*::}   # 去除 '::' 及之前的部分，提取实际的 URL
    echo "Telegram Desktop tar link: ${tg_tar_link}!"
    wget "${tg_tar_link}" -O tdesktop.tar.gz
    oldsha=${sha512sums[0]}
    newsha=$(sha512sum tdesktop.tar.gz | cut -d ' ' -f 1)
    echo "New SHA512: ${newsha}"
    sed -i "s/${oldsha}/${newsha}/" $PKGBUILD

    echo "Updated from ${pkgver} to ${newver}!"

    # echo 1 if updated
    echo 1 > updated
    echo ${newver} > newver
    exit 0
fi

echo "No Update!"
echo 0 >> updated
