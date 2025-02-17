spriteMan = require("/spriteManager")

local Entities = {
    x = 0,
    y = 0,
    angle = 0,
    offsetX = 0,
    offsetY = 0,
    height = 0,
    width = 0,
    images = {},
    nbFrame = 0,
    currentFrame = 0,
    type = "none"
}

function Entities.createHero()
    -- on crée le hero avec les attributs de Entities
    local hero = Entities

        -- on crée les heros avec les attributs de Entities
        local hero = Entities
        --On appel la fonction CreateSprite de notre module spriteManager
        local heroSprites = spriteMan.CreateSprite(HERO, 2)
    
        -- On valorise les attributs de notre hero qui sont par defaut ceux de l'entities
        hero.images = heroSprites.images
        hero.type = HERO
        hero.nbFrame = heroSprites.nbFrame
        hero.currentFrame = heroSprites.currentFrame
        hero.width = heroSprites.width
        hero.height = heroSprites.height
        hero.offsetX = hero.width / 2
        hero.offsetY = hero.height / 2

    return hero
end

function Entities.createMob()
    -- on crée les mobs avec les attributs de Entities
    local mob = Entities
    --On appel la fonction CreateSprite de notre module spriteManager
    local mobSprites = spriteMan.CreateSprite(MOB, 2)

    -- On valorise les attributs de notre mob qui sont par defaut ceux de l'entities
    mob.images = mobSprites.images
    mob.type = MOB
    mob.nbFrame = mobSprites.nbFrame
    mob.currentFrame = mobSprites.currentFrame
    mob.width = mobSprites.width
    mob.height = mobSprites.height
    mob.offsetX = mob.width / 2
    mob.offsetY = mob.height / 2

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