#!/bin/sh

while true; do
    case $(date +%u) in
        1) week="▣▢▢▢▢▥▥" ;;
        2) week="▢▣▢▢▢▥▥" ;;
        3) week="▢▢▣▢▢▥▥" ;;
        4) week="▢▢▢▣▢▥▥" ;;
        5) week="▢▢▢▢▣▥▥" ;;
        6) week="▢▢▢▢▢▣▥" ;;
        7) week="▢▢▢▢▢▥▣" ;;
    esac
    echo "$week $(date +'%d %B %Y-%m-%d %R (:%S)')"
    sleep 1
done
