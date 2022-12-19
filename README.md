# Memory Game
Memory Game made during the Computer Organization and Architecture discipline lectured by Eduardo do Vale Simões

## How to install
Attention: if you're told to update something, DON'T DO IT!

### Windows
- Download the Simulator_Windows.zip
- Extract the folder on your computer
- Enter the folder Simulator-Windows/Sublime Text 3
- Run the sublime: "sublime_text.exe"
- Go to File - Open File and open the file "memorygame.asm"
- Start the Simulator with the F7 key
- When the Simulator opens, press the home key to start the game

### Linux
- Download the Simulator_Linux.zip
- Extract the folder on your computer
- Follow the tutorial "How_to_install_the_Simulator.txt"

## How to play
- A player tries to match two cards
- Even if the player gets a correct combination, the next one to try is the other player
- The game ends when all the cards are matched
- The winner is the player with the most cards matched

# New processor instruction
We added the instruction "POWN", which calculates the Nth power of a number (Rx <- Ry^Rz)
## defs.h
```c
//defs.h changes:

#define POWN_CODE 100
//----------------------
#define POWN "100110"
//----------------------
#define POWN_STR "POWN"
```
## montador.c
```c
//montador.c changes:

/* ==============
   Pown Rx, Ry, Rz
   ==============
*/

   case POWN_CODE :
      str_tmp1 = parser_GetItem_s();
      val1 = BuscaRegistrador(str_tmp1);
      free(str_tmp1);
      parser_Match(',');
      str_tmp2 = parser_GetItem_s();
      val2 = BuscaRegistrador(str_tmp2);
      free(str_tmp2);
      parser_Match(',');
      str_tmp3 = parser_GetItem_s();
      val3 = BuscaRegistrador(str_tmp3);
      free(str_tmp3);
      str_tmp1 = ConverteRegistrador(val1);
      str_tmp2 = ConverteRegistrador(val2);
      str_tmp3 = ConverteRegistrador(val3);
      sprintf(str_msg,"%s%s%s%s0",POWN,str_tmp1,str_tmp2,str_tmp3);
      free(str_tmp1);
      free(str_tmp2);
      free(str_tmp3);
      parser_Write_Inst(str_msg,end_cnt);
      end_cnt += 1;
      break;

//--------------------------------------------------------------------

else if (strcmp(str_tmp, POWN_STR) == 0)
    {
        return POWN_CODE;
    }

//--------------------------------------------------------------------

case POWN_CODE :
```
## simple_simulator.c
```c
//simple_simulator.c changes:

#define POWN 38     // "100110"; -- POWN Rx Ry Rz  -- Rx <- Ry^Rz

//--------------------------------------------------------------------

case POWN:
    selM3 = ry;
    selM4 = rz;
    OP = POWN;
    carry = IR;
    selM2 = sULA;
    LoadReg[rx] = 1;
    selM6 = sULA;
    LoadFR = 1;
    // -----------------------------
    state = STATE_FETCH;
    break;

//--------------------------------------------------------------------

//pown rx, ry, rz ---> rx = ry^rz
//RX(resultado) RY(x) RZ(y)
        
case POWN:
    result = 1;
    for(int i = 0; i < y; i++) {
        result *= x;
    }
    if(result > MAX_VAL)// Arithmetic overflow
        auxFRbits[ARITHMETIC_OVERFLOW] = 1;
    else
        auxFRbits[ARITHMETIC_OVERFLOW] = 0;
    break;
```

### Useful links
- Eduardo's gitlab: https://gitlab.com/simoesusp/disciplinas
- Video showing the game:

### Team:
- Gustavo Sanches Rossi
- Luis Henrique Hergesel Lima
- Sandy da Costa Dutra
