#!/bin/sh
echo "Saving key to file..."
echo -e "${INPUT_KEY}" > key.txt

echo "Set key file access rights..."
chmod 600 key.txt

if [ -n "$INPUT_BEFORE" ]
then
    ssh -q -p $INPUT_PORT -o StrictHostKeyChecking=no -i key.txt "$INPUT_USERNAME"@"$INPUT_HOST":"$INPUT_TARGET" "$INPUT_BEFORE" || exit 1
fi

echo "Starting SCP process..."
scp -pqrv -P $INPUT_PORT -o StrictHostKeyChecking=no -i key.txt "$INPUT_SOURCE" "$INPUT_USERNAME"@"$INPUT_HOST":"$INPUT_TARGET" || exit 1
echo "SCP operation completeted."

if [ -n "$INPUT_AFTER" ]
then
    ssh -q -p $INPUT_PORT -o StrictHostKeyChecking=no -i key.txt "$INPUT_USERNAME"@"$INPUT_HOST":"$INPUT_TARGET" "$INPUT_AFTER" || exit 1
fi