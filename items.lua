local items = {}
items.list = {}

local spriteMan = require("/spriteManager")
local const = require("/constantes")
local spriteName = 0
local frameNb = 0

-- POur plus de lisibilité on decoupe le name du sprite name 
-- initialize le nom de la frame a passer en param a spriteMan ainsi que son nb de frame
function initializeSpriteName(name)

    if name == const.BOW then
        spriteName = const.BOW_SPRT
        frameNb = 3
    else
        spriteName = const.AXE_SPRT
        frameNb = 3
    end

end

function items.create(name, puissance)
-- on appel l'initialize
    initializeSpriteName(name)
    --Creer les sprites de notre objet
    imgSprite = spriteMan.CreateSprite(name, spriteName, frameNb)
    
    local item = {
        x = love.math.random(0, const.SCREENWIDTH - 40),
        y = love.math.random(0, const.SCREENHEIGHT - 40),
        type = "item",
        name = name,
        images = imgSprite.images,
        puissance = puissance,
        width = imgSprite.width,
        height = imgSprite.height,
        proximity = false,
        pick = false,
    }

    table.insert(items.list, item)

    return item
end

return items