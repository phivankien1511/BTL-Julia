HEIGHT = 700
WIDTH = 400

GAP = 130
GRAVITY = 0.3
FLAP_STRENGTH = 4
SPEED = 2.5

background = Actor("background")
bird = Actor("bird1")
bird.pos = (75, 200)
bird_dead = false
bird_score = 0
bird_vy = 0.0

function reset_pipes()
    pipe_gap_y = rand(200:(HEIGHT - 250))
    pipe_top.bottomleft = (WIDTH, pipe_gap_y - GAP ÷ 2)
    pipe_bottom.topleft = (WIDTH, pipe_gap_y + GAP ÷ 2)
end

pipe_top = Actor("top")
pipe_bottom = Actor("bottom")
reset_pipes()

function update_pipes()
    pipe_top.left += -SPEED
    pipe_bottom.left += -SPEED
    global bird_score
    if pipe_top.right < 0
        reset_pipes()
        if bird_dead == false
            bird_score += 1
        end
    end
end
function reset()
    global bird
    global GAP, GRAVITY, FLAP_STRENGTH, SPEED
    GAP = 130
    GRAVITY = 0.3
    FLAP_STRENGTH = 4
    SPEED = 2.5

    bird = Actor("bird1")
    bird.pos = (75, 200)
    global bird_dead
    bird_dead = false
    global score
    global bird_vy
    bird_score = 0
    bird_vy = 0.0

end

function update()
    update_pipes()
    update_bird()

end
function update_bird()
    global bird_vy
    global bird_dead
    global bird_score
    uy = bird_vy
    bird_vy += GRAVITY
    bird.y += Int(round((uy + bird_vy) / 2))
    bird.x = 75

    if bird_dead == false
        if bird_vy < -3
            bird.image = "bird2"
        else
            bird.image = "bird1"
        end
    end

    if collide(bird, pipe_top) || collide(bird, pipe_bottom)
        bird_dead = true
        bird.image = "birddead"
        
    end

    if !(0 < bird.y < 720)
        bird.y = 200
        bird_dead = false
        bird_score = 0
        bird_vy = 0
        reset_pipes()    
    end
    
end


function on_key_down(g::Game)
    global bird_vy
   
    if !bird_dead
        bird_vy = -FLAP_STRENGTH

    end
    
end

function draw(g::Game)
    draw(background)
    draw(pipe_top)
    draw(pipe_bottom)
    draw(bird)
    
    txt = TextActor("score:$bird_score", "comicbd";
        font_size = 25, color = Int[0, 128, 0, 255]
    )
    txt.pos = (10, 5)
    draw(txt)

end
