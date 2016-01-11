-- Game config stuff
function love.conf(t)
    
    -- Love2d version
    t.version = "0.10.0"  
    
    -- Title on game window
    t.window.title = "Zombie Game (Pre-Alpha 0.1.3)"

    -- Game icon
    t.window.icon = "images/gameicon.png"

    -- Games window width
    t.window.width = 1280

    -- Games window height
    t.window.height = 720

    -- Game save folder name
    t.identity = "ZombieGame"  
end