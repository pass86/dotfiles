source $(dirname "$0")/module.sh
for mod in $module; do
    echo $mod
    git submodule update --init $mod
done
