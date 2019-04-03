; made with 6502asm.com/beta/

lda #$ff
sta $00  ; constant $ff at zeropage $00

start:
ldx #$00 ; reset x register
cmp #$00
beq loop1
cmp #$01
beq loop3
cmp #$02
beq loop4
cmp #$03
beq loop2
cmp #$04
beq loop1

loop1:
lda #$01
inc $200,x
cpx $00
beq start
inx
jsr busywork
jmp loop1

loop2:
lda #$02
inc $300,x
cpx $00
beq start
inx
jsr busywork
jmp loop2

loop3:
lda #$03
inc $400,x
cpx $00
beq start
inx
jsr busywork
jmp loop3

loop4:
lda #$04
inc $500,x
cpx $00
beq start
inx
jsr busywork
jmp loop4

busywork:
ldy #$02
f:
nop
dey
cpy #$00
bne f
jmp outofbusy

outofbusy:
rts
