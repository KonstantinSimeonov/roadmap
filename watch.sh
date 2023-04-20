die() {
    kill $(jobs -p)
}

trap 'die' SIGINT SIGTERM

inotifywait \
    --monitor \
    --format "%w%f" \
    --event modify,move,create,delete *.dot | \
    while read f; do
        echo "CHANGED $f"
        out_file="${f/dot/svg}"
        dot -Tsvg "$f" -o "$out_file"
        echo "Built svg $out_file"
    done &

live-server .
