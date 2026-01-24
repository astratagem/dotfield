mod age
mod sops

[doc("Generate a hashed password suitable for use with immutable users")]
generate-hashed-password:
  mkpasswd -m sha-512
