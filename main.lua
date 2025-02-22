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
-- local projectiles = require("/projectile")
local bubble = require("/stateBubble")
local life = require("/life")
local spawner = require("/spawner")
local game = require("/game")
local panel = nil
local groupe = nil
local text = nil
-- local lstProjectiles = {}
local lstEntities = {}
local eye = love.graphics.newImage("/assets/eye.png")
local pause = false

love.graphics.setDefaultFilter("nearest")
-- love.window.setMode(1920, 1080)
math.randomseed(os.time())


function love.load()
    -- 📝📝 Font
    love.graphics.setFont(const.FONT)

    -- 🎼🎼 Musique
    bckgrndMusic = const.MSC_MANSION
    bckgrndMusic:setLooping(true)
    bckgrndMusic:play()

    -- setMode
    -- love.window.setMode( 1920, 1080, {resizable = true})

    -- 🏡🏡spawner
    spawner.spawner()
    -- 🏡👻👾 spawn mob no mob spawn 
    spawner.spawn()

    -- lstEntities = spawner.entities

    --🐱‍🏍🐱‍🏍On creer un hero et on l'ajoute dans notre liste d'entities
    hero = entitie.create(const.HERO)
    hero.angle = 0
    table.insert(lstEntities, hero)


end

function love.update(dt)
    -- gestion de la pause du jeu
    pause = game.isPaused()

    if pause  == false then

        love.audio.play(bckgrndMusic)

        -- 🏡👻👾 update du spawner on fait spawn les ennemis
        spawner.update(dt, lstEntities)

        -- 🏡👻👾 -> On insert nos entities spawner dans notre lstEntities
        for nb = #spawner.entities, 1, -1 do
            table.insert(lstEntities, spawner.entities[nb])
            -- on vide notre spawn entities pour eviter les duplication lié a l'update
            spawner.entities = {}
        end


        if lstEntities ~= 0 then
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
                if lstEntities[nb].type ~= const.HERO then
                    -- si oui on applique notre machine a etats sur nos entities de type mob
                    machine.states(dt, lstEntities[nb], lstEntities)
                    machine.update(dt, lstEntities)
                end
            end
        end
    else
        love.audio.pause(bckgrndMusic)
    end
end

function love.draw()
    -- on affiche tout les gui inventaire et menu pause
    game.draw()
    -- On boucle dans notre liste d'entities (hero ou mobs) afin de tous les afficher a l'ecran
    for index = 1, #lstEntities do
        machine.draw()
        --on formate notre tableau afin de travailler plus facilement dessus
        local entitie = lstEntities[index]
        --On affiche tout nos entities sans distinction de type
        love.graphics.draw(entitie.images[math.floor(entitie.currentFrame)], entitie.x, entitie.y, entitie.angle, 3, 3, entitie.offsetX, entitie.offsetY)
        -- on empeche le nil pointer et on affiche le range
        if entitie.range ~= nil then
            --on affiche le rayon du range autours du mob
            -- love.graphics.circle("line", entitie.x, entitie.y, entitie.range)
        end

        -- 💭💭 stateBubble
        bubble.state(entitie)

        -- 🏡🏡 spawner
        spawner.draw()

        -- Life entitie, pdv, posX, posY
        if entitie.type == const.HERO then
            -- love.graphics.print(entitie.type)
            -- love.graphics.print("pdv "..tostring(entitie.life), 400, 400)
            love.graphics.draw(const.OBJ_BOW[entitie.currentFrameOBJ], entitie.x + entitie.width, entitie.y + entitie.height, entitie.angleShoot, 1, 1, const.OBJ_BOW[1]:getWidth() / 2, const.OBJ_BOW[1]:getHeight() / 2)
            life.show(entitie.life, 10, 10)
        elseif entitie.type ~= const.HERO then
            life.show(entitie.life, entitie.x - entitie.offsetX, entitie.y - 30, 0, 4, 4)
        end

        --debug
        if entitie.state ~= nil and entitie.buff ~= nil then
            love.graphics.print(entitie.state, entitie.x + 10, entitie.y - 20)
            love.graphics.print(tostring(entitie.buff), entitie.x + 30, entitie.y - 50)
            end
    end
end

function love.keypressed(key)
    game.keypressed(key)
    -- a l'appui de la touche echape on quitte le jeu
    if key == "escape" then
        pause = game.pause()
    end

    if key == "p" then
       pause = game.pause()
    end
end