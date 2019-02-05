source $(dirname "$0")/submodules.sh
for mod in $submodules; do
    echo $mod
    git submodule update --remote $mod
done
