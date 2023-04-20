inotifywait \
    --monitor \
    --format "%w%f"  \
    --event modify,move,create,delete *.dot |  \
    while read f; do
        echo "CHANGED %f"
        dot -Tsvg roadmap.dot > roadmap.svg
        echo "Built svg"
    done &

live-server .