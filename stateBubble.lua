local stateBubble = {}

local const = require("/constantes")

--param 1 le status que l'on veux afficher au dessus de l'entitie
function stateBubble.state(entities)

    if entities.state == const.GROWL then
        love.graphics.draw(const.BUBBLE_GROWL, entities.x, entities.y - 35 , 0, 2, 2, const.BUBBLE_GROWL:getWidth() / 2, const.BUBBLE_GROWL:getHeight() / 2 ) 
    end

    if entities.state == const.EAR then
        love.graphics.draw(const.BUBBLE_EAR, entities.x, entities.y - 35 , 0, 2, 2, const.BUBBLE_EAR:getWidth() / 2, const.BUBBLE_EAR:getHeight() / 2 ) 
    end

    if entities.state == const.PURSUIT then
        love.graphics.draw(const.BUBBLE_PURSUIT, entities.x, entities.y - 35 , 0, 2, 2, const.BUBBLE_PURSUIT:getWidth() / 2, const.BUBBLE_PURSUIT:getHeight() / 2 ) 
    end

end

    -- if entitieState == const.
    --     love.graphics.draw(const.BUBBLE_GROWL, entities.x, entities.y, 0, 3, 3, const.BUBBLE_GROWL:getWidth() / 2, const.BUBBLE_GROWL:getHeight() / 2 ) 
    -- end

return stateBubble