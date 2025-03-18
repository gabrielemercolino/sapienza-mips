{
  description = "mips shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    script = ''
      mars-mips sm p nc $1
    '';
  in {
    devShells.${system}.default =
      pkgs.mkShell
      {
        nativeBuildInputs = with pkgs; [
          mars-mips
          (writeShellScriptBin "mips" script)
        ];

        shellHook = ''
          clear
          echo "welcome to mips shell!" | ${pkgs.lolcat}/bin/lolcat
        '';
      };
  };
}
