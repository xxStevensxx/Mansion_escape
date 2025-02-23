local stateBubble = {}

local const = require("/constantes")

--param 1 l'entitie sur laquel on veux afficher la bubble
function stateBubble.state(entities, itemList)

    if entities.state == const.GROWL then
        love.graphics.draw(const.BUBBLE_GROWL, entities.x, entities.y - 35 , 0, 2, 2, const.BUBBLE_GROWL:getWidth() / 2, const.BUBBLE_GROWL:getHeight() / 2 ) 
    end

    if entities.state == const.EAR then
        love.graphics.draw(const.BUBBLE_EAR, entities.x, entities.y - 35 , 0, 2, 2, const.BUBBLE_EAR:getWidth() / 2, const.BUBBLE_EAR:getHeight() / 2 ) 
    end

    if entities.state == const.PURSUIT then
        love.graphics.draw(const.BUBBLE_PURSUIT, entities.x, entities.y - 35 , 0, 2, 2, const.BUBBLE_PURSUIT:getWidth() / 2, const.BUBBLE_PURSUIT:getHeight() / 2 ) 
    end

    -- verif si notre hero est a proximité d'un objet
    for nb = 1, #itemList do
        if itemList[nb].proximity == true and itemList[nb].pick == false  then
            if entities.type == const.HERO then
                love.graphics.print(const.TEXT_PROX, entities.x, entities.y, 0, 2, 2) 
            end
        end
    end

end

return stateBubble