// DIAGONALS
@1
D = A;
@100
M = D;

@2
D = A;
@101
M = D;

@4
D = A;
@102
M = D;

@8
D = A;
@103
M = D;

@16
D = A;
@104
M = D;

@32
D = A;
@105
M = D;

@64
D = A;
@106
M = D;

@128
D = A;
@107
M = D;

@256
D = A;
@108
M = D;

@512
D = A;
@109
M = D;


@1024
D = A;
@110
M = D;

@2048
D = A;
@111
M = D;

@4096
D = A;
@112
M = D;

@8192
D = A;
@113
M = D;

@16384
D = A;
@114
M = D;

@32767
D = A;
D = -D;
D = D - 1;
@115
M = D;

// beginning location of the main diagonal
@2054
D = A;
@SCREEN
D = D + A;
@i       // RAM[i] -> address on SCREEN
M = D;

@100
D = A;
@address // RAM[address] -> value 2^k
M = D;

@8
D = A;
@counter
M = D;

(MAIN_DIAGONAL_FOO)

    (MAIN_DIAGONAL_DRAW)
        // setting D to value
        @address
        A = M
        D = M;

        // drawing on screen
        @i
        A = M;
        M = D;

        @32
        D = A;
        @i
        M = M + D;

        @address
        M = M + 1;

        // loop condition
        @116
        D = A;
        @address
        D = D - M;
        @MAIN_DIAGONAL_FOO
        D ; JGT

    @i
    M = M + 1;

    @100
    D = A;
    @address
    M = D;

    // counter and loop condition
    @counter
    M = M - 1;
    D = M;  
    @MAIN_DIAGONAL_FOO
    D ; JGT


// beginning location of the side diagonal
@6118
D = A;
@SCREEN
D = D + A;
@i       // RAM[i] -> address on SCREEN
M = D;

@100
D = A;
@address // RAM[address] -> value 2^k
M = D;

@8
D = A;
@counter
M = D;

(SIDE_DIAGONAL_FOO)

    (SIDE_DIAGONAL_DRAW)
        // setting D to value
        @address
        A = M
        D = M;

        // drawing on screen
        @i
        A = M;
        M = D;

        @32
        D = A;
        @i
        M = M - D;

        @address
        M = M + 1;

        // loop condition
        @116
        D = A;
        @address
        D = D - M;
        @SIDE_DIAGONAL_FOO
        D ; JGT

    @i
    M = M + 1;

    @100
    D = A;
    @address
    M = D;

    // counter and loop condition
    @counter
    M = M - 1;
    D = M;  
    @SIDE_DIAGONAL_FOO
    D ; JGT
    

// Beginning location of horizontal top line
@SCREEN
D = A;
@2054
D = D + A;

@i
M = D;

(HORIZONTAL_TOP_LINE)
    // Drawing horizontal line
    @i
    A = M;
    M = -1;

    // increasing counter
    @i
    M = M + 1;
    D = M;

    // loop condition
    @18446
    D = A - D;
    @HORIZONTAL_TOP_LINE
    D; JGT



// Beginning location of horizontal bottom line
@SCREEN
D = A;
@6118
D = D + A;

@i
M = D;

(HORIZONTAL_BOTTOM_LINE)
    // Drawing horizontal line
    @i
    A = M;
    M = -1;

    // increasing counter
    @i
    M = M + 1;
    D = M;

    // loop condition
    @22510
    D = A - D;
    @HORIZONTAL_BOTTOM_LINE
    D; JGT


// Beginning location of left vertical line
@2086
D = A;
@i
M = D;

    (VERTICAL_LEFT_LINE)
    @i
    D = M;

    // Drawing the line
    @SCREEN
    A = A + D;
    M = M + 1;

    // increasing counter
    @32
    D = A;
    @i
    M = M + D;
    D = M;

    // loop condition
    @6118
    D = A - D;
    @VERTICAL_LEFT_LINE
    D; JGT


// Beginning location of right vertical line
@SCREEN
D = A;
@2093
D = D + A;
@i
M = D;

    (VERTICAL_RIGHT_LINE)
    @32767
    D = A + 1;
    D = -D;

    // Drawing the line
    @i
    A = M;
    M = M + D;

    // increasing counter
    @32
    D = A;
    @i
    M = M + D;
    D = M;

    // loop condition
    @22500
    D = A - D;
    @VERTICAL_RIGHT_LINE
    D; JGT

(END)
@END
0 ; JMP


