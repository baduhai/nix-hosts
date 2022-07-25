The expression allows for cross compiling. Change ssh public key as needed.  
To build the image, run  
`nix-build '<nixpkgs/nixos>' -A config.system.build.sdImage -I nixos-config=./sd-img.nix`  
Note that this will build the image using the same channel as is currently in use by your system. To build it against a different channel, use:  
`nix-build -I https://github.com/NixOS/nixpkgs/archive/refs/tags/22.05.tar.gz '<nixpkgs/nixos>' -A config.system.build.sdImage -I nixos-config=./sd-img.nix`