#!/ventoy/busybox/sh
#************************************************************************************
# Copyright (c) 2020, longpanda <admin@ventoy.net>
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 3 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.
# 
#************************************************************************************

if $GREP -q '^ *HAVE_PARTS=' /init; then
    $SED '1 apmedia=usbhd'  -i /init
    $SED "/^ *HAVE_PARTS=/a\ $BUSYBOX_PATH/sh $VTOY_PATH/hook/debian/puppy-disk.sh"  -i /init
    $SED "/^ *HAVE_PARTS=/a\ HAVE_PARTS='ventoy|iso9660'"  -i /init
fi

#360UDisk
if [ -e /360anim ]; then    
    $BUSYBOX_PATH/touch /puppy.sfs 
    $SED "/if *.*flag-usb-ready/i\ $BUSYBOX_PATH/sh $VTOY_PATH/hook/debian/360-disk.sh"  -i /init
    $SED "/^exec *switch_root/i\ $BUSYBOX_PATH/sh $VTOY_PATH/hook/debian/360-switch-root.sh"  -i /init    
fi

if [ -f /DISTRO_SPECS ]; then
    if ! [ -d /dev ]; then
        $BUSYBOX_PATH/mkdir /dev
    fi
fi
