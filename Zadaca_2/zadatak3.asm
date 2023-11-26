@5
M = 0

//counter
@i
M = 0;
@4
D = A;
@i
M = D;


(LOOP)
    // go to RAM[i]
    @i
    A = M;
    D = M; // RAM[i]

    // Adding value to RAM[5]
    @5
    M = D + M;

    // Checking if i == 0 -> end program
    @i
    D = M;
    @END
    D ; JEQ

    @i
    M = M - 1
@LOOP
0; JMP




//end of the program
(END)
@END
0; JMP