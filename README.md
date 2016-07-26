# Grappling-Hook

This example attempts to illustrate a grappling hook mechanic using physics. 
 
 Note: this example needs some work. it illustrate the idea but the effect is somewhat random.
 
 The example is built around SKPhysicsJointSpring used to connect the player to 
 a target object. Advantages of this approach: 
 
    1. Using this method you would get realisitic pring like motion
    2. You can also use physics collisions as the spring joint will repsect these. 
    3. Would be possible to attach the target to a moving object.
 
 Disadvantages of this method:
    
    1. Seems more complex than other methods. See the note above.
