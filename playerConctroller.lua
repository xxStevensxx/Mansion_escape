local playercontroller = {}

local projectile = require("/projectile")
local timer

-- param entities a qui on veux appliquer une "manette"
function playercontroller.update(dt, entitie)
    -- ⬆⬇⬅➡ Nous permet d'effectuer une action quand la touche spécifié en param est appuyé
    if love.keyboard.isDown("up") then
        -- Gere l'angle de shoot de notre hero
        local vx = (entitie.speed * dt) * math.cos(entitie.angleShoot)
        local vy = (entitie.speed * dt) * math.sin(entitie.angleShoot)
        entitie.y = entitie.y - entitie.speed * dt
    end

    if love.keyboard.isDown("down") then
        -- Gere l'angle de shoot de notre hero sans modifié sons angle a lui
        local vx = (entitie.speed * dt) * math.cos(entitie.angleShoot)
        local vy = (entitie.speed * dt) * math.sin(entitie.angleShoot)
        entitie.y = entitie.y + entitie.speed * dt
    end

    if love.keyboard.isDown("left") then
        entitie.x = entitie.x - entitie.speed * dt
    end

    -- angle de shoot vers la gauche
    if love.keyboard.isDown("a") then
        entitie.angleShoot = entitie.angleShoot - 5 * dt
    end

    if love.keyboard.isDown("right") then
        entitie.x = entitie.x + entitie.speed * dt
    end

    -- angle de shoot vers la droite
    if love.keyboard.isDown("d") then
        entitie.angleShoot = entitie.angleShoot + 5 * dt
    end
    

    -- 🤺🤺 notre hero attaque
    if love.keyboard.isDown("space") then
        entitie.cooldownHero = entitie.cooldownHero + dt
        if entitie.cooldownHero >= entitie.delayBow then
            entitie.bowShoot:play()
            projectile.shoot(entitie.x + const.PRJTL_ECTOPLASM:getWidth() / 2, entitie.y + const.PRJTL_ECTOPLASM:getHeight() / 2, entitie.angleShoot, 5, entitie.type)
            entitie.cooldownHero = 0
        end
    end
end

return playercontroller


--  -- On tire en respectant le cooldown
--  if entities.cooldownGhost >= entities.delayShoot then
--     --param X, Y, Angle, Speed
--     entities.shooEctoplasm:play()
--     projectile.shoot(entities.x, entities.y, entities.angle, 1, entities.type)
--     -- on remet le cooldown a zero sinon il se transforme en sulfateuse
--     entities.cooldownGhost = 0
-- end
