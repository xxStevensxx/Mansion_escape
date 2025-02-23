local playercontroller = {}

local projectile = require("/projectile")
local inventory = require("/inventory")
local timer

-- param entities a qui on veux appliquer une "manette"
function playercontroller.update(dt, entitie, lstEntitie)
    -- ⬆⬇⬅➡ Nous permet d'effectuer une action quand la touche spécifié en param est appuyé
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        -- Gere l'angle de shoot de notre hero
        local vx = (entitie.speed * dt) * math.cos(entitie.angleShoot)
        local vy = (entitie.speed * dt) * math.sin(entitie.angleShoot)
        entitie.y = entitie.y - entitie.speed * dt
    end

    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        -- Gere l'angle de shoot de notre hero sans modifié sons angle a lui
        local vx = (entitie.speed * dt) * math.cos(entitie.angleShoot)
        local vy = (entitie.speed * dt) * math.sin(entitie.angleShoot)
        entitie.y = entitie.y + entitie.speed * dt
    end

    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        entitie.x = entitie.x - entitie.speed * dt
    end

    -- Calcul de l’angle entre l’entité et la souris
    local mPosX, mPosY = love.mouse.getPosition()
    entitie.angleShoot = math.angle(entitie.x, entitie.y, mPosX, mPosY)


    -- angle de shoot vers la gauche
    -- if love.keyboard.isDown("a") then
    --     entitie.angleShoot = entitie.angleShoot - 5 * dt
    -- end

    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        entitie.x = entitie.x + entitie.speed * dt
    end

    -- angle de shoot vers la droite
    -- if love.keyboard.isDown("d") then
    --     entitie.angleShoot = entitie.angleShoot + 5 * dt
    -- end   

    -- 🤺🤺 Notre héros attaque en fonction de son arme
    if love.keyboard.isDown("space") and entitie.selectedWeapon then
        -- on laance le timer
        entitie.cooldownHero = entitie.cooldownHero + dt

        if entitie.cooldownHero >= entitie.delayBow then
            -- 🏹 **Si c'est un arc (attaque à distance)**
            if entitie.selectedWeapon.name == const.BOW then
                entitie.bowShoot:play()
                projectile.shoot(entitie.x + const.PRJTL_ARROW:getWidth() / 2, entitie.y + const.PRJTL_ARROW:getHeight() / 2, entitie.angleShoot, 5, entitie.type)
            -- 🪓 **Si c'est une hache (attaque de mêlée)**
            elseif entitie.selectedWeapon.name == const.AXE then
                entitie.axeStrike:play()
                -- Ajoute une attaque de mêlée qui touche les ennemis proches
                for _, ennemy in ipairs(lstEntitie) do
                    local distance = math.dist(entitie.x, entitie.y, ennemy.x, ennemy.y)
                    if ennemy.type ~= const.HERO and distance < 50 then
                        ennemy.life = ennemy.life - entitie.selectedWeapon.puissance
                    end
                end
            end

            -- Réinitialisation du cooldown
            entitie.cooldownHero = 0

            -- -- Animation de l'arme en cours
            -- entitie.currentFrameOBJ = entitie.currentFrameOBJ + 300 * dt    
            -- if entitie.currentFrameOBJ > #entitie.selectedWeapon.images + 1 then
            --     entitie.currentFrameOBJ = 1
            -- end
        end
    end
end

return playercontroller