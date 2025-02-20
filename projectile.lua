local projectile = {}
local const = require("/constantes")

-- Table pour stocker les projectiles
projectile.list = {}

-- Tirer un projectile
--param 1 pos x du depart du projectile
--param 1 pos y du depart du projectile
--param 3 angle de tir
--param 4 vitesse du projectile
--param  5 qui tire le projectile hero ou ghost
function projectile.shoot(pX, pY, pAngle, pSpeed, pType)
    local newProjectile = {
        x = pX, 
        y = pY,
        angle = pAngle, 
        speed = pSpeed,
        type = pType
    }

    if type == const.GHOST then
        newProjectile.offsetX = const.PRJTL_ECTOPLASM:getWidth() / 2
        newProjectile.offsetY = const.PRJTL_ECTOPLASM:getHeight() / 2
    else
        newProjectile.offsetX = const.PRJTL_ARROW:getWidth() / 2
        newProjectile.offsetY = const.PRJTL_ARROW:getHeight() / 2
    end
    table.insert(projectile.list, newProjectile)
end

-- Mettre à jour les projectiles
function projectile.update(dt, entities)
    for nb = #projectile.list, 1, -1 do
        local p = projectile.list[nb]

        -- Calcul du déplacement en fonction de l'angle et de la vitesse
        local vx = (p.speed * dt * 60) * math.cos(p.angle)
        local vy = (p.speed * dt * 60) * math.sin(p.angle)

        -- on ajoute de la velocité a notre projctl
        p.x = p.x + vx
        p.y = p.y + vy

        -- Vérification des limites de l'écran si les projectiles sortent on les supprimes de notre liste
        if p.x < 0 or p.x > const.SCREENWIDTH or p.y < 0 or p.y > const.SCREENHEIGHT then
            table.remove(projectile.list, nb) 
        else
            -- il nous touche donc on perd de la vie
            for nb = #entities, 1, -1 do
                --on formate notre code pour plus de lisibilité
                local cible = entities[nb]
                -- on verifie qu'il vise bien notre hero
                if cible.type == const.HERO then
                    -- si le projectile est a plus de la moitié de la surface du hero alors ca touche
                     if math.dist(p.x, p.y, cible.x, cible.y) < cible.width / 2 then
                        -- on joue le son damage
                        const.SND_DMG_SHOOT:play()
                        -- on retire 1 pv au hero
                        cible.life = cible.life - 1
                        -- on oublie pas de supprimer le projectile
                        table.remove(projectile.list, nb)
                     end
                end
            end
            
        end

    end

end

-- Dessiner les projectiles
function projectile.draw()
    for _, projectile in ipairs(projectile.list) do
        if projectile.type == const.GHOST then
            love.graphics.draw(const.PRJTL_ECTOPLASM, projectile.x, projectile.y, projectile.angle, 2, 2, projectile.offsetX, projectile.offsetY)
        else
            love.graphics.draw(const.PRJTL_ARROW, projectile.x, projectile.y, projectile.angle, 1, 1, projectile.offsetX, projectile.offsetY)
        end
    end
    love.graphics.print("nb de projectile "..tostring(#projectile.list), 25, 25)
end

return projectile