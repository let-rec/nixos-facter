{config, pkgs, inputs, ...}:

{
    hardware.facter.reportPath = pkgs.runCommand "facter.json" {
        nativeBuildInputs = [inputs.nixos-facter.packages.${pkgs.system}.default];
    } ''
        nixos-facter -o $out
    ''
}