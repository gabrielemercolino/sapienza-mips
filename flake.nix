{
  description = "test";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
      old-python-nixpkgs.url = "github:nixos/nixpkgs/2030abed5863fc11eccac0735f27a0828376c84e";
    };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default =
        pkgs.mkShell
          {
            nativeBuildInputs = with pkgs; [
              mars-mips
            ];

            shellHook = ''
							clear
              echo "welcome to mips shell!" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
              exec zsh 
            '';
          };
    };
}
