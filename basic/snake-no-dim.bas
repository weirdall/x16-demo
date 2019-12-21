10 REM ########################################
20 REM ### SNAKE GAME WITHOUT USING "DIM"   ###
30 REM ########################################
40 REM WIDTH = 79
50 REM HEIGHT = 58
60 FG = 0:BG = 0:GOSUB 840: REM SETCOLOR
70 PRINT CHR$(147);
80 FG = 8:BG = 2:GOSUB 840: REM SETCOLOR
90 FOR X=0 TO 79
100 Y = 0:GOSUB 800: REM SETPOS
110 PRINT "#";
120 Y = 58:GOSUB 800: REM SETPOS
130 PRINT "#";
140 NEXT
150 FOR Y=1 TO 58
160 X = 0:GOSUB 800: REM SETPOS
170 PRINT "#";
180 X = 79:GOSUB 800: REM SETPOS
190 PRINT "#";
200 NEXT
210 FG = 3:BG = 0:GOSUB 840: REM SETCOLOR
220 REM GAME INIT
230 POO = 0
240 SN$ =  CHR$(60) + CHR$(20) + CHR$(60) + CHR$(20)
250 SN$ = SN$ + CHR$(60) + CHR$(20) + CHR$(60) + CHR$(20)
260 SPD = 10
270 SD$ = "A":CLC=TI+SPD
280 GOSUB 880: REM PUTNEWFOOD
290 REM --------------------------------
300 REM GAME LOOPP
310 X = ASC(SN$): Y = ASC(MID$(SN$,2,1))
320 GOSUB 800: REM SETPOS
330 IF POO <= 0 THEN GOTO 390
340 FG = 7:BG = 9:GOSUB 840: REM SETCOLOR
350 PRINT "#";
360 POO = POO - 1
370 FG = 3:BG = 0:GOSUB 840: REM SETCOLOR
380 GOTO 420
390 REM
400 FG = 3:BG = 0:GOSUB 840: REM SETCOLOR
410 PRINT " ";
420 GET KEY$
430 IF KEY$ = "W" THEN SD$ = "W"
440 IF KEY$ = "A" THEN SD$ = "A"
450 IF KEY$ = "S" THEN SD$ = "S"
460 IF KEY$ = "D" THEN SD$ = "D"
470 X = ASC(RIGHT$(SN$,2)): Y = ASC(RIGHT$(SN$,1))
480 IF SD$ = "W" THEN Y=Y-1
490 IF SD$ = "A" THEN X=X-1
500 IF SD$ = "S" THEN Y=Y+1
510 IF SD$ = "D" THEN X=X+1
520 CH$ = CHR$(VPEEK(0, Y*256+X*2))
530 IF CH$ = " " THEN GOTO 560
540 IF CH$ = CHR$($24) THEN GOTO 580
550 GOTO 680
560 SN$ = MID$(SN$,3) + CHR$(X) + CHR$(Y)
570 GOTO 610
580 SN$ = SN$ + CHR$(X) + CHR$(Y)
590 GOSUB 880: REM PUTNEWFOOD
600 POO = INT(LEN(SN$)/3)
610 REM CAN GO
620 GOSUB 800: REM SETPOS
630 PRINT "*";
640 IF CLC>TI THEN GOTO 640
650 CLC = TI+SPD
660 GOTO 300
670 END
680 REM -------- GAME OVER ---------------
690 GOSUB 800: REM SETPOS
700 FG = 2:BG = 0:GOSUB 840: REM SETCOLOR
710 PRINT CHR$($76);
720 X = 35:Y = 23:GOSUB 800: REM SETPOS
730 PRINT "GAME OVER";
740 X = 37:Y = 25:GOSUB 800: REM SETPOS
750 PRINT (LEN(SN$)/2);
760 FG = 1:BG = 0:GOSUB 840: REM SETCOLOR
770 X = 0:Y = 57:GOSUB 800: REM SETPOS
780 END
790 REM --------------------------------
800 REM SETPOS(X,Y)
810 POKE $030D,Y: POKE $030E,X: POKE $030F,0: SYS $FFF0
820 RETURN
830 REM --------------------------------
840 REM SETCOLOR(FG,BG)
850 POKE 713, (BG AND $F) * 16 + (FG AND $F)
860 RETURN
870 REM --------------------------------
880 REM PUTNEWFOOD()
890 XX=X:YY=Y
900 X = INT(RND(TI)*79)+1: Y = INT(RND(TI)*58)+1
910 IF VPEEK(0,Y*256+X*2) <> 32 THEN GOTO 900
920 GOSUB 800: REM SETPOS
930 FG = 0:BG = 13:GOSUB 840: REM SETCOLOR
940 PRINT CHR$($24);
950 FG = 3:BG = 0:GOSUB 840: REM SETCOLOR
960 X=XX:Y=YY
970 RETURN