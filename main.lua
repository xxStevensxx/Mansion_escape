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
local item = require("/items")
local panel = nil
local groupe = nil
local text = nil
-- local lstProjectiles = {}
local lstEntities = {}
local pause = false
local win = false

love.graphics.setDefaultFilter("nearest")
math.randomseed(os.time())


function love.load()
    -- 🪓🪓 item manager
    game.itemManager()
    game.load()

    -- 💻💻
    -- love.window.setMode(1920, 1080, { resizable = true })
    print(const.SCREENHEIGHT)
    print(const.SCREENHEIGHT)
    -- 📝📝 Font
    love.graphics.setFont(const.FONT)

    -- 🎼🎼 Musique
    bckgrndMusic = const.MSC_MANSION
    bckgrndMusic:setLooping(true)
    bckgrndMusic:play()

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
    -- 🪓🪓 Gestion de la proximité des objet avec le hero
    game.findItems(hero)
    -- 🪓🪓 gestion du changement de l'arme du hero
    game.switchWeapon(hero)


    if pause == false and win == false then
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
            for nb = #lstEntities, 1, -1 do
                --Animation des framerate des entities dans l'entitite.update
                entitie.update(dt, lstEntities[nb])

                -- on verifie si on a un hero
                if lstEntities[nb].type == const.HERO then
                    --Si il existe on lui applique une "manette"
                    controller.update(dt, lstEntities[nb], lstEntities)
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
    for nb = 1, #item.list do
        if item.list[nb].pick == false then

            -- animation pulsation pour rendre les armes au sol plus visible
            local pulseFrequency = 2     -- Fréquence de l'oscillation (en radians par seconde)
            local pulseAmplitude = 0.2   -- Amplitude de variation (20% d'augmentation ou de diminution)
            local scale = 1 + pulseAmplitude * math.cos(love.timer.getTime() * pulseFrequency)

            love.graphics.draw(item.list[nb].images[1], item.list[nb].x, item.list[nb].y, 0, scale, scale, item.list[nb].width / 2, item.list[nb].height / 2)
            --on affiche le rayon du range autours des objets dans leurs zone de pick
            -- love.graphics.circle("line", item.list[nb].x, item.list[nb].y, 50)
        end 
    end
    -- 💻💻 on affiche tout les panel inventaire et menu pause
    game.draw()
    -- On boucle dans notre liste d'entities (hero ou mobs) afin de tous les afficher a l'ecran
    for index = 1, #lstEntities do
        if lstEntities[index].type == hero then
            -- 💻💻 on affiche tout le contenu de l'inventaire sur le panel
            game.drawInventory(lstEntities[index])
        end
        --💻💻 on applique le draw de game
        machine.draw()
        --on formate notre tableau afin de travailler plus facilement dessus
        local entitie = lstEntities[index]
        --On affiche tout nos entities sans distinction de type
        love.graphics.draw(entitie.images[math.floor(entitie.currentFrame)], entitie.x, entitie.y, entitie.angle, 3, 3, entitie.offsetX, entitie.offsetY)

        -- 💭💭 stateBubble
        bubble.state(entitie, item.list)

        -- 🏡🏡 spawner
        spawner.draw()

        -- Life entitie, pdv
        if entitie.type == const.HERO then
            life.show(entitie.life, 10, 10)
        elseif entitie.type ~= const.HERO then
            life.show(entitie.life, entitie.x - entitie.offsetX, entitie.y - 30, 0, 4, 4)
        end
    end

end

function love.keypressed(key)
    -- Gestion des entrées claviers du menu
    game.keypressed(key)
    -- switch Wpn
    game.switchWeapon(lstEntities, key)
    -- a l'appui de la touche echape on quitte le jeu
    if key == "escape" then
        pause = game.pause()
    end

    if key == "p" then
       pause = game.pause()
    end
end