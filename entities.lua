local Entities = {}


spriteMan = require("/spriteManager")
const = require("/constantes")


-- param 1 type d'ennemi
-- param 2 position x du spawner
-- param 3 position y du spawner
function Entities.create(type, pX,pY)

    -- On créer notre entitie et ses attributs 
local entitie = {}
    
    -- 🐱‍🏍🐱‍🏍 On verifie le type afin de creer la bonne entitie
    if type == const.HERO then

        --On appel la fonction CreateSprite de notre module spriteManager
        local entitieSprites = spriteMan.CreateSprite(type, const.HERO_SPRT, 4)

        -- On valorise les attributs de notre hero
            entitie.x = 50
            entitie.y = 50
            entitie.angle = 0
            entitie.angleShoot = 0
            entitie.speed = 120
            entitie.images = entitieSprites.images
            entitie.type = const.HERO
            entitie.nbFrame = entitieSprites.nbFrame
            entitie.currentFrame = entitieSprites.currentFrame
            entitie.currentFrameOBJ = 1
            entitie.width = entitieSprites.width
            entitie.height = entitieSprites.height
            entitie.type = const.HERO
            entitie.offsetX = entitie.width / 2
            entitie.offsetY = entitie.height / 2
            entitie.life = 100
            entitie.inventory = {}
            entitie.range = 250
            entitie.cooldownHero = 0
            entitie.delayBow = 0.8
            entitie.bowShoot = const.SND_SHOOT_BOW:clone()

    -- 👾👾 Dans le cas ou on a que deux type on ajoute juste un sinon a partir de trois type d'entities on ajoutera un elseif
    elseif type == const.MOB then

        --On appel la fonction CreateSprite de notre module spriteManager
        local entitieSprites = spriteMan.CreateSprite(type, const.MOB_SPRT, 2)

        -- On créer et valorise les attributs de notre ?
            entitie.x = pX
            entitie.y = pY
            entitie.vx = 0
            entitie.vy = 0
            entitie.speed = love.math.random(10, 50)
            entitie.angle = 0
            entitie.images = entitieSprites.images
            entitie.type = const.MOB
            entitie.nbFrame = entitieSprites.nbFrame
            entitie.currentFrame = entitieSprites.currentFrame
            entitie.width = entitieSprites.width
            entitie.height = entitieSprites.height
            entitie.type = const.MOB
            entitie.state = const.NONE
            entitie.offsetX = entitie.width / 2
            entitie.offsetY = entitie.height / 2
            entitie.range = love.math.random(10, 150)
            entitie.target = nil
            entitie.life = 100
            entitie.hitDamage = const.SND_DMG_MOBS:clone()
            entitie.cooldownMob = 0
            entitie.cooldownBuff = 0
            entitie.delayHit = 0.5
            entitie.delay_buff = 0
            entitie.buff = false
            
    else 
        -- 👻👻 On appel la fonction CreateSprite de notre module spriteManager
        local entitieSprites = spriteMan.CreateSprite(type, const.GHOST_SPRT, 2)
        -- On créer et valorise les attributs de notre ?
            entitie.x = pX
            entitie.y = pY 
            entitie.vx = 0
            entitie.vy = 0
            entitie.speed = love.math.random(10, 100) / 10
            entitie.angle = 0
            entitie.images = entitieSprites.images
            entitie.type = const.GHOST
            entitie.nbFrame = entitieSprites.nbFrame
            entitie.currentFrame = entitieSprites.currentFrame
            entitie.width = entitieSprites.width
            entitie.height = entitieSprites.height
            entitie.type = const.GHOST
            entitie.state = const.NONE
            entitie.offsetX = entitie.width / 2
            entitie.offsetY = entitie.height / 2
            entitie.range = love.math.random(105, 250)
            entitie.target = nil
            entitie.life = 50
            --Gestion du cooldown des shoot
            entitie.cooldownGhost = 0
            entitie.delayShoot = 0.5
            entitie.delayGrowl = 2
            -- On clone le son afin qu'il puisse etre utilisé simultanement par plusieurs entities
            entitie.growl = const.SND_GROWL:clone()
            entitie.shooEctoplasm = const.SND_SHOOT_ECTOPLASM:clone()

    end

    return entitie

end



function Entities.load()
end

function Entities.update(dt, entitie)

    --boucle dans l'update qui animera les frames des entities
    for frame = 1, #entitie.images do
        entitie.currentFrame = entitie.currentFrame + 1 * dt

        --On gere les effets de bord car avec la multiplication du dt on aura pas le max de notre boucle for
        -- mais plus ou moins du fait des nombres flottants ex 4.33 au lieu de 4 cela pourra generer un nil pointer
        if entitie.currentFrame >= #entitie.images + 1 then
            entitie.currentFrame = 1
        end

    end


end

function Entities.draw()
end

function Entities.keypressed(key)
end

return Entities