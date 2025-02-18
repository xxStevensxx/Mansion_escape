local const = require("/constantes")
local statesMachines = {}
math.randomseed(os.time())


--Love general math
-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end
-- Returns the distance between two points.
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end


--1er param delta time
--2nd param notre l'entité sur laquelle vont etre appliqué nos conditions
function statesMachines.states(dt, entities)
-- Voici notre machine a etat pour tout nos mobs

    --NONE aucun statut en cours
    if entities.state == const.NONE then

        entities.state = const.CHANGEDIR

    --CHANGEDIR applique un angle et une velocité a notre entité afin qu'il change de direction
    elseif entities.state == const.CHANGEDIR then

        --Le vecteur A donc x1 et x2 va du point A vers, B x2, y2 -> (e.x, e.y) → (scrnW,scrnH)
        local angle = math.angle(entities.x, entities.y, love.math.random(const.SCREENWIDTH), love.math.random(const.SCREENHEIGHT))

        --On ajoute une velocité a x et y donc vx et vy en multipliant la vitesse au cos de l'angle pour X et le sin de l'angle pour Y
        entities.vx = entities.speed * math.cos(angle)
        entities.vy = entities.speed * math.sin(angle)

        entities.state = const.WALK

    --WALK marche dans la zone sans but
    elseif entities.state == const.WALK then

        -- on creer un bool afin de gerer le changement de statut en cas de contact avec les bord de l'ecran
        local collider = false

        --conditions de rebond des entities sur le coté gauche
        if entities.x < 0 then
            -- on l'empeche d'aller plus loin
            entities.x = 0
            collider = true
        end

        --conditions de rebond des entities sur le coté droit
        if entities.x > const.SCREENWIDTH - entities.width then
            -- on l'empeche d'aller plus loin
            entities.x = const.SCREENWIDTH - entities.width
            collider = true
        end

        --conditions de rebond des entities sur le haut de l'ecran
        if entities.y < 0 then
            -- on l'empeche d'aller plus loin
            entities.y = 0
            collider = true
        end

        --conditions de rebond des entities sur le bas
        if entities.y > const.SCREENHEIGHT - entities.height then
            -- on l'empeche d'aller plus loin
            entities.y = const.SCREENHEIGHT - entities.height
            collider = true
        end

        if collider then
            entities.state = const.CHANGEDIR
        end

        -- ******************************************


    --PURSUIT notre entities poursuit le hero
    elseif entities.state == const.PURSUIT then

    --EAR Notre entities entend du bruit
    elseif entities.state == const.EAR then

    --GROWL notre entities hurle
    elseif entities.state == const.GROWL then

    --ATTACK notre entities passe à l'attack
    elseif entities.state == const.ATTACK then


    end
end

function statesMachines.update(dt, entities)
    for k, value in ipairs(entities) do
        if value.vx ~= nil and value.vy ~= nil then
            value.x = value.x + value.vx * dt
            value.y = value.y + value.vy * dt
        end
    end
end


return statesMachines