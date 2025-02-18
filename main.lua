-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

local entitie = require("/entities")
local const = require("/constantes")
local controller = require("/playerConctroller")
local machine =  require("/statesMachines")
local lstEntities = {}
local eye = love.graphics.newImage("/assets/eye.png")

love.graphics.setDefaultFilter("nearest")
math.randomseed(os.time())


function love.load()
    --On creer un hero et on l'ajoute dans notre liste d'entities
    hero = entitie.create(const.HERO)
    table.insert(lstEntities, hero)

        --On creer un ou des mob(s) et on l'ajoute dans notre liste d'entities
    for nb = 1, 10 do
        zombie = entitie.create(const.MOB)
        table.insert(lstEntities, zombie)
    end

    --On creer un ou des ghost et on l'ajoute dans notre liste d'entities
    for nb = 1, 10 do
        ghost = entitie.create(const.GHOST)
        table.insert(lstEntities, ghost)
    end


    
end


function love.update(dt)

    --on boucle dans notre lstentitie pour lui appliquer son update
    for nb = 1, #lstEntities do
        --Animation des framerate des entities dans l'entitite.update
        entitie.update(dt, lstEntities[nb])

        -- on verifie si on a un hero
        if lstEntities[nb].type == const.HERO then
            --Si il existe on lui applique une "manette"
            controller.update(dt, lstEntities[nb])
        end

        -- on verifie si on a des mobs
        if lstEntities[nb].type == const.MOB then
            -- si oui on applique notre machine a etats sur nos entities de type mob
            machine.states(dt, lstEntities[nb], lstEntities)
            machine.update(dt, lstEntities)
        end
    end


end

function love.draw()
    -- On boucle dans notre liste d'entities (hero ou mobs) afin de tous les afficher a l'ecran
    for index = 1, #lstEntities do
        --on formate notre tableau afin de travailler plus facilement dessus
        local entitie = lstEntities[index]
        --On affiche tout nos entities sans distinction de type
        love.graphics.draw(entitie.images[math.floor(entitie.currentFrame)], entitie.x, entitie.y, entitie.angle, 3, 3, entitie.offsetX, entitie.offsetY)
        --debug
        if entitie.state ~= nil then
            love.graphics.print(entitie.state, entitie.x, entitie.y)
        end
    end
end

function love.keypressed(key)
    -- a l'appui de la touche echape on quitte le jeu
    if key == "escape" then
        love.event.quit()
    end
end