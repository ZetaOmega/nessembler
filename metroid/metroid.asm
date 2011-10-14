; -------------------
; METROID source code
; -------------------
;-------------------------------[ Defines ]-----------------------------------

#CodePtr                      $0C
#JoyFirst                     $12
#JoyStatus                    $14
#JoyRetrig                    $16
#RetrigDelay                  $18
#NMIStatus                    $1A
#PPUDataPending               $1B
#PalDataPending               $1C
#GameMode                     $1D     ; 0 = Game is playing
                                        ; 1 = At title / password screen
#MainRoutine                  $1E
#TitleRoutine                 $1F
#NextRoutine                  $20
#CurrentBank                  $23
#SwitchPending                $24
#TimerDelay                   $29
#Timer                        $2A
#FrameCount                   $2D     ; number of CPU frames executed
                                        ; (overflows every 256 frames)
#GamePaused                   $31
#RoomPtr                      $33
#StructPtr                    $35

#WRAMWorkPtr                  $37
#WRAMPtr                      $39
#RoomPtrTable                 $3B
#StructPtrTable               $3D
#MacroPtr                     $3F
#EnemyAnimPtr                 $47
#ScrollDir                    $49     ; 0 = Up
                                        ; 1 = Down
                                        ; 2 = Left
                                        ; 3 = Right

#PageIndex                    $4B
#SamusDir                     $4D     ; 0 = Right
                                        ; 1 = Left
#SamusDoorDir                 $4E     ; direction Samus passed through door
#MapPosY                      $4F
#MapPosX                      $50
#SamusScrX                    $51
#SamusScrY                    $52
#WalkSoundDelay               $53
#IsSamus                      $55
#DoorStatus                   $56
#DoorDelay                    $59
#RoomNumber                   $5A
#SpritePagePos                $5B
#ObjectPal                    $67
#RoomPal                      $68
#TempX                        $69
#TempY                        $6A
#SamusBlink                   $70
#PalToggle                    $76
#ScrollY                      $FC
#ScrollX                      $FD
#PPUCNT1ZP                    $FE
#PPUCNT0ZP                    $FF
#HealthLo                     $0106   ; lower health digit in upper 4 bits
#HealthHi                     $0107   ; upper health digit in lower 4 bits
                                        ; # of full tanks in upper 4 bits
#EndTimerLo                   $010A
#EndTimerHi                   $010B
#MissileToggle                $010E   ; 0 = fire bullets, 1 = fire missiles

#SpriteRAM                    $0200

#ObjAction                    $0300
#ObjRadY                      $0301
#ObjRadX                      $0302
#AnimFrame                    $0303
#AnimDelay                    $0304
#AnimResetIndex               $0305
#AnimIndex                    $0306
#SamusOnElevator              $0307   ; 1 = Samus is standing on elevator
#ObjectHi                     $030C
#ObjectY                      $030D
#ObjectX                      $030E

#SamusGravity                 $0314

; Tile respawning

#TileRoutine                  $0500
#TileAnimFrame                $0503
#TileAnimDelay                $0504
#TileAnimIndex                $0506
#TileDelay                    $0507
#TileWRAMLo                   $0508
#TileWRAMHi                   $0509
#TileType                     $050A

#PPUStrIndex                  $07A0
#PPUDataString                $07A1

; bitmask defs used for SamusGear

#gr_BOMBS                     %00000001
#gr_HIGHJUMP                  %00000010
#gr_LONGBEAM                  %00000100
#gr_SCREWATTACK               %00001000
#gr_MARUMARI                  %00010000
#gr_VARIA                     %00100000
#gr_WAVEBEAM                  %01000000
#gr_ICEBEAM                   %10000000

; Samus action handlers

#sa_Stand                     0
#sa_Run                       1
#sa_Jump                      2
#sa_Roll                      3
#sa_PntUp                     4
#sa_Door                      5
#sa_PntJump                   6
#sa_Dead                      7
#sa_Dead2                     8
#sa_Elevator                  9

; Animations

#an_SamusRun                  $00
#an_SamusFront                $04
#an_SamusStand                $07
#an_SamusJump                 $0C
#an_SamusSalto                $0E
#an_SamusRunJump              $13
#an_SamusRoll                 $16
#an_Bullet                    $1B
#an_SamusFireJump             $20
#an_SamusFireRun              $22
#an_SamusPntUp                $27
#an_Explode                   $32
#an_SamusJumpPntUp            $35
#an_SamusRunPntUp             $37
#an_WaveBeam                  $7D
#an_BombTick                  $7F
#an_BombExplode               $82
#an_MissileLeft               $8B
#an_MissileRight              $8D
#an_MissileExplode            $91

; Weapon action handlers

#wa_RegularBeam               1
#wa_WaveBeam                  2
#wa_IceBeam                   3
#wa_BulletExplode             4
#wa_LayBomb                   8
#wa_BombCount                 9
#wa_BombExplode               10
#wa_Missile                   11

#TankCount                    $6877   ; number of energy tanks
#SamusGear                    $6878
#MissileCount                 $6879
#MaxMissiles                  $687A
#SamusAge                     $687D
#JustInBailey                 $69B3   ; 1 = Samus is without suit

#PPUControl0                  $2000
#PPUControl1                  $2001
#PPUStatus                    $2002
#SPRAddress                   $2003
#SPRIOReg                     $2004
#PPUScroll                    $2005
#PPUAddress                   $2006
#PPUIOReg                     $2007
#SPRDMAReg                    $4014
#CPUJoyPad                    $4016

#MMC1Reg0                     $8000
#MMC1Reg1                     $A000
#MMC1Reg2                     $C000
#MMC1Reg3                     $E000

#FramePtrTable                $860B
#PlacePtrTable                $86DF

; Joy pad defs

#btn_RIGHT                    %00000001
#btn_LEFT                     %00000010
#btn_DOWN                     %00000100
#btn_UP                       %00001000
#btn_START                    %00010000
#btn_SELECT                   %00100000
#btn_B                        %01000000       ; FIRE
#btn_A                        %10000000       ; JUMP

#modePlay                     0
#modeTitle                    1

.mapper 1
.rombanks 8
.vrombanks 0
.mirror HORZ
.country NTSC

.bank 0
.loadfile "metbank0"
.bank 1
.loadfile "metbank1"
.bank 2
.loadfile "metbank2"
.bank 3
.loadfile "metbank3"
.bank 4
.loadfile "metbank4"
.bank 5
.loadfile "metbank5"
.bank 6
.loadfile "metbank6"

;----------------------------------[ Code ]-----------------------------------
.bank 7

; The following routine's purpose is unclear...

LC000:  txa
        pha
        ldx #$05
-       lda $2E
        clc
        adc #$05
        sta $2E
        lda $2F
        clc
        adc #$13
        sta $2F
        dex
        bne -
        pla
        tax
        lda $2E
        rts

;-----------------------------------------------------------------------------

        Startup:
        lda #$00
        sta MMC1Reg1    ; clear bit 0
        sta MMC1Reg1    ; clear bit 1
        sta MMC1Reg1    ; clear bit 2
        sta MMC1Reg1    ; clear bit 3
        sta MMC1Reg1    ; clear bit 4
        sta MMC1Reg2    ; clear bit 0
        sta MMC1Reg2    ; clear bit 1
        sta MMC1Reg2    ; clear bit 2
        sta MMC1Reg2    ; clear bit 3
        sta MMC1Reg2    ; clear bit 4
        jsr MMCWriteReg3   ; swap to PRG bank #0 at $8000
        dex             ; X = $FF
        txs             ; S points to end of stack page

; Clear RAM at $000-$7FF

        ldy #$07        ; high byte of start address
        sty $01
        ldy #$00        ; low byte of start address
        sty $00         ; $0000 = #$0700
        tya             ; A = 0
-       sta ($00),y     ; clear address
        iny
        bne -           ; repeat for entire page
        dec $01         ; decrement high byte of address
        bmi +           ; if $01 < 0, all pages are cleared
        ldx $01
        cpx #$01
        bne -

; Clear WRAM at $6000-$7FFF

+       ldy #$7F
        sty $01
        ldy #$00
        sty $00         ; $0000 points to $7F00
        tya             ; A = 0
-       sta ($00),y
        iny
        bne -
        dec $01
        ldx $01
        cpx #$60        ; is address < $6000?
        bcs -           ; if not, do another page

        lda #$0E
        sta $25
        lda #$00
        sta $28
        ldy #$00
        sty ScrollX     ; ScrollX = 0
        sty ScrollY     ; ScrollY = 0
        sty PPUScroll   ; clear hardware scroll x
        sty PPUScroll   ; clear hardware scroll y
        iny             ; Y = 1
        sty GameMode    ; title screen mode
        jsr ClearNameTables
        jsr EraseAllSprites

        lda #%10010000  ; NMI = enabled
                        ; Sprite size = 8x8
                        ; BG pattern table address = $1000
                        ; SPR pattern table address = $0000
                        ; PPU address increment = 1
                        ; Name table address = $2000
        sta PPUControl0
        sta PPUCNT0ZP

        lda #%00000010  ; Sprites visible = no
                        ; Background visible = no
                        ; Sprite clipping = yes
                        ; Background clipping = no
                        ; Display type = color
        sta PPUCNT1ZP

        lda #$47
        sta $FA
        jsr LC4B2
        lda #$00
        sta $4011       ; PCM volume = 0
        lda #$0F
        sta $4015       ; enable sound channel 0,1,2,3
        ldy #$00
        sty TitleRoutine
        sty MainRoutine
        lda #$11
        sta $2E
        lda #$FF
        sta $2F
        iny             ; Y = 1
        sty SwitchPending
        jsr CheckSwitch   ; switch ROM bank #0 into $8000-$BFFF
        bne WaitNMIEnd  ; branch always

;--------------------------------[ Main loop ]--------------------------------

        MainLoop:
        jsr CheckSwitch
        jsr UpdateTimer
        jsr GoMainRoutine
        inc FrameCount
        lda #$00
        sta NMIStatus
        WaitNMIEnd:
        tay
        lda NMIStatus
        bne +           ; if nonzero NMI has ended
        jmp WaitNMIEnd  ; else, keep waiting
+       jsr LC000
        jmp MainLoop

;-------------------------[ Non-Maskable Interrupt ]--------------------------

        NMI:
        php             ; not necessary! sloppy coding indeed ;-)
        pha             ; save A
        txa
        pha             ; save X
        tya
        pha             ; save Y
        lda #$00
        sta SPRAddress  ; Sprite RAM address = 0
        lda #$02
        sta SPRDMAReg   ; transfer page 2 ($200-$2FF) to Sprite RAM
        lda NMIStatus
        bne ++          ; skip if the frame couldn't finish in time
        lda GameMode
        beq +           ; branch if mode=Play
        jsr $9A07
+       jsr CheckPalWrite ; check if palette data pending
        jsr CheckPPUWrite ; check if any other PPU data pending
        jsr WritePPUCtrl ; update $2000 & $2001
        jsr WriteScroll ; update h/v scroll reg
        jsr ReadJoyPads ; read both joypads
++      jsr $B3B4       ; music player
        jsr UpdateAge   ; update Samus' age
        ldy #$01        ; NMI = finished
        sty NMIStatus
        pla
        tay             ; restore Y
        pla
        tax             ; restore X
        pla             ; restore A
        plp
        rti

;-----------------------------------------------------------------------------

; GoMainRoutine
; =============
; This is where the real code of each frame is executed.
; MainRoutine or TitleRoutine (Depending on the value of GameMode)
; is used as an index into a code pointer table, and this routine
; is executed.

        GoMainRoutine:
        lda GameMode
        beq +           ; branch if mode=Play
        jmp $8000       ; jump to $8000, where a routine similar to the one
                        ; below is executed, only using TitleRoutine instead
                        ; of MainRoutine as index into a jump table.
+       lda JoyFirst
        and #btn_START  ; has START been pressed?
        beq +++         ; if not, execute current routine as normal
        lda MainRoutine
        cmp #$03        ; game engine running?
        beq +           ; if yes, switch to routine #5 (pause game)
        cmp #$05        ; game paused?
        bne +++         ; if not routine #5 either, don't give a damn about START being pressed
        lda #$03        ; otherwise, switch to routine #3 (game engine)
        bne ++          ; branch always
+       lda #$05        ; switch to pause routine
++      sta MainRoutine
        lda GamePaused
        eor #$01
        sta GamePaused
        jsr PauseMusic
+++     lda MainRoutine
        jsr GoRoutine

; Pointer table to code

        .dw AreaInit    ; area init
        .dw LC81D       ; more area init
        .dw SamusInit   ; samus init
        .dw GameEngine  ; game engine
        .dw EndGame     ; game over / password display
        .dw PauseMode   ; pause
        .dw GoPassword  ; direct password display
        .dw LC155       ; just advances to next routine in table
        .dw SamusIntro  ; intro
        .dw WaitTimer   ; delay

LC155:  inc MainRoutine
        rts

; ClearNameTables
; ===============

        ClearNameTables:
        jsr +++
        lda GameMode
        beq +           ; branch if mode=Play
        lda TitleRoutine
        cmp #$1D
        beq ++
+       lda #$02
        bne +
++      lda #$03
        bne +
+++     lda #$01
+       sta $01         ; name table to fill
        lda #$FF
        sta $00         ; value to fill with
        ClearNameTable:
        ldx PPUStatus
        lda PPUCNT0ZP
        and #$FB        ; PPU increment = 1
        sta PPUCNT0ZP
        sta PPUControl0
        ldx $01
        dex
        lda HiPPUTable,x     ; get high PPU address
        sta PPUAddress
        lda #$00
        sta PPUAddress
        ldx #$04        ; prepare to fill 4 pages
        ldy #$00        ; reset page address
        lda $00         ; fill-value
-       sta PPUIOReg
        dey
        bne -
        dex
        bne -
        rts

HiPPUTable
      .db $20,$24,$28,$2C

        EraseAllSprites:
        ldy #$02
        sty $01
        ldy #$00
        sty $00
        ldy #$00
        lda #$F0
-       sta ($00),y
        iny
        bne -
        lda GameMode
        beq Exit1       ; branch if mode=Play
        jmp $988A
Exit1:  rts

LC1BC:  ldy #$02
        sty $01
        ldy #$00
        sty $00         ; ($00) = $0200 (sprite page)
        ldy #$5F        ; prepare to clear RAM $0200-$025F
        lda #$F4
-       sta ($00),y
        dey
        bpl -
        lda GameMode
        beq Exit1       ; branch if mode=Play
        jmp $988A

; clear RAM $33-$DF

        ClearRAM_33_DF:
        ldx #$33
        lda #$00
-       sta $00,x
        inx
        cpx #$E0
        bcc -
        rts

        CheckPalWrite:
        lda GameMode
        beq +           ; branch if mode=Play
        lda TitleRoutine
        cmp #$1D
        bcc +
        jmp $9F54
+       ldy PalDataPending
        bne ++          ; if non-zero, need to update palette
        lda GameMode
        beq +           ; branch if mode=Play
        lda TitleRoutine
        cmp #$15
        bcs +
        jmp $8AC7
+       rts

; write palette data to PPU

++      dey             ; pal # = PalDataPending - 1
        tya
        asl a           ; * 2, each pal data ptr is 2 bytes (16-bit)
        tay
        ldx $9560,y     ; X = low byte of PPU data pointer
        lda $9561,y     ; A = high byte of PPU data pointer
        tay
        lda #$00
        sta PalDataPending
        stx $00
        sty $01         ; $0000 = pointer to PPU data string
        jmp ProcessPPUString   ; write data string to PPU

; Read joypads

        ReadJoyPads:
        ldx #$00
        stx $01
        jsr ReadOnePad
        inx
        inc $01

        ReadOnePad:
        ldy #$01
        sty CPUJoyPad   ; reset strobe
        dey
        sty CPUJoyPad   ; clear strobe
        ldy #$08        ; do 8 buttons
-       pha
        lda CPUJoyPad,x ; read button status
        sta $00
        lsr a
        ora $00
        lsr a
        pla
        rol a
        dey             ; done 8 buttons yet?
        bne -           ; if not, do another
        ldx $01         ; joypad # (0..1)
        ldy JoyStatus,x ; get joystat of previous refresh
        sty $00         ; store
        sta JoyStatus,x ; store new joystat
        eor $00
        beq +           ; branch if no buttons changed
        lda $00
        and #$BF
        sta $00
        eor JoyStatus,x
+       and JoyStatus,x
        sta JoyFirst,x
        sta JoyRetrig,x
        ldy #$20
        lda JoyStatus,x
        cmp $00
        bne +
        dec RetrigDelay,x
        bne ++
        sta JoyRetrig,x
        ldy #$08
+       sty RetrigDelay,x
++      rts

; UpdateTimer
; ===========
; This routine is used for timing - or for waiting around, rather.
; TimerDelay is decremented every frame. When it hits zero, $2A, $2B and $2C are
; decremented if they aren't already zero. The program can then check
; these variables (it usually just checks $2C) to determine when it's time
; to "move on". This is used for the various sequences of the intro screen,
; when the game is started, when Samus takes a special item, and when GAME
; OVER is displayed, to mention a few examples.

        UpdateTimer:
        ldx #$01
        dec TimerDelay
        bpl DecTimer
        lda #$09
        sta TimerDelay
        ldx #$02
        DecTimer:
        lda Timer,x
        beq +           ; don't decrease if it's already zero
        dec Timer,x
+       dex
        bpl DecTimer
        rts

; GoRoutine
; =========
; This is an indirect jump routine. A is used as an index into a code
; pointer table, and the routine at that position is executed. The programmers
; always put the pointer table itself directly after the JSR to GoRoutine,
; meaning that its address can be popped from the stack... Man, this is
; clever. :)

        GoRoutine:
        asl a           ; * 2, each ptr is 2 bytes (16-bit)
        sty TempY       ; temp storage
        stx TempX       ; temp storage
        tay
        iny
        pla             ; lo byte of ptr table address
        sta CodePtr
        pla             ; hi byte of ptr table address
        sta CodePtr+1
        lda (CodePtr),y     ; lo byte of code ptr
        tax
        iny
        lda (CodePtr),y     ; hi byte of code ptr
        sta CodePtr+1
        stx CodePtr
        ldx TempX       ; restore X
        ldy TempY       ; restore Y
        jmp (CodePtr)

; Write to scroll registers

        WriteScroll:
        lda PPUStatus   ; reset scroll register flip/flop
        lda ScrollX
        sta PPUScroll
        lda ScrollY
        sta PPUScroll
        rts

; Add Y to pointer at $0000

        AddYToPtr00:
        tya
        clc
        adc $00
        sta $00
        bcc +
        inc $01
+       rts

; Add Y to pointer at $0002

LC2B3:  tya
        clc
        adc $02
        sta $02
        bcc +
        inc $03
+       rts

Adiv32: lsr a
Adiv16: lsr a
Adiv8:  lsr a
        lsr a
        lsr a
        rts

Amul32: asl a
Amul16: asl a
Amul8:  asl a
        asl a
        asl a
        rts

; CheckPPUWrite
; =============
; Checks if any data is waiting to be written to the PPU.

        CheckPPUWrite:
        lda PPUDataPending
        beq +           ; if zero no PPU data to write, exit
        lda #[<PPUDataString]
        sta $00
        lda #[>PPUDataString]
        sta $01         ; $0000 = ptr to PPU data string ($07A1)
        jsr ProcessPPUString    ; write it to PPU!
        lda #$00
        sta PPUStrIndex
        sta PPUDataString
        sta PPUDataPending
+       rts

        PPUWrite:
        sta PPUAddress  ; set high PPU address
        iny
        lda ($00),y
        sta PPUAddress  ; set low PPU address
        iny
        lda ($00),y     ; get data byte containing rep length & RLE status
        asl a           ; CF = PPU address increment (0 = 1, 1 = 32)
        jsr SetPPUInc   ; update PPUCtrl0 according to CF
        asl a           ; CF = bit 6 of byte at ($00),y (1 = RLE)
        lda ($00),y     ; get data byte again
        and #$3F        ; keep lower 6 bits as loop counter
        tax
        bcc PPUWriteLoop ; if CF not set, the data is not RLE
        iny             ; data is RLE, advance to data byte
        PPUWriteLoop:
        bcs +
        iny             ; only inc Y if data is not RLE
+       lda ($00),y     ; get data byte
        sta PPUIOReg    ; write to PPU
        dex             ; decrease loop counter
        bne PPUWriteLoop ; keep going until X=0
        iny
        jsr AddYToPtr00 ; point to next data chunk

; ProcessPPUString
; ================
; write data string at ($00) to PPU

        ProcessPPUString:
        ldx PPUStatus   ; reset PPU addr flip/flop
        ldy #$00
        lda ($00),y
        bne PPUWrite    ; if A is non-zero, PPU data string follows
        jmp WriteScroll ; otherwise we're done

; In: CF = desired PPU address increment (0 = 1, 1 = 32)
; Out: PPU control #0 ($2000) updated accordingly

        SetPPUInc:
        pha             ; preserve A
        lda PPUCNT0ZP
        ora #$04        ; PPU increment = 32
        bcs +           ; only if CF set
        and #$FB        ; else PPU increment = 1
+       sta PPUControl0
        sta PPUCNT0ZP
        pla             ; restore A
        rts

; erase blasted tile on nametable

LC328:  ldy #$01
        sty PPUDataPending      ; data pending = YES
        dey
        lda ($02),y
        and #$0F
        sta $05         ; # of tiles horizontally
        lda ($02),y
        jsr Adiv16      ; / 16
        sta $04         ; # of tiles vertically
        ldx PPUStrIndex
--      lda $01
        jsr WritePPUByte        ; write PPU high address to $07A1
        lda $00
        jsr WritePPUByte        ; write PPU low address to $07A2
        lda $05         ; data length
        sta $06
        jsr WritePPUByte        ; write data length to $07A3
-       iny
        lda ($02),y     ; get data byte
        jsr WritePPUByte        ; write it to $07A1,x , inc x
        dec $06
        bne -
        stx PPUStrIndex
        sty $06
        ldy #$20
        jsr AddYToPtr00
        ldy $06
        dec $04
        bne --
        jsr EndPPUString

        WritePPUByte:
        sta PPUDataString,x
        NextPPUByte:
        inx
        cpx #$4F
        bcc +
        ldx PPUStrIndex
        EndPPUString:
        lda #$00
        sta PPUDataString,x
        pla
        pla
+       rts

LC37E:  ldy #$01
        sty PPUDataPending
        dey
        beq ++          ; branch always
-       sta $04
        lda $01
        jsr WritePPUByte
        lda $00
        jsr WritePPUByte
        lda $04
        jsr LC3C6
        bit $04
        bvc LC39B
        iny
LC39B:  bit $04
        bvs +
        iny
+       lda ($02),y
        jsr WritePPUByte
        sty $06
        ldy #$01
        bit $04
        bpl +
        ldy #$20
+       jsr AddYToPtr00
        ldy $06
        dec $05
        bne LC39B
        stx PPUStrIndex
        iny
++      ldx PPUStrIndex
        lda ($02),y
        bne -
        jsr EndPPUString

LC3C6:  sta $04
        and #$BF
        sta PPUDataString,x
        and #$3F
        sta $05
        jmp NextPPUByte

; GetAbsolute
; ===========

        GetAbsolute:
        eor #$FF
        clc
        adc #$01
        rts

LC3DA:  jsr LC41D
        adc $01
        cmp #$0A
        bcc +
        adc #$05
+       clc
        adc $02
        sta $02
        lda $03
        and #$F0
        adc $02
        bcc +
-       adc #$5F
        sec
        rts
+       cmp #$A0
        bcs -
        rts

LC3FB:  jsr LC41D
        sbc $01
        sta $01
        bcs +
        adc #$0A
        sta $01
        lda $02
        adc #$0F
        sta $02
+       lda $03
        and #$F0
        sec
        sbc $02
        bcs +
        adc #$A0
        clc
+       ora $01
        rts

LC41D:  pha
        and #$0F
        sta $01
        pla
        and #$F0
        sta $02
        lda $03
        and #$0F
        rts

; WaitNMIPass
; ===========
; Wait for the NMI to end.

        WaitNMIPass:    ; $C42C
        jsr ClearNMIStat
-       lda NMIStatus
        beq -
        rts

        ClearNMIStat:
        lda #$00
        sta NMIStatus
        rts

; ScreenOff
; =========

        ScreenOff:
        lda PPUCNT1ZP
        and #$E7        ; BG & SPR visibility = off
--      sta PPUCNT1ZP
        WaitNMIPass_:
        jsr ClearNMIStat
-       lda NMIStatus
        beq -
        rts

; ScreenOn
; ========

        ScreenOn:
        lda PPUCNT1ZP
        ora #$1E        ; BG & SPR visibility = on
        bne --          ; branch always

; WritePPUCtrl
; ============
; Update the actual PPU control registers.

        WritePPUCtrl:
        lda PPUCNT0ZP
        sta PPUControl0
        lda PPUCNT1ZP
        sta PPUControl1
        lda $FA
        jsr LC4D9
        ExitSub:
        rts

; ScreenNmiOff
; ============
; Turn off both screen and NMI.

        ScreenNmiOff:
        lda PPUCNT1ZP
        and #$E7        ; BG & SPR visibility = off
        jsr --
        lda PPUCNT0ZP
        and #$7F        ; NMI = off
        sta PPUCNT0ZP
        sta PPUControl0
        rts

LC46E:  lda PPUCNT0ZP   ; Nmi&ScreenOn
        ora #$80
        sta PPUCNT0ZP
        sta PPUControl0
        lda PPUCNT1ZP
        ora #$1E
        bne --

LC47D:  lda PPUCNT0ZP
        and #$7B
-       sta PPUControl0
        sta PPUCNT0ZP
        rts

; NmiOn
; =====

        NmiOn:
        lda PPUStatus
        and #$80
        bne NmiOn
        lda PPUCNT0ZP
        ora #$80
        bne -           ; branch always

; WaitTimer
; =========

        WaitTimer:
        lda Timer+2
        bne +       ; exit if timer hasn't hit zero yet
        lda NextRoutine
        cmp #$04    ; EndGame
        beq SetMainRoutine
        cmp #$06    ; GoPassword
        beq SetMainRoutine
        jsr LD92C       ; start area music
        lda NextRoutine
        SetMainRoutine:
        sta MainRoutine
+       rts

; SetTimer
; ========

        SetTimer:
        sta Timer+2
        stx NextRoutine
        lda #$09        ; WaitTimer
        bne SetMainRoutine   ; branch always

LC4B2:  nop
        nop
        lda #$47
LC4B6:  lsr a
        lsr a
        lsr a
        and #$01
        sta $00
        lda $25
        and #$FE
        ora $00
        sta $25
        sta MMC1Reg0
        lsr a
        sta MMC1Reg0
        lsr a
        sta MMC1Reg0
        lsr a
        sta MMC1Reg0
        lsr a
        sta MMC1Reg0
        rts

LC4D9:  lda $FA
        jmp LC4B6

; CheckSwitch
; ===========
; This is how the bank switching works... Every frame, the routine below
; is executed. First, it checks the value of SwitchPending. If it is zero,
; the routine will simply exit. If it is non-zero, it means that a bank
; switch has been issued, and must be performed. SwitchPending then contains
; the bank to switch to, plus one.

        CheckSwitch:
        ldy SwitchPending
        beq +           ; exit if zero (no bank switch issued)
                        ; otherwise, Y contains bank# + 1
        jsr SwitchOK    ; perform bank switch
        jmp GoBankInit

        SwitchOK:
        lda #$00
        sta SwitchPending   ; reset (so that the bank switch won't be
                        ; performed every succeeding frame too)
        dey             ; Y now contains the bank to switch to
        sty CurrentBank

        ROMSwitch:
        tya
        sta $00
        lda $28
        and #$18
        ora $00
        sta $28

        MMCWriteReg3:
        sta MMC1Reg3       ; write bit 0 of ROM bank #
        lsr a
        sta MMC1Reg3       ; write bit 1 of ROM bank #
        lsr a
        sta MMC1Reg3       ; write bit 2 of ROM bank #
        lsr a
        sta MMC1Reg3       ; write bit 3 of ROM bank #
        lsr a
        sta MMC1Reg3       ; write bit 4 of ROM bank #
        lda $00
+       rts

; GoBankInit
; ==========
; Calls the proper routine according to the bank number in A.

        GoBankInit:
        asl a
        tay
        lda BankInitTable,y
        sta $0A
        lda BankInitTable+1,y
        sta $0B
        jmp ($000A)

        BankInitTable:
        .dw InitBank0
        .dw InitBank1
        .dw InitBank2
        .dw InitBank3
        .dw InitBank4
        .dw InitBank5
        .dw ExitSub       ; rts
        .dw ExitSub       ; rts
        .dw ExitSub       ; rts

; "Title screen" bank

        InitBank0:
        ldy #$00
        sty GamePaused
        iny
        sty GameMode    ; mode=Title
        jsr ScreenNmiOff
        jsr $A93E       ; copy game map from ROM to WRAM $7000-$73FF
        jsr ClearNameTables
        ldy #$A0
-       lda $98BF,y
        sta $6DFF,y
        dey
        bne -
        jsr InitTitleGFX
        jmp NmiOn

; Brinstar bank

        InitBank1:
        lda #modePlay
        sta GameMode
        jsr ScreenNmiOff
        lda MainRoutine
        cmp #$03
        beq +
        lda #$00
        sta MainRoutine
        sta $74
        sta GamePaused
        jsr ClearRAM_33_DF
        jsr ClearRAM_100_10F
+       ldy #$00
        jsr ROMSwitch
        jsr InitBrinstarGFX
        jmp NmiOn

; clear RAM $100-$10F

        ClearRAM_100_10F:
        ldy #$0F
        lda #$00
-       sta $0100,y
        dey
        bpl -
        rts

; Norfair bank

        InitBank2:
        lda #modePlay
        sta GameMode
        jsr ScreenNmiOff
        jsr InitNorfairGFX
        jmp NmiOn

; Tourian bank

        InitBank3:
        lda #modePlay
        sta GameMode
        jsr ScreenNmiOff
        ldy #$0D
-       lda Table00,y
        sta $77F0,y
        dey
        bpl -
        jsr InitTourianGFX
        jmp NmiOn

; Table used by above subroutine

Table00
        .db $F8
        .db $08
        .db $30
        .db $D0
        .db $60
        .db $A0
        .db $02
        .db $04
        .db $00
        .db $00
        .db $00
        .db $00
        .db $00
        .db $00

; Kraid bank

        InitBank4:
        lda #modePlay
        sta GameMode
        jsr ScreenNmiOff
        jsr InitKraidGFX
        jmp NmiOn

; Ridley bank

        InitBank5:
        lda #modePlay
        sta GameMode
        jsr ScreenNmiOff
        jsr InitRidleyGFX
        jmp NmiOn

LC5D0:  lda #modeTitle
        sta GameMode
        jmp InitGFX6

        InitTitleGFX:
        ldy #$15
        jsr LoadGFX
        ldy #$00
        jsr LoadGFX
        lda JustInBailey
        beq +           ; branch if wearing suit
        ldy #$1B
        jsr LoadGFX     ; switch to girl gfx
+       ldy #$14
        jsr LoadGFX
        ldy #$17
        jsr LoadGFX
        ldy #$18
        jsr LoadGFX
        ldy #$19
        jsr LoadGFX
        ldy #$16
        jmp LoadGFX

        InitBrinstarGFX:
        ldy #$03
        jsr LoadGFX
        ldy #$04
        jsr LoadGFX
        ldy #$05
        jsr LoadGFX
        ldy #$06
        jsr LoadGFX
        ldy #$19
        jsr LoadGFX
        ldy #$16
        jmp LoadGFX

        InitNorfairGFX:
        ldy #$04
        jsr LoadGFX
        ldy #$05
        jsr LoadGFX
        ldy #$07
        jsr LoadGFX
        ldy #$08
        jsr LoadGFX
        ldy #$09
        jsr LoadGFX
        ldy #$19
        jsr LoadGFX
        ldy #$16
        jmp LoadGFX

        InitTourianGFX:
        ldy #$05
        jsr LoadGFX
        ldy #$0A
        jsr LoadGFX
        ldy #$0B
        jsr LoadGFX
        ldy #$0C
        jsr LoadGFX
        ldy #$0D
        jsr LoadGFX
        ldy #$0E
        jsr LoadGFX
        ldy #$1A
        jsr LoadGFX
        ldy #$1C
        jsr LoadGFX
        ldy #$19
        jsr LoadGFX
        ldy #$16
        jmp LoadGFX

        InitKraidGFX:
        ldy #$04
        jsr LoadGFX
        ldy #$05
        jsr LoadGFX
        ldy #$0A
        jsr LoadGFX
        ldy #$0F
        jsr LoadGFX
        ldy #$10
        jsr LoadGFX
        ldy #$11
        jsr LoadGFX
        ldy #$19
        jsr LoadGFX
        ldy #$16
        jmp LoadGFX

        InitRidleyGFX:
        ldy #$04
        jsr LoadGFX
        ldy #$05
        jsr LoadGFX
        ldy #$0A
        jsr LoadGFX
        ldy #$12
        jsr LoadGFX
        ldy #$13
        jsr LoadGFX
        ldy #$19
        jsr LoadGFX
        ldy #$16
        jmp LoadGFX

        InitGFX6:
        ldy #$01
        jsr LoadGFX
        ldy #$02
        jsr LoadGFX
        ldy #$19
        jsr LoadGFX
        ldy #$16
        jmp LoadGFX

        InitGFX7:
        ldy #$17
        jsr LoadGFX
        ldy #$16
        jmp LoadGFX

; The table below contains info for each tile data block in the ROM.
; Each entry is 7 bytes long. The format is as follows:

; byte 0: ROM bank where GFX data is located.
; byte 1-2: 16-bit ROM start address (src)
; byte 3-4: 16-bit PPU start address (dest)
; byte 5-6: data length (16-bit)

GFXInfo
        .db $06 : .dw $8000, $0000, $09A0       ; [SPR] Samus, items
        .db $04 : .dw $8D60, $0000, $0520       ; [SPR] Samus in ending
        .db $01 : .dw $8D60, $1000, $0400       ; [BGR] Partial font, "The End"
        .db $06 : .dw $9DA0, $1000, $0150
        .db $05 : .dw $8D60, $1200, $0450
        .db $06 : .dw $9EF0, $1800, $0800
        .db $01 : .dw $9160, $0C00, $0400       ; [SPR] Brinstar enemies
        .db $06 : .dw $A6F0, $1000, $0260
        .db $06 : .dw $A950, $1700, $0070
        .db $02 : .dw $8D60, $0C00, $0400       ; [SPR] Norfair enemies
        .db $06 : .dw $A9C0, $1000, $02E0
        .db $06 : .dw $ACA0, $1200, $0600
        .db $06 : .dw $B2A0, $1900, $0090
        .db $05 : .dw $91B0, $1D00, $0300
        .db $02 : .dw $9160, $0C00, $0400       ; [SPR] Tourian enemies
        .db $06 : .dw $B330, $1700, $00C0
        .db $04 : .dw $9360, $1E00, $0200
        .db $03 : .dw $8D60, $0C00, $0400       ; [SPR] Miniboss I enemies
        .db $06 : .dw $B3F0, $1700, $00C0
        .db $03 : .dw $9160, $0C00, $0400       ; [SPR] Miniboss II enemies
        .db $06 : .dw $89A0, $0C00, $0100
        .db $06 : .dw $8BE0, $1400, $0500       ; [BGR] Title
        .db $06 : .dw $9980, $1FC0, $0040
        .db $06 : .dw $B4C0, $1000, $0400       ; [BGR] Complete font
        .db $06 : .dw $B4C0, $0A00, $00A0
        .db $06 : .dw $9980, $0FC0, $0040
        .db $06 : .dw $B4C0, $1D00, $02A0
        .db $06 : .dw $90E0, $0000, $07B0       ; [SPR] Suitless Samus
        .db $06 : .dw $9890, $1F40, $0010

; LoadGFX
; =======
; Y contains the GFX header to fetch from the table above, GFXInfo.

        LoadGFX:
        lda #$FF
-       clc
        adc #$07        ; each header is 7 bytes
        dey             ; advanced to the (end of the) desired header?
        bpl -           ; if not, advance to the next
        tay             ; Y is now the index into GFXInfo table (see above)

; Copy header from ROM to $00-$06

        ldx #$06
-       lda GFXInfo,y
        sta $00,x
        dey
        dex
        bpl -

        ldy $00         ; ROM bank containing the GFX data
        jsr ROMSwitch   ; switch to that bank
        lda PPUCNT0ZP
        and #$FB        ; PPU increment = 1
        sta PPUCNT0ZP
        sta PPUControl0
        jsr CopyGFXBlock
        ldy CurrentBank
        jmp ROMSwitch   ; switch back to the "old" bank

; CopyGFXBlock
; =============
; Writes tile data from ROM to VRAM, according to the gfx header data
; contained in $00-$06.

        CopyGFXBlock:
        lda $05
        bne GFXCopyLoop
        dec $06
        GFXCopyLoop:
        lda $04
        sta PPUAddress
        lda $03
        sta PPUAddress
        ldy #$00
-       lda ($01),y
        sta PPUIOReg
        dec $05
        bne +
        lda $06
        beq ++
        dec $06
+       iny
        bne -
        inc $02
        inc $04
        jmp GFXCopyLoop
++      rts

; AreaInit
; ========

        AreaInit:
        lda #$00
        sta ScrollX     ; Clear ScrollX
        sta ScrollY     ; Clear ScrollY
        lda PPUCNT0ZP
        and #$FC        ; nametable address = $2000
        sta PPUCNT0ZP
        inc MainRoutine
        lda JoyStatus
        and #$C0
        sta $F0         ; ???
        jsr EraseAllSprites
        lda #$10
        jsr LCA18
LC81D:  ldy #$01
        sty PalDataPending
        ldx #$FF
        stx $75
        inx             ; X = 0
        stx $6883
        stx DoorStatus
        stx $58
        stx $71
        txa             ; A = 0
-       cpx #$65
        bcs +
        sta $7A,x
+       cpx #$FF
        bcs +
        sta ObjAction,x
+       inx
        bne -
        jsr ScreenOff
        jsr ClearNameTables
        jsr EraseAllSprites
        jsr DestroyEnemies
        stx $6C
        stx $6D
        inx
        stx $30
        inx
        stx ScrollDir
        lda $95D7       ; Get start x pos on map
        sta MapPosX
        lda $95D8       ; Get start y pos on map
        sta MapPosY
        lda $95DA       ; Get ??? Something to do with palette switch
        sta PalToggle
        lda #$FF
        sta RoomNumber  ; room number = $FF (invalid)
        jsr CopyPtrs    ; copy pointers from ROM to ZP
        jsr GetRoomNum  ; put room # at current map pos in $5A
-       jsr SetupRoom
        ldy RoomNumber  ; load room number
        iny
        bne -

        ldy WRAMPtr+1
        sty $01
        ldy WRAMPtr
        sty $00
        lda PPUCNT0ZP
        and #$FB        ; PPU increment = 1
        sta PPUCNT0ZP
        sta PPUControl0
        ldy PPUStatus   ; reset PPU addr flip/flop

; Copy WRAM Name Table #0 ($6000) to PPU Name Table #0 ($2000)

        ldy #$20
        sty PPUAddress
        ldy #$00
        sty PPUAddress
        ldx #$04        ; prepare to write 4 pages
-       lda ($00),y
        sta PPUIOReg
        iny
        bne -
        inc $01
        dex
        bne -

        stx $91
        inx             ; X = 1
        stx PalDataPending
        stx $30
        inc MainRoutine
        jmp ScreenOn

; CopyPtrs
; ========
; Copy 7 16-bit pointers at $959A to $3B

        CopyPtrs:
        ldx #$0D
-       lda $959A,x
        sta $3B,x
        dex
        bpl -
        rts

; DestroyEnemies
; ==============

        DestroyEnemies:
        lda #$00
        tax
-       cpx #$48
        bcs +
        sta $97,x
+       sta $6AF4,x
        pha
        pla
        inx
        bne -
        stx $92
        jmp $95AB

; SamusInit
; =========
; Code that sets up Samus, when the game is first started

        SamusInit:
        lda #$08
        sta MainRoutine ; intro will be executed next frame
        lda #$2C        ; Number of time units it takes to "beam down" Samus
        sta Timer+2
        jsr IntroMusic  ; start the intro music
        ldy #$14
        sty ObjAction
        ldx #$00
        stx SamusBlink
        dex             ; X = $FF
        stx $0728
        stx $0730
        stx $0732
        stx $0738
        stx EndTimerLo
        stx EndTimerHi
        stx $8B
        stx $8E
        ldy #$27
        lda $74
        and #$0F
        beq +           ; branch if Samus not in Brinstar
        lsr ScrollDir
        ldy #$2F
+       sty $FA
        sty $93
        sty $94
        lda $95D9       ; Samus' initial vertical position
        sta ObjectY
        lda #$80        ; Samus' initial horizontal position
        sta ObjectX
        lda PPUCNT0ZP
        and #$01
        sta ObjectHi
        lda #$00
        sta HealthLo
        lda #$03
        sta HealthHi
-       rts

; GameEngine
; ==========
; main game engine

        GameEngine:
        jsr ScrollDoor
        jsr ScrollDoor
        lda $69B2
        beq +
    ; think this must be some debugging mode they forgot to remove...
    ; gives you new health, missiles and every power-up every frame.
        lda #$03
        sta HealthHi
        lda #$FF
        sta SamusGear
        lda #$05
        sta MissileCount
+       jsr UpdateWorld
        lda $0108
        ora $0109
        beq +
        lda #$00
        sta $0108
        sta $0109
        lda #$18
        ldx #$03
        jsr SetTimer
+       lda ObjAction
        cmp #sa_Dead2   ; is Samus dead?
        bne -           ; exit if not
        lda AnimDelay
        bne -
    ; Samus is way dead...
        jsr SilenceMusic
        lda $98
        cmp #$0A
        beq +
        lda #$04        ; # of time units to delay
        ldx #$04        ; password display routine
        jmp SetTimer
+       inc MainRoutine
        rts

; UpdateAge
; =========
; This is the routine which keeps track of Samus' age. It is called in the
; NMI. Basically, this routine just increments a 24-bit variable every
; 256th frame. (Except it's not really 24-bit, because the lowest age byte
; overflows at $D0.)

        UpdateAge:
        lda GameMode
        bne +           ; exit if at title/password screen
        lda MainRoutine
        cmp #$03        ; is game engine running?
        bne +           ; if not, don't update age
        ldx FrameCount  ; only update age when FrameCount is zero
        bne +           ; (which is approx. every 4.266666666667 seconds)
        inc SamusAge,x  ; Minor Age = Minor Age + 1
        lda SamusAge
        cmp #$D0        ; has Minor Age reached $D0?
        bcc +           ; if not, we're done
        lda #$00        ; else...
        sta SamusAge    ; ... reset Minor Age
-       cpx #$03
        bcs +
        inx
        inc SamusAge,x
        beq -           ; branch if Middle Age overflowed, need to increment Major Age too
+       rts

; EndGame
; =======

        EndGame:
        lda #$1C
        sta TitleRoutine
        lda #$01
        sta SwitchPending
        jmp ScreenOff

; PauseMode
; =========

        PauseMode:
        lda JoyStatus+1 ; joypad #2
        and #$88
        eor #$88        ; both A & UP pressed? (zero result = yes)
        bne Exit14      ; exit if not
        ldy EndTimerHi
        iny
        bne Exit14      ; sorry, can't quit if this is during escape sequence
        sta GamePaused
        inc MainRoutine ; password display
        Exit14:
        rts

; GoPassword
; ==========

        GoPassword:
        lda #$19
        sta TitleRoutine
        lda #$01
        sta SwitchPending
        lda $0680
        ora #$01
        sta $0680
        jmp ScreenOff

; SamusIntro
; ==========
; Game intro - fades Samus onto the screen

        SamusIntro:
        jsr EraseAllSprites
        ldy ObjAction
        lda Timer+2
        bne +
        ; intro is over, time to start game
        sta $79
        lda #$FF
        sta ObjAction
        jsr LD92C       ; start main music
        jsr SelectSamusPal
        lda #$03
        sta MainRoutine ; game engine will be called next frame
+       cmp #$1F
        bcs Exit14
        cmp Table0B-20,y
        bne +
        inc ObjAction
        sty PalDataPending
+       lda FrameCount
        lsr a
        bcc Exit14       ; only display Samus on odd frames [the blink effect]
        lda #an_SamusFront
        jsr SetSamusAnim
        lda #$00
        sta SpritePagePos
        sta PageIndex
        jmp AnimDrawObject

Table0B
        .db $1E,$14,$0B,$04,$FF

LCA18:  ldy MainRoutine
        cpy #$07
        beq +
        cpy #$03
        beq ++
+       rts

; Switch to appropriate area bank

++      sta $74
        and #$0F
        tay
        lda BankTable,y
        sta SwitchPending
        jmp CheckSwitch

; Table used by above subroutine
; Each value is the area bank number plus one

BankTable
                .db $02         ; Brinstar
                .db $03         ; Norfair
                .db $05         ; Kraid
                .db $04         ; Tourian
                .db $06         ; Ridley

LCA35:  pha
        pha
        jsr LCA96
        lda $6884
        bpl +
        and #$01
        sta $6884
        jsr LCAA1
        lda #$01
        sta $7800,y
+       lda MainRoutine
        cmp #$01
        beq +
        lda $74
        jsr LCAC6
        ldy #$3F
-       lda $6886,y
        sta ($00),y
        dey
        bpl -
        ldy $6875
        ldx #$00
-       lda $6876,x
        sta $77FE,y
        iny
        inx
        cpx #$10
        bne -
+       pla
        jsr LCAC6
        ldy #$3F
-       lda ($00),y
        sta $6886,y
        dey
        bpl -
        bmi +
        pha
+       ldy $6875
        ldx #$00
-       lda $77FE,y
        sta $6876,x
        iny
        inx
        cpx #$10
        bne -
        pla
        rts

LCA96:  lda $6885
        asl a
        asl a
        asl a
        asl a
        sta $6875
        rts

LCAA1:  lda #$00
        jsr LCAC6
        inc $03
        ldy #$00
        tya
-       sta ($00),y
        cpy #$40
        bcs +
        sta ($02),y
+       iny
        bne -
        ldy $6875
        ldx #$00
        txa
-       sta $77FE,y
        iny
        inx
        cpx #$0C
        bne -
        rts

LCAC6:  pha
        lda $6885
        asl a
        tax
        lda Table03,x
        sta $00
        sta $02
        lda Table03+1,x
        sta $01
        sta $03
        pla
        and #$0F
        tax
        beq ++
-       lda $00
        clc
        adc #$40
        sta $00
        bcc +
        inc $01
+       dex
        bne -
++      rts

; Table used by above subroutine

Table03
        .dw $69B4
        .dw $69B4
        .dw $69B4

; determine what type of ending is to be shown, based on Samus' age

LCAF5:  ldy #$01
-       lda SamusAge+2
        bne +
        lda SamusAge+1
        cmp AgeTable-1,y
        bcs +
        iny
        cpy #$05
        bne -
+       sty $6872       ; store the ending # (1..5), 5 = best ending
        lda #$00
        cpy #$04        ; was the best or 2nd best ending achieved?
        bcc +           ; branch if not (suit stays on)
        lda #$01
+       sta JustInBailey ; suit OFF, baby!
        rts

; Table used by above subroutine

AgeTable
        .db $7A        ; worst ending... 30 hours+
        .db $16         ; max. 5.4 hours
        .db $0A         ; max. 2.5 hours
        .db $04         ; best ending... max. 1 hour

LCB1C:  jsr ScreenOff
        lda #$FF
        sta $00
        jsr ClearNameTable
        jmp EraseAllSprites

; ===== THE REAL GUTS OF THE GAME ENGINE! =====

        UpdateWorld:
        ldx #$00
        stx SpritePagePos
        jsr UpdateEnemies       ; display of enemies
        jsr UpdateProjectiles   ; display of bullets/missiles/bombs
        jsr UpdateSamus ; display / movement of Samus
        jsr $95C3       ; area-dependent
        jsr UpdateElevator
        jsr UpdateStatues       ; Ridley & Kraid statues
        jsr LFA9D       ; destruction of enemies
        jsr LFC65       ; update of Mellow/Memu enemies
        jsr LF93B
        jsr LFBDD       ; destruction of green spinners
        jsr $8B13       ; scrolling when Samus goes through door
        jsr $8B79       ; display of doors
        jsr UpdateTiles ; tile de/regeneration
        jsr LF034       ; Samus <--> enemies crash detection
        jsr DisplayBar  ; display of data bar
        jsr LFAF2
        jsr CheckMissileToggle
        jsr UpdateItems ; display of special items
        jsr LFDE3
; Clear remaining sprite RAM
        ldx SpritePagePos
        lda #$F4
-       sta SpriteRAM,x
        jsr Xplus4       ; X = X + 4
        bne -
        rts

; SelectSamusPal
; ==============
; Select the proper palette for Samus
; Based on:
; - Is Samus wearing Varia (protective suit)?
; - Is Samus firing missiles or regular bullets?
; - Is Samus with or without suit?

        SelectSamusPal:
        tya
        pha
        lda SamusGear
        asl a
        asl a
        asl a           ; CF contains Varia status (1 = Samus has it)
        lda MissileToggle   ; A = 1 if Samus is firing missiles, else 0
        rol a           ; bit 0 of A = 1 if Samus is wearing Varia
        adc #$02
        ldy JustInBailey ; in suit?
        beq +           ; branch if yes
        clc
        adc #$17        ; add #$17 to the pal # to reach "no suit"-palettes
+       sta PalDataPending      ; palette will be written next NMI
        pla
        tay
        rts

; initiate sound effects

        SilenceMusic:
        lda #$01        ; ??? (silence)
        bne SFX_SetX0
        PauseMusic:
        lda #$02        ; ??? (silence)
        bne SFX_SetX0
        SFX_SamusWalk:
        lda #$08
        bne SFX_SetX0
        SFX_BombExplode:
        lda #$10
        bne SFX_SetX0
        SFX_MissileLaunch:
        lda #$20
        SFX_SetX0:
        ldx #$00
        beq SFX_SetSoundFlag
        SFX_Zeb:
        lda #$08
        bne SFX_SetX1
        SFX_BombLaunch:
        lda #$01
        bne SFX_SetX3
        SFX_SamusJump:
        lda #$02
        bne SFX_SetX1
        SFX_EnemyHit:
        lda #$04
        bne SFX_SetX1
        SFX_BulletFire:
        lda #$10
        bne SFX_SetX1
        SFX_Metal:
        lda #$20
        bne SFX_SetX1
        SFX_EnergyPickup:
        lda #$40
        bne SFX_SetX1
        SFX_MissilePickup:
        lda #$80
        SFX_SetX1:
        ldx #$01
        bne SFX_SetSoundFlag
        SFX_WaveFire:
        lda #$01
        bne SFX_SetX1
        SFX_ScrewAttack:
        lda #$40
        bne SFX_SetX0
LCBCE:  lda #$04        ; ??? (silence)
        bne SFX_SetX3
        SFX_MetroidHit:
        lda #$20
        bne SFX_SetX3
        SFX_MBrainHit:
        lda #$02
        bne SFX_SetX4
LCBDA:  lda #$40        ; Door open/close
        bne SFX_SetX3
        SFX_SamusHit:
        lda #$04
        bne SFX_SetX4
        SFX_SamusDie:
        lda #$80
        bne SFX_SetX3
        ldx #$02
        SFX_SetSoundFlag:
        ora $0680,x
        sta $0680,x
        rts

        SFX_SamusBall:
        lda #$02        ; Samus --> ball
        bne SFX_SetX3
        SFX_Beep:
        lda #$08
        SFX_SetX3:
        ldx #$03
        bne SFX_SetSoundFlag

; initiate music

        PowerUpMusic:
        lda #$40        ; Take power-up
        bne SFX_SetX4
        IntroMusic:
        lda #$80        ; Game begin
        SFX_SetX4:
        ldx #$04
        bne SFX_SetSoundFlag
LCC01:  lda #$02        ; ??? (silence)
        bne SFX_SetX5
LCC07:  lda #$40        ; Tourian music
        SFX_SetX5:
        ldx #$05
        bne SFX_SetSoundFlag

; UpdateSamus
; ===========

        UpdateSamus:
        ldx #$00
        stx PageIndex
        inx
        stx IsSamus     ; signal that Samus is the obj being updated
        jsr GoSamusHandler
        dec IsSamus
        rts

        GoSamusHandler:
        lda ObjAction
        bmi SamusStand
        jsr GoRoutine

; Pointer table for Samus' action handlers... One of these is executed
; EVERY frame

        .dw SamusStand  ; standing
        .dw SamusRun    ; running
        .dw SamusJump   ; jumping
        .dw SamusRoll   ; rolling
        .dw SamusPntUp  ; pointing up
        .dw SamusDoor   ; inside door while screen scrolling
        .dw SamusJump   ; jumping while pointing up
        .dw SamusDead   ; dead
        .dw SamusDead2  ; more dead
        .dw SamusElevator

; SamusStand
; ==========

        SamusStand:
        lda JoyStatus   ; status of joypad #0
        and #%11001111  ; ditch SEL & START status bits
        beq +           ; branch if no buttons pressed
        jsr LCF5D
        lda JoyStatus
+       and #%00000111  ; keep status of DOWN/LEFT/RIGHT
        bne +           ; branch if pressed
        lda JoyFirst
        and #btn_UP     ; keep status of UP
        beq ++          ; branch if not pressed
+       jsr BitScan
        cmp #$02
        bcs +
        sta SamusDir    ; 0 = right, 1 = left
+       tax
        lda ActionTable,x
        sta ObjAction
++      lda JoyFirst
        ora JoyRetrig
        asl a
        bpl +           ; branch if FIRE not pressed
        jsr SamusShoot  ; shoot left/right
+       bit JoyFirst
        bpl +           ; branch if JUMP not pressed
        lda #sa_Jump    ; jump handler
        sta ObjAction
+       lda #$04
        jsr LCD6D
        lda ObjAction
        cmp #sa_Door
        bcs +           ; rts
        jsr GoRoutine

; Pointer table to code

        .dw ExitSub       ; rts
        .dw $CC98
        .dw $CFC3
        .dw $D0B5
        .dw LCF77

; Table used by above subroutine

ActionTable
                .db sa_Run
                .db sa_Run
                .db sa_Roll
                .db sa_PntUp

LCC8B:  lda #$50
        sta $030F
        lda #an_Explode
        jsr SetSamusAnim
        sta $65
+       rts

LCC98:  lda #$09
        sta WalkSoundDelay
        ldx #$00
        lda AnimResetIndex
        cmp #an_SamusStand
        beq +
        inx
        cmp #$27
        beq +
        lda #$04
        jsr SetSamusNextAnim
+       lda LCCBE,x
        sta AnimResetIndex
        ldx SamusDir
LCCB7:  lda LCCC0,x
        sta $0315
        rts

LCCBE:  .db an_SamusRun
        .db an_SamusRunPntUp
LCCC0:  .db $30
        .db $D0

; SamusRun
; ========

        SamusRun:
        ldx SamusDir
        lda SamusGravity                ;Samus's gravity
        beq +++
        ldy $030F
        bit $0308
        bmi +
        cpy #$18
        bcs ++
        lda #an_SamusJump
        sta AnimResetIndex
        bcc ++          ; branch always
+       cpy #$18
        bcc ++
        lda AnimResetIndex
        cmp #an_SamusFireJump
        beq +                     ;Branch if Samus is shooting in mid air
        lda #an_SamusSalto
        sta AnimResetIndex
+       cpy #$20
        bcc ++
        lda JoyStatus
        and #btn_UP
        beq +
        lda #an_SamusJumpPntUp
        sta AnimResetIndex
+       bit JoyStatus
        bmi ++
        jsr LD147
++      lda #an_SamusRun
        cmp AnimResetIndex
        bne +
        lda #an_SamusJump
        sta AnimResetIndex
+       lda $64
        beq +
        lda JoyFirst
        bmi LCD40       ; branch if JUMP pressed
+       jsr LCF88
        jsr LD09C
        jsr LCF2E
        lda #$02
        bne LCD6D       ; branch always
+++     lda SamusOnElevator
        bne +
        jsr LCCB7
+       jsr LCDBF
        dec WalkSoundDelay  ; time to play walk sound?
        bne +               ; branch if not
        lda #$09
        sta WalkSoundDelay  ; # of frames till next walk sound trigger
        jsr SFX_SamusWalk
+       jsr LCF2E
        lda JoyFirst
        bpl +           ; branch if JUMP not pressed
LCD40:  jsr LCFC3
        lda #$12
        sta $0316
        jmp LCD6B

+       ora JoyRetrig
        asl a
        bpl +           ; branch if FIRE not pressed
        jsr LCDD7
+       lda JoyStatus
        and #$03
        bne +
        jsr LCF55
        jmp LCD6B

+       jsr BitScan
        cmp SamusDir
        beq LCD6B
        sta SamusDir
        jsr LCC98
LCD6B:  lda #$03
LCD6D:  jsr UpdateObjAnim
        jsr LCD9C
        bcs +
        lda FrameCount
        lsr a
        and #$03
        ora #$A0
        sta $6B
+       jsr LCDFA
        jsr LE269
        lda $92
        beq +
        lda #$A1
        sta $6B
+       jsr LCD92
        jmp DrawFrame   ; display Samus!

LCD92:  lda SamusDir
        jsr Amul16       ; * 16
        ora $6B
        sta $6B
        rts

LCD9C:  sec
        ldy ObjAction
        dey
        bne Exit2       ; exit if Samus isn't running
        lda SamusGear
        and #gr_SCREWATTACK
        beq Exit2       ; exit if Samus doesn't have Screw Attack
        lda AnimResetIndex
        cmp #an_SamusSalto
        beq +
        cmp #an_SamusJump
        sec
        bne Exit2
        bit $0308
        bpl Exit2
+       cmp AnimIndex
Exit2:  rts

LCDBF:  lda JoyStatus
        and #btn_UP
        lsr a
        lsr a
        lsr a
        tax
        lda LCCBE,x
        cmp AnimResetIndex
        beq Exit2
        jsr SetSamusAnim
        pla
        pla
        jmp LCD6B

LCDD7:  jsr SamusShoot
        lda JoyStatus
        and #btn_UP
        bne +
        lda #an_SamusFireRun
        sta AnimIndex
        rts

+       lda AnimIndex
        sec
        sbc AnimResetIndex
        and #$03
        tax
        lda Table05,x
        jmp SetSamusNextAnim

; Table used by above subroutine

Table05
        .db $3F
        .db $3B
        .db $3D
        .db $3F

LCDFA:  lda $030A
        and #$20
        beq +++
        lda #$32
        sta SamusBlink
        lda #$FF
        sta $72
        lda $73
        sta $77
        beq ++
        bpl +
        jsr SFX_SamusHit
+       lda $030A
        and #$08
        lsr a
        lsr a
        lsr a
        sta $72
++      lda #$FD
        sta $0308
        lda #$38
        sta SamusGravity
        jsr IsSamusDead
        bne +++
        jmp CheckHealthBeep

+++     lda SamusBlink
        beq CheckHealthBeep
        dec SamusBlink
        ldx $72
        inx
        beq ++
        jsr Adiv16       ; / 16
        cmp #$03
        bcs +
        ldy $0315
        bne ++
        jsr LCF4E
+       dex
        bne +
        jsr GetAbsolute
+       sta $0309
++      lda $77
        bpl CheckHealthBeep
        lda FrameCount
        and #$01
        bne CheckHealthBeep
        tay
        sty AnimDelay
        ldy #$F7
        sty AnimFrame
        CheckHealthBeep:
        ldy HealthHi
        dey
        bmi +
        bne ++
        lda HealthLo
        cmp #$70
        bcs ++
; health < 17
+       lda FrameCount
        and #$0F
        bne ++          ; only beep every 16th frame
        jsr SFX_Beep
++      lda #$00
        sta $030A
        rts

        IsSamusDead:
        lda ObjAction
        cmp #sa_Dead
        beq Exit3
        cmp #sa_Dead2
        beq Exit3
        cmp #$FF        ; make sure zero flag is NOT set on exit
Exit3:  rts

LCE92:  lda $6E
        ora $6F
        beq Exit3
        jsr IsSamusDead
        beq LCEA3
        ldy EndTimerHi
        iny
        beq +
LCEA3:  jmp LF323

+       lda $98
        cmp #$03
        bcs LCEA3
        lda SamusGear
        and #gr_VARIA
        beq +           ; branch if Samus doesn't have Varia
        lsr $6E
        lsr $6F
        bcc +
        lda #$4F
        adc $6E
        sta $6E
+       lda HealthLo
        sta $03
        lda $6E
        sec
        jsr LC3FB
        sta HealthLo
        lda HealthHi
        sta $03
        lda $6F
        jsr LC3FB
        sta HealthHi
        lda HealthLo
        and #$F0
        ora HealthHi
        beq +
        bcs ++

; Samus is dead!

+       lda #$00
        sta HealthLo
        sta HealthHi
        lda #sa_Dead        ; death handler
        sta ObjAction
        jsr SFX_SamusDie
        jmp LCC8B

LCEF9:  lda HealthLo
        sta $03
        lda $6E
        clc
        jsr LC3DA
        sta HealthLo
        lda HealthHi
        sta $03
        lda $6F
        jsr LC3DA
        sta HealthHi
        lda TankCount
        jsr Amul16       ; * 16
        ora #$0F
        cmp HealthHi
        bcs ++
        and #$F9
        sta HealthHi
        lda #$99
        sta HealthLo
++      jmp LF323

LCF2E:  lda $030A
        lsr a
        and #$02
        beq +++
        bcs +
        lda $0315
        bmi +++
        bpl ++
+       lda $0315
        bmi ++
        bne +++
++      jsr GetAbsolute
        sta $0315
LCF4C:  ldy #$00
LCF4E:  sty $0309
        sty $0313
+++     rts

LCF55:  lda $0315
        bne LCF5D
        jsr SFX_SamusWalk
LCF5D:  jsr LCF81
        sty ObjAction
        lda JoyStatus
        and #btn_UP
        bne LCF77
        lda #an_SamusStand
        SetSamusAnim:
        sta AnimResetIndex
        SetSamusNextAnim:
        sta AnimIndex
        lda #$00
        sta AnimDelay
        rts

LCF77:  lda #sa_PntUp
        sta ObjAction
        lda #an_SamusPntUp
        jsr SetSamusAnim
LCF81:  jsr LCFB7
        sty AnimDelay
        rts

LCF88:  lda JoyStatus
        and #$03
        beq +
        jsr BitScan
        tax
        jsr LCCB7
        lda SamusGravity
        bmi ++
        lda AnimResetIndex
        cmp #an_SamusSalto
        beq ++                  ;Branch if Samus's animation is the somersault
        stx SamusDir
        lda Table06+1,x
        jmp SetSamusAnim

+       lda SamusGravity
        bmi ++
        beq ++
        lda AnimResetIndex
        cmp #an_SamusJump
        bne ++
LCFB7:  jsr LCF4C
        sty $0315
++      rts

LCFBE:  ldy #an_SamusJumpPntUp
        jmp +

LCFC3:  ldy #an_SamusJump
+       sty AnimResetIndex
        dey
        sty AnimIndex
        lda #$04
        sta AnimDelay
        lda #$00
        sta $030F
        lda #$FC
        sta $0308
        ldx ObjAction
        dex
        bne +           ; branch if Samus is standing still
        lda SamusGear
        and #gr_SCREWATTACK
        beq +           ; branch if Samus doesn't have Screw Attack
        lda #$00
        sta $0686
        jsr SFX_ScrewAttack
+       jsr SFX_SamusJump
        ldy #$18        ; gravity (high value -> low jump)
        lda SamusGear
        and #gr_HIGHJUMP
        beq +           ; branch if Samus doesn't have High Jump
        ldy #$12        ; lower gravity value -> high jump!
+       sty SamusGravity
        rts

        SamusJump:
        lda $030F
        bit $0308
        bpl +           ; branch if falling down
        cmp #$20
        bcc +           ; branch if jumped less than 32 pixels upwards
        bit JoyStatus
        bmi +           ; branch if JUMP button still pressed
        jsr LD147       ; stop jump (start falling)
+       jsr LD055
        jsr LCF2E
        lda JoyStatus
        and #btn_UP     ; UP pressed?
        beq +           ; branch if not
        lda #an_SamusJumpPntUp
        sta AnimResetIndex
        lda #sa_PntJump      ; "jumping & pointing up" handler
        sta ObjAction
+       jsr LD09C
        lda $64
        beq +
        lda JoyFirst
        bpl +           ; branch if JUMP not pressed
        jsr LCFC3
        jmp LCD6B

+       lda SamusGravity
        bne ++
        lda ObjAction
        cmp #sa_PntJump
        bne +
        jsr LCF77
        bne ++
+       jsr LCF55
++      lda #$03
        jmp LCD6D

LD055:  ldx #$01
        ldy #$00
        lda JoyStatus
        lsr a
        bcs +           ; branch if RIGHT pressed
        dex
        lsr a
        bcc +++       ; branch if LEFT not pressed
        dex
        iny
+       cpy SamusDir
        beq +++
        lda ObjAction
        cmp #sa_PntJump
        bne +
        lda AnimResetIndex
        cmp Table04,y
        bne ++
        lda Table04+1,y
        jmp ++

+       lda AnimResetIndex
        cmp Table06,y
        bne ++
        lda Table06+1,y
++      jsr SetSamusAnim
        lda #$08
        sta AnimDelay
        sty SamusDir
+++     stx $0309
-       rts

; Table used by above subroutine

Table06
        .db $0C
        .db $0C
        .db $0C
Table04
        .db $35
        .db $35
        .db $35

LD09C:  lda JoyFirst
        ora JoyRetrig
        asl a
        bpl -           ; exit if FIRE not pressed
        lda AnimResetIndex
        cmp #an_SamusJumpPntUp
        bne +
        jmp SamusShootUp

+       jsr SamusShootFoward
        lda #an_SamusFireJump
        jmp SetSamusAnim

LD0B5:  lda SamusGear
        and #gr_MARUMARI
        beq +           ; branch if Samus doesn't have Maru Mari
        lda SamusGravity
        bne +
    ; turn Samus into ball
        ldx SamusDir
        lda #an_SamusRoll
        sta AnimResetIndex
        lda #an_SamusRunJump
        sta AnimIndex
        lda LCCC0,x
        sta $0315
        lda #$01
        sta $0686
        jmp SFX_SamusBall

+       lda #sa_Stand
        sta ObjAction
        rts

; SamusRoll
; =========

        SamusRoll:
        lda JoyFirst
        and #btn_UP     ; UP pressed?
        bne +           ; branch if yes
        bit JoyFirst    ; JUMP pressed?
        bpl ++          ; branch if no
+       lda JoyStatus
        and #btn_DOWN   ; DOWN pressed?
        bne ++          ; branch if yes
    ; break out of "ball mode"
        lda ObjRadY
        clc
        adc #$08
        sta ObjRadY
        jsr CheckMoveUp
        bcc ++          ; branch if not possible to stand up
        ldx #$00
        jsr LE8BE
        stx $05
        lda #$F5
        sta $04
        jsr LFD8F
        jsr LD638
        jsr LCF55
        dec AnimIndex
        jsr LD147
        lda #$04
        jmp LD144

++      lda JoyFirst
        jsr BitScan
        cmp #$02
        bcs +
        sta SamusDir
        lda #an_SamusRoll
        jsr SetSamusAnim
+       ldx SamusDir
        jsr LCCB7
        jsr LCF2E
        jsr CheckBombLaunch
        lda JoyStatus
        and #$03
        bne +
        jsr LCFB7
+       lda #$02
LD144:  jmp LCD6D

LD147:  ldy #$00
        sty $0308
        sty $0312
        rts

; CheckBombLaunch
; ===============
; This routine is called only when Samus is rolled into a ball.
; It does the following:
; - Checks if Samus has bombs
; - If so, checks if the FIRE button has been pressed
; - If so, checks if there are any object "slots" available
;   (only 3 bullets/bombs can be active at the same time)
; - If so, a bomb is launched.

        CheckBombLaunch:
        lda SamusGear
        lsr a
        bcc ++          ; exit if Samus doesn't have Bombs
        lda JoyFirst
        ora JoyRetrig
        asl a           ; bit 7 = status of FIRE button
        bpl ++          ; exit if FIRE not pressed
        lda $0308
        ora SamusOnElevator
        bne ++
        ldx #$D0        ; try object slot D
        lda ObjAction,x
        beq +           ; launch bomb if slot available
        ldx #$E0        ; try object slot E
        lda ObjAction,x
        beq +           ; launch bomb if slot available
        ldx #$F0        ; try object slot F
        lda ObjAction,x
        bne ++          ; no bomb slots available, exit
; launch bomb... give it same coords as Samus
+       lda ObjectHi
        sta ObjectHi,x
        lda ObjectX
        sta ObjectX,x
        lda ObjectY
        clc
        adc #$04        ; 4 pixels further down than Samus' center
        sta ObjectY,x
        lda #wa_LayBomb
        sta ObjAction,x
        jsr SFX_BombLaunch
++      rts

        SamusPntUp:
        lda JoyStatus
        and #btn_UP     ; UP still pressed?
        bne +           ; branch if yes
        lda #sa_Stand   ; stand handler
        sta ObjAction
+       lda JoyStatus
        and #$07        ; DOWN, LEFT, RIGHT pressed?
        beq ++          ; branch if no
        jsr BitScan
        cmp #$02
        bcs +
        sta SamusDir
+       tax
        lda Table07,x
        sta ObjAction
++      lda JoyFirst
        ora JoyRetrig
        asl a
        bpl +           ; branch if FIRE not pressed
        jsr SamusShoot
+       bit JoyFirst
        bpl +           ; branch if JUMP not pressed
        lda #sa_PntJump
        sta ObjAction
+       lda #$04
        jsr LCD6D
        lda ObjAction
        jsr GoRoutine

; Pointer table to code

        .dw $CF55
        .dw $CC98
        .dw ExitSub       ; rts
        .dw $D0B5
        .dw ExitSub       ; rts
        .dw ExitSub       ; rts
        .dw $CFBE
        .dw ExitSub       ; rts
        .dw ExitSub       ; rts
        .dw ExitSub       ; rts

; Table used by above subroutine

Table07
        .db sa_Run
        .db sa_Run
        .db sa_Roll

SamusShoot:
        lda JoyStatus
        and #btn_UP
        beq SamusShootFoward
        jmp SamusShootUp

LD1F7:  ldy #$D0
-       lda ObjAction,y
        beq +
        jsr Yplus16
        bne -
        iny
        rts

+       sta $030A,y
        lda MissileToggle
        beq +
        cpy #$D0
+       rts

SamusShootFoward:
        lda $92
        bne +
        jsr LD1F7
        bne +
        jsr LD2EB
        jsr LD359
        jsr LD38E
        lda #$0C
        sta $030F,y
        ldx SamusDir
        lda BulletSpeedTable,x   ; get bullet speed
        sta $0309,y     ; -4 or 4, depending on Samus' direction
        lda #$00
        sta $0308,y
        lda #$01
        sta $030B,y
        jsr CheckMissileLaunch
        lda ObjAction,y
        asl a
        ora SamusDir
        and #$03
        tax
        lda Table08,x
        sta $05
        lda #$FA
        sta $04
        jsr LD306
        lda SamusGear
        and #gr_LONGBEAM
        lsr a
        lsr a
        lsr a
        ror a
        ora $061F
        sta $061F
        ldx ObjAction,y
        dex
        bne +
        jsr SFX_BulletFire
+       ldy #$09
LD26B:  tya
        jmp SetSamusNextAnim

Table08
        .db $0C
        .db $F4
        .db $08
        .db $F8

BulletSpeedTable
        .db $04
        .db $FC

SamusShootUp:
        lda $92
        bne +
        jsr LD1F7
        bne +
        jsr LD2EB
        jsr LD38A
        jsr LD38E
        lda #$0C
        sta $030F,y
        lda #$FC
        sta $0308,y
        lda #$00
        sta $0309,y
        lda #$01
        sta $030B,y
        jsr LD340
        ldx SamusDir
        lda Table09+4,x
        sta $05
        lda ObjAction,y
        and #$01
        tax
        lda Table09+6,x
        sta $04
        jsr LD306
        lda SamusGear
        and #gr_LONGBEAM
        lsr a
        lsr a
        lsr a
        ror a
        ora $061F
        sta $061F
        lda ObjAction,y
        cmp #$01
        bne +
        jsr SFX_BulletFire
+       ldx SamusDir
        ldy Table09,x
        lda SamusGravity
        beq +
        ldy Table09+2,x
+       lda ObjAction
        cmp #$01
        beq +
        jmp LD26B

; Table used by above subroutine

Table09
        .db $26
        .db $26
        .db $34
        .db $34
        .db $01
        .db $FF
        .db $EC
        .db $F0

LD2EB:  tya
        tax
        inc ObjAction,x
        lda #$02
        sta ObjRadY,y
        sta ObjRadX,y
        lda #an_Bullet
        SetProjectileAnim:
        sta AnimResetIndex,x
        sta AnimIndex,x
        lda #$00
        sta AnimDelay,x
+       rts

LD306:  ldx #$00
        jsr LE8BE
        tya
        tax
        jsr LFD8F
        txa
        tay
        jmp LD638

        CheckMissileLaunch:
        lda MissileToggle
        beq Exit4       ; exit if Samus not in "missile fire" mode
        cpy #$D0
        bne Exit4
        ldx SamusDir
        lda MissileAnims,x
-       jsr SetBulletAnim
        jsr SFX_MissileLaunch
        lda #wa_Missile        ; missile handler
        sta ObjAction,y
        lda #$FF
        sta $030F,y     ; # of frames projectile should last
        dec MissileCount
        bne Exit4       ; exit if not the last missile
; Samus has no more missiles left
        dec MissileToggle       ; put Samus in "regular fire" mode
        jmp SelectSamusPal      ; update Samus' palette to reflect this

        MissileAnims:
        .db an_MissileRight
        .db an_MissileLeft

LD340:  lda MissileToggle
        beq Exit4
        cpy #$D0
        bne Exit4
        lda #$8F
        bne -

        SetBulletAnim:
        sta AnimIndex,y
        sta AnimResetIndex,y
        lda #$00
        sta AnimDelay,y
Exit4:  rts

LD359:  lda SamusDir
-       sta $0502,y
        bit SamusGear
        bvc Exit4       ; branch if Samus doesn't have Wave Beam
        lda MissileToggle
        bne Exit4
        lda #$00
        sta $0501,y
        sta $0304,y
        tya
        jsr Adiv32      ; / 32
        lda #$00
        bcs +
        lda #$0C
+       sta $0500,y
        lda #wa_WaveBeam
        sta ObjAction,y
        lda #an_WaveBeam
        jsr SetBulletAnim
        jmp SFX_WaveFire

LD38A:  lda #$02
        bne -
LD38E:  lda MissileToggle
        bne Exit4
        lda SamusGear
        bpl Exit4       ; branch if Samus doesn't have Ice Beam
        lda #wa_IceBeam
        sta ObjAction,y
        lda $061F
        ora #$01
        sta $061F
        jmp SFX_BulletFire

; SamusDoor
; =========

        SamusDoor:
        lda DoorStatus
        cmp #$05
        bcc +++
    ; move Samus out of door, how far depends on initial value of DoorDelay
        dec DoorDelay
        bne MoveOutDoor
    ; done moving
        asl a
        bcc +
        lsr a
        sta DoorStatus
        bne +++
+       jsr LD48C
        jsr LED65
        jsr $95AB
        lda $79
        beq +
        pha
        jsr LD92C       ; start music
        pla
        bpl +
        lda #$00
        sta $79
        beq +
-       lda #$80
        sta $79
+       lda $6987
        beq +
        jsr LCC07
        lda #$00
        sta $6987
        beq -           ; branch always
+       lda $58
        and #$0F
        sta ObjAction
        lda #$00
        sta $58
        sta DoorStatus
        jsr LD147
        MoveOutDoor:
        lda SamusDoorDir
        beq ++          ; branch if door leads to the right
        ldy ObjectX
        bne +
        jsr ToggleSamusHi       ; toggle 9th bit of Samus' X coord
+       dec ObjectX
        jmp +++

++      inc ObjectX
        bne +++
        jsr ToggleSamusHi       ; toggle 9th bit of Samus' X coord
+++     jsr LCDFA
        jsr LCD92
        jmp DrawFrame       ; display Samus

        SamusDead:
        lda #$01
        jmp LCD6D

        SamusDead2:
        dec $0304
        rts

; SamusElevator
; =============

        SamusElevator:
        lda $0320
        cmp #$03
        beq +
        cmp #$08
        bne +++
+       lda $032F
        bmi ++
        lda ObjectY
        sec
        sbc ScrollY     ; A = Samus' Y position on the visual screen
        cmp #$84
        bcc +           ; if ScreenY < $84, don't scroll
        jsr ScrollDown  ; otherwise, attempt to scroll
+       ldy ObjectY
        cpy #239        ; wrap-around required?
        bne +
        jsr ToggleSamusHi       ; toggle 9th bit of Samus' Y coord
        ldy #$FF        ; ObjectY will now be 0
+       iny
        sty ObjectY
        jmp LD47E

++      lda ObjectY
        sec
        sbc ScrollY     ; A = Samus' Y position on the visual screen
        cmp #$64
        bcs +           ; if ScreenY >= $64, don't scroll
        jsr ScrollUp    ; otherwise, attempt to scroll
+       ldy ObjectY
        bne +           ; wraparound required? (branch if not)
        jsr ToggleSamusHi       ; toggle 9th bit of Samus' Y coord
        ldy #240        ; ObjectY will now be 239
+       dey
        sty ObjectY
        jmp LD47E

+++     ldy #$00
        sty $0308
        cmp #$05
        beq +
        cmp #$07
        beq +
LD47E:  lda FrameCount
        lsr a
        bcc ++
+       jsr LCD92
        lda #$01
        jmp AnimDrawObject
++      rts

LD48C:  ldx #$60
        sec
-       jsr LD4B4
        txa
        sbc #$20
        tax
        bpl -
        jsr LEB85
        tay
        ldx #$18
-       jsr LD4A8
        txa
        sec
        sbc #$08
        tax
        bne -
LD4A8:  tya
        cmp $072C,x
        bne +
        lda #$FF
        sta $0728,x
+       rts

LD4B4:  lda $0405,x
        and #$02
        bne +
        sta $6AF4,x
+       rts

; UpdateProjectiles
; =================

        UpdateProjectiles:
        ldx #$D0
        jsr DoOneProjectile
        ldx #$E0
        jsr DoOneProjectile
        ldx #$F0
        DoOneProjectile:
        stx PageIndex
        lda ObjAction,x
        jsr GoRoutine

        .dw ExitSub     ; rts
        .dw UpdateBullet ; regular beam
        .dw UpdateWaveBullet      ; wave beam
        .dw UpdateIceBullet       ; ice beam
        .dw BulletExplode    ; bullet/missile explode
        .dw $D65E       ; lay bomb
        .dw $D670       ; lay bomb
        .dw $D691       ; lay bomb
        .dw $D65E       ; lay bomb
        .dw $D670       ; bomb countdown
        .dw $D691       ; bomb explode
        .dw UpdateBullet  ; missile

        UpdateBullet:
        lda #$01
        sta $71
        jsr LD5FC
        jsr LD5DA
        jsr LD609
        CheckBulletStat:
        ldx PageIndex
        bcc +
        lda SamusGear
        and #gr_LONGBEAM
        bne DrawBullet  ; branch if Samus has Long Beam
        dec $030F,x     ; decrement bullet timer
        bne DrawBullet
        lda #$00        ; timer hit 0, kill bullet
        sta ObjAction,x
        beq DrawBullet  ; branch always
+       lda ObjAction,x
        beq +
        jsr LD5E4
        DrawBullet:
        lda #$01
        jsr AnimDrawObject
+       dec $71
        rts

-       inc $0500,x
LD522:  inc $0500,x
        lda #$00
        sta $0501,x
        beq +           ; branch always

        UpdateWaveBullet:
        lda #$01
        sta $71
        jsr LD5FC
        jsr LD5DA
        lda $0502,x
        and #$FE
        tay
        lda Table0A,y
        sta $0A
        lda Table0A+1,y
        sta $0B
+       ldy $0500,x
        lda ($0A),y
        cmp #$FF
        bne +
        sta $0500,x
        jmp LD522

+       cmp $0501,x
        beq -
        inc $0501,x
        iny
        lda ($0A),y
        jsr $8296
        ldx PageIndex
        sta $0308,x
        lda ($0A),y
        jsr $832F
        ldx PageIndex
        sta $0309,x
        tay
        lda $0502,x
        lsr a
        bcc +
        tya
        jsr GetAbsolute
        sta $0309,x
+       jsr LD609
        bcs +
        jsr LD624
+       jmp CheckBulletStat

Table0A
        .dw Table0C     ; pointer to table #1 below
        .dw Table0D     ; pointer to table #2 below

; Table #1 (size: 25 bytes)

Table0C
        .db $01
        .db $F3
        .db $01
        .db $D3
        .db $01
        .db $93
        .db $01
        .db $13
        .db $01
        .db $53
        .db $01
        .db $73
        .db $01
        .db $73
        .db $01
        .db $53
        .db $01
        .db $13
        .db $01
        .db $93
        .db $01
        .db $D3
        .db $01
        .db $F3
        .db $FF

; Table #2 (size: 25 bytes)

Table0D
        .db $01
        .db $B7
        .db $01
        .db $B5
        .db $01
        .db $B1
        .db $01
        .db $B9
        .db $01
        .db $BD
        .db $01
        .db $BF
        .db $01
        .db $BF
        .db $01
        .db $BD
        .db $01
        .db $B9
        .db $01
        .db $B1
        .db $01
        .db $B5
        .db $01
        .db $B7
        .db $FF

; UpdateIceBullet
; ===============

        UpdateIceBullet:
        lda #$81
        sta $6B
        jmp UpdateBullet

; BulletExplode
; =============
; bullet/missile explode

        BulletExplode:
        lda #$01
        sta $71
        lda $0303,x
        sec
        sbc #$F7
        bne +
        sta ObjAction,x         ; kill bullet
+       jmp DrawBullet

LD5DA:  lda $030A,x
        beq Exit5
        lda #$00
        sta $030A,x
LD5E4:  lda #$1D
        ldy ObjAction,x
        cpy #wa_BulletExplode
        beq Exit5
        cpy #wa_Missile
        bne +
        lda #an_MissileExplode
+       jsr SetProjectileAnim
        lda #wa_BulletExplode
-       sta ObjAction,x
Exit5:  rts

LD5FC:  lda $030B,x
        lsr a
        bcs Exit5
--      lda #$00
        beq -         ; branch always
-       jmp LE81E

; bullet <--> background crash detection

LD609:  jsr GetObjCoords
        ldy #$00
        lda ($04),y     ; get tile # that bullet touches
        cmp #$A0
        bcs LD624
        jsr $95C0
        cmp #$4E
        beq -
        jsr LD651
        bcc ++
        clc
        jmp IsBlastTile

LD624:  ldx PageIndex
        lda $0309,x
        sta $05
        lda $0308,x
        sta $04
        jsr LE8BE
        jsr LFD8F
        bcc --
LD638:  lda $08
        sta ObjectY,x
        lda $09
        sta ObjectX,x
        lda $0B
        and #$01
        bpl +           ; branch always
        ToggleObjectHi:
        lda ObjectHi,x
        eor #$01
+       sta ObjectHi,x
++      rts

LD651:  ldy $74
        cpy #$10
        beq +
        cmp #$70
        bcs ++
+       cmp #$80
++      rts

LD65E:  lda #an_BombTick
        jsr SetProjectileAnim
        lda #$18        ; fuse length :-)
        sta $030F,x
        inc ObjAction,x       ; bomb update handler
        DrawBomb:
        lda #$03
        jmp AnimDrawObject

LD670:  lda FrameCount
        lsr a
        bcc ++          ; only update counter on odd frames
        dec $030F,x
        bne ++
        lda #$37
        ldy ObjAction,x
        cpy #$09
        bne +
        lda #an_BombExplode
+       jsr SetProjectileAnim
        inc ObjAction,x
        jsr SFX_BombExplode
++      jmp DrawBomb

LD691:  inc $030F,x
        jsr LD6A7
        ldx PageIndex
        lda $0303,x
        sec
        sbc #$F7
        bne +
        sta ObjAction,x     ; kill bomb
+       jmp DrawBomb

LD6A7:  jsr GetObjCoords
        lda $04
        sta $0A
        lda $05
        sta $0B
        ldx PageIndex
        ldy $030F,x
        dey
        beq ++
        dey
        bne +++
        lda #$40
        jsr LD78B
        txa
        bne +
        lda $04
        and #$20
        beq Exit6
+       lda $05
        and #$03
        cmp #$03
        bne ++
        lda $04
        cmp #$C0
        bcc ++
        lda ScrollDir
        and #$02
        bne Exit6
        lda #$80
        jsr LD78B
++      jsr LD76A
Exit6:  rts

+++     dey
        bne ++
        lda #$40
        jsr LD77F
        txa
        bne +
        lda $04
        and #$20
        bne Exit6
+       lda $05
        and #$03
        cmp #$03
        bne +
        lda $04
        cmp #$C0
        bcc +
        lda ScrollDir
        and #$02
        bne Exit6
        lda #$80
        jsr LD77F
+       jmp LD76A

++      dey
        bne ++
        lda #$02
        jsr LD78B
        txa
        bne +
        lda $04
        lsr a
        bcc Exit7
+       lda $04
        and #$1F
        cmp #$1E
        bcc +
        lda ScrollDir
        and #$02
        beq Exit7
        lda #$1E
        jsr LD77F
        lda $05
        eor #$04
        sta $05
+       jmp LD76A

++      dey
        bne Exit7
        lda #$02
        jsr LD77F
        txa
        bne +
        lda $04
        lsr a
        bcs Exit7
+       lda $04
        and #$1F
        cmp #$02
        bcs LD76A
        lda ScrollDir
        and #$02
        beq Exit7
        lda #$1E
        jsr LD78B
        lda $05
        eor #$04
        sta $05
LD76A:  txa
        pha
        ldy #$00
        lda ($04),y
        jsr LD651
        bcc +
        cmp #$A0
        bcs +
        jsr LE9C2
+       pla
        tax
Exit7:  rts

LD77F:  clc
        adc $0A
        sta $04
        lda $0B
        adc #$00
        jmp LD798

LD78B:  sta $00
        lda $0A
        sec
        sbc $00
        sta $04
        lda $0B
        sbc #$00
LD798:  and #$07
        ora #$60
        sta $05
-       rts

        GetObjCoords:
        ldx PageIndex
        lda ObjectY,x
        sta $02
        lda ObjectX,x
        sta $03
        lda ObjectHi,x
        sta $0B
        jmp MakeWRAMPtr

        UpdateElevator:
        ldx #$20
        stx PageIndex
        lda ObjAction,x
        jsr GoRoutine

; Pointer table to elevator handlers

        .dw ExitSub       ; rts
        .dw ElevatorIdle
        .dw $D80E
        .dw ElevatorMove
        .dw ElevatorScroll
        .dw $D8A3
        .dw $D8BF
        .dw $D8A3
        .dw ElevatorMove
        .dw ElevatorStop

        ElevatorIdle:
        lda SamusOnElevator
        beq ShowElevator
        lda #btn_DOWN
        bit $032F       ; elevator direction in bit 7 (1 = up)
        bpl +
        asl a           ; btn_UP
+       and JoyStatus
        beq ShowElevator
    ; start elevator!
        jsr LD147
        sty AnimDelay
        sty SamusGravity
        tya
        sta $0308,x
        inc ObjAction,x
        lda #sa_Elevator
        sta ObjAction
        lda #an_SamusFront
        jsr SetSamusAnim
        lda #128
        sta ObjectX     ; center
        lda #112
        sta ObjectY     ; center
        ShowElevator:
        lda FrameCount
        lsr a
        bcc -          ; only display elevator at odd frames
        jmp DrawFrame       ; display elevator

LD80E:  lda ScrollX
        bne +
        lda $FA
        ora #$08
        sta $FA
        lda ScrollDir
        and #$01
        sta ScrollDir
        inc ObjAction,x
        jmp ShowElevator

+       lda #$80
        sta ObjectX
        lda ObjectX,x
        sec
        sbc ScrollX
        bmi +
        jsr ScrollLeft
        jmp ShowElevator

+       jsr ScrollRight
        jmp ShowElevator

        ElevatorMove:
        lda $030F,x
        bpl ++          ; branch if elevator going down
    ; move elevator up one pixel
        ldy ObjectY,x
        bne +
        jsr ToggleObjectHi
        ldy #240
+       dey
        tya
        sta ObjectY,x
        jmp +++

    ; move elevator down one pixel
++      inc ObjectY,x
        lda ObjectY,x
        cmp #240
        bne +++
        jsr ToggleObjectHi
        lda #$00
        sta ObjectY,x
+++     cmp #$83
        bne +           ; move until Y coord = $83
        inc ObjAction,x
+       jmp ShowElevator

        ElevatorScroll:
        lda ScrollY
        bne ElevScrollRoom  ; scroll until ScrollY = 0
        lda #$4E
        sta AnimResetIndex
        lda #$41
        sta AnimIndex
        lda #$5D
        sta AnimResetIndex,x
        lda #$50
        sta AnimIndex,x
        inc ObjAction,x
        lda #$40
        sta Timer
        jmp ShowElevator

        ElevScrollRoom:
        lda $030F,x
        bpl +           ; branch if elevator going down
        jsr ScrollUp
        jmp ShowElevator

+       jsr ScrollDown
        jmp ShowElevator

LD8A3:  inc ObjAction,x
        lda ObjAction,x
        cmp #$08        ; ElevatorMove
        bne +
        lda #$23
        sta $0303,x
        lda #an_SamusFront
        jsr SetSamusAnim
        jmp ShowElevator

+       lda #$01
        jmp AnimDrawObject

LD8BF:  lda $030F,x
        tay
        cmp #$8F        ; Leads-To-Ending elevator?
        bne +
    ; Samus made it! YAY!
        lda #$07
        sta MainRoutine
        inc $6883
        ldy #$00
        sty $33
        iny
        sty SwitchPending   ; switch to bank 0
        lda #$1D        ; ending
        sta TitleRoutine
        rts

+       tya
        bpl ++
        ldy #$00
        cmp #$84
        bne +
        iny
+       tya
++      ora #$10
        jsr LCA18
        lda PalToggle
        eor #$07
        sta PalToggle
        ldy $74
        cpy #$12
        bcc +
        lda #$01
+       sta PalDataPending
        jsr WaitNMIPass_
        jsr SelectSamusPal
        jsr LD92C       ; start music
        jsr ScreenOn
        jsr CopyPtrs
        jsr DestroyEnemies
        ldx #$20
        stx PageIndex
        lda #$6B
        sta AnimResetIndex
        lda #$5F
        sta AnimIndex
        lda #$7A
        sta AnimResetIndex,x
        lda #$6E
        sta AnimIndex,x
        inc ObjAction,x
        lda #$40
        sta Timer
        rts

; start music

LD92C:  lda $0320
        cmp #$06
        bne +
        lda $032F
        bmi ++
+       lda $95CD
        ldy $79
        bmi +++
        beq +++
++      lda #$81
        sta $79
        lda #$20
+++     ora $0685
        sta $0685
        rts

        ElevatorStop:
        lda ScrollY
        bne ++          ; scroll until ScrollY = 0
        lda #sa_Stand
        sta ObjAction
        jsr LCF55
        ldx PageIndex   ; #$20
        lda #$01        ; ElevatorIdle
        sta ObjAction,x
        lda $030F,x
        eor #$80        ; switch elevator direction
        sta $030F,x
        bmi +
        jsr ToggleScroll
        sta $FA
+       jmp ShowElevator
++      jmp ElevScrollRoom

LD976:  lda #$00
        sta SamusOnElevator
        sta $7D
        tay
        ldx #$50
        jsr LF186
-       lda $6AF4,x
        cmp #$04
        bne +
        jsr LF152
        jsr LF1BF
        jsr LF1FA
        bcs +
        jsr LD9BA
        bne +
        inc $7D
        bne ++
+       jsr Xminus16
        bpl -
++      lda $0320
        beq +
        ldy #$00
        ldx #$20
        jsr LDC82
        bcs +
        jsr LD9BA
        bne +
        inc SamusOnElevator     ; Samus is standing on elevator
+       rts

LD9BA:  lda $10
        and #$02
        bne +
        ldy $11
        iny
        cpy $04
        beq Exit8
+       lda $030A
        and #$38
        ora $10
        ora #$40
        sta $030A
Exit8:  rts

; UpdateStatues
; =============

        UpdateStatues:
        lda #$60
        sta PageIndex
        ldy $0360
        beq Exit8           ; exit if no statue present
        dey
        bne +
        jsr LDAB0
        ldy #$01
        jsr LDAB0
        bcs +
        inc $0360
+       ldy $0360
        cpy #$02
        bne ++
        lda $687B
        bpl +
        ldy #$02
        jsr LDAB0
+       lda $687C
        bpl +
        ldy #$03
        jsr LDAB0
+       bcs ++
        inc $0360
++      ldx #$60
        jsr LDA1A
        ldx #$61
        jsr LDA1A
        jmp LDADA

LDA1A:  jsr LDA3D
        jsr LDA7C
        txa
        and #$01
        tay
        lda LDA3B,y
        sta $0363
        lda $681B,x
        beq +
        bmi +
        lda FrameCount
        lsr a
        bcc ++          ; only display statue at odd frames
+       jmp DrawFrame       ; display statue

LDA39:  .db $88
        .db $68
LDA3B:  .db $65
        .db $66

LDA3D:  lda $0304,x
        bmi ++
        lda #$01
        sta $0304,x
        lda $030F,x
        and #$0F
        beq ++
        inc $0304,x
        dec $030F,x
        lda $030F,x
        and #$0F
        bne ++
        lda $0304,x
        ora #$80
        sta $0304,x
        sta $681B,x
        inc $0304,x
        txa
        pha
        and #$01
        pha
        tay
        jsr LDAB0
        pla
        tay
        iny
        iny
        jsr LDAB0
        pla
        tax
++      rts

LDA7C:  lda $030F,x
        sta $036D
        txa
        and #$01
        tay
        lda LDA39,y
        sta $036E
        lda $681B,x
        beq +
        bmi +
        lda $0304,x
        cmp #$01
        bne +
        lda $0306,x
        beq +
        dec $030F,x
        lda $0683
        ora #$10
        sta $0683
+       lda #$00
        sta $0306,x
        rts

LDAB0:  lda Table0E,y
        sta $05C8
        lda $036C
        asl a
        asl a
        ora Table1B,y
        sta $05C9
        lda #$09
        sta $05C3
        lda #$C0
        sta PageIndex
        jsr DrawTileBlast
        lda #$60
        sta PageIndex
        rts

; Table used by above subroutine

Table0E
        .db $30
        .db $AC
        .db $F0
        .db $6C
Table1B
        .db $61
        .db $60
        .db $60
        .db $60

LDADA:  lda $54
        bmi Exit0
        lda DoorStatus
        bne Exit0
        lda $687B
        and $687C
        bpl Exit0
        sta $54
        ldx #$70
        ldy #$08
-       lda #$03
        sta $0500,x
        tya
        asl a
        sta $0507,x
        lda #$04
        sta TileType,x
        lda $036C
        asl a
        asl a
        ora #$62
        sta TileWRAMHi,x
        tya
        asl a
        adc #$08
        sta TileWRAMLo,x
        jsr Xminus16
        dey
        bne -
Exit0:  rts

; CheckMissileToggle
; ==================
; Toggles between bullets/missiles (if Samus has any missiles).

        CheckMissileToggle:
        lda MissileCount
        beq Exit0       ; exit if Samus has no missiles
        lda JoyFirst
        ora JoyRetrig
        and #btn_SELECT
        beq Exit0       ; exit if SELECT not pressed
        lda MissileToggle
        eor #$01        ; 0 = fire bullets, 1 = fire missiles
        sta MissileToggle
        jmp SelectSamusPal

; MakeBitMask
; ===========
; in: Y = bit index
; out: A = bit Y set, other 7 bits zero

        MakeBitMask:
        sec
        lda #$00
-       rol a
        dey
        bpl -
-       rts

; UpdateItems
; ===========

        UpdateItems:
        lda #$40
        sta PageIndex
        ldx #$00
        jsr LDB42
        ldx #$08
LDB42:  stx $4C
        ldy $0748,x
        iny
        beq -
        lda $0749,x
        sta $034D
        lda $074A,x
        sta $034E
        lda $074B,x
        sta $034C
        jsr GetObjCoords
        ldx $4C
        ldy #$00
        lda ($04),y
        cmp #$A0
        bcc -
        lda $0748,x
        and #$0F
        ora #$50
        sta $0343
        lda FrameCount
        lsr a
        and #$03
        ora #$80
        sta $6B
        lda SpritePagePos
        pha
        lda $074F,x
        jsr DrawFrame       ; display special item
        pla
        cmp SpritePagePos
        beq Exit9
        tax
        ldy $4C
        lda $0748,y
        ldy #$01
        cmp #$07
        beq +
        dey
        cmp #$06
        beq +
        cmp #$02
        bne ++
+       tya
        sta $0206,x
        lda #$FF
++      pha
        ldx #$00
        ldy #$40
        jsr LDC7F
        pla
        bcs Exit9
        tay
        jsr PowerUpMusic
        ldx $4C
        iny
        beq +
        lda $074B,x
        sta $08
        lda $0748,x
        sta $09
        jsr LDC1C
+       lda $0748,x
        tay
        cpy #$08
        bcs ++
        cpy #$06
        bcc +
        lda SamusGear
        and #$3F
        sta SamusGear
+       jsr MakeBitMask
        ora SamusGear
        sta SamusGear
-       lda #$FF
        sta $0109
        sta $0748,x
        ldy $79
        beq +
        ldy #$01
+       sty $79
        jmp SelectSamusPal
Exit9:  rts

++      beq +
        lda #5
        jsr AddToMaxMissiles
        bne -           ; branch always
+       lda TankCount
        cmp #$06        ; has Samus got 6 energy tanks?
        beq +           ; then she can't have any more
        inc TankCount   ; otherwise give her a new tank
+       lda TankCount
        jsr Amul16      ; shift into upper nibble
        ora #$09
        sta HealthHi
        lda #$99
        sta HealthLo    ; health is now FULL!
        bne -           ; branch always

LDC1C:  lda MapPosX
        sta $07
        lda MapPosY
        sta $06
        lda ScrollDir
        lsr a
        php
        beq ++
        bcc +
        lda ScrollX
        beq +
        dec $07
        bcs +
++      bcc +
        lda ScrollY
        beq +
        dec $06
+       lda PPUCNT0ZP
        eor $08
        and #$01
        plp
        clc
        beq +
        adc $07
        sta $07
        jmp LDC51

+       adc $06
        sta $06
LDC51:  jsr LDC67
LDC54:  ldy $6886
        lda $06
        sta $6887,y
        lda $07
        sta $6888,y
        iny
        iny
        sty $6886
        rts

LDC67:  lda $07
        jsr Amul32       ; * 32
        ora $06
        sta $06
        lsr $07
        lsr $07
        lsr $07
        lda $09
        asl a
        asl a
        ora $07
        sta $07
        rts

LDC7F:  jsr LF186
LDC82:  jsr LF172
        jsr LF1A7
        jmp LF1FA

; Table

Table0F
        .db $00
        .db $80
        .db $C0
        .db $40

; UpdateObjAnim
; =============
; Advance to object's next frame of animation

        UpdateObjAnim:
        ldx PageIndex
        ldy AnimDelay,x
        beq +           ; is it time to advance to the next anim frame?
        dec AnimDelay,x     ; nope
        bne ++          ; exit if still not zero (don't update animation)
+       sta AnimDelay,x     ; set initial anim countdown value
        ldy AnimIndex,x
-       lda $8572,y     ; load frame number
        cmp #$FF        ; has end of anim been reached?
        beq +
        sta AnimFrame,x     ; store frame number
        iny             ; inc anim index
        tya
        sta AnimIndex,x     ; store anim index
++      rts

+       ldy AnimResetIndex,x     ; reset anim frame index
        jmp -           ; do first frame of animation

LDCB7:  pha
        lda #$00
        sta $06
        pla
        bpl +
        dec $06
+       clc
        rts

LDCC3:  ldy #$00
        sty $0F
        lda ($00),y
        sta $04
        tax
        jsr Adiv16       ; / 16
        and #$03
        sta $05
        txa
        and #$C0
        ora #$20
        ora $05
        sta $05
        lda $6B
        and #$10
        asl a
        asl a
        eor $04
        sta $04
        lda $6B
        bpl +
        asl $6B
        jsr LE038
+       txa
        and #$0F
        asl a
        tax
        rts

LDCF5:  jsr LDF2D
        pla
        pla
        ldx PageIndex
LDCFC:  lda $74
        cmp #$13
        bne +
        lda $6B02,x
        cmp #$04
        beq ++
        cmp #$02
        beq ++
+       lda $040C,x
        asl a
        bmi LDD75
        jsr LF74B
        sta $00
        jsr $80B0
        and #$20
        sta $6B02,x
        lda #$05
        sta $6AF4,x
        lda #$60
        sta $040D,x
        lda $2E
        cmp #$10
        bcc LDD5B
--      and #$07
        tay
        lda Table88,y
        sta $6AF7,x
        cmp #$80
        bne +
        ldy $93
        cpy $95
        beq LDD5B
        lda MaxMissiles
        beq LDD5B
        inc $95
-       rts

+       ldy $94
        cpy $96
        beq LDD5B
        inc $96
        cmp #$89
        bne -
        lsr $00
        bcs -
LDD5B:  ldx PageIndex
        lda $74
        cmp #$13
        beq +
++      jmp KillObject

+       lda $2E
        ldy #$00
        sty $96
        sty $95
        iny
        sty $93
        sty $94
        bne --

LDD75:  jsr PowerUpMusic
        lda $74
        and #$0F
        sta $0108
        lsr a
        tay
        sta MaxMissiles,y
        lda #75
        jsr AddToMaxMissiles
        bne LDD5B
LDD8B:  ldx PageIndex
        lda $6AF7,x
        cmp #$F7
        bne ++
        jmp LDF2D

; AddToMaxMissiles
; ================
; Adds A to both MissileCount & MaxMissiles, storing the new count
; (255 if it overflows)

        AddToMaxMissiles:
        pha
        clc
        adc MissileCount
        bcc +
        lda #$FF
+       sta MissileCount
        pla
        clc
        adc MaxMissiles
        bcc +
        lda #$FF
+       sta MaxMissiles
        rts

++      lda $0400,x
        sta $0A         ; Y coord
        lda $0401,x
        sta $0B         ; X coord
        lda $6AFB,x
        sta $06         ; hi coord
        lda $6AF7,x
        asl a
        tay
        lda ($41),y
        bcc +
        lda ($43),y
+       sta $00
        iny
        lda ($41),y
        bcc +
        lda ($43),y
+       sta $01
        jsr LDCC3
        tay
        lda ($45),y
        sta $02
        iny
        lda ($45),y
        sta $03
        ldy #$00
        cpx #$02
        bne +
        ldx PageIndex
        inc $0406,x
        lda $0406,x
        pha
        and #$03
        tax
        lda $05
        and #$3F
        ora Table0F,x
        sta $05
        pla
        cmp #$19
        bne +
        jmp LDCF5

+       ldx PageIndex
        iny
        lda ($00),y
        sta $6AF5,x
        jsr LDE3D
        iny
        lda ($00),y
        sta $6AF6,x
        sta $09
        iny
        sty $11
        jsr LDFDF
        txa
        asl a
        sta $08
        ldx PageIndex
        lda $0405,x
        and #$FD
        ora $08
        sta $0405,x
        lda $08
        beq ++
        jmp LDEDE

; Table

Table88
        .db $80
        .db $81
        .db $89
        .db $80
        .db $81
        .db $89
        .db $81
        .db $89

LDE3D:  sec
        sbc #$10
        bcs +
        lda #$00
+       sta $08
        rts

        AnimDrawObject:
        jsr UpdateObjAnim
        DrawFrame:
        ldx PageIndex
        lda AnimFrame,x
        cmp #$F7            ; is the frame valid?
        bne +               ; branch if yes
++      jmp LDF2D
+       cmp #$07
        bne +
        lda $6B
        and #$EF
        sta $6B
+       lda ObjectY,x
        sta $0A
        lda ObjectX,x
        sta $0B
        lda ObjectHi,x
        sta $06
        lda AnimFrame,x
        asl a
        tax
        lda FramePtrTable,x
        sta $00
        lda FramePtrTable+1,x
        sta $01
        jsr LDCC3
        lda PlacePtrTable,x
        sta $02
        lda PlacePtrTable+1,x
        sta $03
        lda IsSamus
        beq +
    ; special case for Samus
        cpx #$0E
        bne +
        ldx PageIndex
        inc $65
        lda $65
        pha
        and #$03
        tax
        lda $05
        and #$3F
        ora Table0F,x
        sta $05
        pla
        cmp #$19
        bne +
        ldx PageIndex
        lda #$08
        sta ObjAction,x
        lda #$28
        sta AnimDelay,x
        pla
        pla
        jmp LDF2D

+       ldx PageIndex
        iny
        lda ($00),y
        sta ObjRadY,x
        jsr LDE3D
        iny
        lda ($00),y
        sta ObjRadX,x
        sta $09
        iny
        sty $11
        jsr LDFDF
        txa
        ldx PageIndex
        sta $030B,x
        tax
        beq +
LDEDE:  ldx SpritePagePos
        jmp LDF19       ; start drawing object

+       jmp LDF2D
-       ldy $0F         ; placement data pos
        jsr LDF6B
        adc $10         ; add initial Y pos
        sta SpriteRAM,x     ; store sprite Y coord
        dec SpriteRAM,x     ; because PPU uses Y + 1 as real Y coord
        inc $0F         ; advance to X placement
        ldy $11         ; frame data pos
        lda ($00),y     ; tile value
        sta SpriteRAM+1,x
        lda $6B
        asl a
        asl a
        and #$40
        eor $05
        sta SpriteRAM+2,x
        inc $11
        ldy $0F
        jsr LDFA3
        adc $0E         ; add initial X pos
        sta SpriteRAM+3,x     ; store sprite X coord
        inc $0F         ; advance to next placement
        inx             ; advance
        inx             ;  to
        inx             ;  next
        inx             ;  sprite
LDF19:  ldy $11         ; get frame data pos
LDF1B:  lda ($00),y
        cmp #$FC
        bcc -           ; if < FC, do another tile
        beq +++
        cmp #$FD
        beq ++
        cmp #$FE
        beq +
        stx SpritePagePos
LDF2D:  lda #$00
        sta $6B
        rts

+       inc $0F
        inc $0F
        inc $11
        jmp LDF19

++      iny
        asl $6B
        bcc +
        jsr LE038
        bne ++
+       lsr $6B
        lda ($00),y
        sta $05
++      iny
        sty $11
        jmp LDF1B

+++     iny
        lda ($00),y
        clc
        adc $10
        sta $10
        inc $11
        inc $11
        ldy $11
        lda ($00),y
        clc
        adc $0E
        sta $0E
        inc $11
        jmp LDF19

LDF6B:  lda ($02),y
        tay
        and #$F0
        cmp #$80
        beq +
        tya
-       bit $04
        bmi LDFB1
        clc
        rts

+       tya
        and #$0E
        lsr a
        tay
        lda Table10,y
        ldy IsSamus
        bne +
        ldy PageIndex
        adc $0406,y
        jmp ++
    ; special case for Samus
+       adc $65
++      tay
        lda Table10+2,y
        pha
        lda $0F
        clc
        adc #$0C
        tay
        pla
        clc
        adc ($02),y
        jmp -

LDFA3:  lda ($02),y
        tay
        and #$F0
        cmp #$80
        beq ++
        tya
-       bit $04
        bvc +
LDFB1:  eor #$FF
        sec
        adc #$F8
+       clc
        rts

++      ldy PageIndex
        lda $0406,y
        ldy IsSamus
        beq +
        lda $65
+       asl a
        pha
        ldy $0F
        lda ($02),y
        lsr a
        bcs +
        pla
        eor #$FF
        adc #$01
        pha
+       lda $0F
        clc
        adc #$0C
        tay
        pla
        clc
        adc ($02),y
        jmp -

LDFDF:  ldx #$01
        lda $0A         ; ObjectY
        tay
        sec
        sbc ScrollY
        sta $10         ; ScreenY
        lda $0B         ; ObjectX
        sec
        sbc ScrollX
        sta $0E         ; ScreenX
        lda ScrollDir
        and #$02
        bne LE01C
        cpy ScrollY
        lda $06
        eor PPUCNT0ZP
        and #$01
        beq +
        bcs ++
        lda $10
        sbc #$0F
        sta $10
        lda $09
        clc
        adc $10
        cmp #$F0
        bcc +++
        clc
+       bcc ++
        lda $09
        cmp $10
        bcc +++
++      dex
+++     rts

LE01C:  lda $06
        eor PPUCNT0ZP
        and #$01
        beq +
        bcs ++
        lda $09
        clc
        adc $0E
        bcc +++
        clc
+       bcc ++
        lda $09
        cmp $0E
        bcc +++
++      dex
+++     rts

LE038:  lsr $6B
        lda ($00),y
        and #$C0
        ora $6B
        sta $05
        lda $6B
        ora #$80
        sta $6B
        rts

; Table

Table10
        .db $00
        .db $18
        .db $30
        .db $FC
        .db $F8
        .db $F4
        .db $F0
        .db $EE
        .db $EC
        .db $EA
        .db $E8
        .db $E7
        .db $E6
        .db $E6
        .db $E5
        .db $E5
        .db $E4
        .db $E4
        .db $E3
        .db $E5
        .db $E7
        .db $E9
        .db $EB
        .db $EF
        .db $F3
        .db $F7
        .db $FB
        .db $FE
        .db $FC
        .db $FA
        .db $F8
        .db $F6
        .db $F4
        .db $F2
        .db $F0
        .db $EE
        .db $ED
        .db $EB
        .db $EA
        .db $E9
        .db $E8
        .db $E7
        .db $E6
        .db $E6
        .db $E6
        .db $E6
        .db $E6
        .db $E8
        .db $EA
        .db $EC
        .db $EE
        .db $FE
        .db $FC
        .db $FA
        .db $F8
        .db $F7
        .db $F6
        .db $F5
        .db $F4
        .db $F3
        .db $F2
        .db $F1
        .db $F1
        .db $F0
        .db $F0
        .db $EF
        .db $EF
        .db $EF
        .db $EF
        .db $EF
        .db $EF
        .db $F0
        .db $F0
        .db $F1
        .db $F2

; UpdateEnemyAnim
; ===============
; Advance to next frame of enemy's animation.
; Basically the same as UpdateSamusAnim, only for enemies.

        UpdateEnemyAnim:
        ldx PageIndex
        ldy $6AF4,x
        cpy #$05
        beq ++
        ldy $6AF8,x     ; anim delay
        beq +
        dec $6AF8,x
        bne ++
+       sta $6AF8,x
        ldy $6AFA,x     ; anim index
-       lda (EnemyAnimPtr),y
        cmp #$FF        ; end of anim?
        beq +++
        sta $6AF7,x     ; frame
        iny
        tya
        sta $6AFA,x     ; anim index
++      rts

+++     ldy $6AF9,x     ; reset anim index
        bcs -

; DisplayBar
; ==========
; Displays Samus' status bar components.

        DisplayBar:
        ldy #$00
        lda SpritePagePos
        pha             ; save sprite page pos
        tax
-       lda DataDisplay,y
        sta SpriteRAM,x
        inx
        iny
        cpy #40
        bne -
        stx SpritePagePos
        pla             ; restore initial sprite page pos
        tax
        lda HealthHi
        and #$0F        ; upper health digit
        jsr SPRWriteDigit
        lda HealthLo     
        jsr Adiv16      ; lower health digit
        jsr SPRWriteDigit
        ldy EndTimerHi
        iny
        bne ++          ; branch if Samus is in escape sequence
        ldy MaxMissiles
        beq +           ; don't show missile count if Samus has no containers
; display 3-digit missile count
        lda MissileCount
        jsr HexToDec
        lda $02         ; upper digit
        jsr SPRWriteDigit
        lda $01         ; middle digit
        jsr SPRWriteDigit
        lda $00         ; lower digit
        jsr SPRWriteDigit
        bne +++         ; branch always
; Samus has no missiles, erase missile sprite
+       lda #$FF        ; "blank" tile
        cpx #$F4
        bcs +++
        sta $020D,x     ; erase left half of missile
        cpx #$F0
        bcs +++
        sta $0211,x     ; erase right half of missile
        bne +++         ; branch always
; display 3-digit end sequence timer
++      lda EndTimerHi
        jsr Adiv16      ; upper timer digit
        jsr SPRWriteDigit
        lda EndTimerHi
        and #$0F        ; middle timer digit
        jsr SPRWriteDigit
        lda EndTimerLo
        jsr Adiv16      ; lower timer digit
        jsr SPRWriteDigit
        lda #$58        ; "TI"  sprite (left half of "TIME")
        sta SpriteRAM+1,x
        inc SpriteRAM+2,x
        cpx #$FC
        bcs +++
        lda #$59        ; "ME" sprite (right half of "TIME")
        sta SpriteRAM+5,x
        inc SpriteRAM+6,x
+++     ldx SpritePagePos
        lda TankCount
        beq ++          ; exit if Samus has no tanks
; display full/empty energy tanks
        sta $03         ; temp store tank count
        lda #$40        ; X coord of right-most energy tank
        sta $00         ; (they are drawn from right to left)
        ldy #$6F        ; "full energy tank" tile
        lda HealthHi
        jsr Adiv16      ; / 16. A contains # of full energy tanks
        sta $01
        bne AddTanks    ; branch if at least 1 tank is full
        dey             ; else switch to "empty energy tank" tile

        AddTanks:
        jsr AddOneTank
        dec $01         ; any more full energy tanks left?
        bne +           ; branch if yes
        dey             ; otherwise, switch to "empty energy tank" tile
+       dec $03         ; done all tanks?
        bne AddTanks    ; if not, do another

        stx SpritePagePos
++      rts

; SPRWriteDigit
; =============
; In: A = value in range 0..9.
; #$A0 is added to A (the number sprites begin at $A0),
; and the result is stored as the tile # for the sprite indexed by X.

        SPRWriteDigit:
        ora #$A0
        sta SpriteRAM+1,x
        jmp Xplus4

; Add missile container to Samus' data display

        AddOneTank:
        lda #$17        ; Y coord - 1
        sta SpriteRAM,x
        tya             ; tile value
        sta SpriteRAM+1,x
        lda #$01        ; palette #
        sta SpriteRAM+2,x
        lda $00         ; X coord
        sta SpriteRAM+3,x
        sec
        sbc #$0A
        sta $00         ; X coord of next energy tank
        Xplus4:
        inx
        inx
        inx
        inx
        rts

; HexToDec
; ========
; Convert 8-bit value in A to 3 decimal digits.
; Upper digit stored in $02, middle in $01 and lower in $00.

        HexToDec:
        ldy #100
        sty $0A
        jsr GetDigit
        sty $02
        ldy #10
        sty $0A
        jsr GetDigit
        sty $01
        sta $00
        rts

        GetDigit:
        ldy #$00
        sec
-       iny
        sbc $0A
        bcs -
        dey
        adc $0A
        rts

; Sprite data for Samus' data display

        DataDisplay:
        .db $21,$A0,$01,$30     ; Upper health digit
        .db $21,$A0,$01,$38     ; Lower health digit
        .db $2B,$FF,$01,$28     ; Upper missile digit
        .db $2B,$FF,$01,$30     ; Middle missile digit
        .db $2B,$FF,$01,$38     ; Lower missile digit
        .db $2B,$5E,$00,$18     ; Left half of missile
        .db $2B,$5F,$00,$20     ; Right half of missile
        .db $21,$76,$01,$18     ; E
        .db $21,$7F,$01,$20     ; N
        .db $21,$3A,$00,$28     ; ..

; BitScan
; =======
; Input: A = any value.
; Output: A = index of first bit of A that's set (0..7, 8 if none set).

        BitScan:
        stx $0E         ; preserve X
        ldx #$00        ; first bit is bit 0
-       lsr a           ; transfer bit to carry flag
        bcs +           ; if the shifted bit was 1, we're done
        inx
        cpx #$08        ; tested all 8 bits?
        bne -
+       txa
        ldx $0E         ; restore X
-       rts

; ScrollDoor
; ==========
; Scrolls the screen if Samus is inside a door.

        ScrollDoor:
        ldx DoorStatus
        beq -           ; exit if Samus isn't in a door
        dex
        bne +
        jsr ScrollRight ; DoorStatus = 1 --> scroll 1 pixel right
        jmp ++

+       dex
        bne +
        jsr ScrollLeft  ; DoorStatus = 2 --> scroll 1 pixel left
++      ldx ScrollX
        bne Exit15
    ; scrolled one full screen, time to exit door
        ldx #$05
        bne DoneDoorScroll
+       dex
        bne +
        jsr ScrollDown
        jmp ++
+       dex
        bne Exit15
        jsr ScrollUp
++      ldx ScrollY
        bne Exit15
        stx $6C
        stx $6D
        inx
        lda ObjectX
        bmi ++
        inx
        bne ++
        DoneDoorScroll:
        lda #$20
        sta DoorDelay
        lda $58
        jsr Amul8       ; * 8
        bcs +
        ldy $57
        cpy #$03
        bcc ++
+       lda #$47
        bne +++
++      jsr ToggleScroll
+++     sta $FA
        stx $56         ; = 5
        Exit15:
        rts

        ToggleSamusHi:
        lda ObjectHi
        eor #$01
        sta ObjectHi
        rts

; ToggleScroll
; ============
; Toggles both mirroring and scroll direction when Samus has moved from
; a horizontal shaft to a vertical shaft or vice versa.

        ToggleScroll:
        lda ScrollDir
        eor #$03
        sta ScrollDir
        lda $FA
        eor #$08
        rts

LE25D:  lda #$01
        cmp ScrollDir
        bcs Exit21
        lda #$D8
        cmp ObjectY
Exit21: rts

LE269:  lda ObjAction
        cmp #sa_Elevator    ; is Samus in elevator?
        beq +
        cmp #sa_Dead
        bcs Exit21
+       jsr LE25D
        ldy #$FF
        bcs +++
        sty $72
        jsr LF323
        lda #$32
        sta SamusBlink
        lda FrameCount
        and #$03
        bne +
        jsr SFX_SamusJump
+       lda FrameCount
        lsr a
        and #$03
        bne ++
        lda SamusGear
        and #gr_VARIA
        beq +       ; branch if Samus doesn't have Varia
        bcc ++
+       lda #$07
        sta $6E
        jsr LCE92
++      ldy #$00
+++     iny
        sty $64
        jsr LE37A
        lda ObjectY
        sec
        sbc ScrollY
        sta SamusScrY
        lda $00
        bpl ++
        jsr GetAbsolute
        ldy $64
        beq +
        lsr a
        beq LE31A
+       sta $65
-       jsr MoveSamusUp
        bcs +
        sec
        ror $0308
        ror $0312
        jmp LE31A
+       dec $65
        bne -
++      beq LE31A
        ldy $64
        beq +
        lsr a
        lsr a
        beq LE31A
+       sta $65
-       jsr MoveSamusDown
        bcs +++
        lda ObjAction
        cmp #sa_Roll
        bne +
        lsr $0308
        beq ++
        ror $0312
        lda #$00
        sec
        sbc $0312
        sta $0312
        lda #$00
        sbc $0308
        sta $0308
        jmp LE31A

+       jsr SFX_SamusWalk       ; Samus has hit ground, make sum noise
++      jsr LD147
        sty SamusGravity
        beq LE31A
+++     dec $65
        bne -
LE31A:  jsr LE3E5
        lda ObjectX
        sec
        sbc ScrollX
        sta SamusScrX
        lda $00
        bpl ++
        jsr GetAbsolute
        ldy $64
        beq +
        lsr a
        beq Exit10
+       sta $65
-       jsr MoveSamusLeft
        jsr LE365
        dec $65
        bne -
        lda $58
        beq Exit10
        lda #$01        ; door leads to the left
        bne +++         ; branch always
++      beq Exit10
        ldy $64
        beq +
        lsr a
        beq Exit10
+       sta $65
-       jsr MoveSamusRight
        jsr LE365
        dec $65
        bne -
        lda $58
        beq Exit10
        lda #$00        ; door leads to the right
+++     sta SamusDoorDir
Exit10: rts

LE365:  bcs Exit10
        lda #$01
        sta $65
        lda SamusGravity
        bne Exit10
        lda ObjAction
        cmp #sa_Roll
        beq Exit10
        jmp LCF55

LE37A:  lda SamusGravity
        bne ++
        lda #$18
        sta $0316
        lda ObjectY
        clc
        adc ObjRadY
        and #$07
        bne +
        jsr CheckMoveDown       ; check if Samus obstructed DOWNWARDS
        bcc ++          ; branch if yes
+       jsr LD976
        lda SamusOnElevator
        bne ++
        lda $7D
        bne ++
        lda #$1A
        sta SamusGravity
++      ldx #$05
        lda $0312
        clc
        adc SamusGravity
        sta $0312
        lda $0308
        adc #$00
        sta $0308
        bpl +
        lda #$00
        cmp $0312
        sbc $0308
        cmp #$06
        ldx #$FA
        bne ++
+       cmp #$05
++      bcc +
        jsr LD147
        stx $0308
+       lda $0310
        clc
        adc $0312
        sta $0310
        lda #$00
        adc $0308
        sta $00
        rts

LE3E5:  lda $0316
        jsr Amul16       ; * 16
        sta $00
        sta $02
        lda $0316
        jsr Adiv16       ; / 16
        sta $01
        sta $03
        lda $0313
        clc
        adc $0315
        sta $0313
        tax
        lda #$00
        bit $0315
        bpl +
        lda #$FF
+       adc $0309
        sta $0309
        tay
        bpl +
        lda #$00
        sec
        sbc $0313
        tax
        lda #$00
        sbc $0309
        tay
        jsr LE449
+       cpx $02
        tya
        sbc $03
        bcc +
        lda $00
        sta $0313
        lda $01
        sta $0309
+       lda $0311
        clc
        adc $0313
        sta $0311
        lda #$00
        adc $0309
        sta $00
        rts

LE449:  lda #$00
        sec
        sbc $00
        sta $00
        lda #$00
        sbc $01
        sta $01
        rts

; attempt to move Samus one pixel up

        MoveSamusUp:
        lda ObjectY
        sec
        sbc ObjRadY
        and #$07
        bne +           ; only call crash detection every 8th pixel
        jsr CheckMoveUp ; check if Samus obstructed UPWARDS
        bcc +++         ; exit if yes (can't move any further)
+       lda ObjAction
        cmp #sa_Elevator    ; is Samus in elevator?
        beq +
        jsr LD976
        lda $030A
        and #$42
        cmp #$42
        clc
        beq +++
+       lda SamusScrY
        cmp #$66        ; reached up scroll limit?
        bcs +           ; branch if not
        jsr ScrollUp
        bcc ++
+       dec SamusScrY
++      lda ObjectY
        bne ++
        lda ScrollDir
        and #$02
        bne +
        jsr ToggleSamusHi       ; toggle 9th bit of Samus' Y coord
+       lda #240
        sta ObjectY
++      dec ObjectY
        inc $030F
        sec
+++     rts

; attempt to move Samus one pixel down

        MoveSamusDown:
        lda ObjectY
        clc
        adc ObjRadY
        and #$07
        bne +                   ; only call crash detection every 8th pixel
        jsr CheckMoveDown       ; check if Samus obstructed DOWNWARDS
        bcc +++         ; exit if yes
+       lda ObjAction
        cmp #sa_Elevator        ; is Samus in elevator?
        beq +
        jsr LD976
        lda SamusOnElevator
        clc
        bne +++
        lda $7D
        bne +++
+       lda SamusScrY
        cmp #$84        ; reached down scroll limit?
        bcc +           ; branch if not
        jsr ScrollDown
        bcc ++
+       inc SamusScrY
++      lda ObjectY
        cmp #239
        bne ++
        lda ScrollDir
        and #$02
        bne +
        jsr ToggleSamusHi       ; toggle 9th bit of Samus' Y coord
+       lda #$FF
        sta ObjectY
++      inc ObjectY
        dec $030F
        sec
+++     rts

; Attempt to scroll UP

        ScrollUp:
        lda ScrollDir
        beq +
        cmp #$01
        bne +++
        dec ScrollDir
        lda ScrollY
        beq +
        dec MapPosY
+       ldx ScrollY
        bne +
        dec MapPosY     ; decrement MapY
        jsr GetRoomNum  ; put room # at current map pos in $5A
        bcs ++   ; if function returns CF = 1, moving up is not possible
        jsr LE9B7       ; switch to the opposite Name Table
        ldx #240        ; new Y coord
+       dex
        jmp LE53F

++      inc MapPosY
+++     sec
        rts

; Attempt to scroll DOWN

        ScrollDown:
        ldx ScrollDir
        dex
        beq +
        bpl +++
        inc ScrollDir
        lda ScrollY
        beq +
        inc MapPosY
+       lda ScrollY
        bne +
        inc MapPosY     ; increment MapY
        jsr GetRoomNum  ; put room # at current map pos in $5A
        bcs ++   ; if function returns CF = 1, moving down is not possible
+       ldx ScrollY
        cpx #239
        bne +
        jsr LE9B7       ; switch to the opposite Name Table
        ldx #$FF
+       inx
LE53F:  stx ScrollY
        jsr LE54A       ; check if it's time to update Name Table
        clc
        rts

++      dec MapPosY
+++     sec
-       rts

LE54A:  jsr SetupRoom
        ldx RoomNumber
        inx
        bne -
        lda ScrollDir
        and #$02
        bne +
        jmp LE571
+       jmp LE701

; Table

Table11
        .db $07
        .db $00

PPUAddrs
        .db $20         ; hi byte of nametable #0 (PPU)
        .db $2C         ; hi byte of nametable #1 (PPU)
WRAMAddrs
        .db $60         ; hi byte of nametable #0 (WRAM)
        .db $64         ; hi byte of nametable #1 (WRAM)

        GetNameAddrs:
        jsr LEB85
        and #$01        ; A = nametable to update
        tay
        lda PPUAddrs,y  ; get high PPU addr of nametable (dest)
        ldx WRAMAddrs,y ; get high WRAM addr of nametable (src)
        rts

; check if it's time to update nametable (when scrolling is VERTICAL)

LE571:  ldx ScrollDir
        lda ScrollY
        and #$07        ; compare value = 0 if ScrollDir = down, else 7
        cmp Table11,x
        bne -           ; exit if not equal (no nametable update)
LE57C:  ldx ScrollDir
        cpx $4A
        bne -
        lda ScrollY
        and #$F8        ; keep upper 5 bits
        sta $00
        lda #$00
        asl $00
        rol a
        asl $00
        rol a
LE590:  sta $01         ; $0001 = (ScrollY & 0xF8) << 2 = row offset
        jsr GetNameAddrs
        ora $01
        sta $03
        txa
        ora $01
        sta $01
        lda $00
        sta $02
        lda ScrollDir
        lsr a           ; A = 0 if vertical scrolling, 1 if horizontal
        tax
        lda Table01,x
        sta $04
        ldy #$01
        sty PPUDataPending      ; data pending = YES
        dey
        ldx PPUStrIndex
        lda $03
        jsr WritePPUByte
        lda $02
        jsr WritePPUByte
        lda $04
        jsr LC3C6
-       lda ($00),y
        jsr WritePPUByte
        sty $06
        ldy #$01        ; WRAM pointer increment = 1...
        bit $04         ; ... if bit 7 (PPU inc) of $04 clear
        bpl +
        ldy #$20        ; else ptr inc = 32
+       jsr AddYToPtr00
        ldy $06
        dec $05
        bne -
        stx PPUStrIndex
        jsr EndPPUString

Table01
        .db $20         ; horizontal write... PPU inc = 1, length = 32 tiles
        .db $9E         ; vertical write... PPU inc = 32, length = 30 tiles

LE5E2:  ldx #$C0
        lda $5A
        cmp #$F2
        beq +
        ldx #$E0
+       stx $00
        stx $02
        jsr GetNameAddrs
        ora #$03
        sta $03
        txa
        ora #$03
        sta $01
        lda #$01
        sta PPUDataPending      ; data pending = YES
        ldx PPUStrIndex
        lda $03
        jsr WritePPUByte
        lda $02
        jsr WritePPUByte
        lda #$20
        sta $04
        jsr WritePPUByte
        ldy #$00
-       lda ($00),y
        jsr WritePPUByte
        iny
        dec $04
        bne -
        stx PPUStrIndex
        jsr EndPPUString

; attempt to move Samus one pixel left

        MoveSamusLeft:
        lda ObjectX
        sec
        sbc ObjRadX
        and #$07
        bne +                   ; only call crash detection every 8th pixel
        jsr CheckMoveLeft       ; check if player is obstructed to the LEFT
        bcc +++         ; branch if yes! (CF = 0)
+       jsr LD976
        lda $030A
        and #$41
        cmp #$41
        clc
        beq +++
        lda SamusScrX
        cmp #$71        ; reached left scroll limit?
        bcs +           ; branch if not
        jsr ScrollLeft
        bcc ++
+       dec SamusScrX
++      lda ObjectX
        bne +
        lda ScrollDir
        and #$02
        beq +
        jsr ToggleSamusHi       ; toggle 9th bit of Samus' X coord
+       dec ObjectX
        sec
        rts

; crash with object on the left

+++     lda #$00
        sta $58
        rts

; attempt to move Samus one pixel right

        MoveSamusRight:
        lda ObjectX
        clc
        adc ObjRadX
        and #$07
        bne +                   ; only call crash detection every 8th pixel
        jsr CheckMoveRight      ; check if Samus is obstructed to the RIGHT
        bcc +++       ; branch if yes! (CF = 0)
+       jsr LD976
        lda $030A
        and #$41
        cmp #$40
        clc
        beq +++
        lda SamusScrX
        cmp #$8F        ; reached right scroll limit?
        bcc +           ; branch if not
        jsr ScrollRight
        bcc ++
+       inc SamusScrX
++      inc ObjectX      ; go right, Samus!
        bne +
        lda ScrollDir
        and #$02
        beq +
        jsr ToggleSamusHi       ; toggle 9th bit of Samus' X coord
+       sec
        rts

; crash with object on the right

+++     lda #$00
        sta $58
        rts

; Attempt to scroll LEFT

        ScrollLeft:
        lda ScrollDir
        cmp #$02
        beq +
        cmp #$03
        bne +++
        dec ScrollDir
        lda ScrollX
        beq +
        dec MapPosX
+       lda ScrollX
        bne +
        dec MapPosX     ; decrement MapX
        jsr GetRoomNum  ; put room # at current map pos in $5A
        bcs ++  ; if function returns CF=1, scrolling left is not possible
        jsr LE9B7       ; switch to the opposite Name Table
+       dec ScrollX
        jsr LE54A       ; check if it's time to update Name Table
        clc
        rts

++      inc MapPosX
+++     sec
        rts

; Attempt to scroll RIGHT

        ScrollRight:
        lda ScrollDir
        cmp #$03
        beq +
        cmp #$02
        bne +++
        inc ScrollDir
        lda ScrollX
        beq +
        inc MapPosX
+       lda ScrollX
        bne +
        inc MapPosX
        jsr GetRoomNum  ; put room # at current map pos in $5A
        bcs ++   ; if function returns CF=1, scrolling right is not possible
+       inc ScrollX
        bne +
        jsr LE9B7       ; switch to the opposite Name Table
+       jsr LE54A       ; check if it's time to update Name Table
        clc
        rts

++      dec MapPosX
+++     sec
-       rts

Table02
        .db $07,$00

; check if it's time to update nametable (when scrolling is HORIZONTAL)

LE701:  ldx ScrollDir
        lda ScrollX
        and #$07        ; keep lower 3 bits
        cmp Table02-2,x ; compare value = 0 if ScrollDir = right, else 7
        bne -           ; exit if not equal (no nametable update)
LE70C:  ldx ScrollDir
        cpx $4A
        bne -
        lda ScrollX
        and #$F8        ; keep upper five bits
        jsr Adiv8       ; / 8 (make 'em lower five)
        sta $00
        lda #$00
        jmp LE590

; GetRoomNum
; ==========
; Description: Gets room number at current map position
; Returns: CF = 1 if room # at map position is FF
;          Else room # in $5A (RAM)

        GetRoomNum:
        lda ScrollDir
        lsr a
        beq +
        rol a
        adc #$FF
        pha
        jsr LEC93
        pla
        and $006C,y
        sec
        bne +++
+       lda MapPosY         ; map pos y
        jsr Amul16       ; * 16
        sta $00
        lda #$00
        rol a
        rol $00
        rol a
        sta $01
        lda $00
        adc MapPosX
        sta $00
        lda $01
        adc #$70
        sta $01         ; $0000 = (MapY*32)+MapX + 7000h
        ldy #$00
        lda ($00),y     ; load map entry!
        cmp #$FF        ; is it unused?
        beq +++       ; if so, exit with CF = 1
        sta RoomNumber  ; store room number
-       cmp $95D0,y     ; is it a special room?
        beq +           ; if so, branch
        iny             ; advance to next special room
        cpy #$07        ; tried 7 rooms yet?
        bne -           ; if not, try another
        lda $79
        beq ++
        lda #$80
        bne ++
+       lda #$01        ; creepy music = yes
++      sta $79
        clc             ; return CF = 0, function succeeded
+++     rts

LE770:  ldx PageIndex
        lda $6AF5,x
        clc
        adc #$08
        jmp LE783

LE77B:  ldx PageIndex
        lda #$00
        sec
        sbc $6AF5,x
LE783:  sta $02
        lda #$08
        sta $04
        jsr LE792
        lda $6AF6,x
        jmp LE7BD

LE792:  lda $0401,x
        sta $09     ; X coord
        lda $0400,x
        sta $08     ; Y coord
        lda $6AFB,x
        sta $0B     ; hi coord
        rts

        CheckMoveUp:
        ldx PageIndex
        lda ObjRadY,x
        clc
        adc #$08
        jmp +

        CheckMoveDown:
        ldx PageIndex
        lda #$00
        sec
        sbc ObjRadY,x
+       sta $02
        jsr LE8BE
        lda ObjRadX,x
LE7BD:  bne +
        sec
        rts

+       sta $03
        tay
        ldx #$00
        lda $09
        sec
        sbc $03
        and #$07
        beq +
        inx
+       jsr LE8CE
        sta $04
        jsr LE90F
        ldx #$00
        ldy #$08
        lda $00
LE7DE:  bne +++
        stx $06
        sty $07
        ldx $04

; object<-->background crash detection

LE7E6:  jsr MakeWRAMPtr ; set up ptr in $0004
        ldy #$00
        lda ($04),y     ; get tile value
        cmp #$4E
        beq LE81E
        jsr $95C0
        jsr LD651
        bcc Exit16      ; CF = 0 if tile # < $80 (solid tile)... CRASH!!!
        cmp #$A0        ; is tile >= A0h? (walkable tile)
        bcs IsWalkableTile
        jmp IsBlastTile  ; tile is $80-$9F (blastable tiles)

        IsWalkableTile:
        ldy IsSamus
        beq ++
    ; special case for Samus
        dey             ; = 0
        sty $58
        cmp #$A0        ; crash with tile A0h? (door)
        beq +
        cmp #$A1        ; crash with tile A1h? (door)
        bne ++
        inc $58
+       inc $58
++      dex
        beq +++
        jsr LE98E
        jmp LE7E6

+++     sec             ; no crash
        Exit16:
        rts

LE81E:  ldx $71
        beq ClcExit
        ldx #$06
-       lda $05
        eor $5D,x
        and #$04
        bne +++
        lda $04
        eor $5C,x
        and #$1F
        bne +++
        txa
        jsr Amul8       ; * 8
        ora #$80
        tay
        lda ObjAction,y
        beq +++
        lda $0307,y
        lsr a
        bcs ++
        ldx PageIndex
        lda ObjAction,x
        eor #$0B
        beq +
        lda ObjAction,x
        eor #$04
        bne PlaySnd4
        lda AnimResetIndex,x
        eor #$91
        bne PlaySnd4
+       lda $0683
        ora #$02
        sta $0683
++      lda #$04
        sta $030A,y
        bne ClcExit
+++     dex
        dex
        bpl -
        lda $04
        jsr Adiv8       ; / 8
        and #$01
        tax
        inc $0366,x
        ClcExit:
        clc
        rts

        PlaySnd4:
        jmp SFX_Metal

        CheckMoveLeft:
        ldx PageIndex
        lda ObjRadX,x
        clc
        adc #$08
        jmp +

        CheckMoveRight:
        ldx PageIndex
        lda #$00
        sec
        sbc ObjRadX,x
+       sta $03
        jsr LE8BE
        ldy ObjRadY,x
LE89B:  bne +
        sec
        rts

+       sty $02
        ldx #$00
        lda $08
        sec
        sbc $02
        and #$07
        beq +
        inx
+       jsr LE8CE
        sta $04
        jsr LE90F
        ldx #$08
        ldy #$00
        lda $01
        jmp LE7DE

LE8BE:  lda ObjectHi,x
        sta $0B
        lda ObjectY,x
        sta $08
        lda ObjectX,x
        sta $09
        rts

LE8CE:  eor #$FF
        clc
        adc #$01
        and #$07
        sta $04
        tya
        asl a
        sec
        sbc $04
        bcs +
        adc #$08
+       tay
        lsr a
        lsr a
        lsr a
        sta $04
        tya
        and #$07
        beq +
        inx
+       txa
        clc
        adc $04
        rts

LE8F1:  ldx PageIndex
        lda $6AF6,x
        clc
        adc #$08
        jmp LE904

LE8FC:  ldx PageIndex
        lda #$00
        sec
        sbc $6AF6,x
LE904:  sta $03
        jsr LE792
        ldy $6AF5,x
        jmp LE89B

LE90F:  lda $02
        bpl ++
        jsr LE95F
        bcs +
        cpx #$F0
        bcc +++
+       txa
        adc #$0F
        jmp LE934

++      jsr LE95F
        lda $08
        sec
        sbc $02
        tax
        and #$07
        sta $00
        bcs +++
        txa
        sbc #$0F
LE934:  tax
        lda ScrollDir
        and #$02
        bne +++
        inc $0B
+++     stx $02
        ldx #$00
        lda $03
        bmi +
        dex
+       lda $09
        sec
        sbc $03
        sta $03
        and #$07
        sta $01
        txa
        adc #$00
        beq +
        lda ScrollDir
        and #$02
        beq +
        inc $0B
+       rts

LE95F:  lda $08
        sec
        sbc $02
        tax
        and #$07
        sta $00
        rts

; MakeWRAMPtr
; ===========
; Makes pointer to WRAM nametable based on object's coordinates.
; In: $02 = ObjectY, $03 = ObjectX, $0B = ObjectHi
; Out: $04 = WRAM pointer

        MakeWRAMPtr:
        lda #$18
        sta $05
        lda $02         ; ObjectY
        and #$F8        ; keep upper 5 bits
        asl a
        rol $05
        asl a
        rol $05
        sta $04
        lda $03         ; ObjectX
        lsr a
        lsr a
        lsr a           ; A = ObjectX / 8
        ora $04
        sta $04
        lda $0B         ; ObjectYHi
        asl a
        asl a           ; A = ObjectYHi * 4
        and #$04
        ora $05
        sta $05
        rts

LE98E:  lda $02
        clc
        adc $06
        sta $02
        cmp #$F0
        bcc +
        adc #$0F
        sta $02
        lda ScrollDir
        and #$02
        bne +
        inc $0B
+       lda $03
        clc
        adc $07
        sta $03
        bcc +
        lda ScrollDir
        and #$02
        beq +
        inc $0B
+       rts

LE9B7:  lda PPUCNT0ZP
        eor #$03
        sta PPUCNT0ZP
        rts

        IsBlastTile:
        ldy $71
        beq Exit18
LE9C2:  tay
        jsr $95BD
        cpy #$98
        bcs +++
    ; attempt to find a vacant tile slot
        ldx #$C0
-       lda TileRoutine,x
        beq +           ; 0 = free slot
        jsr Xminus16
        bne -
        lda TileRoutine,x
        bne +++         ; no more slots, can't blast tile
+       inc TileRoutine,x
        lda $04
        and #$DE
        sta TileWRAMLo,x
        lda $05
        sta TileWRAMHi,x
        lda $74
        cmp #$11
        bne +
        cpy #$76
        bne +
        lda #$04
        bne ++
+       tya
        clc
        adc #$10
        and #$3C
        lsr a
++      lsr a
        sta TileType,x
+++     clc
Exit18: rts

LEA05:  jsr LEB85
        asl a
        asl a
        ora #$60
        sta WRAMPtr+1
        lda #$00
        sta WRAMPtr
        rts

--      lda RoomNumber
        and #$0F
        inc RoomNumber
        jsr GoRoutine

; Pointer table to code

        .dw ExitSub       ; rts
        .dw $E5E2
        .dw ExitSub       ; rts
        .dw $E5E2
        .dw $EA26

LEA26:  lda #$FF
        sta RoomNumber
-       rts

; SetupRoom
; =========

        SetupRoom:
        lda RoomNumber  ; room number
        cmp #$FF        ; is it FF?
        beq -           ; if so, exit
        cmp #$FE
        beq +
        cmp #$F0
        bcs --
        jsr LEC9B
        jsr ScanForItems ; set up special items
        lda RoomNumber  ; room number
        asl a           ; * 2
        tay             ; transfer to index Y register
        lda (RoomPtrTable),y     ; low byte of 16-bit room pointer
        sta RoomPtr
        iny
        lda (RoomPtrTable),y     ; high byte of 16-bit room pointer
        sta RoomPtr+1
        ldy #$00
        lda (RoomPtr),y ; first byte of room data
        sta RoomPal     ; store initial palette # to fill attrib table with
        lda #$01
        jsr AddToRoomPtr        ; add A to room data pointer
        jsr LEA05       ; set up destination WRAM address of decompressed room data
        jsr InitTables  ; clear Name Table & do initial Attrib Table setup
+       jmp DrawRoom

; DrawObject
; ==========

        DrawObject:
        sta $0E         ; store object pos (%yyyyxxxx)
        lda WRAMPtr
        sta WRAMWorkPtr
        lda WRAMPtr+1
        sta WRAMWorkPtr+1
        lda $0E         ; get object pos
        jsr Adiv16      ; / 16. Acc contains object ypos
        tax             ; transfer it to X, prepare for loop
        beq ++          ; skip the next piece of code if ypos is zero
-       lda WRAMWorkPtr ; lo byte of current nametable address
        clc
        adc #64     ; advance two rows on nametable (one y unit)
        sta WRAMWorkPtr
        bcc +
        inc WRAMWorkPtr+1
+       dex
        bne -           ; repeat until X is zero
++      lda $0E         ; get object pos
        and #$0F        ; A contains object xpos
        asl a           ; each x unit is 2 tiles
        adc WRAMWorkPtr
        sta WRAMWorkPtr ; update nametable pointer
        bcc +
        inc WRAMWorkPtr+1
+
; WRAMWorkPtr now points to the object's starting location (upper left
; corner) on the WRAM nametable
        iny
        lda (RoomPtr),y     ; load structure number
        tax             ; transfer to X reg
        iny
        lda (RoomPtr),y     ; load pal # of structure
        sta ObjectPal
        txa             ; restore struct number to A
        asl a           ; * 2
        tay
        lda (StructPtrTable),y  ; low byte of 16-bit structure ptr
        sta StructPtr
        iny
        lda (StructPtrTable),y  ; high byte of 16-bit structure ptr
        sta StructPtr+1
        jsr DrawStruct  ; draw one structure
        lda #$03
        jsr AddToRoomPtr        ; add A to room data pointer

; DrawRoom
; ========
; Draw room on WRAM nametable.

        DrawRoom:
        ldy #$00
        lda (RoomPtr),y     ; load next byte of room data
        cmp #$FF        ; is it FF (end-of-room)?
        beq EndOfRoom
        cmp #$FE        ; ???
        beq +
        cmp #$FD        ; is it FD (end-of-objects)?
        bne DrawObject  ; no, so it's another room object
        beq EndOfObjs   ; yes, set up enemies/doors
+       sta RoomNumber
        lda #$01

; adds A to 16-bit pointer

        AddToRoomPtr:
        clc
        adc RoomPtr
        sta RoomPtr
        bcc +
        inc RoomPtr+1
+       rts

; enemy/door handler

        EndOfObjs:
        lda RoomPtr
        sta $00
        lda RoomPtr+1
        sta $01
        lda #$01

        EnemyLoop:
        jsr AddToPtr00  ; add A to pointer at $00
        ldy #$00
        lda ($00),y
        cmp #$FF        ; end of enemy/door data?
        beq EndOfRoom   ; if so, branch
        and #$0F
        jsr GoRoutine

; Pointer table to code

        .dw ExitSub     ; rts
        .dw LoadEnemy
        .dw LoadDoor
        .dw ExitSub     ; rts
        .dw LoadElevator    ; Elevator
        .dw ExitSub     ; rts
        .dw LoadStatues     ; Kraid & Ridley statues
        .dw $EC57

        EndOfRoom:
        ldx #$F0
        stx RoomNumber
        lda ScrollDir
        sta $4A
        and #$02
        bne +
        jmp LE57C
+       jmp LE70C

; LoadEnemy
; =========

        LoadEnemy:
        jsr LEB0C
        jmp EnemyLoop   ; do next room object

LEB0C:  lda ($00),y     ; get 1st byte again
        and #$F0        ; keep ID tag
        tax
        jsr LEB7A
        bne +       ; exit if object slot taken
        iny
        lda ($00),y     ; get enemy #
        jsr LEB28
        ldy #$02
        lda ($00),y     ; get position (%yyyyxxxx)
        jsr LEB4D
        pha
-       pla
+       lda #$03        ; # of bytes to add to ptr at $0000
        rts

LEB28:  pha
        and #$C0
        sta $040F,x
        asl a
        bpl ++
        lda $74
        and #$06
        lsr a
        tay
        lda MaxMissiles,y
        beq +
        pla
        pla
        jmp -

+       lda #$01
        sta $6987
++      pla
        and #$3F
        sta $6B02,x
        rts

LEB4D:  tay
        and #$F0
        ora #$08
        sta $0400,x
        tya
        jsr Amul16       ; * 16
        ora #$0C
        sta $0401,x
        lda #$01
        sta $6AF4,x
        lda #$00
        sta $0404,x
        jsr LEB85
        sta $6AFB,x
        ldy $6B02,x
        asl $0405,x
        jsr LFB7B
        jmp LF85A

LEB7A:  lda $6AF4,x
        beq +
        lda $0405,x
        and #$02
+       rts

LEB85:  lda PPUCNT0ZP
        eor ScrollDir
        and #$01
        rts

; LoadDoor
; ========

        LoadDoor:
        jsr LEB92
-       jmp EnemyLoop    ; do next room object

LEB92:  iny
        lda ($00),y     ; door info byte
        pha
        jsr Amul16      ; CF = door side (0=right, 1=left)
        php
        lda MapPosX
        clc
        adc MapPosY
        plp
        rol a
        and #$03
        tay
        ldx $EC00,y
        pla             ; retrieve door info
        and #$03
        sta $0307,x     ; door palette
        tya
        pha
        lda $0307,x
        cmp #$01
        beq ++
        cmp #$03
        beq ++
        lda #$0A
        sta $09
        ldy MapPosX
        txa
        jsr Amul16       ; * 16
        bcc +
        dey
+       tya
        jsr LEE41
        jsr LEE4A
        bcs +
++      lda #$01
        sta ObjAction,x
+       pla
        and #$01        ; A = door side (0=right, 1=left)
        tay
        jsr LEB85
        sta ObjectHi,x
        lda DoorXs,y    ; get door's X coordinate
        sta ObjectX,x
        lda #$68        ; door Y coord is always #$68
        sta ObjectY,x
        lda LEBFE,y
        tay
        jsr LEB85
        eor #$01
        tax
        tya
        ora $6C,x
        sta $6C,x
        lda #$02
        rts

DoorXs
        .db $F0         ; X coord of RIGHT door
        .db $10         ; X coord of LEFT door
LEBFE:  .db $02
        .db $01
LEC00:  .db $80
        .db $B0
        .db $A0
        .db $90

; LoadElevator
; ============

        LoadElevator:
        jsr LEC09
        bne -           ; branch always

LEC09:  lda $0320
        bne +           ; exit if elevator already present
        iny
        lda ($00),y
        sta $032F
        ldy #$83
        sty $032D       ; elevator Y coord
        lda #$80
        sta $032E       ; elevator X coord
        jsr LEB85
        sta $032C       ; high Y coord
        lda #$23
        sta $0323       ; elevator frame
        inc $0320       ; 1
+       lda #$02
        rts

; LoadStatues
; ===========

        LoadStatues:
        jsr LEB85
        sta $036C
        lda #$40
        ldx $687C
        bpl +           ; branch if Kraid statue not hit
        lda #$30
+       sta $0370
        lda #$60
        ldx $687B
        bpl +           ; branch if Ridley statue not hit
        lda #$50
+       sta $036F
        sty $54
        lda #$01
        sta $0360
--      jmp EnemyLoop   ; do next room object

LEC57:  ldx #$20
-       txa
        sec
        sbc #$08
        bmi +
        tax
        ldy $0728,x
        iny
        bne -
        ldy #$00
        lda ($00),y
        and #$F0
        sta $0729,x
        iny
        lda ($00),y
        sta $0728,x
        iny
        lda ($00),y
        tay
        and #$F0
        ora #$08
        sta $072A,x
        tya
        jsr Amul16       ; * 16
        ora #$00
        sta $072B,x
        jsr LEB85
        sta $072C,x
+       lda #$03
        bne --

LEC93:  lda PPUCNT0ZP
        eor #$01
        and #$01
        tay
        rts

LEC9B:  ldx ScrollDir
        dex
        ldy #$00
        jsr LED51
        iny
        jsr LED51
        ldx #$50
        jsr LEB85
        tay
-       tya
        eor $6AFB,x
        lsr a
        bcs +
        lda $0405,x
        and #$02
        bne +
        sta $6AF4,x
+       jsr Xminus16
        bpl -
        ldx #$18
-       tya
        eor $B3,x
        lsr a
        bcs +
        lda #$00
        sta $B0,x
+       txa
        sec
        sbc #$08
        tax
        bpl -
        jsr LED65
        jsr LED5B
        jsr LEB85
        asl a
        asl a
        tay
        ldx #$C0
-       tya
        eor TileWRAMHi,x
        and #$04
        bne +
        sta $0500,x
+       jsr Xminus16
        cmp #$F0
        bne -
        tya
        lsr a
        lsr a
        tay
        ldx #$D0
        jsr LED7A
        ldx #$E0
        jsr LED7A
        ldx #$F0
        jsr LED7A
        tya
        sec
        sbc $032C
        bne +
        sta $0320
+       ldx #$1E
-       lda $0704,x
        bne +
        lda #$FF
        sta $0700,x
+       txa
        sec
        sbc #$06
        tax
        bpl -
        cpy $036C
        bne +
        lda #$00
        sta $0360
+       ldx #$18
-       tya
        cmp $072C,x
        bne +
        lda #$FF
        sta $0728,x
+       txa
        sec
        sbc #$08
        tax
        bpl -
        ldx #$00
        jsr LED8C
        ldx #$08
        jsr LED8C
        jmp $95AE

LED51:  txa
        eor #$03
        and $006C,y
-       sta $006C,y
        rts

LED5B:  jsr LEB85
        eor #$01
        tay
        lda #$00
        beq -
LED65:  ldx #$B0
-       lda ObjAction,x
        beq +
        lda $030B,x
        bne +
        sta ObjAction,x
+       jsr Xminus16
        bmi -
        rts

LED7A:  lda ObjAction,x
        cmp #$05
        bcc +
        tya
        eor ObjectHi,x
        lsr a
        bcs +
        sta ObjAction,x
+       rts

LED8C:  tya
        cmp $074B,x
        bne Exit11
        lda #$FF
        sta $0748,x
Exit11: rts

; Special item handler

        ScanForItems:
        lda $9598       ; lo byte of ptr to 1st item data
        sta $00
        lda $9599       ; hi byte of ptr to 1st item data

        ScanOneItem:
        sta $01
        ldy #$00
        lda ($00),y     ; load map Ypos of item
        cmp MapPosY     ; does it equal Samus' Ypos on map?
        beq +           ; if yes, check Xpos too
        bcs Exit11      ; exit if Ypos > MapPosY
        iny
        lda ($00),y     ; lo byte of ptr to next item data
        tax             ; safe-keep in X
        iny
        and ($00),y     ; AND with hi byte of item ptr
        cmp #$FF        ; if result is FFh, then this was the last item (item ptr = FFFF)
        beq Exit11      ; exit
        lda ($00),y     ; hi byte of ptr to next item data
        stx $00         ; write lo byte
        jmp ScanOneItem ; process next item

+       lda #$03
        jsr AddToPtr00  ; add A to pointer at $0000

        ScanItemX:
        ldy #$00
        lda ($00),y     ; load map Xpos of object
        cmp MapPosX     ; does it equal Samus' Xpos on map?
        beq +           ; if so, then load object
        bcs Exit11      ; exit if A > MapPosX
        iny
        jsr GetItemByte
        jmp ScanItemX   ; try next X coord

+       lda #$02
LEDD6:  jsr AddToPtr00  ; add A to pointer at $0000
        ldy #$00
        lda ($00),y     ; object type
        and #$0F
        jsr GoRoutine       ; GO!

; Code pointer table (used by above routine)

        .dw ExitSub       ; rts
        .dw $EDF8
        .dw $EDFE       ; power-up
        .dw $EE63
        .dw $EEA1
        .dw $EEA6
        .dw $EEAE
        .dw $EECA
        .dw $EEEE
        .dw $EEF4
        .dw $EEFA

LEDF8:  jsr LEB0C
-       jmp LEDD6

; power-up item handler

LEDFE:  iny
        ldx #$00
        lda #$FF
        cmp $0748
        beq +
        ldx #$08
        cmp $0750
        bne ++
+       lda ($00),y     ; power-up #
        jsr LEE3D
        jsr LEE4A
        bcs ++      ; exit if CF set
        ldy #$02
        lda $09
        sta $0748,x     ; store power-up #
        lda ($00),y     ; %yyyyxxxx
        tay             ; safe-keep
        and #$F0        ; keep Y coord
        ora #$08        ; + 8
        sta $0749,x     ; store center Y coord
        tya             ; restore %yyyyxxxx
        jsr Amul16       ; * 16
        ora #$08        ; + 8
        sta $074A,x     ; store center X coord
        jsr LEB85
        sta $074B,x
++      lda #$03
        bne -           ; branch always

                        ; NOTE: If you trace the code from "bne -",
                        ; you will see that this is an indirect exit. What
                        ; it does is this: #$03 is added to the item data
                        ; pointer, and the byte at the new address is used
                        ; as an index into the code pointer table above.
                        ; The byte always seems to be 0, so the code will
                        ; jump to an RTS ($C45C).

LEE3D:  sta $09
        lda MapPosX
LEE41:  sta $07
        lda MapPosY
        sta $06
        jmp LDC67

LEE4A:  ldy $6886
        beq ++
-       lda $07
        cmp $6886,y
        bne +
        lda $06
        cmp $6885,y
        beq +++
+       dey
        dey
        bne -
++      clc
+++     rts

LEE63:  ldx #$18
        lda $2E
        adc FrameCount
        sta $8A
-       jsr LEE86
        txa
        sec
        sbc #$08
        tax
        bpl -
        lda $95E4
        sta $6BE9
        sta $6BEA
        lda #$01
        sta $6BE4
-       jmp LEDD6

LEE86:  lda $B0,x
        bne +
        txa
        adc $8A
        and #$7F
        sta $B1,x
        adc $2F
        sta $B2,x
        jsr LEB85
        sta $B3,x
        lda #$01
        sta $B0,x
        rol $8A
+       rts

LEEA1:  jsr LEC09
        bne -           ; branch always

LEEA6:  jsr $95B1
        lda #$02
-       jmp LEDD6

LEEAE:  jsr $95B4
        lda #$38
        sta $07
        lda #$00
        sta $06
        jsr LEE4A
        bcc LEEC6
        lda #$08
        sta $98
        lda #$00
        sta $99
LEEC6:  lda #$01
        bne -

LEECA:  jsr $95B7
        txa
        lsr a
        adc #$3C
        sta $07
        lda #$00
        sta $06
        jsr LEE4A
        bcc +
        lda #$81
        sta $0758,x
        lda #$01
        sta $075D,x
        lda #$07
        sta $075B,x
+       jmp LEEC6

LEEEE:  jsr $95BA
        jmp LEEC6

LEEF4:  jsr LEB92
        jmp LEDD6

LEEFA:  lda ScrollDir
        sta $91
        bne LEEC6

        GetItemByte:
        lda ($00),y
        cmp #$FF        ; end of data reached?
        bne AddToPtr00  ; if not, A is amount to add to ptr
        pla
        pla
        rts

; add A to pointer at $0000

        AddToPtr00:
        clc
        adc $00
        sta $00
        bcc +
        inc $01
+       rts

; DrawStructRow
; =============
; draws one row of the structure
; A = # of 2x2 tile macros to draw horizontally

        DrawStructRow:
        and #$0F        ; row length (in macros), range 00..0F
        bne +
        lda #$10
+       sta $0E         ; store horizontal macro count
        lda (StructPtr),y      ; get length byte again
        jsr Adiv16       ; / 16. Acc contains relative x coord
        asl a           ; * 2, because a macro is 2 tiles wide
        adc WRAMWorkPtr
        sta $00
        lda #$00
        adc WRAMWorkPtr+1
        sta $01         ; $0000 = workptr

        DrawMacro:
        lda $01         ; high byte of current nametable address
        cmp #$63
        beq +           ; check if end of nametable #0 reached
        cmp #$67
        bcc ++          ; draw macro
        beq +           ; check if end of nametable #1 reached
        rts

+       lda $00         ; low byte of current nametable address
        cmp #$A0        ; reached attrib table?
        bcc ++          ; if not, draw the macro
        rts             ; can't draw any more of the structure, exit

++      inc $10         ; increase struct data index
        ldy $10         ; struct data index in Y
        lda (StructPtr),y     ; get macro #
        asl a
        asl a           ; A = macro # * 4. Each macro is 4 bytes long
        sta $11         ; store macro index
        ldx #$03        ; prepare to copy four tile #'s
-       ldy $11         ; macro index in Y
        lda (MacroPtr),y     ; get tile #
        inc $11         ; increase macro index
        ldy TilePosTable,x   ; get buffer index
        sta ($00),y     ; write tile #
        dex             ; done four tiles yet?
        bpl -           ; if not, do another
        jsr UpdateAttrib ; update attribute table if necessary
        ldy #$02        ; macrowidth (in tiles)
        jsr AddYToPtr00
        lda $00         ; low byte of current nametable address
        and #$1F        ; still inside nametable?
        bne +           ; branch = yes, do another macro
; need to "clip" structure
        lda $10         ; struct index
        clc
        adc $0E         ; + number of macros remaining
        sec
        sbc #$01        ; - 1
        jmp AdvanceRow
+       dec $0E         ; drawn all macros on this row?
        bne DrawMacro   ; if not, draw another

        lda $10         ; struct index
        AdvanceRow:
        sec
        adc StructPtr
        sta StructPtr   ; update the struct pointer
        bcc +
        inc StructPtr+1
+       lda #64
        clc
        adc WRAMWorkPtr ; advance two rows in nametable
        sta WRAMWorkPtr
        bcc DrawStruct
        inc WRAMWorkPtr+1

; DrawStruct
; ==========
; Draws one structure on the WRAM nametable.

        DrawStruct:
        ldy #$00
        sty $10         ; reset struct index
        lda (StructPtr),y     ; load data byte
        cmp #$FF        ; end-of-struct?
        beq +           ; if so, exit
        jmp DrawStructRow       ; draw a row of macros
+       rts

; Tile placement table

TilePosTable
                .db $21
                .db $20
                .db $01
                .db $00

; UpdateAttrib
; ============
; Updates attribute bits for one 2x2 tile section on the screen.
; All this code just to modify *TWO* bits -- whew.

        UpdateAttrib:
        lda ObjectPal   ; load pal # of structure
        cmp RoomPal     ; is it the same as the room's default pal?
        beq ++          ; then no need to modify the attribute table, exit

; figure out WRAM address of the byte containing the relevant bits

        lda $00
        sta $02
        lda $01
        lsr a
        ror $02
        lsr a
        ror $02
        lda $02
        and #$07
        sta $03
        lda $02
        lsr a
        lsr a
        and #$38
        ora $03
        ora #$C0
        sta $02
        lda #$63
        sta $03         ; $0002 contains ptr to attribute byte

; Figure out palette selector (0..3)

        ldx #$00
        bit $00
        bvc +
        ldx #$02
+       lda $00
        and #$02
        beq +
        inx

; X now contains which 2x2 tile section's palette to modify:
; +---+---+
; | 0 | 1 |
; +---+---+
; | 2 | 3 |
; +---+---+
; Where each box represents 2x2 tiles, and the value inside the
; corresponding X value

+       lda $01
        and #$04
        ora $03
        sta $03
        lda PalMaskTable,x
        ldy #$00
        and ($02),y     ; clear the old palette bits
        sta ($02),y
        lda ObjectPal   ; palette # (0..3)
-       dex
        bmi +
        asl a
        asl a           ; palette bits shifted one step left
        bcc -           ; branch always
+       ora ($02),y     ; set palette bits
        sta ($02),y
++      rts

PalMaskTable
                .db %11111100
                .db %11110011
                .db %11001111
                .db %00111111

; InitTables
; ==========

        InitTables:
        lda WRAMPtr+1   ; $60 or $64
        tay
        tax
        iny
        iny
        iny
        lda #$FF        ; value to fill WRAM nametable with
        jsr FillWRAMTable
        ldx $01
        jsr Xplus4       ; X = X + 4
        stx $01

; fill attribute table with initial pal #

        ldx RoomPal     ; pal # (2-bit)
        lda PalLookup,x
        ldy #$C0        ; prepare to fill entire attribute table
-       sta ($00),y     ; write attribute bits
        iny
        bne -
        rts

PalLookup
                .db $00;.db %00000000
                .db $55;.db %01010101
                .db $AA;.db %10101010
                .db $FF;.db %11111111

        FillWRAMTable:
        pha
        txa
        sty $01
        clc
        sbc $01
        tax
        pla
        ldy #$00
        sty $00
-       sta ($00),y
        dey
        bne -
        dec $01
        inx
        bne -
        rts

; Crash detection
; ===============

LF034:  lda #$FF
        sta $73
        sta $010F
    ; check for crash with Memus
        ldx #$18
--      lda $B0,x
        beq +++             ; branch if no Memu in slot
        cmp #$03
        beq +++
        jsr LF19A
        jsr IsSamusDead
        beq +
        lda SamusBlink
        bne +
        ldy #$00
        jsr LF149
        jsr LF2B4
    ; check for crash with bullets
+       ldy #$D0
-       lda ObjAction,y       ; projectile active?
        beq ++                  ; try next one if not
        cmp #wa_BulletExplode
        bcc +
        cmp #$07
        beq +
        cmp #wa_BombExplode
        beq +
        cmp #wa_Missile
        bne ++
+       jsr LF149
        jsr LF32A
++      jsr Yplus16
        bne -
+++     txa
        sec
        sbc #$08                ; each Memu occupies 8 bytes
        tax
        bpl --

        ldx #$B0
-       lda ObjAction,x
        cmp #$02
        bne +
        ldy #$00
        jsr IsSamusDead
        beq ++
        jsr LDC7F
        jsr LF277
+       jsr Xminus16
        bmi -
; enemy <--> bullet/missile/bomb detection
++      ldx #$50                ; start with enemy slot #5
LF09F:  lda $6AF4,x             ; slot active?
        beq +                   ; branch if not
        cmp #$03
+       beq NextEnemy           ; next slot
        jsr LF152
        lda $6AF4,x
        cmp #$05
        beq +++
        ldy #$D0                ; first projectile slot
-       lda ObjAction,y         ; is it active?
        beq ++                  ; branch if not
        cmp #wa_BulletExplode
        bcc +
        cmp #$07
        beq +
        cmp #wa_BombExplode
        beq +
        cmp #wa_Missile
        bne ++
; check if enemy is actually hit
+       jsr LF140
        jsr LF2CA
++      jsr Yplus16             ; next projectile slot
        bne -
+++     ldy #$00
        lda SamusBlink
        bne NextEnemy
        jsr IsSamusDead
        beq NextEnemy
        jsr LF140
        jsr LF282
        NextEnemy:
        jsr Xminus16
        bmi +
        jmp LF09F

+       ldx #$00
        jsr LF172
        ldy #$60
-       lda $6AF4,y
        beq +
        cmp #$05
        beq +
        lda SamusBlink
        bne +
        jsr IsSamusDead
        beq +
        jsr LF1B3
        jsr LF162
        jsr LF1FA
        jsr LF2ED
+       jsr Yplus16
        cmp #$C0
        bne -
        ldy #$00
        jsr IsSamusDead
        beq +++
        jsr LF186
        ldx #$F0
-       lda ObjAction,x
        cmp #$07
        beq +
        cmp #$0A
        bne ++
+       jsr LDC82
        jsr LF311
++      jsr Xminus16
        cmp #$C0
        bne -
+++     jmp LCE92

LF140:  jsr LF1BF
        jsr LF186
        jmp LF1FA

LF149:  jsr LF186
        jsr LF1D2
        jmp LF1FA

LF152:  lda $0400,x
        sta $07         ; Y coord
        lda $0401,x
        sta $09         ; X coord
        lda $6AFB,x     ; hi coord
        jmp LF17F

LF162:  lda $0400,y     ; Y coord
        sta $06
        lda $0401,y     ; X coord
        sta $08
        lda $6AFB,y     ; hi coord
        jmp LF193

LF172:  lda ObjectY,x
        sta $07
        lda ObjectX,x
        sta $09
        lda ObjectHi,x
LF17F:  eor PPUCNT0ZP
        and #$01
        sta $0B
        rts

LF186:  lda ObjectY,y
        sta $06
        lda ObjectX,y
        sta $08
        lda ObjectHi,y
LF193:  eor PPUCNT0ZP
        and #$01
        sta $0A
        rts

LF19A:  lda $B1,x
        sta $07
        lda $B2,x
        sta $09
        lda $B3,x
        jmp LF17F

LF1A7:  lda ObjRadY,x
        jsr LF1E0
        lda ObjRadX,x
        jmp LF1D9

LF1B3:  lda ObjRadY,x
        jsr LF1E7
        lda ObjRadX,x
        jmp LF1CB

LF1BF:  lda $6AF5,x
        jsr LF1E0
        lda $6AF6,x
        jmp LF1D9

LF1CB:  clc
        adc $6AF6,y
        sta $05
        rts

LF1D2:  lda #$04
        jsr LF1E0
        lda #$08
LF1D9:  clc
        adc ObjRadX,y
        sta $05
        rts

LF1E0:  clc
        adc ObjRadY,y
        sta $04
        rts

LF1E7:  clc
        adc $6AF5,y
        sta $04
        rts

; Y = Y + 16

        Yplus16:
        tya
        clc
        adc #$10
        tay
        rts

; X = X - 16

        Xminus16:
        txa
        sec
        sbc #$10
        tax
        rts

LF1FA:  lda #$02
        sta $10
        and ScrollDir
        sta $03
        lda $07
        sec
        sbc $06     ; Y
        sta $00
        lda $03
        bne ++
        lda $0B
        eor $0A
        beq ++
        jsr LF262
        lda $00
        sec
        sbc #$10
        sta $00
        bcs +
        dec $01
+       jmp LF22B

++      lda #$00
        sbc #$00
        jsr LF266
LF22B:  sec
        lda $01
        bne ++
        lda $00
        sta $11
        cmp $04
        bcs ++
        asl $10
        lda $09
        sec
        sbc $08
        sta $00
        lda $03
        beq +
        lda $0B
        eor $0A
        beq +
        jsr LF262
        jmp LF256

+       sbc #$00
        jsr LF266
LF256:  sec
        lda $01
        bne ++
        lda $00
        sta $0F
        cmp $05
++      rts

LF262:  lda $0B
        sbc $0A
LF266:  sta $01
        bpl +
        jsr LE449
        inc $10
+       rts

LF270:  ora $030A,x
        sta $030A,x
        rts

LF277:  bcs Exit17
LF279:  lda $10
LF27B:  ora $030A,y
        sta $030A,y
        Exit17:
        rts

LF282:  bcs Exit17
        jsr LF2E8
        jsr LCD9C
        ldy #$00
        bcc ++
        lda $6AF4,x
        cmp #$04
        bcs Exit17
        lda $6B02,x
-       sta $010F
        tay
        bmi +
        lda $968B,y
        and #$10
        bne Exit17
+       ldy #$00
        jsr LF338
        jmp LF306

++      lda #$81
        sta $040E,x
        bne ++
LF2B4:  bcs +
        jsr LCD9C
        ldy #$00
        lda #$C0
        bcs -
LF2BF:  lda $B6,x
        and #$F8
        ora $10
        eor #$03
        sta $B6,x
+       rts

LF2CA:  bcs +
        lda ObjAction,y
        sta $040E,x
        jsr LF279
++      jsr LF332
-       ora $0404,x
        sta $0404,x
+       rts

LF2DF:  lda $10
        ora $0404,y
        sta $0404,y
        rts

LF2E8:  jsr LF340
        bne -
LF2ED:  bcs +
        jsr LF2DF
        tya
        pha
        jsr LCD9C
        pla
        tay
        bcc +
        lda #$80
        sta $010F
        jsr LF332
        jsr LF270
LF306:  lda $95CE
        sta $6E
        lda $95CF
        sta $6F
+       rts

LF311:  bcs Exit22
        lda #$E0
        sta $010F
        jsr LF338
        lda $0F
        beq +
        lda #$01
+       sta $73
LF323:  lda #$00
        sta $6E
        sta $6F
Exit22: rts

LF32A:  bcs Exit22
        jsr LF279
        jmp LF2BF

LF332:  jsr LF340
        jmp Amul8       ; * 8

LF338:  lda $10
        asl a
        asl a
        asl a
        jmp LF27B

LF340:  lda $10
        eor #$03
        rts

; UpdateEnemies
; =============

        UpdateEnemies:
        ldx #$50
-       jsr DoOneEnemy
        ldx PageIndex
        jsr Xminus16
        bne -
        DoOneEnemy:
        stx PageIndex
        ldy $6AF4,x
        beq +
        cpy #$03
        bcs +
        jsr LF37F
+       jsr LF3AA
        lda $6AF4,x
        sta $81
        cmp #$07
        bcs +
        jsr GoRoutine

; Pointer table to code

        .dw ExitSub       ; rts
        .dw $F3BE
        .dw $F3E6
        .dw $F40D
        .dw $F43E
        .dw $F483
        .dw $F4EE

+       jmp KillObject

LF37F:  lda $0405,x
        and #$02
        bne +
        lda $0400,x     ; Y coord
        sta $0A
        lda $0401,x     ; X coord
        sta $0B
        lda $6AFB,x     ; hi coord
        sta $06
        lda $6AF5,x
        sta $08
        lda $6AF6,x
        sta $09
        jsr LDFDF
        txa
        bne +
        pla
        pla
+       ldx PageIndex
        rts

LF3AA:  lda $0405,x
        asl a
        rol a
        tay
        txa
        jsr Adiv16       ; / 16
        eor FrameCount
        lsr a
        tya
        ror a
        ror a
        sta $0405,x
        rts

LF3BE:  lda $0405,x
        asl a
        bmi +
        lda #$00
        sta $6B01,x
        sta $0406,x
        sta $040A,x
        jsr LF6B9
        jsr LF75B
        jsr LF682
        jsr LF676
        lda $0409,x
        beq +
        jsr LF7BA
+       jmp ++

LF3E6:  lda $0405,x
        asl a
        bmi ++
        lda $0405,x
        and #$20
        beq +
        ldy $6B02,x
        lda $96BB,y
        sta $0409,x
        dec $6AF4,x
        bne ++
+       jsr LF6B9
        jsr LF75B
        jsr LF51E
++      jsr LF536
        jmp $95E5

LF410:  jsr UpdateEnemyAnim
        jsr $8058
LF416:  ldx PageIndex
        lda $040F,x
        bpl +
        lda $6B
        bmi +
        lda #$A3
LF423:  sta $6B
+       lda $6AF4,x
        beq LF42D
        jsr LDD8B
LF42D:  ldx PageIndex
        lda #$00
        sta $0404,x
        sta $040E,x
        rts

LF438:  jsr UpdateEnemyAnim
LF43B:  jmp LF416

LF43E:  jsr LF536
        lda $6AF4,x
        cmp #$03
        beq LF410
        bit $6B
        bmi +
        lda #$A1
        sta $6B
+       lda FrameCount
        and #$07
        bne +
        dec $040D,x
        bne +
        lda $6AF4,x
        cmp #$03
        beq +
        lda $040C,x
        sta $6AF4,x
        ldy $6B02,x
        lda $969B,y
        sta $040D,x
+       lda $040D,x
        cmp #$0B
        bcs +
        lda FrameCount
        and #$02
        beq +
        asl $6B
+       jmp LF416

LF483:  lda $0404,x
        and #$24
        beq +++
        jsr KillObject
        ldy $6AF7,x
        cpy #$80
        beq PickupMissile
        tya
        pha
        lda $6B02,x
        pha
        ldy #$00
        ldx #$03
        pla
        bne ++
        dex
        pla
        cmp #$81
        bne +
        ldx #$00
        ldy #$50
+       pha
++      pla
        sty $6E
        stx $6F
        jsr LCEF9
        jmp SFX_EnergyPickup

        PickupMissile:
        lda #$02
        ldy $6B02,x
        beq +
        lda #$1E
+       clc
        adc MissileCount
        bcs +                   ; can't have more than 255 missiles
        cmp MaxMissiles         ; can Samus hold this many missiles?
        bcc ++                  ; branch if yes
+       lda MaxMissiles         ; set to max. # of missiles allowed
++      sta MissileCount
        jmp SFX_MissilePickup

+++     lda FrameCount
        and #$03
        bne +
        dec $040D,x
        bne +
        jsr KillObject
+       lda FrameCount
        and #$02
        lsr a
        ora #$A0
        sta $6B
        jmp LF416

LF4EE:  dec $040F,x
        bne ++
        lda $040C,x
        tay
        and #$C0
        sta $040F,x
        tya
        and #$3F
        sta $6AF4,x
        pha
        jsr $80B0
        and #$20
        beq +
        pla
        jsr LF515
        pha
+       pla
++      lda #$A0
        jmp LF423

LF515:  sta $040C,x
LF518:  lda #$04
        sta $6AF4,x
        rts

LF51E:  lda ScrollDir
        ldx PageIndex
        cmp #$02
        bcc +
        lda $0400,x     ; Y coord
        cmp #$EC
        bcc +
        jmp KillObject

-       jsr SFX_MetroidHit
        jmp GetPageIndex

LF536:  lda $040F,x
        sta $0A
        lda $0404,x
        and #$20
        beq +
        lda $040E,x
        cmp #$03
        bne ++
        bit $0A
        bvs ++
        lda $6AF4,x
        cmp #$04
        beq ++
        jsr LF515
        lda #$40
        sta $040D,x
        jsr $80B0
        and #$20
        beq +
        lda #$05
        sta $040B,x
        jmp $95A8
+       rts

--      jsr $80B0
        and #$20
        bne -
        jsr SFX_Metal
        jmp LF42D

++      lda $040B,x
        cmp #$FF
        beq --
        bit $0A
        bvc ++
        jsr SFX_MBrainHit
        bne +
++      jsr LF74B
        and #$0C
        beq PlaySnd1
        cmp #$04
        beq PlaySnd2
        cmp #$08
        beq PlaySnd3
        jsr SFX_MetroidHit
        bne +       ; branch always
        PlaySnd1:
        jsr SFX_EnemyHit
        bne +       ; branch always
        PlaySnd2:
        jsr SFX_EnemyHit
        bne +       ; branch always
        PlaySnd3:
        jsr LCBCE
+       ldx PageIndex
        jsr $80B0
        and #$20
        beq +
        lda $040E,x
        cmp #$0B
        bne --
+       lda $6AF4,x
        cmp #$04
        bne +
        lda $040C,x
+       ora $0A
        sta $040C,x
        asl a
        bmi +
        jsr $80B0
        and #$20
        bne +
        ldy $040E,x
        cpy #$0B
        beq +++
        cpy #$81
        beq +++
+       lda #$06
        sta $6AF4,x
        lda #$0A
        bit $0A
        bvc +
        lda #$03
+       sta $040F,x
        cpy #$02
        beq +
        bit $0A
        bvc ++
        ldy $040E,x
        cpy #$0B
        bne ++
        dec $040B,x
        beq +++
        dec $040B,x
        beq +++
+       dec $040B,x
        beq +++
++      dec $040B,x
        bne GetPageIndex
+++     lda #$03
        sta $6AF4,x
        bit $0A
        bvs +
        lda $040E,x
        cmp #$02
        bcs +
        lda #$00
        jsr LDCFC
        ldx PageIndex
+       jsr LF844
        lda $960B,y
        jsr LF68D
        sta $0406,x
        ldx #$C0
-       lda $6AF4,x
        beq +
        txa
        clc
        adc #$08
        tax
        cmp #$E0
        bne -
        beq GetPageIndex
+       lda $95DD
        jsr LF68D
        lda #$0A
        sta $0406,x
        inc $6AF4,x
        lda #$00
        bit $0A
        bvc +
        lda #$03
+       sta $0407,x
        ldy PageIndex
        lda $0400,y
        sta $0400,x
        lda $0401,y
        sta $0401,x
        lda $6AFB,y
        sta $6AFB,x
        GetPageIndex:
        ldx PageIndex
        rts

LF676:  jsr $80B0
        asl a
        asl a
        asl a
        and #$C0
        sta $6B03,x
        rts

LF682:  jsr LF844
        lda $963B,y
        cmp $6AF9,x
        beq +
LF68D:  sta $6AF9,x
LF690:  sta $6AFA,x
LF693:  lda #$00
        sta $6AF8,x
+       rts

LF699:  jsr LF844
        lda $965B,y
        cmp $6AF9,x
        beq Exit12
        jsr LF68D
        ldy $6B02,x
        lda $967B,y
        and #$7F
        beq Exit12
        tay
-       dec $6AFA,x
        dey
        bne -
Exit12: rts

LF6B9:  lda #$00
        sta $82
        jsr LF74B
        tay
        lda $6AF4,x
        cmp #$02
        bne +
        tya
        and #$02
        beq Exit12
+       tya
        dec $040D,x
        bne Exit12
        pha
        ldy $6B02,x
        lda $969B,y
        sta $040D,x
        pla
        bpl +++
        lda #$FE
        jsr LF7B3
        lda ScrollDir
        cmp #$02
        bcc +
        jsr LF752
        bcc +
        tya
        eor PPUCNT0ZP
        bcs ++
+       lda $0401,x
        cmp ObjectX
        bne +
        inc $82
+       rol a
++      and #$01
        jsr LF744
        lsr a
        ror a
        eor $0403,x
        bpl +++
        jsr $81DA
+++     lda #$FB
        jsr LF7B3
        lda ScrollDir
        cmp #$02
        bcs +
        jsr LF752
        bcc +
        tya
        eor PPUCNT0ZP
        bcs ++
+       lda $0400,x
        cmp ObjectY
        bne +
        inc $82
        inc $82
+       rol a
++      and #$01
        asl a
        asl a
        jsr LF744
        lsr a
        lsr a
        lsr a
        ror a
        eor $0402,x
        bpl +
        jmp $820F

LF744:  ora $0405,x
        sta $0405,x
+       rts

LF74B:  ldy $6B02,x
        lda $968B,y
        rts

LF752:  lda $6AFB,x
        tay
        eor ObjectHi
        lsr a
        rts

LF75B:  lda #$E7
        sta $06
        lda #$18
        jsr LF744
        ldy $6B02,x
        lda $96AB,y
        beq +++
        tay
        lda $0405,x
        and #$02
        beq ++
        tya
        ldy #$F7
        asl a
        bcs +
        ldy #$EF
+       lsr a
        sta $02
        sty $06
        lda ObjectY
        sta $00
        ldy $0400,x
        lda $0405,x
        bmi +
        ldy ObjectX
        sty $00
        ldy $0401,x
+       lda ObjectHi
        lsr a
        ror $00
        lda $6AFB,x
        lsr a
        tya
        ror a
        sec
        sbc $00
        bpl +
        jsr GetAbsolute
+       lsr a
        lsr a
        lsr a
        cmp $02
        bcc +++
++      lda $06
LF7B3:  and $0405,x
        sta $0405,x
+++     rts

LF7BA:  dec $0409,x
        bne +
        lda $0405,x
        and #$08
        bne ++
        inc $0409,x
+       rts

++      lda $6B02,x
        cmp #$07
        bne +
        jsr SFX_Zeb
        ldx PageIndex
+       inc $6AF4,x
        jsr LF699
        ldy $6B02,x
        lda $96CB,y
        clc
        adc #$D1
        sta $00
        lda #$00
        adc #$97
        sta $01
        lda FrameCount
        eor $2E
        ldy #$00
        and ($00),y
        tay
        iny
        lda ($00),y
        sta $0408,x
        jsr $80B0
        bpl ++
        lda #$00
        sta $0406,x
        sta $0407,x
        ldy $0408,x
        lda $972B,y
        sta $6AFE,x
        lda $973F,y
        sta $6AFF,x
        lda $9753,y
        sta $0402,x
        lda $9767,y
        sta $0403,x
        lda $0405,x
        bmi +
        lsr a
        bcc ++
        jsr $81D1
        jmp ++

+       and #$04
        beq ++
        jsr $8206
++      lda #$DF
        jmp LF7B3

LF83E:  lda $0405,x
LF841:  jmp +

LF844:  lda $0405,x
        bpl +
        lsr a
        lsr a
+       lsr a
        lda $6B02,x
        rol a
        tay
        rts

LF852:  txa
        lsr a
        lsr a
        lsr a
        adc FrameCount
        lsr a
        rts

LF85A:  ldy $6B02,x
        lda $969B,y
        sta $040D,x
        lda $962B,y
        ldy $040F,x
        bpl +
        asl a
+       sta $040B,x
-       rts

LF870:  lda $0405,x
        and #$10
        beq -
        lda $87
        and $6AF4,x
        beq -
        lda $87
        bpl +
        ldy $6B01,x
        bne -
+       jsr LF8E8
        bcs +
        sta $0404,y
        jsr LF92C
        lda $0405,x
        lsr a
        lda $85
        pha
        rol a
        tax
        lda $978B,x
        pha
        tya
        tax
        pla
        jsr LF68D
        ldx PageIndex
        lda #$01
        sta $6AF4,y
        and $0405,x
        tax
        lda Table15,x
        sta $0403,y
        lda #$00
        sta $0402,y
        ldx PageIndex
        jsr LF8F8
        lda $0405,x
        lsr a
        pla
        tax
        lda $97A3,x
        sta $04
        txa
        rol a
        tax
        lda $979B,x
        sta $05
        jsr LF91D
        ldx PageIndex
        bit $87
        bvc +
        lda $0405,x
        and #$01
        tay
        lda $0083,y
        jmp LF690

LF8E8:  ldy #$60
        clc
-       lda $6AF4,y
        beq +
        jsr Yplus16
        cmp #$C0
        bne -
+       rts

LF8F8:  lda $85
        cmp #$02
        bcc +
        ldx PageIndex
        lda $0405,x
        lsr a
        lda $88
        rol a
        and #$07
        sta $040A,y
        lda #$02
        sta $6AF4,y
        lda #$00
        sta $0409,y
        sta $6AF8,y
        sta $0408,y
+       rts

LF91D:  ldx PageIndex
        jsr LE792
        tya
        tax
        jsr LFD8F
        jmp LFA49

; Table used by above subroutine

Table15
        .db $02
        .db $FE

LF92C:  lda #$02
        sta $6AF5,y
        sta $6AF6,y
        ora $0405,y
        sta $0405,y
        rts

LF93B:  ldx #$B0
-       jsr LF949
        ldx PageIndex
        jsr Xminus16
        cmp #$60
        bne -
LF949:  stx PageIndex
        lda $0405,x
        and #$02
        bne +
        jsr KillObject
+       lda $6AF4,x
        beq Exit19
        jsr GoRoutine

; Pointer table to code

        .dw ExitSub     ; rts
        .dw $F96A
        .dw LF991       ; spit dragon's fireball
        .dw ExitSub     ; rts
        .dw $FA6B
        .dw $FA91

Exit19: rts

LF96A:  jsr LFA5B
        jsr LFA1E
        ldx PageIndex
        bcs LF97C
        lda $6AF4,x
        beq Exit19
        jsr LFA60
LF97C:  lda #$01
LF97E:  jsr UpdateEnemyAnim
        jmp LDD8B

-       inc $0408,x
LF987:  inc $0408,x
        lda #$00
        sta $0409,x
        beq +
LF991:  jsr LFA5B
        lda $040A,x
        and #$FE
        tay
        lda $97A7,y
        sta $0A
        lda $97A8,y
        sta $0B
+       ldy $0408,x
        lda ($0A),y
        cmp #$FF
        bne +
        sta $0408,x
        jmp LF987

+       cmp $0409,x
        beq -
        inc $0409,x
        iny
        lda ($0A),y
        jsr $8296
        ldx PageIndex
        sta $0402,x
        lda ($0A),y
        jsr $832F
        ldx PageIndex
        sta $0403,x
        tay
        lda $040A,x
        lsr a
        php
        bcc +
        tya
        jsr GetAbsolute
        sta $0403,x
+       plp
        bne +
        lda $0402,x
        beq +
        bmi +
        ldy $040A,x
        lda $95E0,y
        sta $6AF9,x
+       jsr LFA1E
        ldx PageIndex
        bcs ++
        lda $6AF4,x
        beq Exit20
        ldy #$00
        lda $040A,x
        lsr a
        beq +
        iny
+       lda $95E2,y
        jsr LF68D
        jsr LF518
        lda #$0A
        sta $0409,x
++      jmp LF97C

        KillObject:
        lda #$00
        sta $6AF4,x
        rts

; enemy<-->background crash detection

LFA1E:  lda $74
        cmp #$11
        bne +
        lda $6AF4,x
        lsr a
        bcc ++
+       jsr LFA7D
        ldy #$00
        lda ($04),y
        cmp #$A0
        bcc +
        ldx PageIndex
++      lda $0403,x
        sta $05
        lda $0402,x
        sta $04
LFA41:  jsr LE792
        jsr LFD8F
        bcc KillObject
LFA49:  lda $08
        sta $0400,x
        lda $09
        sta $0401,x
        lda $0B
        and #$01
        sta $6AFB,x
+       rts

LFA5B:  lda $0404,x
        beq Exit20
LFA60:  lda #$00
        sta $0404,x
        lda #$05
        sta $6AF4,x
Exit20: rts

LFA6B:  lda $6AF7,x
        cmp #$F7
        beq +
        dec $0409,x
        bne ++
+       jsr KillObject
++      jmp LF97C

LFA7D:  ldx PageIndex
        lda $0400,x
        sta $02
        lda $0401,x
        sta $03
        lda $6AFB,x
        sta $0B
        jmp MakeWRAMPtr

LFA91:  jsr KillObject
        lda $95DC
        jsr LF68D
        jmp LF97C

LFA9D:  ldx #$C0
-       stx PageIndex
        lda $6AF4,x
        beq +
        jsr LFAB4
+       lda PageIndex
        clc
        adc #$08
        tax
        cmp #$E0
        bne -
--      rts

LFAB4:  dec $0406,x
        bne ++
        lda #$0C
        sta $0406,x
        dec $0407,x
        bmi +
        bne ++
+       jsr KillObject
++      lda $0406,x
        cmp #$09
        bne +
        lda $0407,x
        asl a
        tay
        lda Table16,y
        sta $04
        lda Table16+1,y
        sta $05
        jsr LFA41
+       lda #$80
        sta $6B
        lda #$03
        jmp LF97E

; Table used by above subroutine

Table16
        .db $00
        .db $00
        .db $0C
        .db $1C
        .db $10
        .db $F0
        .db $F0
        .db $08

LFAF2:  ldy #$18
-       jsr LFAFF
        lda PageIndex
        sec
        sbc #$08
        tay
        bne -

LFAFF:  sty PageIndex
        ldx $0728,y
        inx
        beq --
        ldx $0729,y
        lda $6AF4,x
        beq +
        lda $0405,x
        and #$02
        bne Exit13
+       sta $0404,x
        lda #$FF
        cmp $6B02,x
        bne +
        dec $0409,x
        bne Exit13
        lda $0728,y
        jsr LEB28
        ldy PageIndex
        lda $072A,y
        sta $0400,x
        lda $072B,y
        sta $0401,x
        lda $072C,y
        sta $6AFB,x
        lda #$18
        sta $6AF6,x
        lda #$0C
        sta $6AF5,x
        ldy #$00
        jsr LF186
        jsr LF152
        jsr LF1BF
        jsr LF1FA
        bcc Exit13
        lda #$01
        sta $0409,x
        sta $6AF4,x
        and ScrollDir
        asl a
        sta $0405,x
        ldy $6B02,x
        jsr LFB7B
        jmp LF85A

+       sta $6B02,x
        lda #$01
        sta $0409,x
        jmp KillObject

LFB7B:  jsr $80B0
        ror $0405,x
        lda $96BB,y
        sta $0409,x
Exit13: rts

LFB88:  ldx PageIndex
        jsr LF844
        lda $6B01,x
        inc $6B03,x
        dec $6B03,x
        bne +
        pha
        pla
+       bpl +
        jsr GetAbsolute
+       cmp #$08
        bcc +
        cmp #$10
        bcs Exit13
        tya
        and #$01
        tay
        lda $0085,y
        cmp $6AF9,x
        beq Exit13
        sta $6AFA,x
        dec $6AFA,x
        sta $6AF9,x
        jmp LF693

+       lda $963B,y
        cmp $6AF9,x
        beq Exit13
        jmp LF68D

LFBCA:  ldx PageIndex
        jsr LF844
        lda $965B,y
        cmp $6AF9,x
        beq Exit13
        sta $6AF9,x
        jmp LF690

LFBDD:  lda #$40
        sta PageIndex
        ldx #$0C
-       jsr LFBEC
        dex
        dex
        dex
        dex
        bne -
LFBEC:  lda $A0,x
        beq ++
        dec $A0,x
        txa
        lsr a
        tay
        lda Table17,y
        sta $04
        lda Table17+1,y
        sta $05
        lda $A1,x
        sta $08
        lda $A2,x
        sta $09
        lda $A3,x
        sta $0B
        jsr LFD8F
        bcc +++
        lda $08
        sta $A1,x
        sta $034D
        lda $09
        sta $A2,x
        sta $034E
        lda $0B
        and #$01
        sta $A3,x
        sta $034C
        lda $A3,x
        sta $034C
        lda #$5A
        sta $0343
        txa
        pha
        jsr DrawFrame
        lda SamusBlink
        bne +
        ldy #$00
        ldx #$40
        jsr LDC7F
        bcs +
        jsr LCD9C
        ldy #$00
        bcc +
        clc
        jsr LF311
        lda #$50
        sta $6E
        jsr LCE92
+       pla
        tax
++      rts

+++     lda #$00
        sta $A0,x
        rts

; Table used by above subroutine

Table17
        .db $00
        .db $FB
        .db $FB
        .db $FE
        .db $FB
        .db $02
        .db $00
        .db $05

LFC65:  lda $6BE4
        beq +
        ldx #$F0
        stx PageIndex
        lda $6BE9
        cmp $95E4
        bne ++
        lda #$03
        jsr UpdateEnemyAnim
        lda $2E
        sta $8A
        lda #$18
-       pha
        tax
        jsr LFC98
        pla
        tax
        lda $B6,x
        and #$F8
        sta $B6,x
        txa
        sec
        sbc #$08
        bpl -
+       rts

++      jmp KillObject

LFC98:  lda $B0,x
        jsr GoRoutine

; Pointer table to code

        .dw ExitSub       ; rts
        .dw $FCA5
        .dw $FCB1
        .dw $FCBA

LFCA5:  jsr LFD84
        jsr LFD08
        jsr LFD25
        jmp LDD8B

LFCB1:  jsr LFD84
        jsr LFCC1
        jmp LDD8B

LFCBA:  lda #$00
        sta $B0,x
        jmp SFX_EnemyHit

LFCC1:  jsr LFD5F
        lda $B4,x
        cmp #$02
        bcs +
        ldy $08
        cpy ObjectY
        bcc +
        ora #$02
        sta $B4,x
+       ldy #$01
        lda $B4,x
        lsr a
        bcc +
        ldy #$FF
+       sty $05
        ldy #$04
        lsr a
        lda $B5,x
        bcc +
        ldy #$FD
+       sty $04
        inc $B5,x
        jsr LFD8F
        bcs +
        lda $B4,x
        ora #$02
        sta $B4,x
+       bcc +
        jsr LFD6C
+       lda $B5,x
        cmp #$50
        bcc +
        lda #$01
        sta $B0,x
+       rts

LFD08:  lda #$00
        sta $B5,x
        tay
        lda ObjectX
        sec
        sbc $B2,x
        bpl +
        iny
        jsr GetAbsolute
+       cmp #$10
        bcs +
        tya
        sta $B4,x
        lda #$02
        sta $B0,x
+       rts

LFD25:  txa
        lsr a
        lsr a
        lsr a
        adc $8A
        sta $8A
        lsr $8A
        and #$03
        tay
        lda Table18,y
        sta $04
        lda Table18+1,y
        sta $05
        jsr LFD5F
        lda $08
        sec
        sbc ScrollY
        tay
        lda #$02
        cpy #$20
        bcc +
        jsr GetAbsolute
        cpy #$80
        bcc ++
+       sta $04
++      jsr LFD8F
        jmp LFD6C

; Table used by above subroutine

Table18
        .db $02
        .db $FE
        .db $01
        .db $FF
        .db $02

LFD5F:  lda $B3,x
        sta $0B
        lda $B1,x
        sta $08
        lda $B2,x
        sta $09
        rts

LFD6C:  lda $08
        sta $B1,x
        sta $04F0
        lda $09
        sta $B2,x
        sta $04F1
        lda $0B
        and #$01
        sta $B3,x
        sta $6BEB
        rts

LFD84:  lda $B6,x
        and #$04
        beq +
        lda #$03
        sta $B0,x
+       rts

LFD8F:  lda ScrollDir
        and #$02
        sta $02
        lda $04
        clc
        bmi +++
        beq LFDBF
        adc $08
        bcs +
        cmp #$F0
        bcc ++
+       adc #$0F
        ldy $02
        bne ClcExit2
        inc $0B
++      sta $08
        jmp LFDBF

+++     adc $08
        bcs +
        sbc #$0F
        ldy $02
        bne ClcExit2
        inc $0B
+       sta $08
LFDBF:  lda $05
        clc
        bmi ++
        beq SecExit
        adc $09
        bcc +
        ldy $02
        beq ClcExit2
        inc $0B
+       jmp +++

++      adc $09
        bcs +++
        ldy $02
        beq ClcExit2
        inc $0B
+++     sta $09
        SecExit:
        sec
        rts

        ClcExit2:
        clc
--      rts

LFDE3:  lda EndTimerHi
        cmp #$99
        bne +
        clc
        sbc EndTimerLo  ; A = zero if timer just started
        bne +           ; branch if not
        sta $06
        lda #$38
        sta $07
        jsr LDC54
+       ldx #$20
-       jsr LFE05
        txa
        sec
        sbc #$08
        tax
        bne -

LFE05:  lda $0758,x
        sec
        sbc #$02
        bne --
        sta $06
        inc $0758,x
        txa
        lsr a
        adc #$3C
        sta $07
        jmp LDC54

; Tile degenerate/regenerate

        UpdateTiles:
        ldx #$C0
-       jsr DoOneTile
        ldx PageIndex
        jsr Xminus16
        bne -
        DoOneTile:
        stx PageIndex
        lda TileRoutine,x
        beq +               ; exit if tile not active
        jsr GoRoutine

; Pointer table to code

        .dw ExitSub       ; rts
        .dw $FE3D
        .dw $FE54
        .dw $FE59
        .dw $FE54
        .dw $FE83

LFE3D:  inc TileRoutine,x
        lda #$00
        jsr SetTileAnim
        lda #$50
        sta TileDelay,x
        lda TileWRAMLo,x     ; low WRAM addr of blasted tile
        sta $00
        lda TileWRAMHi,x     ; high WRAM addr
        sta $01

LFE54:  lda #$02
        jmp UpdateTileAnim

LFE59:  lda FrameCount
        and #$03
        bne +       ; only update tile timer every 4th frame
        dec TileDelay,x
        bne +       ; exit if timer not reached zero
        inc TileRoutine,x
        ldy TileType,x
        lda Table19,y
        SetTileAnim:
        sta TileAnimIndex,x
        sta $0505,x
        lda #$00
        sta TileAnimDelay,x
+       rts

; Table used for indexing the animations in TileBlastAnim (see below)

Table19
        .db $18,$1C,$20,$00,$04,$08,$0C,$10,$24,$14

LFE83:  lda #$00
        sta TileRoutine,x       ; tile = respawned
        lda TileWRAMLo,x
        clc
        adc #$21
        sta $00
        lda TileWRAMHi,x
        sta $01
        jsr LFF3C
        lda $02
        sta $07
        lda $03
        sta $09
        lda $01
        lsr a
        lsr a
        and #$01
        sta $0B
        ldy #$00
        jsr LF186
        lda #$04
        clc
        adc ObjRadY
        sta $04
        lda #$04
        clc
        adc ObjRadX
        sta $05
        jsr LF1FA
        bcs Exit23
        jsr LF311
        lda #$50
        sta $6E
        jmp LCE92

        GetTileFramePtr:
        lda TileAnimFrame,x
        asl a
        tay
        lda $97AF,y
        sta $02
        lda $97B0,y
        sta $03
Exit23: rts

        DrawTileBlast:
        lda PPUStrIndex
        cmp #$1F
        bcs Exit23
        ldx PageIndex
        lda TileWRAMLo,x
        sta $00
        lda TileWRAMHi,x
        sta $01
        jsr GetTileFramePtr
        ldy #$00
        sty $11
        lda ($02),y
        tax
        jsr Adiv16       ; / 16
        sta $04
        txa
        and #$0F
        sta $05
        iny
        sty $10
--      ldx $05
-       ldy $10
        lda ($02),y
        inc $10
        ldy $11
        sta ($00),y
        inc $11
        dex
        bne -
        lda $11
        clc
        adc #$20
        sec
        sbc $05
        sta $11
        dec $04
        bne --
        lda $01
        and #$04
        beq +
        lda $01
        ora #$0C
        sta $01
+       lda $01
        and #$2F
        sta $01
        jsr LC328
        clc
        rts

LFF3C:  lda $00
        tay
        and #$E0
        sta $02
        lda $01
        lsr a
        ror $02
        lsr a
        ror $02
        tya
        and #$1F
        jsr Amul8       ; * 8
        sta $03
        rts

        UpdateTileAnim:
        ldx PageIndex
        ldy TileAnimDelay,x
        beq +
        dec TileAnimDelay,x
        bne ++
+       sta TileAnimDelay,x
        ldy TileAnimIndex,x
        lda TileBlastAnim,y
        cmp #$FE            ; end of "tile-blast" animation?
        beq +
        sta TileAnimFrame,x
        iny
        tya
        sta TileAnimIndex,x
        jsr DrawTileBlast
        bcc ++
        ldx PageIndex
        dec TileAnimIndex,x
++      rts

+       inc TileRoutine,x
        pla
        pla
        rts

; Frame data for tile blasts

        TileBlastAnim:
        .db $06,$07,$00,$FE
        .db $07,$06,$01,$FE
        .db $07,$06,$02,$FE
        .db $07,$06,$03,$FE
        .db $07,$06,$04,$FE
        .db $07,$06,$05,$FE
        .db $07,$06,$09,$FE
        .db $07,$06,$0A,$FE
        .db $07,$06,$0B,$FE
        .db $07,$06,$08,$FE

        .db $00
        .db $00

;--------------------[ Reset address (code entrypoint) ]----------------------

        RESET:
        sei
        cld
        ldx #$00
        stx PPUControl0       ; clear PPUCNT0
        stx PPUControl1       ; clear PPUCNT1
-       lda PPUStatus
        bpl -           ; wait for vblank
-       lda PPUStatus
        bpl -           ; wait for vblank
        ora #$FF
        sta MMC1Reg0       ; reset MMCREG0
        sta MMC1Reg1       ; reset MMCREG1
        sta MMC1Reg2       ; reset MMCREG2
        sta MMC1Reg3       ; reset MMCREG3
        jmp Startup

        .db $FF
        .db $FF
        .db $FF
        jmp $B3E4
        .db $FF
        .db $FF
        .db $FF
        .db $FF
        .db $FF
        .db $FF
        .db $FF
        .db $FF
        .db $FF
        .db $FF
        .db $FF
        .db $FF
        .db $FF
        .db $FF
        .db $4D ; M
        .db $45 ; E
        .db $54 ; T
        .db $52 ; R
        .db $4F ; O
        .db $49 ; I
        .db $44 ; D
        .db $E4
        .db $8D
        .db $00
        .db $00
        .db $38
        .db $04
        .db $01
        .db $06
        .db $01
        .db $BC

; Vectors

.dw     NMI
.dw     RESET
.dw     RESET

.end
