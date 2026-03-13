#!/bin/bash

# Catppuccin Mocha colors (truecolor)
RST=$'\033[0m'
BOLD=$'\033[1m'
DIM=$'\033[2m'
REV=$'\033[7m'
MAUVE=$'\033[38;2;203;166;247m'      # #cba6f7 - titles, nav active
SUBTEXT1=$'\033[38;2;186;194;222m'   # #bac2de - subtitles (LEFT/RIGHT HAND)
SURFACE1=$'\033[38;2;69;71;90m'      # #45475a - box-drawing chars
TEXT=$'\033[38;2;205;214;244m'       # #cdd6f4 - key labels
SURFACE2=$'\033[38;2;88;91;112m'     # #585b70 - empty cells (·)
SUBTEXT0=$'\033[38;2;166;173;200m'   # #a6adc8 - legend text
OVERLAY0=$'\033[38;2;108;112;134m'   # #6c7086 - nav inactive tabs
RED=$'\033[38;2;243;139;168m'        # #f38ba8 - q:Quit

# Color a data row — dim │ pipes, TEXT color for key labels
colorize_row() {
  printf "%s%s%s\n" "${TEXT}" "${1//│/${DIM}${SURFACE1}│${RST}${TEXT}}" "${RST}"
}

# Color a horizontal border line (─ ┌ ┐ └ ┘ ┬ ┴ ┼ ├ ┤)
colorize_border() {
  printf "${DIM}${SURFACE1}%s${RST}\n" "$1"
}

# Navigation bar with active layer highlighted
nav_bar() {
  local active=$1
  local labels=("1:Symbol" "2:Cursor" "3:Number" "4:Mouse")
  printf "   "
  for i in 0 1 2 3; do
    n=$((i+1))
    if [ "$n" = "$active" ]; then
      printf "%s ▶ %s ◀ %s" "${BOLD}${MAUVE}${REV}" "${labels[$i]}" "${RST}"
    else
      printf "%s  %s  %s" "${OVERLAY0}" "${labels[$i]}" "${RST}"
    fi
  done
  printf "  %sq:Quit%s\n" "${RED}" "${RST}"
}

show_symbol() {
  printf "\n"
  printf "   ${BOLD}${MAUVE}SYMBOL LAYER${RST}${TEXT}  (hold Space)${RST}\n"
  printf "\n"
  printf "   ${SUBTEXT1}LEFT HAND${RST}                          ${SUBTEXT1}RIGHT HAND${RST}\n"
  colorize_border "   ┌─────┬─────┬─────┬─────┬─────┬─────┐ ┌─────┬─────┬─────┬─────┬─────┬─────┐"
  colorize_row    "   │  \`  │  ,  │  (  │  )  │  ;  │  .  │ │  ·  │  ·  │  ·  │  ·  │  ·  │  ·  │"
  colorize_border "   ├─────┼─────┼─────┼─────┼─────┼─────┤ ├─────┼─────┼─────┼─────┼─────┼─────┤"
  colorize_row    "   │  !  │  [  │  {  │  }  │  ]  │  ?  │ │  \`  │ DEL │S-TB │ INS │ ESC │  ·  │"
  colorize_border "   ├─────┼─────┼─────┼─────┼─────┼─────┤ ├─────┼─────┼─────┼─────┼─────┼─────┤"
  colorize_row    "   │  #  │  ^  │  =  │  _  │  \$  │  *  │ │  \"  │ BSP │ TAB │ SPC │ RET │  ·  │"
  colorize_border "   ├─────┼─────┼─────┼─────┼─────┼─────┤ ├─────┼─────┼─────┼─────┼─────┼─────┤"
  colorize_row    "   │  ~  │  <  │  |  │  -  │  >  │  /  │ │  '  │ Sft │ Cmd │ Opt │ Ctl │  ·  │"
  colorize_border "   └─────┴─────┴─────┴─────┴─────┴─────┘ └─────┴─────┴─────┴─────┴─────┴─────┘"
  colorize_border "         ┌─────┬─────┬─────┬─────┬─────┐ ┌─────┬─────┬─────┬─────┬─────┐"
  colorize_row    "         │  '  │  \"  │  +  │  %  │  :  │ │  ·  │  ·  │  ·  │ END │PgUp │"
  colorize_border "         └─────┴─────┴─────┴─────┴─────┘ └─────┴─────┴─────┴─────┴─────┘"
  printf "\n"
  printf "   ${SUBTEXT0}Right side: text-editing keys (DEL, BSP, TAB, SPC, RET, ESC)${RST}\n"
}

show_cursor() {
  printf "\n"
  printf "   ${BOLD}${MAUVE}CURSOR LAYER${RST}${TEXT}  (hold Backspace)${RST}\n"
  printf "\n"
  printf "   ${SUBTEXT1}LEFT HAND${RST}                          ${SUBTEXT1}RIGHT HAND${RST}\n"
  colorize_border "   ┌─────┬─────┬─────┬─────┬─────┬─────┐ ┌─────┬─────┬─────┬─────┬─────┬─────┐"
  colorize_row    "   │  ·  │ ESC │ INS │S-TB │ DEL │  ·  │ │  ·  │  ·  │  ·  │  ·  │  ·  │  ·  │"
  colorize_border "   ├─────┼─────┼─────┼─────┼─────┼─────┤ ├─────┼─────┼─────┼─────┼─────┼─────┤"
  colorize_row    "   │  ·  │ RET │ SPC │ TAB │ BSP │ CUT │ │ CUT │S-TB │UNDO │REDO │ TAB │  ·  │"
  colorize_border "   ├─────┼─────┼─────┼─────┼─────┼─────┤ ├─────┼─────┼─────┼─────┼─────┼─────┤"
  colorize_row    "   │ Sft │ ^/A │ !/S │ @/D │ \$/F │ CPY │ │ CPY │  ←  │  ↑  │  ↓  │  →  │ Sft │"
  colorize_border "   ├─────┼─────┼─────┼─────┼─────┼─────┤ ├─────┼─────┼─────┼─────┼─────┼─────┤"
  colorize_row    "   │  ·  │ ^A  │ ^L  │ ^W  │ FND │ PST │ │ PST │HOME │PgUp │PgDn │ END │  ·  │"
  colorize_border "   └─────┴─────┴─────┴─────┴─────┴─────┘ └─────┴─────┴─────┴─────┴─────┴─────┘"
  colorize_border "         ┌─────┬─────┬─────┬─────┬─────┐ ┌─────┬─────┬─────┬─────┬─────┐"
  colorize_row    "         │  ·  │  ·  │  ·  │  ·  │  ·  │ │ F12 │ FND │ ^SG │ ^G  │  ·  │"
  colorize_border "         └─────┴─────┴─────┴─────┴─────┘ └─────┴─────┴─────┴─────┴─────┘"
  printf "\n"
  printf "   ${SUBTEXT0}^=Ctrl !=Opt @=Cmd \$=Shft  ^A=SelAll ^L=SelLine ^W=SelWord${RST}\n"
}

show_number() {
  printf "\n"
  printf "   ${BOLD}${MAUVE}NUMBER LAYER${RST}${TEXT}  (hold Tab)${RST}\n"
  printf "\n"
  printf "   ${SUBTEXT1}LEFT HAND${RST}                          ${SUBTEXT1}RIGHT HAND${RST}\n"
  colorize_border "   ┌─────┬─────┬─────┬─────┬─────┬─────┐ ┌─────┬─────┬─────┬─────┬─────┬─────┐"
  colorize_row    "   │  ·  │ F1  │ F2  │ F3  │ F4  │ F5  │ │ F6  │ F7  │ F8  │ F9  │ F10 │ F11 │"
  colorize_border "   ├─────┼─────┼─────┼─────┼─────┼─────┤ ├─────┼─────┼─────┼─────┼─────┼─────┤"
  colorize_row    "   │  A  │  B  │  C  │  D  │  E  │  F  │ │  G  │  7  │  8  │  9  │  0  │  #  │"
  colorize_border "   ├─────┼─────┼─────┼─────┼─────┼─────┤ ├─────┼─────┼─────┼─────┼─────┼─────┤"
  colorize_row    "   │ Sft │ ^/A │ !/S │ @/D │ \$/F │  ·  │ │  K  │  4  │  5  │  6  │  -  │  +  │"
  colorize_border "   ├─────┼─────┼─────┼─────┼─────┼─────┤ ├─────┼─────┼─────┼─────┼─────┼─────┤"
  colorize_row    "   │  0  │  ·  │  ·  │  ·  │  ·  │  ·  │ │  J  │  1  │  2  │  3  │  /  │  %  │"
  colorize_border "   └─────┴─────┴─────┴─────┴─────┴─────┘ └─────┴─────┴─────┴─────┴─────┴─────┘"
  colorize_border "         ┌─────┬─────┬─────┬─────┬─────┐ ┌─────┬─────┬─────┬─────┬─────┐"
  colorize_row    "         │  ·  │  ·  │  ·  │  ·  │  ·  │ │  0  │  (  │  [  │  ]  │  )  │"
  colorize_border "         └─────┴─────┴─────┴─────┴─────┘ └─────┴─────┴─────┴─────┴─────┘"
  printf "\n"
  printf "   ${SUBTEXT0}Hex A-F on left.  Numpad on right.  F-keys on top row.${RST}\n"
}

show_mouse() {
  printf "\n"
  printf "   ${BOLD}${MAUVE}MOUSE LAYER${RST}${TEXT}  (hold right Tab)${RST}\n"
  printf "\n"
  printf "   ${SUBTEXT1}LEFT HAND${RST}                          ${SUBTEXT1}RIGHT HAND${RST}\n"
  colorize_border "   ┌─────┬─────┬─────┬─────┬─────┬─────┐ ┌─────┬─────┬─────┬─────┬─────┬─────┐"
  colorize_row    "   │  ·  │  ·  │  ·  │  ·  │  ·  │  ·  │ │  ·  │ S↑  │  ·  │  ·  │  ·  │  ·  │"
  colorize_border "   ├─────┼─────┼─────┼─────┼─────┼─────┤ ├─────┼─────┼─────┼─────┼─────┼─────┤"
  colorize_row    "   │  ·  │  ·  │  ·  │ S↑  │  ·  │  ·  │ │ S↓  │ LMB │ M↑  │ RMB │  ·  │  ·  │"
  colorize_border "   ├─────┼─────┼─────┼─────┼─────┼─────┤ ├─────┼─────┼─────┼─────┼─────┼─────┤"
  colorize_row    "   │  ·  │ FST │ S←  │ S↓  │ S→  │  ·  │ │ S↓  │ M←  │ M↓  │ M→  │ FST │  ·  │"
  colorize_border "   ├─────┼─────┼─────┼─────┼─────┼─────┤ ├─────┼─────┼─────┼─────┼─────┼─────┤"
  colorize_row    "   │  ·  │  ·  │ CUT │ CPY │ PST │  ·  │ │  ·  │ S←  │ MMB │ S→  │  ·  │  ·  │"
  colorize_border "   └─────┴─────┴─────┴─────┴─────┴─────┘ └─────┴─────┴─────┴─────┴─────┴─────┘"
  colorize_border "         ┌─────┬─────┬─────┬─────┬─────┐ ┌─────┬─────┬─────┬─────┬─────┐"
  colorize_row    "         │  ·  │  ·  │  ·  │  ·  │  ·  │ │  ·  │  ·  │  ·  │  ·  │  ·  │"
  colorize_border "         └─────┴─────┴─────┴─────┴─────┘ └─────┴─────┴─────┴─────┴─────┘"
  printf "\n"
  printf "   ${SUBTEXT0}S=Scroll  M=Mouse  LMB/MMB/RMB=Clicks  FST=Fast 4x speed (hold)${RST}\n"
}

current=1
while true; do
  clear
  case $current in
    1) show_symbol ;;
    2) show_cursor ;;
    3) show_number ;;
    4) show_mouse ;;
  esac
  echo
  nav_bar $current
  read -n1 -s -r key
  case $key in
    1) current=1 ;;
    2) current=2 ;;
    3) current=3 ;;
    4) current=4 ;;
    l) current=$(( current % 4 + 1 )) ;;
    h) current=$(( (current + 2) % 4 + 1 )) ;;
    $'\e')
      # Read arrow key sequence or treat bare Esc as quit
      read -n1 -s -r -t 0.1 seq1
      if [ "$seq1" = "[" ]; then
        read -n1 -s -r -t 0.1 seq2
        case $seq2 in
          C) current=$(( current % 4 + 1 )) ;;       # Right arrow
          D) current=$(( (current + 2) % 4 + 1 )) ;;  # Left arrow
        esac
      else
        break  # Bare Esc = quit
      fi
      ;;
    q) break ;;
  esac
done
