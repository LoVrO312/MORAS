$MV(R0, base)
$MV(R1, exp)

@R1
D = M;
@SET_1
D; JEQ

@exp
M = M - 1;

$MV(R0, temp)

$WHILE(exp)
    @exp
    M = M - 1;

    @R2
    M = 0;

    $WHILE(base)
        @temp
        D = M;

        @R2
        M = M + D;

        @base
        M = M - 1;
    $END

    $MV(R2,temp)
    $MV(R0, base)

$END



(END)
@END
0; JMP

(SET_1)
@R2
M = 1;
@END
0; JMP
