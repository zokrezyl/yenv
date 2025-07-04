{
  description = "Flake root delegating to all subflakes in ./flakes";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  inputsFrom = ./flakes;

  outputs = inputs@{ self, ... }:
    {};
}

