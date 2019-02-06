if [[ $# != 1 ]]; then
    echo $0 directory
    exit 1
fi

for file in $1/*; do
    echo $file
    touch $file
done
