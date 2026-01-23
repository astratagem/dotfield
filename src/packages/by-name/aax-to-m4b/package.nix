{
  audible-cli,
  ffmpeg,
  writeShellApplication,
}:

writeShellApplication {
  name = "aax-to-m4b";

  runtimeInputs = [
    audible-cli
    ffmpeg
  ];

  text = ''
    ACTIVATION_BYTES="$(audible activation-bytes)" || {
      echo "Error: Failed to get activation bytes"
      exit 1
    }

    convert_file() {
      local file="$1"
      local base="''${file%.*}"
      local output="''${base}.m4b"

      if [[ -f "$output" ]]; then
        echo "Skipping $file (output exists)"
        return
      fi

      if [[ "$file" == *.aaxc ]]; then
        local voucher="''${base}.voucher"
        if [[ ! -f "$voucher" ]]; then
          echo "Error: Missing voucher for $file"
          return 1
        fi
        ffmpeg -audible_key "$voucher" -i "$file" -vn -c:a copy -b:a 128k "$output"
      else
        ffmpeg -activation_bytes "$ACTIVATION_BYTES" -i "$file" -vn -c:a copy -b:a 128k "$output"
      fi
    }

    for file in *.aax *.aaxc; do
      [[ -f "$file" ]] || continue
      convert_file "$file"
    done
  '';
}
