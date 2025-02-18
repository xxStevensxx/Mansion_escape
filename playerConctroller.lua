local playercontroller = {}


-- param entities a qui on veux appliquer une "manette"
function playercontroller.update(dt, entitie)
    --Nous permet d'effectuer une action quand la touche spécifié en param est appuyé
    if love.keyboard.isDown("up") then
        entitie.y = entitie.y - 100 * dt
    end

    if love.keyboard.isDown("down") then
        entitie.y = entitie.y + 100 * dt
    end

    if love.keyboard.isDown("left") then
        entitie.x = entitie.x - 100 * dt
    end

    if love.keyboard.isDown("right") then
        entitie.x = entitie.x + 100 * dt
    end
end

return playercontroller