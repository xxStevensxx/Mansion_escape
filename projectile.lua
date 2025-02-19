local projectile = {}
local const = require("/constantes")

-- Table pour stocker les projectiles
projectile.list = {}

-- Tirer un projectile
function projectile.shoot(pX, pY, pAngle, pSpeed)
    local newProjectile = {
        x = pX, 
        y = pY,
        angle = pAngle, 
        speed = pSpeed
    }
    table.insert(projectile.list, newProjectile)
end

-- Mettre à jour les projectiles
function projectile.update(dt)
    for nb = #projectile.list, 1, -1 do
        local p = projectile.list[nb]

        -- Calcul du déplacement en fonction de l'angle et de la vitesse
        local vx = (p.speed * dt * 60) * math.cos(p.angle)
        local vy = (p.speed * dt * 60) * math.sin(p.angle)

        p.x = p.x + vx
        p.y = p.y + vy

        -- Vérification des limites de l'écran si les projectiles sortent on les supprimes de notre liste
        if p.x < 0 or p.x > const.SCREENWIDTH or p.y < 0 or p.y > const.SCREENHEIGHT then
            table.remove(projectile.list, nb) 
        else
            
        end

    end

end

-- Dessiner les projectiles
function projectile.draw()
    for _, projectile in ipairs(projectile.list) do
        love.graphics.draw(const.PRJTL_ECTOPLASM, projectile.x, projectile.y, 3, 2, 2)
    end
    love.graphics.print("nb de projectile "..tostring(#projectile.list), 25, 25)
end

return projectile