local game = {}

local const = require("/constantes")
local item = require("/items")
local inventory = require("/inventory")

-- 📜📜 var lié au menu pause
local pause = false
local selectedOption = 1
local options = {
    "Reprendre",
    "Options",
    "Quitter"
}

-- 🔊🔊var lie au son du menu
local cancelSnd = const.SND_CANCEL:clone()
local pauseSnd = const.SND_PAUSE:clone()

function game.pause()
    pauseSnd:play()
    pause = not pause
    -- return pause
end

function game.isPaused()
    return pause
end

-- c'est ici qu'on choisit les objet à créer mais pas ici qu'on les crée
function game.itemManager()
    -- on creer nos objet de maniere dynamique
    --🪓🪓🪓🪓
    axe = item.create(const.AXE, 5)
    bow = item.create(const.BOW, 1)

end


function game.findItems(entitie)
    -- gestion de colision avec nos objet
    -- on boucle sur tout les objets de la liste et qui seront succeptible d'etre à l'ecran 
        for index = 1, #item.list do
            -- on calcul la distance de notre hero au objet
            if math.dist(entitie.x, entitie.y, item.list[index].x, item.list[index].y) < 50 then
                -- on est a proximité de l'objet
                item.list[index].proximity = true
            else
                item.list[index].proximity = false
            end
            -- 🪓🪓 ramasser un objet
            if love.keyboard.isDown("e")  and item.list[index].proximity == true and item.list[index].pick == false then
                sndPicking:play()
                inventory.addObj(entitie, item.list[index])
            end
        end
end 

function game.switchWeapon(lstEntities, key)
    -- Vérifie si la touche "q" est pressée une seule fois
    for index = 1, #lstEntities do 
        -- on recupere notre hero
        if lstEntities[index].type == const.HERO then
            -- on formate notre variable pour + de lisibilité
            local hero = lstEntities[index]
            if key == "q" and #hero.inventory > 0 then
                sndSwitchWpn:play()
                -- Incrémente l'index de l'arme actuelle
                hero.currentWpn = hero.currentWpn % #hero.inventory + 1
        
                -- Définit l'arme actuelle
                hero.selectedWeapon = hero.inventory[hero.currentWpn]
                print("Nouvelle arme équipée :", hero.selectedWeapon.name)
            end
        end

    end
end

function drawInventory(hero)
    local x = 0
    local y = const.SCREENHEIGHT - const.PANEL_INVENTORY:getHeight()
    local offset = 60

    -- on boucle dans l'inventaire du hero
    for index, weapon in ipairs(hero.inventory) do
        -- on affiche nos armes a l écran sur notre panel 
        love.graphics.draw(weapon.images[1], x + index * offset, y)

        -- Met en surbrillance l'arme actuellement sélectionnée
        if index == hero.currentWpn then
            love.graphics.setColor(1, 0, 1) -- violet
            love.graphics.rectangle("line", x + index * offset, y, 60, 60)
            love.graphics.setColor(1, 1, 1) -- Reset color
        else
            -- affiche un rectangle blanc sur l'arme non selectionné
            love.graphics.rectangle("line", x + index * offset, y, 60, 60)
        end
    end
end

function game.load()
    sndPicking = const.SND_PICK_WPN:clone()
    sndSwitchWpn = const.SND_SWITCH_WPN:clone()
end

function game.draw()
    -- panel de la pause ou de l'HUD selon que le jeu soit en pause ou non
    if pause then
        -- on affiche le panel pause
        love.graphics.draw(const.PANEL_PAUSE, const.SCREENWIDTH / 2 - const.PANEL_PAUSE:getWidth() / 2, const.SCREENHEIGHT / 2 - const.PANEL_PAUSE:getHeight() / 2)
        -- on affiche les options du panel pause
        for key, option in pairs(options) do
            -- on colorie le menu selectionné
            if key == selectedOption then
                love.graphics.setColor(1, 0, 1) -- Option sélectionnée en violet
            else
                --le reste reste blanc
                love.graphics.setColor(1, 1, 1) -- Option normale en blanc
            end
            love.graphics.printf(option, 0, (const.SCREENHEIGHT / 3) + key * 50, const.SCREENWIDTH, "center")
            love.graphics.setColor(1, 1, 1) -- Option normale en blanc
        end
    else
        -- on affiche le panel inventaire et son contenu
        love.graphics.draw(const.PANEL_INVENTORY, 0 , const.SCREENHEIGHT - const.PANEL_INVENTORY:getHeight())
        drawInventory(hero)
        -- on affiche l'arme current du hero on check le nil pointer
        if hero.selectedWeapon ~= nil then
            love.graphics.draw(hero.selectedWeapon.images[math.floor(hero.currentFrameOBJ)], hero.x + hero.width, hero.y + hero.height,hero.angleShoot, 1, 1,hero.selectedWeapon.width / 2, hero.selectedWeapon.height / 2 )

            -- Animation de l'arme equipé
            hero.currentFrameOBJ = hero.currentFrameOBJ + 10 
            if hero.currentFrameOBJ > #hero.selectedWeapon.images + 1 then
                hero.currentFrameOBJ = 1
            end
        end
    end
end

function game.keypressed(key)

    if pause then
        
            if key == "up" then
                cancelSnd:play()
                selectedOption = selectedOption - 1
                -- si on est deja à la premiere option du menu on retourne en bas
                if selectedOption < 1 then
                    selectedOption = #options
                end
            elseif key == "down" then
                cancelSnd:play()
                selectedOption = selectedOption + 1
                -- si on est a la derniere  option du menu on retourne en haut
                if selectedOption > #options then
                    selectedOption = 1
                end
            -- maintenant le comportement si on appui sur entrer
            elseif key == "return" then
                cancelSnd:play()
                if options[selectedOption] == "Reprendre" then
                    pause = false
                elseif options[selectedOption] == "Quitter" then
                    love.event.quit()
                end
            end        
    end

end

return game