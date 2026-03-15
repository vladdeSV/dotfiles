#!/bin/sh
set -eu

# legend
# - fw: "first week"
# - lw: "last week"

enable_color='auto'
for arg in "$@"; do
  case "$arg" in
  --color=*) enable_color=${arg#--color=} ;;
  esac
done

if [ "$enable_color" = 'auto' ]; then
  if [ -t 1 ]; then
    enable_color='always'
  else
    enable_color='never'
  fi
fi

esc_dim=$(printf '\033[37m')
esc_rst=$(printf '\033[0m')
esc_reverse=$(printf '\033[7m')
esc_unreverse=$(printf '\033[27m')

if [ "$enable_color" = 'never' ]; then
  esc_reverse=""
  esc_unreverse=""
  esc_dim=""
  esc_rst=""
elif [ "$enable_color" != 'always' ]; then
  echo "error: invalid color value"
  exit 1
fi

puts() {
  printf '%s' "$1"
}
trim_blank() {
  sed 's/^[[:space:]]*$//'
}
trim() {
  sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
}
trim_leading() {
  sed 's/^[[:space:]]*//'
}
trim_trailing() {
  sed 's/[[:space:]]*$//'
}
sed_if() {
  if [ "$1" = "$2" ]; then
    sed "$3"
  else
    cat
  fi
}

calendar=$(cal "$@" --color=never -3c1)
day_of_month="$(date '+%e')"

# figure out if any of the months include the actual month, used for highlighting current day
real_month_id=''
real_heading=$(date '+%B %Y')
prev_heading=$(puts "$calendar" | tail -n +1 | head -n 1 | trim)
curr_heading=$(puts "$calendar" | tail -n +9 | head -n 1 | trim)
next_heading=$(puts "$calendar" | tail -n +17 | head -n 1 | trim)

case "$real_heading" in
"$prev_heading") real_month_id='prev' ;;
"$curr_heading") real_month_id='curr' ;;
"$next_heading") real_month_id='next' ;;
esac

prev_month=$(puts "$calendar" | tail -n +3 | head -n 6 | trim_blank)
curr_month=$(puts "$calendar" | tail -n +11 | head -n 6 | trim_blank)
next_month=$(puts "$calendar" | tail -n +19 | head -n 6 | trim_blank)

d=$day_of_month
ssed="s/${d}\\([^0-9]\\)/${esc_reverse}${d}${esc_unreverse}\\1/g;s/${d}\$/${esc_reverse}${d}${esc_unreverse}/"

curr_month_fw=" $(puts "$curr_month" | head -n 1 | trim)"
curr_month_lw=$(puts "$curr_month" | tail -n 1 | trim)

# print the current month's heading
puts "$calendar" | tail -n +9 | head -n 2

# do we need to print previous month's last week
if [ "${#curr_month_fw}" -le 18 ]; then
  printf "%s%s%s " "$esc_dim" "$(puts "$prev_month" | tail -n 1 | trim_trailing | sed_if "$real_month_id" 'prev' "$ssed")" "$esc_rst"
fi

# print the current month
echo "$curr_month_fw" | sed_if "$real_month_id" 'curr' "$ssed"
puts "$curr_month" | tail -n +2 | trim_trailing | sed_if "$real_month_id" 'curr' "$ssed"

# do we need to print the next month's first week
if [ "${#curr_month_lw}" -le 18 ]; then
  printf " %s%s%s\n" "$esc_dim" " $(puts "$next_month" | head -n 1 | trim_leading)" "$esc_rst" | sed_if "$real_month_id" 'next' "$ssed"
else
  printf "\n"
fi

# ensure we have printed 8 lines
line_count=$(puts "$curr_month" | wc -l)
diff=$((6 - line_count - 1))
while [ "$diff" -gt 0 ]; do
  printf "                    \n"
  diff=$((diff - 1))
done
