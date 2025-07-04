{
  description = "Multi-flake repo root";

  inputs = {
    clang.url = "path:flakes/clang";
    #python.url = "path:flakes/python";
    bin.url = "path:flakes/bin";
    # add more if needed
  };

  outputs = inputs@{ self, clang, bin, ... }:
    # empty or export top-level outputs if desired
    {};
}

