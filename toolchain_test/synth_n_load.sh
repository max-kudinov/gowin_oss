#!/bin/sh

device="GW2A-LV18PG256C8/I7"
board="tangprimer20k"
source_files="$1"

# Synthesis into Gowin primitives
yosys -p "read -sv $source_files; synth_gowin -json button.json" &&

# PnR
nextpnr-himbaechel --json button.json --write pnrbutton.json  \
    --device $device --vopt family=GW2A-18 --vopt cst=pins.cst   &&

# Generate bitstream
echo "------------------------------------"                      &&
echo "Generating bitstream for the board.."                      &&
echo "------------------------------------"                      &&
gowin_pack -d $device -o pack.fs pnrbutton.json                  &&
echo "DONE!"                                                     &&

# Load into board
echo "--------------------------------"                          &&
echo "Loading bitstream into the board"                          &&
echo "--------------------------------"                          &&
openFPGALoader -b $board pack.fs
