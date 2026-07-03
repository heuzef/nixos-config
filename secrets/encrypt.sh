# USAGE : sh encrypt.sh

encrypt_file() {
    local file="$1"
    local enc_file="${file}.enc"
    echo "Encrypt $file -> $enc_file"
    sops --encrypt --input-type binary --output-type binary --output "$enc_file" "$file"
    rm -v "$file"
}

for file in ./*.tar.gz; do
    [ -e "$file" ] || continue
    encrypt_file "$file"
done
