$MV(R0, i) // i = R0

$WHILE(i)
    @i
    M = M - 1;

    // ode na zadnji element
    D = M;  // D = i
    @100
    A = D + A;  

    // seta max na zadnji element
    D = M;
    @max
    M = D;

    // seta j na element koji prethodi i
    @i
    D = M;
    @j
    M = D - 1;

    // provjera
    @j
    D = M;
    @END
    D ; JLT

    $WHILE(j)
        // uzimam vrijednost sa j + 100
        @j
        D = M;
        @100
        A = D + A;
        D = M;

        // usporedujem j + 100 sa max -> ako je max veći skipam
        @max
        D = D - M;
        @SKIP
        D ; JLE
        
        // Ako se skip nije izvrsio swapam j + 100 i i + 100 jer je j + 100 novi max
        // setam tmp na j + 100
        @j
        D = M;
        @100
        A = D + A
        D = M;

        @tmp
        M = D;

        // setam i + 100 na tmp
        @i
        D = M;
        @100
        D = D + M;
        @ind_i
        M = D;
        @tmp
        D = M;
        @ind_i
        A = M;
        M = D;

        // setam j + 100 na max
        @j
        D = M;
        @100
        D = D + M;
        @ind_j
        M = D;
        @max
        D = M;
        @ind_j
        A = M;
        M = D;

        $SWP(max, tmp)

        (SKIP)
        @j
        M = M - 1;
    $END

$END


(END)
@END
0; JMP
