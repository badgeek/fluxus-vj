 (clear) 
 (define obj (build-cube)) ; make a cube for the camera to lock to 
 
 (with-state ; make a background cube so we can tell what's happening 
     (hint-wire) 
     (hint-unlit) 
     (texture (load-texture "test.png")) 
     (colour (vector 0.5 0.5 0.5)) 
     (scale (vector -20 -10 -10)) 
     (build-cube)) 
 
 (lock-camera obj) ; lock the camera to our first cube 
 (camera-lag 0.1)  ; set the lag amount, this will smooth out the cube jittery movement 
 (define (animate) 
     (with-primitive obj 
         (identity) 
         (translate (vector (fmod (time) 5) 0 0)))) ; make a jittery movement 
 
 (every-frame (animate)) 
