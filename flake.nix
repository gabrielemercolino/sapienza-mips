{
  description = "mips shell";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
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
