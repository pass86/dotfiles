source $(dirname $0)/submodules.sh
for mod in $SUBMODULES; do
    echo $mod
    git submodule update --remote $mod
done
