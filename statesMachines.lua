local statesMachines = {}


local const = require("/constantes")
local projectile = require("/projectile")
local lstProjectiles = {}
math.randomseed(os.time())


--Love general math
-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end
-- Returns the distance between two points.
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end


--1er param delta time
--2nd param notre l'entité sur laquelle vont etre appliqué nos conditions
function statesMachines.states(dt, entities, lstEntities)
-- Voici notre machine a etat pour tout nos mobs

    local timer = 0

    -- 🧺🧺 NONE aucun statut en cours
    if entities.state == const.NONE then

        entities.state = const.CHANGEDIR

    -- 🧭🧭 CHANGEDIR applique un angle et une velocité a notre entité afin qu'il change de direction
    elseif entities.state == const.CHANGEDIR then

        -- if entities.type == const.MOB then
            --Le vecteur A donc x1 et x2 va du point A vers, B x2, y2 -> (e.x, e.y) → (scrnW,scrnH)
            local angle = math.angle(entities.x, entities.y, love.math.random(const.SCREENWIDTH), love.math.random(const.SCREENHEIGHT))

            --On ajoute une velocité a x et y donc vx et vy en multipliant la vitesse au cos de l'angle pour X et le sin de l'angle pour Y
            entities.vx = entities.speed * math.cos(angle)
            entities.vy = entities.speed * math.sin(angle)

            entities.state = const.WALK
        -- else
            
        -- end

    -- 🏃🏿‍♂️🏃🏿‍♂️ WALK marche dans la zone sans but
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

        -- en cas de collision on fais notre entities changer de direction en changant son status
        if collider then
            entities.state = const.CHANGEDIR
        end

        -- local distance

        -- 👾👾 On fait notre entities type mob chercher notre heros dans son errance
        if entities.type == const.MOB then
            --On boucle sur notre tableau de mob
            for key, entitie in ipairs(lstEntities) do 
                -- On verifie si il y'a un hero dans notre liste et on le recupere
                if entitie.type == const.HERO then
                    -- on calcul la distance entre le mob et le hero entities = mob, entitie = hero
                    local distance = math.dist(entities.x, entities.y, entitie.x, entitie.y)
                    -- on verifie que le hero est dans le champs d'action de notre mob
                    if distance < entities.range then
                        -- on change son statut et defini la cible du mob
                        entities.state = const.PURSUIT
                        entities.target = entitie
                    end

                end

            end
        end

        -- 👻👻 On fait notre entities type Ghost errer jusqu'a sentir un humain dans sa zone
        if entities.type == const.GHOST then
            --On boucle sur notre tableau de ghost
            for key, entitie in ipairs(lstEntities) do 
                -- On verifie si il y'a un hero dans notre liste et on le recupere
                if entitie.type == const.HERO then
                    -- on calcul la distance entre le mob et le hero 🔥🔥entities = mob, 💧💧entitie = hero
                    local distance = math.dist(entities.x, entities.y, entitie.x, entitie.y)
                    -- on verifie que le hero est dans le champs d'action de notre mob
                    if distance <= entities.range + entitie.width then
                        -- on change son statut et defini la cible du mob
                        entities.target = entitie
                        entities.state = const.ATTACK
                    end
                end
            end
        end

    -- 🏃🏿‍♂️🏃🏿‍♀️ PURSUIT notre entities poursuit le hero
    elseif entities.state == const.PURSUIT then

        -- On gere le nil pointer exception
        if  entities.target == nil then
            --si il n'a pas de target il change de direction
            entities.state = const.CHANGEDIR

        --si la distance entre le mob et sa cible est superieur au range du mob il change de direction
        elseif math.dist(entities.x, entities.y, entities.target.x, entities.target.y) > entities.range and entities.target.type == const.HERO then
            entities.state = const.CHANGEDIR

        --si la distance entre le mob et sa cible est inferieur a 5 et son type est bien HERO on passe à l'attaque
        elseif math.dist(entities.x, entities.y, entities.target.x, entities.target.y) < 5 and entities.target.type == const.HERO then
            entities.state = const.ATTACK
            --On fait notre mob s'aretter afin d'attaquer
            entities.vx = 0
            entities.vy = 0

        else --le mob se dirige vers sa target
            -- renvoi l'angle entre les deux vecteurs mob -> cible
            local angle = math.angle(entities.x, entities.y, entities.target.x, entities.target.y)
            --on ajooute de la velocité a son angle pour qu'il suive sa target
            entities.vx = entities.speed * math.cos(angle)
            entities.vy = entities.speed * math.sin(angle)
        end

    --👂🏿👂🏿 EAR Notre entities entend du bruit
    elseif entities.state == const.EAR then

        -- on les fait s'arreter pour rendre leurs mouvement plus effrayant
        entities.vx = 0
        entities.vy = 0

        --on les fait changer de statut 
        entities.state = const.NONE

    --😱😱 GROWL notre entities hurle
    elseif entities.state == const.GROWL then
        --le GROWL est un buff temporaire de tout les mobs autres que les fantomes

        -- on incremente notre cooldown
        entities.cooldown = entities.cooldown + dt

        --On fait notre mob s'aretter afin de hurler
        entities.vx = 0
        entities.vy = 0

        --On le fait hurler
        entities.growl:play()
        -- entities.cooldown = 0 

        for k, v in ipairs(lstEntities) do
            if v.type == const.MOB then
                -- on stock les attributs a buffer pour les reinitialiser apres
                local currentRange = v.range
                local currentSpeed = v.speed

                -- on buff leur vitesse a maximum 150
                if v.speed <= 150 then
                    v.speed = v.speed + 10 * dt
                else
                    v.speed = math.random(1, 100)
                end

                -- on buff leur range ou rayon de detection a 400 maximum 
                if v.range <= 400 then
                    v.range = v.range + 200 * dt
                else
                    v.range = currentRange
                end

                -- On change leurs status
                v.state = const.EAR
            end

            if entities.cooldown >= entities.delayGrowl then
                entities.state = const.NONE
            end
    
            -- v.state = const.EAR
        end





    --🤺🤺 ATTACK notre entities passe à l'attack
    elseif entities.state == const.ATTACK then
        --👾
        if entities.type == const.MOB then
        -- On verifie que si notre hero se deplace on se remette à le poursuivre
         if math.dist(entities.x, entities.y, entities.target.x, entities.target.y) > 5 then
            entities.state = const.PURSUIT
        -- sinon on l áttaque et lui retire de la vie
         else
            print("life --")
         end
         --👻
        elseif entities.type == const.GHOST then
            -- On incremente  notre cooldown jusqu'a atteindre le delay
            entities.cooldown = entities.cooldown + dt
            -- on lui met l'angle vers notre hero pour la visé
            local angleVersHero = math.angle(entities.x, entities.y, entities.target.x, entities.target.y)
            entities.angle = angleVersHero
            -- il s'arrete pour viser
            entities.vx = 0
            entities.vy = 0

            print("target type "..tostring(entities.target.type))
            print("target x "..tostring(entities.target.x))
            print("ghost range "..tostring(entities.range))

            
            -- On tire en respectant le cooldown
            if entities.cooldown >= entities.delayShoot then
                --param X, Y, Angle, Speed
                lstProjectiles = projectile.shoot(entities.x, entities.y, entities.angle, 1, lstProjectiles)
                -- print("👻👻💀")
                -- on remet le cooldown a zero sinon il se transforme en sulfateuse
                entities.cooldown = 0
            end

            if math.dist(entities.x, entities.y, entities.target.x, entities.target.y) > entities.range + entities.target.width then
                -- on remet notre cooldown a zero
                entities.cooldown = 0
                -- on change de statut
                entities.state = const.GROWL
            -- sinon on l áttaque et lui retire de la vie
            end

        end

    end
    
end

function statesMachines.update(dt, entities)

    --On gere la vie des projectile ici
    projectile.update(dt)

    -- On ajoute de la velocité au deplacement de nos mobs et ghost
    for k, value in ipairs(entities) do
        if value.vx ~= nil and value.vy ~= nil then
            value.x = value.x + value.vx * dt
            value.y = value.y + value.vy * dt
        end
    end
end


function statesMachines.draw()
    projectile.draw()
end


return statesMachines