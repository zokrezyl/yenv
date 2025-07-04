{
  description = "Clang + libc++ + CMake dev shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs }: {
    packages = {
      x86_64-linux = let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in {
        dev-shell-bin = pkgs.writeShellApplication {
          name = "dev-shell";
          runtimeInputs = [ pkgs.bash ];
          text = builtins.readFile ./bin/dev-shell;
        };
      };
    };

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
            self.packages.x86_64-linux.dev-shell-bin
          ];
          shellHook = ''
            exec dev-shell
          '';
        };
      };
    };
  };
}

