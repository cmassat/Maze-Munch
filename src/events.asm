handle_events
   jsr process_offscreen
    ; Peek at the queue to see if anything is pending
    lda		kernel.args.events.pending  ; Negated count
    bpl		_done

    ; Get the next event.
    jsr		kernel.NextEvent
    bcs		_done

    ; Handle the event
    jsr		_dispatch
 _done       
        ; Continue until the queue is drained.

   
    bra		handle_events
    rts

 _dispatch
   ; Get the event's type
   lda		event.type
   
   ; Call the appropriate handler
   cmp		#kernel.event.key.PRESSED
   beq		_key_pressed

   cmp     #kernel.event.timer.EXPIRED
   beq		_handle_timer_event
   rts
			
_key_pressed
   lda event.key.ascii
   sta keypress
  
   rts     ; Anything not handled can be ignored.

_handle_timer_event
   inc m_screen_updating
   jsr spash_event_processing
   jsr menu_event_processing
   jsr game_event_processing
   jsr game_over_event_processing
   jsr handle_animation
   jsr set_frame_timer
   stz m_screen_updating
   rts 

process_offscreen
   lda m_screen_updating
   bne _done
   jsr splash_offscreen_processing
   jsr menu_offscreen_processing
   jsr game_offscreen_processing
   jsr game_over_offscreen_processing
   inc m_screen_updating
_done
   rts 

set_frame_timer
   lda #kernel.args.timer.FRAMES | kernel.args.timer.QUERY
   sta kernel.args.timer.units
   
   stz kernel.args.timer.absolute
   lda #1
   sta kernel.args.timer.cookie
   jsr kernel.Clock.SetTimer

   adc #1
   sta kernel.args.timer.absolute

   lda #kernel.args.timer.FRAMES 
   sta kernel.args.timer.units
   
   lda #1
   sta kernel.args.timer.cookie
   jsr kernel.Clock.SetTimer
   rts

init_events
    lda     #<event
    sta     kernel.args.events+0
    lda     #>event
    sta     kernel.args.events+1
    rts

handle_animation
   inc m_frame_counter
   lda m_frame_counter
   cmp #5
   bne _frame1
   lda #1
   sta m_animation
   rts 
_frame1
   lda m_frame_counter
   cmp #10
   bne _done
   lda #0
   sta m_animation
   stz m_frame_counter
_done 
   rts 

m_screen_updating
   .byte 0
m_pm_speed
   .byte 0   
m_rg_speed
   .byte 0
m_pg_speed
   .byte 0
m_bg_speed
   .byte 0
m_og_speed
   .byte 0
m_animation 
   .byte 0
m_frame_counter
   .byte 0