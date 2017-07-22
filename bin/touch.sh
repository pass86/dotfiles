for file in "$1/"*
do
    echo "$file"
    touch "$file"
done
