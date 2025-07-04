{
  description = "Repo-wide shared bin scripts";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs }: {
    packages = let
      systems = [ "x86_64-linux" ]; # Add more if needed
    in builtins.listToAttrs (map (system: {
      name = system;
      value = {
        bin-scripts = let
          pkgs = import nixpkgs { inherit system; };
        in pkgs.stdenv.mkDerivation {
          name = "bin-scripts";
          src = self;  # gives access to the full flake repo (not just flakes/bin)

          installPhase = ''
            mkdir -p $out/bin
            cp -r $src/bin/* $out/bin/
            chmod +x $out/bin/*
          '';
        };
      };
    }) systems);
  };
}

