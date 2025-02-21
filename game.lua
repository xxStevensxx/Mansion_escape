local game = {}


local const = require("/constantes")

-- 📜📜 var lié au menu pause
local pause = false
local inventory = true
local selectedOption = 1
local options = {
    "Reprendre",
    "Options",
    "Quitter"
}

-- 🔊🔊var lie au son du menu
local cancelSnd = const.SND_CANCEL:clone()

function game.pause()
    cancelSnd:play()
    pause = not pause
    -- return pause
end

function game.isPaused()
    return pause
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
        love.graphics.draw(const.PANEL_INVENTORY, 15 , const.SCREENHEIGHT - const.PANEL_INVENTORY:getHeight() - 15)
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