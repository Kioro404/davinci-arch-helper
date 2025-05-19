#!/bin/bash

# NOTE: Execute this script without root permissions

if [[ "$( /opt/resolve/bin/resolve 2>&1 )" == "/opt/resolve/bin/resolve: symbol lookup error: /usr/lib/libpango-1.0.so.0: undefined symbol: g_once_init_leave_pointer" ]]; then
	resolve_libs="/opt/resolve/libs/"
	resolve_libs_backup="lib_backup/"

	sudo mkdir -p $resolve_libs$resolve_libs_backup
	
	for lib in "libglib-2.0.so*" "libgio-2.0.so*" "libgmodule-2.0.so*" "libgobject-2.0.so*"; do
		sudo mv $resolve_libs$lib $resolve_libs$resolve_libs_backup
	done
	
	echo "Bookstores in conflict moved to $resolve_libs$resolve_libs_backup"
fi

sudo pacman -Syu --needed git base-devel wget yay

AMD_RXs="-legacy" # Installation version for AMD RX 4xx/5xx

# List of AUR packages to install
paquetes=(
	"amdgpu-pro-oglp"$AMD_RXs
	"opencl-amd"
)

# Iterate over the list of packages and install them
for paquete in "${paquetes[@]}"; do
	if ! pacman -Qs "$paquete" > /dev/null; then
		echo "Install $paquete..."
		yay -S --noconfirm "$paquete"
	else
		echo "$paquete install succesfull."
	fi
done

echo "Instalation complete."