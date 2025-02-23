local Entities = {}

spriteMan = require("/spriteManager")
const = require("/constantes")

-- Fonction pour initialiser les entités avec les attributs communs
local function initializeEntity(entitie, type, sprite, frames, pX, pY)
    local entitieSprites = spriteMan.CreateSprite(type, sprite, frames)
    -- les param pour le MOB et le GHOST et 50 pour le hero
    entitie.x = pX or 50
    entitie.y = pY or 50
    entitie.vx, entitie.vy = 0, 0
    entitie.angle, entitie.angleShoot = 0, 0
    entitie.images = entitieSprites.images
    entitie.type = type
    entitie.nbFrame = entitieSprites.nbFrame
    entitie.currentFrame = entitieSprites.currentFrame
    entitie.width = entitieSprites.width
    entitie.height = entitieSprites.height
    entitie.offsetX = entitie.width / 2
    entitie.offsetY = entitie.height / 2
    entitie.rem = false
end

-- Création des entités selon leur type
function Entities.create(type, pX, pY)
    local entitie = {}

    -- 🐱‍🏍 HERO
    if type == const.HERO then
        initializeEntity(entitie, const.HERO, const.HERO_SPRT, 4)
        entitie.speed = 120
        entitie.life = 5
        entitie.inventory = {}
        entitie.range = 250
        entitie.cooldownHero = 0
        entitie.delayBow = 0.8
        entitie.delayAxe = 2
        entitie.bowShoot = const.SND_SHOOT_BOW:clone()
        entitie.axeStrike = const.SND_AXE_STRIKE:clone()
        entitie.currentFrameOBJ = 1
        entitie.proximity = false
        entitie.currentWpn = 1
        entitie.selectedWeapon = nil


    -- 👾 MOB
    elseif type == const.MOB then
        initializeEntity(entitie, const.MOB, const.MOB_SPRT, 2, pX, pY)
        entitie.speed = love.math.random(10, 50)
        entitie.state = const.NONE
        entitie.range = love.math.random(10, 150)
        entitie.target = nil
        entitie.life = 10
        entitie.hitDamage = const.SND_DMG_MOBS:clone()
        entitie.cooldownMob, entitie.cooldownBuff = 0, 0
        entitie.delayHit = 0.5
        entitie.delay_buff = 2
        entitie.buff = false

    -- 👻 GHOST
    elseif type == const.GHOST then
        initializeEntity(entitie, const.GHOST, const.GHOST_SPRT, 2, pX, pY)
        entitie.speed = love.math.random(1, 10)
        entitie.state = const.NONE
        entitie.range = love.math.random(105, 250)
        entitie.target = nil
        entitie.life = 10
        -- Gestion du cooldown des tirs
        entitie.cooldownGhost = 0
        entitie.delayShoot = 0.5
        entitie.delayGrowl = 2
        -- Clonage des sons pour les entités multiples
        entitie.growl = const.SND_GROWL:clone()
        entitie.shooEctoplasm = const.SND_SHOOT_ECTOPLASM:clone()

    -- 👺👺
    else
        initializeEntity(entitie, const.ONI, const.ONI_SPRT, 3, pX, pY)
        entitie.life = 100
    end

    return entitie
end

-- Fonction update pour animer les sprites des entités
function Entities.update(dt, entitie)
    entitie.currentFrame = entitie.currentFrame + 5 * dt

    -- Gestion des effets de bord (évite les erreurs de dépassement d'index)
    if entitie.currentFrame >= #entitie.images + 1 then
        entitie.currentFrame = 1
    end
end

return Entities