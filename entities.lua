local Entities = {
    x = 0,
    y = 0,
    angle = 0,
    offsetX = 0,
    offsetY = 0,
    images = {},
    nbFrame = 0,
    currentFrame = 0,
    entitieType = "none"
}

function Entities.createHero()
    -- on crée le hero avec les attributs de Entities
    local hero = Entities

    return hero
end

function Entities.createMob()
    -- on crée les mobs avec les attributs de Entities
    local mob = Entities

    return mob
end


function Entities.load()
end

function Entities.update(dt)
end

function Entities.draw()
end

function Entities.keypressed(key)
end

return Entities