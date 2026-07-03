# USAGE : sh decrypt.sh

decrypt_file() {
    local enc_file="$1"
    local file="${enc_file%.enc}"
    echo "Decrypt $enc_file -> $file"
    sops --decrypt --input-type binary --output-type binary --output "$file" "$enc_file"
    rm -v "$enc_file"
}

for enc_file in ./*.tar.gz.enc; do
    [ -e "$enc_file" ] || continue
    decrypt_file "$enc_file"
done