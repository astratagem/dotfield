[doc("Generate a Nix package expression from a URL")]
add-new pname url:
  nix-init --url {{url}} {{module_directory()}}/by-name/{{pname}}/package.nix
