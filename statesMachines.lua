local statesMachines = {}

local const = require("/constantes")
local projectile = require("/projectile")
math.randomseed(os.time())

--Love general math
function math.angle(x1, y1, x2, y2) return math.atan2(y2 - y1, x2 - x1) end
function math.dist(x1, y1, x2, y2) return ((x2 - x1)^2 + (y2 - y1)^2)^0.5 end

-- Machine à états des entités
function statesMachines.states(dt, entities, lstEntities)
    -- 💕💕 verification life
    -- nos mobs et ghost on plus de vie ils passent en mode death
    if entities.life <= 0 then
        entities.state = const.DEATH
    end

    -- 💀💀 si nos MOBS, GHOST ou HERO sont dead on les supprime
    for index = #lstEntities, 1, -1 do
        -- MOB ET GHOST or HERO
        if lstEntities[index].rem == true or (lstEntities[index].life <= 0 and lstEntities[index].type == const.HERO) then
            table.remove(lstEntities, index)
        end
    end

    -- 🧺 NONE -> CHANGEDIR (si aucune action définie)
    if entities.state == const.NONE then
        entities.state = const.CHANGEDIR

    -- 🧭 CHANGEDIR -> Définit une direction aléatoire
    elseif entities.state == const.CHANGEDIR then
        local angle = math.angle(entities.x, entities.y, love.math.random(const.SCREENWIDTH), love.math.random(const.SCREENHEIGHT))
        entities.vx = entities.speed * math.cos(angle)
        entities.vy = entities.speed * math.sin(angle)
        entities.state = const.WALK

    -- 🏃🏿‍♂️ WALK -> Déplacement aléatoire
    elseif entities.state == const.WALK then
        local collider = false

        -- Détection des collisions avec les bords
        if entities.x < 0 then entities.x = 0 collider = true end
        if entities.x > const.SCREENWIDTH - entities.width then entities.x = const.SCREENWIDTH - entities.width collider = true end
        if entities.y < 0 then entities.y = 0 collider = true end
        if entities.y > const.SCREENHEIGHT - entities.height then entities.y = const.SCREENHEIGHT - entities.height collider = true end

        -- 💥 Si collision, changer de direction
        if collider then entities.state = const.CHANGEDIR end

        -- 👾 Détection du héros par les MOBS et GHOSTS
        for _, entitie in ipairs(lstEntities) do
            -- on verifie que c'est bien le heros qui est a proximité
            if entitie.type == const.HERO then
                -- on calcul la distance entre le mob (entities) et le hero (entitie)
                local distance = math.dist(entities.x, entities.y, entitie.x, entitie.y)
                -- seul les mobs type MOB peuvent poursuivre si le hero est dans le range alors PURSUIT
                if entities.type == const.MOB and distance < entities.range then
                    entities.state = const.PURSUIT
                    -- la cible du mob devient le hero
                    entities.target = entitie
                    -- si le hero est suffisament pret le mob passe en statu ATTACK
                elseif entities.type == const.GHOST and distance <= entities.range + entitie.width then
                    entities.target = entitie
                    entities.state = const.ATTACK
                end
            end
        end

        -- 💢 Gestion des buffs par le ghost
        -- si nos ennemis sont buffés on lance le timer
        if entities.delay_buff ~= 0 and entities.buff then
            -- on incremente notre timer des qu'il atteindra le delay on debuff
            entities.cooldownMob = entities.cooldownMob + dt
            if entities.cooldownMob >= entities.delay_buff then
                -- on leurs fourni des stats aleatoire dans le min et max de  depart
                entities.range = love.math.random(10, 150)
                entities.speed = love.math.random(10, 50)
                -- on remet le cooldown a zero
                entities.cooldownMob = 0
                -- on change le statut du buff
                entities.buff = false
            end
        end

    -- 🏃🏿‍♂️🏃🏿 PURSUIT -> Poursuite du héros
    elseif entities.state == const.PURSUIT then
        -- si la cible est nul ou que la distance est superieur au range CHANGEDIR
        if not entities.target or math.dist(entities.x, entities.y, entities.target.x, entities.target.y) > entities.range then
            entities.state = const.CHANGEDIR
        -- a proximité de morsure on passe au statut ATTACK
        elseif math.dist(entities.x, entities.y, entities.target.x, entities.target.y) < 5 then
            entities.state = const.ATTACK
            entities.vx, entities.vy = 0, 0
        else -- on fait les mobs se rapprocher de facon erratique

            --Mouvement erratique à proixmité du hero
            local destX, destY
            destX = math.random(entities.target.x - math.random(15, 55), entities.target.x + math.random(15, 65))
            destY = math.random(entities.target.y - math.random(15, 55), entities.target.y + math.random(15, 65))
            -- On applique le mouvement
            local angle = math.angle(entities.x, entities.y, destX, destY)
            entities.vx = entities.speed * math.cos(angle)
            entities.vy = entities.speed * math.sin(angle)
        end

        -- 💢 Gestion des buffs par le ghost
        -- si nos ennemis sont buffés on lance le timer
        if entities.delay_buff ~= 0 and entities.buff then
            -- on incremente notre timer des qu'il atteindra le delay on debuff
            entities.cooldownMob = entities.cooldownMob + dt
            if entities.cooldownMob >= entities.delay_buff then
                -- on leurs fourni des stats aleatoire dans le min et max de  depart
                entities.range = love.math.random(10, 150)
                entities.speed = love.math.random(10, 50)
                -- on remet le cooldown a zero
                entities.cooldownMob = 0
                -- on change le statut du buff
                entities.buff = false
            end
        end

    -- 👂🏿👂🏿 EAR -> Écoute un bruit, puis retourne à l’état initial
    elseif entities.state == const.EAR then
        entities.vx, entities.vy = 0, 0
        -- NONE pour que les mobs puissent repasser en PURSUIT ou walk selon la situation
        entities.state = const.NONE

    -- 😱 GROWL -> Cri d'alerte des MOBS
    elseif entities.state == const.GROWL then
        -- on lance le timer pour le cooldown
        entities.cooldownGhost = entities.cooldownGhost + dt
        -- Nos GHOST s'arretent pour hurler
        entities.vx, entities.vy = 0, 0
        entities.growl:play()

        for _, v in ipairs(lstEntities) do
            -- 💢 on buff nos MOB apres le GROWL
            if v.type == const.MOB then
                v.speed = math.min(v.speed + 15 * dt, 150)
                v.range = math.min(v.range + 100 * dt, 400)
                v.delay_buff = love.math.random(4, 8)
                -- On change le statut du buff et on les passe en EAR
                v.buff = true
                v.state = const.EAR
            end
        end

        -- a la fin du growl on repassent les mobs en none pour qu'ils puissent se mettre a nous poursuivre
        if entities.cooldownGhost >= entities.delayGrowl then
            entities.state = const.NONE
        end

    -- 🤺🤺 ATTACK -> Attaque le héros
    elseif entities.state == const.ATTACK then
        -- 👾
        if entities.type == const.MOB then
            -- on calcul la distance mob - > hero si elle est inf a 5 on porsuit le hero
            if math.dist(entities.x, entities.y, entities.target.x, entities.target.y) > 5 then
                entities.state = const.PURSUIT
            else
                -- on incremente notre timer
                entities.cooldownMob = entities.cooldownMob + dt
                -- cela veux dire que le mob est suffisament proche pour attaquer
                if entities.cooldownMob >= entities.delayHit then
                    entities.hitDamage:play()
                    entities.target.life = entities.target.life - 3
                    entities.cooldownMob = 0
                end
            end
            --👻
        elseif entities.type == const.GHOST then
            -- on incremente notre timer
            entities.cooldownGhost = entities.cooldownGhost + dt
            -- on fait le GHOST nous viser
            local angleVersHero = math.angle(entities.x, entities.y, entities.target.x, entities.target.y)
            entities.angle = angleVersHero
            entities.vx, entities.vy = 0, 0
            -- on time pour eviter les effets sulfateuse
            if entities.cooldownGhost >= entities.delayShoot then
                entities.shooEctoplasm:play()
                projectile.shoot(entities.x, entities.y, entities.angle, 1, entities.type)
                entities.cooldownGhost = 0
            end
            -- si notre hero sort du champs du GHOST alors il Hurle(alerte et buff les mobs)
            if math.dist(entities.x, entities.y, entities.target.x, entities.target.y) > entities.range + entities.target.width then
                entities.cooldownGhost = 0
                entities.state = const.GROWL
                entities.angle = 0
            end
        end
        -- on debuff nos mobs
        if entities.buff then
            entities.range = love.math.random(10, 150)
            entities.speed = love.math.random(10, 50)
            entities.buff = false
        end
        -- 💀💀 mort d'une entitie
    elseif entities.state == const.DEATH then
        entities.vx, entities.vy = 0, 0
        entities.rem = true
    end
end


function statesMachines.update(dt, entities)
    -- Gestion de l'update des projectiles en fonction du stateMachine
    projectile.update(dt, entities)
    for _, value in ipairs(entities) do
        if value.vx and value.vy then
            value.x = value.x + value.vx * dt
            value.y = value.y + value.vy * dt
        end
    end
end

function statesMachines.draw()
    projectile.draw()
end

return statesMachines