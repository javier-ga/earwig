#!/bin/bash
set -e
export PATH=~/.local/bin:$PATH
echo "Executing command <$1>"

if [ "$1" = 'earwig' ]; then
    mkdir ~/.earwig
    echo "Extracting credentials parameters"
    aws ssm get-parameter --name '/nifi/prod/google_play/ANR/credentials' --with-decryption | jq -r '.Parameter.Value' > ~/.earwig/earwig.properties
    echo "Executing earwig"
    $@
    echo "Uploading cookies"
    aws ssm put-parameter --name "/nifi/prod/google_play/ANR/cookie" --value "$(< ~/.earwig/state.json)" --type "SecureString" --overwrite
    
else

    echo "Other comand"
    exec "$@"

fi