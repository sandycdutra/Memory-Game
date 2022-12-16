jmp main

;GAME MADE BY:
;Gustavo Sanches Rossi
;Luis Henrique Hergesel de Lima
;Sandy da Costa Dutra

;variables used in the program------------------------------

;stores the user's pressed key
pressedKey: var #1

;indicates if the card has been turned (facing up)
flag0: var #1
flag1: var #1
flag2: var #1
flag3: var #1
flag4: var #1
flag5: var #1
flag6: var #1
flag7: var #1
flag8: var #1
flag9: var #1

;indicates if the pair has been matched
match08: var #1
match17: var #1
match26: var #1
match35: var #1
match49: var #1

;players' scores
scoreP1: var #1
scoreP2: var #1

;total score (how many pairs were matched)
scoreTotal: var #1

main:
	push r0
	push r1
	push r2
	push r3
	push r4
	
	loadn r0, #13 ;loading r0 with the ASCII code for enter

	;printing the game menu	
	loadn r2, #0
	loadn r1, #screen1line1 
	call printScreenOverlap

	;waiting untill the input is enter
	menuLoop:
		call getChar
		load r3, pressedKey
		cmp r3, r0
		jne menuLoop 
	
	call clearScreen

	;printing the tutorial menu
	loadn r2, #0
	loadn r1, #screen2line1 
	call printScreenOverlap
	
	;waiting untill the input is enter
	loopTutorial:
		call getChar
		load r3, pressedKey
		cmp r3, r0
		jne loopTutorial 

	call clearScreen
	
	startGame:
	;starting the game--------------------------
	call resetVariables
    call printTitle
	call printAllFront
	call printScoreboard
	call printScore
	
	;showing the cards for a few seconds
	call longDelay
	call longDelay
	
	;hiding the cards
	call printAllBack

	loopGame:
		call nowPlaying1 ;indicating who's playing
		loadn r6, #1
		
		call getChar
		load r7, pressedKey
		call printFront
		call getChar
		load r7, pressedKey
		call printFront
		call longDelay
		call verifyMatch ;verifying if the two inputs form a match
		call longDelay
		call printBack ;checking if the cards need to be printed backwards or not

		call printScore
		
		;--------------------
		load r3, scoreTotal
		loadn r4, #5
		cmp r3, r4
		jeq endMain
		;--------------------

		call nowPlaying2 ;indicating who's playing
		loadn r6, #2

		call getChar
		load r7, pressedKey
		call printFront
		call getChar
		load r7, pressedKey
		call printFront
		call longDelay
		call verifyMatch
		call longDelay
		call printBack

		call printScore

		;--------------------
		load r3, scoreTotal
		loadn r4, #5
		cmp r3, r4
		jeq endMain
		;--------------------
		
		jmp loopGame

	endMain:
		call clearScreen
		call printResult ;printing the winner
	
	;after the game ends the program checks if the players want to play again
	
	playMGAgain:
		loadn r0, #121 ;loading r0 with the ASCII code for "y"
		call getChar
		load r3, pressedKey
		cmp r3, r0
		jne notplayMGAgain ;if the input is not "y" then check if it's "n"
		
		;if the input is "y" call the game loop
		call clearScreen
		;jmp loopGame
		jmp startGame
		
		notplayMGAgain:
			loadn r0, #110 ;loading r0 with the ASCII code for "n"
			load r3, pressedKey
			cmp r3, r0
			jeq endGame ;if the input is "n" end the program
			call playMGAgain ;if the input is neither "y" nor "n" then check again
	
	endGame:
	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	halt

printFront:
	push r1
	push r2
	push r3
	push r5
	
	loadn r2, #0
	
	loadn r3, #48 ;0 + 48 (turning 0 into it's actual ASCII code)
	
	;cheking if the input is 0
	cmp r3, r7
	jne nextCard1 ;if it's not 0 then check if it's 1
	;if the input is 0 then change the 0 flag to 1 (card facing up)
	load r5, flag0
	inc r5
	store flag0, r5
	call printCard0 ;actually printing the card frontwards
    jmp endPfront ;going to the end because this function only checks one input at a time
    
    ;repeating this process to the other cards
	nextCard1:
		loadn r3, #49 ;1 + 48 (ASCII)

		cmp r3, r7
		jne nextCard2
		load r5, flag1
		inc r5
		store flag1, r5
		call printCard1
        jmp endPfront
	
	nextCard2: 
		loadn r3, #50 ;2 + 48 (ASCII)

		cmp r3, r7
		jne nextCard3
		load r5, flag2
		inc r5
		store flag2, r5
		call printCard2
        jmp endPfront

	nextCard3: 
		loadn r3, #51 ;3 + 48 (ASCII)

		cmp r3, r7
		jne nextCard4
		load r5, flag3
		inc r5
		store flag3, r5
		call printCard3
        jmp endPfront

	nextCard4: 
		loadn r3, #52 ;4 + 48 (ASCII)

		cmp r3, r7
		jne nextCard5
		load r5, flag4
		inc r5
		store flag4, r5
		call printCard4
        jmp endPfront

	nextCard5: 
		loadn r3, #53 ;5 + 48 (ASCII)

		cmp r3, r7
		jne nextCard6
		load r5, flag5
		inc r5
		store flag5, r5
		call printCard5
        jmp endPfront

	nextCard6: 
		loadn r3, #54 ;6 + 48 (ASCII)

		cmp r3, r7
		jne nextCard7
		load r5, flag6
		inc r5
		store flag6, r5
		call printCard6
        jmp endPfront

	nextCard7: 
		loadn r3, #55 ;7 + 48 (ASCII)

		cmp r3, r7
		jne nextCard8
		load r5, flag7
		inc r5
		store flag7, r5
		call printCard7
        jmp endPfront

	nextCard8: 
		loadn r3, #56 ;8 + 48 (ASCII)

		cmp r3, r7
		jne nextCard9
		load r5, flag8
		inc r5
		store flag8, r5
		call printCard8
        jmp endPfront

	nextCard9: 
		loadn r3, #57 ;9 + 48 (ASCII)
		
		cmp r3, r7
		jne endPfront
		load r5, flag9
		inc r5
		store flag9, r5
		call printCard9
        jmp endPfront

	endPfront:
		
	pop r5
	pop r3
	pop r2
	pop r1

	rts

printBack:
	push r0
	push r1
	push r2
	push r3
	
	loadn r2, #0
	
	loadn r0, #0
	load r3, flag0
	cmp r0, r3
	jeq nextVerification1 ;if the card is facing down then it doesn't need to be printed backwards again
	
	;verifying if the card facing up has already been matched
	loadn r0, #1
	load r3, match08
	cmp r0, r3
	jeq nextVerification1 ;if the match has been made the front of the card must be kept facing up
	
	;if the card is facing up but hasn't been matched then it should be printed facing down
	call printCard0back
	;changing the card flag to 0 (facing down)
	load r3, flag0
	dec r3
	store flag0, r3
	
	;repeating this process to the other cards
	nextVerification1:
		loadn r0, #0
		load r3, flag1
		cmp r0, r3
		jeq nextVerification2

		loadn r0, #1
		load r3, match17
		cmp r0, r3
		jeq nextVerification2

		call printCard1back
		load r3, flag1
		dec r3
		store flag1, r3

	nextVerification2:
		loadn r0, #0
		load r3, flag2
		cmp r0, r3
		jeq nextVerification3

		loadn r0, #1
		load r3, match26
		cmp r0, r3
		jeq nextVerification3

		call printCard2back
		load r3, flag2
		dec r3
		store flag2, r3
	
	nextVerification3:
		loadn r0, #0
		load r3, flag3
		cmp r0, r3
		jeq nextVerification4

		loadn r0, #1
		load r3, match35
		cmp r0, r3
		jeq nextVerification4

		call printCard3back
		load r3, flag3
		dec r3
		store flag3, r3
	
	nextVerification4:
		loadn r0, #0
		load r3, flag4
		cmp r0, r3
		jeq nextVerification5

		loadn r0, #1
		load r3, match49
		cmp r0, r3
		jeq nextVerification5

		call printCard4back
		load r3, flag4
		dec r3
		store flag4, r3
	
	nextVerification5:
		loadn r0, #0
		load r3, flag5
		cmp r0, r3
		jeq nextVerification6

		loadn r0, #1
		load r3, match35
		cmp r0, r3
		jeq nextVerification6

		call printCard5back
		load r3, flag5
		dec r3
		store flag5, r3

	nextVerification6:
		loadn r0, #0
		load r3, flag6
		cmp r0, r3
		jeq nextVerification7

		loadn r0, #1
		load r3, match26
		cmp r0, r3
		jeq nextVerification7

		call printCard6back
		load r3, flag6
		dec r3
		store flag6, r3

	nextVerification7:
		loadn r0, #0
		load r3, flag7
		cmp r0, r3
		jeq nextVerification8

		loadn r0, #1
		load r3, match17
		cmp r0, r3
		jeq nextVerification8

		call printCard7back
		load r3, flag7
		dec r3
		store flag7, r3

	nextVerification8:
		loadn r0, #0
		load r3, flag8
		cmp r0, r3
		jeq nextVerification9

		loadn r0, #1
		load r3, match08
		cmp r0, r3
		jeq nextVerification9

		call printCard8back
		load r3, flag8
		dec r3
		store flag8, r3

	nextVerification9:
		loadn r0, #0
		load r3, flag9
		cmp r0, r3
		jeq endPback

		loadn r0, #1
		load r3, match49
		cmp r0, r3
		jeq endPback

		call printCard9back
		load r3, flag9
		dec r3
		store flag9, r3

	endPback:

	pop r3	
	pop r2
	pop r1
	pop r0

	rts

verifyMatch:
	push r0
	push r1
	
	;if the match has already been done then we skip this verification
	loadn r0, #1
	load r1, match08
	cmp r0, r1
	jeq nextCheck1

	loadn r0, #0
	
	load r1, flag0
	cmp r0, r1
	jeq nextCheck1
	
	load r1, flag8
	cmp r0, r1
	jeq nextCheck1
	
	;both 0 and 8 cards are facing up (flag = 1)
	load r1, match08
	inc r1
	store match08, r1 ;match08 = 1
	call increaseScore
	jmp endVerify
	
	;repeating this process to the other matches
	nextCheck1:
		loadn r0, #1
		load r1, match17
		cmp r0, r1
		jeq nextCheck2

		loadn r0, #0

		load r1, flag1
		cmp r0, r1
		jeq nextCheck2

		load r1, flag7
		cmp r0, r1
		jeq nextCheck2
		
		;both 1 and 7 cards are facing up (flag = 1)
		load r1, match17
		inc r1
		store match17, r1 ;match17 = 1
		call increaseScore
		jmp endVerify

	nextCheck2:

		loadn r0, #1
		load r1, match26
		cmp r0, r1
		jeq nextCheck3
	
		loadn r0, #0

		load r1, flag2
		cmp r0, r1
		jeq nextCheck3

		load r1, flag6
		cmp r0, r1
		jeq nextCheck3
		
		;both 2 and 6 cards are facing up (flag = 1)
		load r1, match26
		inc r1
		store match26, r1 ;match26 = 1
		call increaseScore
		jmp endVerify

	nextCheck3:

		loadn r0, #1
		load r1, match35
		cmp r0, r1
		jeq nextCheck4
		
		loadn r0, #0

		load r1, flag3
		cmp r0, r1
		jeq nextCheck4

		load r1, flag5
		cmp r0, r1
		jeq nextCheck4
		
		;both 3 and 5 cards are facing up (flag = 1)
		load r1, match35
		inc r1
		store match35, r1 ;match35 = 1
		call increaseScore
		jmp endVerify

	nextCheck4:

		loadn r0, #1
		load r1, match49
		cmp r0, r1
		jeq endVerify
		
		loadn r0, #0

		load r1, flag4
		cmp r0, r1
		jeq endVerify

		load r1, flag9
		cmp r0, r1
		jeq endVerify
		
		;both 4 and 9 cards are facing up (flag = 1)
		load r1, match49
		inc r1
		store match49, r1 ;match49 = 1
		call increaseScore
		jmp endVerify

	endVerify:

	pop r1
	pop r0
	
	rts

;checks who's playing and increases it's score, then increases the total score
increaseScore:
	push r0

	loadn r0, #2
	cmp r0, r6
	jeq increaseP2

	;if it's not P2 then it's P1 playing
	load r0, scoreP1
	inc r0
	store scoreP1, r0
	jmp endIncScore

	increaseP2:
		load r0, scoreP2
		inc r0
		store scoreP2, r0

	endIncScore:
	
	;increasing the total score
	load r0, scoreTotal
	inc r0
	store scoreTotal, r0

	pop r0

	rts

;prints the box that shows the scores
printScore:

	push r2
	push r3
	push r4

	loadn r2, #48 ;(ASCII)
	
	load r3, scoreP1 ;loading the score
	loadn r4, #1134 ;loading it's position on the screen
	add r3, r3, r2 ;turning the number into it's actual ASCII code
	outchar r3, r4 ;printing the score

	load r3, scoreP2 ;loading the score
	loadn r4, #1155 ;loading it's position on the screen
	add r3, r3, r2 ;turning the number into it's actual ASCII code
	outchar r3, r4 ;printing the score
	
	pop r4
	pop r3
	pop r2

	rts

;prints the game screen
printAllFront:

	call printTitle
	
	call printCard0
	call printCard1
	call printCard2
	call printCard3
	call printCard4
	call printCard5
	call printCard6
	call printCard7
	call printCard8
	call printCard9
	
	call printScoreboard

	rts

;prints all the cards facing down
printAllBack:

	call printCard0back
	call printCard1back
	call printCard2back
	call printCard3back
	call printCard4back
	call printCard5back
	call printCard6back
	call printCard7back
	call printCard8back
	call printCard9back

	rts

;prints the tutorial's screen
showTutorial:
	push r1
	push r2
	
	loadn r2, #0
	loadn r1, #screen2line1 ;tutorial's screen
	call printScreenOverlap
	
	pop r2
	pop r1
	
	rts

;prints whole screens
printScreenOverlap:

	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r0, #0 ;the initial position is the first position of the screen
	loadn r3, #40 ;increasing the position to the next line
	loadn r4, #41 ;increasing the pointer of the lines of the screen
	loadn r5, #1200 ;end of the screen
	loadn r6, #screen0line1	;adress of the first line of the scenario
	
	printScreenOverlap_Loop:
		call printStringOverlap
		add r0, r0, r3 ;going to the next line -> r0 = r0 + 40
		add r1, r1, r4 ;increasing the pointer to the beggining of the next line of the memory -> r1 = r1 + 41 (41 because every string ends with "\0")
		add r6, r6, r4 ;increasing the pointer to the beggining of the next line of the memory -> r1 = r1 + 41 (41 because every string ends with "\0")
		cmp r0, r5 ;compares the r0 to 1200
		jne printScreenOverlap_Loop	;while r0 < 1200

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;used on the printScreenOverlap function
printStringOverlap:
	push r0	
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	
	loadn r3, #'\0' ;end of the string
	loadn r5, #' ' ;blank space

	printStringOverlap_Loop:
		loadi r4, r1
		cmp r4, r3 ;if (Char == '\0') return
		jeq printStringOverlap_Return
		cmp r4, r5 ;if (Char == ' '): jump the outchar of " " not to erase the other characters
		jeq printStringOverlap_Skip
		add r4, r2, r4 ;adds the color code
		outchar r4, r0;printing the character to the screen
		storei r6, r4
	printStringOverlap_Skip:
		inc r0 ;increases screen position
		inc r1 ;increases the string pointer
		inc r6 ;increases the string pointer of screen0
		jmp printStringOverlap_Loop
	
	printStringOverlap_Return:	
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts	

;gets the input from the keyboard
getChar:
	push r1
	push r0
	
	;waiting for a reasonable input
	loadn r1, #255
	recebeCharLoop:
		inchar r0 
		cmp r0, r1
		jeq recebeCharLoop
	
	;storing the input to the pressedKey variable
	store pressedKey, r0 

	pop r0
	pop r1
	
	rts

printString:
	push r0
	push r1
	push r2
	push r3
	push r4
	
	loadn r3, #'\0'	;end of the string

	printStringLoop:	
		loadi r4, r1
		cmp r4, r3
		jeq printStringReturn
		add r4, r2, r4
		outchar r4, r0
		inc r0
		inc r1
		jmp printStringLoop
		
	printStringReturn:	
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

clearScreen:
    push fr
	push r0
	push r1
	
	loadn r0, #1200 ;erases the 1200 positions of the screen
	loadn r1, #' ' ;blank space
	
	clearScreen_Loop: ;label for(r0 = 1200; r3 > 0; r3--)
		dec r0
		outchar r1, r0
		jnz clearScreen_Loop
 
	pop r1
	pop r0
    pop fr
	rts

longDelay:
	push r0
	push r1
	push r2
	
	loadn r0,#0
	loadn r2,#3000

	loopj:
		loadn r1,#0
		loopi:
			inc r1
			cmp r1,r2
			jne loopi
		inc r0
		cmp r0,r2
		jne loopj
		
	pop r2
	pop r1
	pop r0
	
	rts	

;resets all the variables
resetVariables:
	push r0
	
	loadn r0, #0
	store flag0, r0
	store flag1, r0
	store flag2, r0
	store flag3, r0
	store flag4, r0
	store flag5, r0
	store flag6, r0
	store flag7, r0
	store flag8, r0
	store flag9, r0 
	store match08, r0
	store match17, r0
	store match26, r0
	store match35, r0
	store match49, r0
	store scoreP1, r0
	store scoreP2, r0
	store scoreTotal, r0  
	
	pop r0

screen0line1 :  string "                                        "
screen0line2 :  string "                                        "
screen0line3 :  string "                                        "
screen0line4 :  string "                                        "
screen0line5 :  string "                                        "
screen0line6 :  string "                                        "
screen0line7 :  string "                                        "
screen0line8 :  string "                                        "
screen0line9 :  string "                                        "
screen0line10 : string "                                        "
screen0line11 : string "                                        "
screen0line12 : string "                                        "
screen0line13 : string "                                        "
screen0line14 : string "                                        "
screen0line15 : string "                                        "
screen0line16 : string "                                        "
screen0line17 : string "                                        "
screen0line18 : string "                                        "
screen0line19 : string "                                        "
screen0line20 : string "                                        "
screen0line21 : string "                                        "
screen0line22 : string "                                        "
screen0line23 : string "                                        "
screen0line24 : string "                                        "
screen0line25 : string "                                        "
screen0line26 : string "                                        "
screen0line27 : string "                                        "
screen0line28 : string "                                        "
screen0line29 : string "                                        "
screen0line30 : string "                                        "

screen1line1 :  string "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"
screen1line2 :  string "}}                                    }}"
screen1line3 :  string "}                                      }"
screen1line4 :  string "}                                      }"
screen1line5 :  string "}  }   } }}}}} }   } }}}} }}}}  }   }  }"
screen1line6 :  string "}  }} }} }     }} }} }  } }   } }   }  }"
screen1line7 :  string "}  } } } }     } } } }  } }   } }   }  }"
screen1line8 :  string "}  }   } }}}}  }   } }  } }}}}}  } }   }"
screen1line9 :  string "}  }   } }     }   } }  } } }     }    }"
screen1line10 : string "}  }   } }     }   } }  } }  }    }    }"
screen1line11 : string "}  }   } }}}}} }   } }}}} }   }   }    }"
screen1line12 : string "}                                      }"
screen1line13 : string "}         }}}   }}}  }   } }}}}}       }"
screen1line14 : string "}        }   } }   } }} }} }           }"
screen1line15 : string "}        }     }   } } } } }           }"
screen1line16 : string "}        } }}} }}}}} }   } }}}}        }"
screen1line17 : string "}        }   } }   } }   } }           }"
screen1line18 : string "}        }   } }   } }   } }           }"
screen1line19 : string "}         }}}  }   } }   } }}}}}       }"
screen1line20 : string "}                                      }"
screen1line21 : string "}                                      }"
screen1line22 : string "}       ------------------------       }"
screen1line23 : string "}         PRESS ENTER TO START         }"
screen1line24 : string "}       ------------------------       }"
screen1line25 : string "}                                      }"
screen1line26 : string "}                                      }"
screen1line27 : string "}                                      }"
screen1line28 : string "}                                      }"
screen1line29 : string "}}                                    }}"
screen1line30 : string "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"

screen2line1 :  string "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"
screen2line2 :  string "}}                                    }}"
screen2line3 :  string "}                                      }"
screen2line4 :  string "}                                      }"
screen2line5 :  string "}                                      }"
screen2line6 :  string "}             HOW TO PLAY              }"
screen2line7 :  string "}                                      }"
screen2line8 :  string "}                                      }"
screen2line9 :  string "}                                      }"
screen2line10 : string "}                                      }"
screen2line11 : string "}   A PLAYER TRIES TO MATCH 2 CARDS    }"
screen2line12 : string "}                                      }"
screen2line13 : string "}  EVEN IF THE PLAYER GETS A CORRECT   }"
screen2line14 : string "} COMBINATION, THE NEXT ONE TO TRY IS  }"
screen2line15 : string "}          THE OTHER PLAYER            }"
screen2line16 : string "}                                      }"
screen2line17 : string "}   THE GAME ENDS WHEN ALL THE CARDS   }"
screen2line18 : string "}             ARE MATCHED              }"
screen2line19 : string "}                                      }"
screen2line20 : string "}  THE WINNER IS THE PLAYER WITH THE   }"
screen2line21 : string "}         MOST PAIRS MATCHED           }"
screen2line22 : string "}                                      }"
screen2line23 : string "}                                      }"
screen2line24 : string "}                                      }"
screen2line25 : string "}       -------------------------      }"
screen2line26 : string "}        PRESS ENTER TO CONTINUE       }"
screen2line27 : string "}       -------------------------      }"
screen2line28 : string "}                                      }"
screen2line29 : string "}}                                    }}"
screen2line30 : string "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"

memorygamestring : string "MEMORY GAME"

printTitle:
	push r0
	push r1
	push r2
	
	loadn r0, #94 ;start position
    loadn r2, #0 ;selects the color of the string
    
    loadn r1, #memorygamestring
    call printString
    
    pop r2
    pop r1
    pop r0
    
    rts

scoreboard1 : string "]||||||||||||||||SCORE|||||||||||||||||["
scoreboard2 : string "`   PLAYER 1:            PLAYER 2:     `"
scoreboard3 : string "^||||||||||||||||||||||||||||||||||||||_"

printScoreboard:
	push r0
	push r1
	push r2
	push r3
	
	loadn r0, #1080 ;start position
    loadn r3, #40
    loadn r2, #0 ;selects the color of the string
    
    loadn r1, #scoreboard1
    call printString
    add r0, r0, r3           ; Position on the screen where the message will be printed
    loadn r1, #scoreboard2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #scoreboard3
    call printString
    
    pop r3
	pop r2
	pop r1
	pop r0
	
    rts

nowPlaying1 : string "NOW PLAYING: P1"

printNowplaying1:
	push r0
	push r1
	push r2
	
	loadn r0, #1012 ;start position
    loadn r2, #0 ;selects the color of the string
    
    loadn r1, #nowPlaying1
    call printString
    
    pop r2
    pop r1
    pop r0
    
    rts

nowPlaying2 : string "NOW PLAYING: P2"

printNowplaying2:
	push r0
	push r1
	push r2
	
	loadn r0, #1012 ;start position
    loadn r2, #0 ;selects the color of the string
    
    loadn r1, #nowPlaying2
    call printString
    
    pop r2
    pop r1
    pop r0
    
    rts

;front of the cards-------------------------------------------------

card0_1: string "}}}}}}"
card0_2: string "}$}}$}"
card0_3: string "}$}}$}"
card0_4: string "}}$$}}"
card0_5: string "}}$$}}"
card0_6: string "}$}}$}"
card0_7: string "}$}}$}"
card0_8: string "}}}}}}"

printCard0:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #201
    loadn r2, #0 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card0_1
    call printString
    add r0, r0, r3       ; Position on the screen where the message will be printed
    loadn r1, #card0_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card0_3
    call printString
    add r0, r0, r3
    loadn r1, #card0_4
    call printString
    add r0, r0, r3
    loadn r1, #card0_5
    call printString
    add r0, r0, r3
    loadn r1, #card0_6
    call printString
    add r0, r0, r3
    loadn r1, #card0_7
    call printString
    add r0, r0, r3
    loadn r1, #card0_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card1_1: string "}}}}}}"
card1_2: string "}$$$$}"
card1_3: string "}$}}$}"
card1_4: string "}$$}$}"
card1_5: string "}$$}$}"
card1_6: string "}}}}$}"
card1_7: string "}$$$$}"
card1_8: string "}}}}}}"

printCard1:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #209
    loadn r2, #0 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card1_1
    call printString
    add r0, r0, r3       ; Position on the screen where the message will be printed
    loadn r1, #card1_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card1_3
    call printString
    add r0, r0, r3
    loadn r1, #card1_4
    call printString
    add r0, r0, r3
    loadn r1, #card1_5
    call printString
    add r0, r0, r3
    loadn r1, #card1_6
    call printString
    add r0, r0, r3
    loadn r1, #card1_7
    call printString
    add r0, r0, r3
    loadn r1, #card1_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card2_1: string "}}}}}}"
card2_2: string "}$}}$}"
card2_3: string "}}}}}}"
card2_4: string "}}$$}}"
card2_5: string "}}$$}}"
card2_6: string "}}}}}}"
card2_7: string "}$}}$}"
card2_8: string "}}}}}}"

printCard2:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #217
    loadn r2, #0 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card2_1
    call printString
    add r0, r0, r3       ; Position on the screen where the message will be printed
    loadn r1, #card2_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card2_3
    call printString
    add r0, r0, r3
    loadn r1, #card2_4
    call printString
    add r0, r0, r3
    loadn r1, #card2_5
    call printString
    add r0, r0, r3
    loadn r1, #card2_6
    call printString
    add r0, r0, r3
    loadn r1, #card2_7
    call printString
    add r0, r0, r3
    loadn r1, #card2_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card3_1: string "}}}}}}"
card3_2: string "}}$$}}"
card3_3: string "}$$$$}"
card3_4: string "}$}}$}"
card3_5: string "}$}}$}"
card3_6: string "}$$$$}"
card3_7: string "}}$$}}"
card3_8: string "}}}}}}"

printCard3:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #225
    loadn r2, #0 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card3_1
    call printString
    add r0, r0, r3       ; Position on the screen where the message will be printed
    loadn r1, #card3_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card3_3
    call printString
    add r0, r0, r3
    loadn r1, #card3_4
    call printString
    add r0, r0, r3
    loadn r1, #card3_5
    call printString
    add r0, r0, r3
    loadn r1, #card3_6
    call printString
    add r0, r0, r3
    loadn r1, #card3_7
    call printString
    add r0, r0, r3
    loadn r1, #card3_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card4_1: string "}}}}}}"
card4_2: string "}$$$$}"
card4_3: string "}}}}}}"
card4_4: string "}$}}$}"
card4_5: string "}$}}$}"
card4_6: string "}}}}}}"
card4_7: string "}$$$$}"
card4_8: string "}}}}}}"

printCard4:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #233
    loadn r2, #0 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card4_1
    call printString
    add r0, r0, r3       ; Position on the screen where the message will be printed
    loadn r1, #card4_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card4_3
    call printString
    add r0, r0, r3
    loadn r1, #card4_4
    call printString
    add r0, r0, r3
    loadn r1, #card4_5
    call printString
    add r0, r0, r3
    loadn r1, #card4_6
    call printString
    add r0, r0, r3
    loadn r1, #card4_7
    call printString
    add r0, r0, r3
    loadn r1, #card4_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card5_1: string "}}}}}}"
card5_2: string "}}$$}}"
card5_3: string "}$$$$}"
card5_4: string "}$}}$}"
card5_5: string "}$}}$}"
card5_6: string "}$$$$}"
card5_7: string "}}$$}}"
card5_8: string "}}}}}}"

printCard5:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #601
    loadn r2, #0 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card5_1
    call printString
    add r0, r0, r3       ; Position on the screen where the message will be printed
    loadn r1, #card5_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card5_3
    call printString
    add r0, r0, r3
    loadn r1, #card5_4
    call printString
    add r0, r0, r3
    loadn r1, #card5_5
    call printString
    add r0, r0, r3
    loadn r1, #card5_6
    call printString
    add r0, r0, r3
    loadn r1, #card5_7
    call printString
    add r0, r0, r3
    loadn r1, #card5_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card6_1: string "}}}}}}"
card6_2: string "}$}}$}"
card6_3: string "}}}}}}"
card6_4: string "}}$$}}"
card6_5: string "}}$$}}"
card6_6: string "}}}}}}"
card6_7: string "}$}}$}"
card6_8: string "}}}}}}"

printCard6:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #609
    loadn r2, #0 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card6_1
    call printString
    add r0, r0, r3       ; Position on the screen where the message will be printed
    loadn r1, #card6_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card6_3
    call printString
    add r0, r0, r3
    loadn r1, #card6_4
    call printString
    add r0, r0, r3
    loadn r1, #card6_5
    call printString
    add r0, r0, r3
    loadn r1, #card6_6
    call printString
    add r0, r0, r3
    loadn r1, #card6_7
    call printString
    add r0, r0, r3
    loadn r1, #card6_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card7_1: string "}}}}}}"
card7_2: string "}$$$$}"
card7_3: string "}$}}$}"
card7_4: string "}$$}$}"
card7_5: string "}$$}$}"
card7_6: string "}}}}$}"
card7_7: string "}$$$$}"
card7_8: string "}}}}}}"

printCard7:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #617
    loadn r2, #0 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card7_1
    call printString
    add r0, r0, r3       ; Position on the screen where the message will be printed
    loadn r1, #card7_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card7_3
    call printString
    add r0, r0, r3
    loadn r1, #card7_4
    call printString
    add r0, r0, r3
    loadn r1, #card7_5
    call printString
    add r0, r0, r3
    loadn r1, #card7_6
    call printString
    add r0, r0, r3
    loadn r1, #card7_7
    call printString
    add r0, r0, r3
    loadn r1, #card7_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card8_1: string "}}}}}}"
card8_2: string "}$}}$}"
card8_3: string "}$}}$}"
card8_4: string "}}$$}}"
card8_5: string "}}$$}}"
card8_6: string "}$}}$}"
card8_7: string "}$}}$}"
card8_8: string "}}}}}}"

printCard8:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #625
    loadn r2, #0 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card8_1
    call printString
    add r0, r0, r3       ; Position on the screen where the message will be printed
    loadn r1, #card8_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card8_3
    call printString
    add r0, r0, r3
    loadn r1, #card8_4
    call printString
    add r0, r0, r3
    loadn r1, #card8_5
    call printString
    add r0, r0, r3
    loadn r1, #card8_6
    call printString
    add r0, r0, r3
    loadn r1, #card8_7
    call printString
    add r0, r0, r3
    loadn r1, #card8_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card9_1: string "}}}}}}"
card9_2: string "}$$$$}"
card9_3: string "}}}}}}"
card9_4: string "}$}}$}"
card9_5: string "}$}}$}"
card9_6: string "}}}}}}"
card9_7: string "}$$$$}"
card9_8: string "}}}}}}"

printCard9:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #633
    loadn r2, #0 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card9_1
    call printString
    add r0, r0, r3       ; Position on the screen where the message will be printed
    loadn r1, #card9_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card9_3
    call printString
    add r0, r0, r3
    loadn r1, #card9_4
    call printString
    add r0, r0, r3
    loadn r1, #card9_5
    call printString
    add r0, r0, r3
    loadn r1, #card9_6
    call printString
    add r0, r0, r3
    loadn r1, #card9_7
    call printString
    add r0, r0, r3
    loadn r1, #card9_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

;back of the cards-------------------------------------------------

card0back_1: string "}}}}}}"
card0back_2: string "}$$$$}"
card0back_3: string "}$}}$}"
card0back_4: string "}$}}$}"
card0back_5: string "}$}}$}"
card0back_6: string "}$}}$}"
card0back_7: string "}$$$$}"
card0back_8: string "}}}}}}"

printCard0back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #201
    loadn r2, #1536 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card0back_1
    call printString
    add r0, r0, r3           ; Position on the screen where the message will be printed
    loadn r1, #card0back_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card0back_3
    call printString
    add r0, r0, r3
    loadn r1, #card0back_4
    call printString
    add r0, r0, r3
    loadn r1, #card0back_5
    call printString
    add r0, r0, r3
    loadn r1, #card0back_6
    call printString
    add r0, r0, r3
    loadn r1, #card0back_7
    call printString
    add r0, r0, r3
    loadn r1, #card0back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card1back_1: string "}}}}}}"
card1back_2: string "}}}$}}"
card1back_3: string "}}$$}}"
card1back_4: string "}$}$}}"
card1back_5: string "}}}$}}"
card1back_6: string "}}}$}}"
card1back_7: string "}$$$$}"
card1back_8: string "}}}}}}"

printCard1back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #209
    loadn r2, #1536 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card1back_1
    call printString
    add r0, r0, r3           ; Position on the screen where the message will be printed
    loadn r1, #card1back_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card1back_3
    call printString
    add r0, r0, r3
    loadn r1, #card1back_4
    call printString
    add r0, r0, r3
    loadn r1, #card1back_5
    call printString
    add r0, r0, r3
    loadn r1, #card1back_6
    call printString
    add r0, r0, r3
    loadn r1, #card1back_7
    call printString
    add r0, r0, r3
    loadn r1, #card1back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card2back_1: string "}}}}}}"
card2back_2: string "}}$$}}"
card2back_3: string "}$}}$}"
card2back_4: string "}}}}$}"
card2back_5: string "}}}$}}"
card2back_6: string "}}$}}}"
card2back_7: string "}$$$$}"
card2back_8: string "}}}}}}"

printCard2back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #217
    loadn r2, #1536 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card2back_1
    call printString
    add r0, r0, r3           ; Position on the screen where the message will be printed
    loadn r1, #card2back_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card2back_3
    call printString
    add r0, r0, r3
    loadn r1, #card2back_4
    call printString
    add r0, r0, r3
    loadn r1, #card2back_5
    call printString
    add r0, r0, r3
    loadn r1, #card2back_6
    call printString
    add r0, r0, r3
    loadn r1, #card2back_7
    call printString
    add r0, r0, r3
    loadn r1, #card2back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card3back_1: string "}}}}}}"
card3back_2: string "}}$$}}"
card3back_3: string "}$}}$}"
card3back_4: string "}}}$}}"
card3back_5: string "}}}}$}"
card3back_6: string "}$}}$}"
card3back_7: string "}}$$}}"
card3back_8: string "}}}}}}"

printCard3back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #225
    loadn r2, #1536 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card3back_1
    call printString
    add r0, r0, r3           ; Position on the screen where the message will be printed
    loadn r1, #card3back_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card3back_3
    call printString
    add r0, r0, r3
    loadn r1, #card3back_4
    call printString
    add r0, r0, r3
    loadn r1, #card3back_5
    call printString
    add r0, r0, r3
    loadn r1, #card3back_6
    call printString
    add r0, r0, r3
    loadn r1, #card3back_7
    call printString
    add r0, r0, r3
    loadn r1, #card3back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card4back_1: string "}}}}}}"
card4back_2: string "}}}$$}"
card4back_3: string "}}$}$}"
card4back_4: string "}$}}$}"
card4back_5: string "}$$$$}"
card4back_6: string "}}}}$}"
card4back_7: string "}}}}$}"
card4back_8: string "}}}}}}"

printCard4back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #233
    loadn r2, #1536 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card4back_1
    call printString
    add r0, r0, r3           ; Position on the screen where the message will be printed
    loadn r1, #card4back_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card4back_3
    call printString
    add r0, r0, r3
    loadn r1, #card4back_4
    call printString
    add r0, r0, r3
    loadn r1, #card4back_5
    call printString
    add r0, r0, r3
    loadn r1, #card4back_6
    call printString
    add r0, r0, r3
    loadn r1, #card4back_7
    call printString
    add r0, r0, r3
    loadn r1, #card4back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card5back_1: string "}}}}}}"
card5back_2: string "}$$$$}"
card5back_3: string "}$}}}}"
card5back_4: string "}$$$$}"
card5back_5: string "}}}}$}"
card5back_6: string "}$}}$}"
card5back_7: string "}$$$$}"
card5back_8: string "}}}}}}"

printCard5back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #601
    loadn r2, #1536 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card5back_1
    call printString
    add r0, r0, r3           ; Position on the screen where the message will be printed
    loadn r1, #card5back_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card5back_3
    call printString
    add r0, r0, r3
    loadn r1, #card5back_4
    call printString
    add r0, r0, r3
    loadn r1, #card5back_5
    call printString
    add r0, r0, r3
    loadn r1, #card5back_6
    call printString
    add r0, r0, r3
    loadn r1, #card5back_7
    call printString
    add r0, r0, r3
    loadn r1, #card5back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card6back_1: string "}}}}}}"
card6back_2: string "}$$$$}"
card6back_3: string "}$}}$}"
card6back_4: string "}$}}}}"
card6back_5: string "}$$$$}"
card6back_6: string "}$}}$}"
card6back_7: string "}$$$$}"
card6back_8: string "}}}}}}"

printCard6back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #609
    loadn r2, #1536 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card6back_1
    call printString
    add r0, r0, r3           ; Position on the screen where the message will be printed
    loadn r1, #card6back_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card6back_3
    call printString
    add r0, r0, r3
    loadn r1, #card6back_4
    call printString
    add r0, r0, r3
    loadn r1, #card6back_5
    call printString
    add r0, r0, r3
    loadn r1, #card6back_6
    call printString
    add r0, r0, r3
    loadn r1, #card6back_7
    call printString
    add r0, r0, r3
    loadn r1, #card6back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card7back_1: string "}}}}}}"
card7back_2: string "}$$$$}"
card7back_3: string "}}}}$}"
card7back_4: string "}}}}$}"
card7back_5: string "}}}$}}"
card7back_6: string "}}$}}}"
card7back_7: string "}}$}}}"
card7back_8: string "}}}}}}"

printCard7back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #617
    loadn r2, #1536 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card7back_1
    call printString
    add r0, r0, r3           ; Position on the screen where the message will be printed
    loadn r1, #card7back_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card7back_3
    call printString
    add r0, r0, r3
    loadn r1, #card7back_4
    call printString
    add r0, r0, r3
    loadn r1, #card7back_5
    call printString
    add r0, r0, r3
    loadn r1, #card7back_6
    call printString
    add r0, r0, r3
    loadn r1, #card7back_7
    call printString
    add r0, r0, r3
    loadn r1, #card7back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card8back_1: string "}}}}}}"
card8back_2: string "}}$$}}"
card8back_3: string "}$}}$}"
card8back_4: string "}}$$}}"
card8back_5: string "}$}}$}"
card8back_6: string "}$}}$}"
card8back_7: string "}}$$}}"
card8back_8: string "}}}}}}"

printCard8back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #625
    loadn r2, #1536 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card8back_1
    call printString
    add r0, r0, r3           ; Position on the screen where the message will be printed
    loadn r1, #card8back_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card8back_3
    call printString
    add r0, r0, r3
    loadn r1, #card8back_4
    call printString
    add r0, r0, r3
    loadn r1, #card8back_5
    call printString
    add r0, r0, r3
    loadn r1, #card8back_6
    call printString
    add r0, r0, r3
    loadn r1, #card8back_7
    call printString
    add r0, r0, r3
    loadn r1, #card8back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts

card9back_1: string "}}}}}}"
card9back_2: string "}$$$$}"
card9back_3: string "}$}}$}"
card9back_4: string "}$$$$}"
card9back_5: string "}}}}$}"
card9back_6: string "}$}}$}"
card9back_7: string "}$$$$}"
card9back_8: string "}}}}}}"

printCard9back:
	push r0
    push r1
    push r2
    push r3
    
    loadn r0, #633
    loadn r2, #1536 ;selects the color of the string
    loadn r3, #40
    
    loadn r1, #card9back_1
    call printString
    add r0, r0, r3           ; Position on the screen where the message will be printed
    loadn r1, #card9back_2   ; Loads r1 with the adress of the vector that contains the message
    call printString
    add r0, r0, r3
    loadn r1, #card9back_3
    call printString
    add r0, r0, r3
    loadn r1, #card9back_4
    call printString
    add r0, r0, r3
    loadn r1, #card9back_5
    call printString
    add r0, r0, r3
    loadn r1, #card9back_6
    call printString
    add r0, r0, r3
    loadn r1, #card9back_7
    call printString
    add r0, r0, r3
    loadn r1, #card9back_8
    call printString
    
    pop r3
    pop r2
    pop r1
    pop r0
    
    rts
   
finalScreenP1line1 :  string "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"
finalScreenP1line2 :  string "}}                                    }}"
finalScreenP1line3 :  string "}                                      }"
finalScreenP1line4 :  string "}                                      }"
finalScreenP1line5 :  string "}                                      }"
finalScreenP1line6 :  string "}                                      }"
finalScreenP1line7 :  string "}                                      }"
finalScreenP1line8 :  string "}             }}}}       }             }"
finalScreenP1line9 :  string "}             }   }     }}             }"
finalScreenP1line10 : string "}             }   }    } }             }"
finalScreenP1line11 : string "}             }   }   }  }             }"
finalScreenP1line12 : string "}             }}}}       }             }"
finalScreenP1line13 : string "}             }          }             }"
finalScreenP1line14 : string "}             }          }             }"
finalScreenP1line15 : string "}             }          }             }"
finalScreenP1line16 : string "}                                      }"
finalScreenP1line17 : string "}          }     } } }  }  }}          }"
finalScreenP1line18 : string "}          }     } } }  } }            }"
finalScreenP1line19 : string "}           }   }  } }} }  }}          }"
finalScreenP1line20 : string "}           } } }  } } }}    }         }"
finalScreenP1line21 : string "}            } }   } }  }  }}          }"
finalScreenP1line22 : string "}                                      }"
finalScreenP1line23 : string "}                                      }"
finalScreenP1line24 : string "}                                      }"
finalScreenP1line25 : string "}                                      }"
finalScreenP1line26 : string "}           PLAY AGAIN? (y/n)          }"
finalScreenP1line27 : string "}                                      }"
finalScreenP1line28 : string "}                                      }"
finalScreenP1line29 : string "}}                                    }}"
finalScreenP1line30 : string "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"

finalScreenP2line1 :  string "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"
finalScreenP2line2 :  string "}}                                    }}"
finalScreenP2line3 :  string "}                                      }"
finalScreenP2line4 :  string "}                                      }"
finalScreenP2line5 :  string "}                                      }"
finalScreenP2line6 :  string "}                                      }"
finalScreenP2line7 :  string "}                                      }"
finalScreenP2line8 :  string "}             }}}}    }}}              }"
finalScreenP2line9 :  string "}             }   }  }   }             }"
finalScreenP2line10 : string "}             }   }      }             }"
finalScreenP2line11 : string "}             }   }      }             }"
finalScreenP2line12 : string "}             }}}}      }              }"
finalScreenP2line13 : string "}             }        }               }"
finalScreenP2line14 : string "}             }       }                }"
finalScreenP2line15 : string "}             }      }}}}}             }"
finalScreenP2line16 : string "}                                      }"
finalScreenP2line17 : string "}          }     } } }  }  }}          }"
finalScreenP2line18 : string "}          }     } } }  } }            }"
finalScreenP2line19 : string "}           }   }  } }} }  }}          }"
finalScreenP2line20 : string "}           } } }  } } }}    }         }"
finalScreenP2line21 : string "}            } }   } }  }  }}          }"
finalScreenP2line22 : string "}                                      }"
finalScreenP2line23 : string "}                                      }"
finalScreenP2line24 : string "}                                      }"
finalScreenP2line25 : string "}                                      }"
finalScreenP2line26 : string "}           PLAY AGAIN? (y/n)          }"
finalScreenP2line27 : string "}                                      }"
finalScreenP2line28 : string "}                                      }"
finalScreenP2line29 : string "}}                                    }}"
finalScreenP2line30 : string "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"

printResult:
	push r0
	push r1

	load r0, scoreP1
	load r1, scoreP2
	cmp r0, r1
	jgr printP1win
	
	;P2's score is greater
	loadn r2, #0
	loadn r1, #finalScreenP2line1 
	call printScreenOverlap
	jmp endpResult
	
	printP1win: ;P1's score is greater
		loadn r2, #0
		loadn r1, #finalScreenP1line1 
		call printScreenOverlap
	
	endpResult:
	
	pop r1
	pop r0