encrypt_file() {
    local file="$1"
    local enc_file="${file}.enc"
    echo "Encrypt $file -> $enc_file"
    sops --encrypt "$file" > "$enc_file"
    rm -v "$file"
}

find . -type f ! -name '.sops.yaml' ! -name '*.enc*' ! -name '*.sh' | while read -r file; do
    encrypt_file "$file"
done

tree
