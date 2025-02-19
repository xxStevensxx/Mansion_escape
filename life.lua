local life = {}


local const = require("/constantes")
--param 1 entitie a qui on afficher la vie
--param 2 les pdv 
--param 3 la pos x des coeurs a l'ecran
--param 4 la pos y des coeurs a l'ecran
function life.show(pdv, posX, posY)
    --position x et y des coeurs
    local posx = posX
    local posy = posY

    -- on boucle sur les pdv passé en param
    for nb = 1, pdv do
        -- On verifie si nos pv sont pairs ou impairs la dans cette boucle on verifie impair
        -- le nb de pv modulo 2 renvoi zero ou un donc pair ou impair
        local impair = nb % 2 ~= 0

        if impair then
            --On DESSINE nos image en fonction du nb de pv pairs ou impairs pour l'affichage gauche ou droite
            love.graphics.draw(const.LEFT_HEART, posx , posy, 0, 2, 2)
        else
            love.graphics.draw(const.RIGHT_HEART, posx, posy, 0, 2, 2)
        end

        -- si le nb de pv est pairs on decale la position du coeur de sa largeur 
        if impair == false then
            posx = posx + const.LEFT_HEART:getWidth() / 2
        end

    end

end

return life