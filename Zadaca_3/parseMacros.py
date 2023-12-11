def _parse_macros(self):
    self._macros = ["MV", "SWP", "SUM", "WHILE", "END"]
    lines = []

    self._temp_count = 0
    self._while_loop = False
    self._loop_variables = []


    for (line, p, o) in self._lines:
        lineNum = len(lines) + 1

        if line[0] != "$":
            if line.strip() != "":
                lines.append((line, lineNum, lineNum))
            continue

        parse = _parse_macro(self, line, p, o)
        if parse == []:
            return
        
        for p in parse:
            lineNum = len(lines) + 1
            lines.append((p, lineNum, lineNum))
    
    if len(self._loop_variables) > 0:
        self._flag = False
        self._line = len(lines)
        self._errm = "Invalid while loop."
        return []

    self._lines = lines


def _parse_macro(self, line, p, o):
    l = line[1:]
    macro_command = l.strip().split("(")[0]

    if macro_command not in self._macros:
        self._flag = False
        self._line = o
        self._errm = "Macro does not exist."
        return []

    if macro_command != "END":
        # $SUM(A, B, D) throw_err -> (["A,B,D"], ["throw_err"])
        macro_arguments_split = l.strip().split("(")[1].split(")")
        # ["A","B","D"]
        macro_arguments = macro_arguments_split[0].split(",")

        if macro_arguments_split[1] != "":
            self._flag = False
            self._line = o
            self._errm = "Invalid syntax"

        #provjeravamo valjanost argumenata
        for arg in macro_arguments:
            if arg == "":           # mozda treba biti "/n" ??
                self._flag = False
                self._line = o
                self._errm = "Invalid macro argument."
                return []
    else:
        macro_split = l.strip().split("D")[1]
        if macro_split != "":
            self._flag = False
            self._line = o
            self._errm = "Invalid syntax."
            return []
        
    # pozivi makroa

    if macro_command == "END":
        if len(self._loop_variables) == 0:
            self._flag = False
            self._line = o
            self._errm = "Invalid macro."
            return []
        return _END(self)

    if macro_command == "WHILE":
        if len(macro_arguments) != 1:
            self._flag = False
            self._line = o
            self._errm = "Invalid macro arguments."
            return []
        return _WHILE(self, macro_arguments[0])

    if macro_command == "MV" or macro_command == "SWP":
        if len(macro_arguments) != 2:
            self._flag = False
            self._line = o
            self._errm = "Invalid macro arguments."
            return []
        
        if macro_command == "MV":
            return _MV(self, macro_arguments[0], macro_arguments[1])
        if macro_command == "SWP":
            return _SWP(self, macro_arguments[0], macro_arguments[1])
    
    elif macro_command == "SUM":
        if len(macro_arguments) != 3:
            self._flag = False
            self._line = o
            self._errm = "Invalid macro arguments."
            return []
        return _SUM(self, macro_arguments[0], macro_arguments[1], macro_arguments[2])


# Definiramo makro funkcije MV SWP SUM WHILE

def _WHILE(self, A):
    self._loop_variables.append((A, self._temp_count))
    ret = f"(WHILE_LOOP_START_{self._temp_count})"
    self._temp_count += 1

    return [
        ret
    ]

def _END(self):
    loop_condition, loop_count = self._loop_variables.pop()
    start = f"WHILE_LOOP_START_{loop_count}"
    end = f"WHILE_LOOP_END_{loop_count}"

    return [      
        f"@{loop_condition}",
        "D=M",
        f"@{end}",
        "D;JEQ",
        f"@{start}",
        "0;JMP",
        f"({end})"
    ]

def _MV(self, A, B):
    return [
        f"@{A}",
        "D=M",
        f"@{B}",
        "M=D"
    ]

def _SWP(self, A, B):
    temp = "@SWP_" + str(self._temp_count)
    self._temp_count += 1

    return [
        f"@{A}",
        "D=M",
        temp,
        "M=D",
        f"@{B}",
        "D=M",
        f"@{A}",
        "M=D",
        temp,
        "D=M",
        f"@{B}",
        "M=D"
    ]

def _SUM(self, A, B, D):
    return [
        f"@{A}",
        "D=M",
        f"@{B}",
        "D=D+M",
        f"@{D}",
        "M=D"
    ]
