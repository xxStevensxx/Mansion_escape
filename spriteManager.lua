local spriteManager = {}

-- 1 param = type de frame selon le type d'entities 
-- 2 param = nom du fichier
-- 3 param == nombre de frame du type d'entities
function spriteManager.CreateSprite(typeFrame, frameName, frameNb)

    -- Notre liste de sprites et ses attributs
    local sprites = {
        images = {},
        currentFrame = 0,
        nbFrame = frameNb,
    }

        --on boucle sur le nb de frame specifié en parametre afin d'ajouter les psrites necessaires 
        for index = 1, frameNb do 
            -- On formate notre filename afin d'ajouter nos images dynamiquement
            local fileName = "/assets/"..frameName..tostring(index)..".png"

            -- On ajoute nos sprite dans notre liste sprites
            sprites.images[index] = love.graphics.newImage(fileName)

            --On ajoutes les champs Height et width apres l'ajout des images dans notre sprite
            sprites.width = sprites.images[1]:getWidth()
            sprites.height = sprites.images[1]:getHeight()
            -- Maintenant qu'on à des sprites notre current est logiquement le 1
            sprites.currentFrame = 1
        end

        return sprites
end

function spriteManager.CreateSpriteSheet()
    
end

return spriteManager