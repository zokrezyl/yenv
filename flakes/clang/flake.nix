{
  description = "Clang + libc++ + CMake dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    bin-scripts.url = "path:../bin";
  };

  outputs = { self, nixpkgs, bin-scripts }: {
    devShells = {
      x86_64-linux = let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        llvm = pkgs.llvmPackages;
      in {
        default = llvm.libcxxStdenv.mkDerivation {
          name = "clang-libcxx-shell";
          buildInputs = [
            llvm.clang
            llvm.lld
            pkgs.cmake
            pkgs.python314
            bin-scripts.packages.x86_64-linux.bin-scripts
          ];
          shellHook = ''
            exec ${bin-scripts.packages.x86_64-linux.bin-scripts}/bin/dev-shell
          '';
        };
      };
    };
  };
}

