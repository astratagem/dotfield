{ inputs, ... }:
let
  inherit (inputs.apparat.lib.net.constants) dns;
in
{
  aspects.dns__quad9.nixos = {
    networking.nameservers = dns.nameservers.quad9;
    networking.networkmanager.insertNameservers = dns.nameservers.quad9;
  };
}
