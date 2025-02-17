local spriteManager = 

}


-- 1 param = nom du fichier 
-- 2 param == nombre de frame du type d'entities
function spriteManager.CreateSprite(frameName, frameNb)

    local sprites = {}

        --on boucle sur le nb de frame specifié en parametre afin d'ajouter les psrites necessaires 
        for index = 1, nbFrame do 
            -- On formate notre filename afin d'ajouter nos images dynamiquement
            local fileName = "/assets/"..frameName..tostring(index)..".png"

            -- On ajoute nos sprite dans notre liste sprites
            sprites[index] = love.graphics.newImage(fileName)

        end
        return sprites
end

return spriteManager