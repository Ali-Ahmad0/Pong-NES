@echo off
cl65 -t nes -g -c src/main.asm -o main.o
ld65 -t nes -o game.nes src/main.o --dbgfile game.dbg

del src\main.o
game.nes