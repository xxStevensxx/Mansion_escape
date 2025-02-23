local spawner = {}

spawner.list = {}
spawner.entities = {}

math.randomseed(os.time())
local delay = 2
local timer = delay
local entitie = require("/entities")
local const = require("/constantes")


-- Crée les spawner 
function spawner.spawner()
    -- 🎲🎲 On utilise un dé pour generer un nb de spawner aleatoires entre 1 et 3
    local dice = love.math.random(1, 3)
    -- on genere nos spawner en fonction du nombre du dé
    for nb = dice, 1, -1 do
        spawner.list[nb] = {
            x = love.math.random(const.SPWN_GRAVE:getWidth(), const.SCREENWIDTH - const.SPWN_GRAVE:getWidth()),
            y = love.math.random(const.SPWN_GRAVE:getHeight(), const.SCREENHEIGHT - const.SPWN_GRAVE:getHeight())
        }
    end
    
end

-- Fait spawner les ennemies
function spawner.spawn()
    -- 👾👻 on stock nos types d'ennemis ici
    local typeEnnemies = {
        const.GHOST,
        const.MOB
    }

    -- 🎲🎲 on lance  nos dé pour creer un ennemi aleatoire
    local diceMob = love.math.random(1, #typeEnnemies)

    -- 🎲🎲 on lance nos dé pour placer un ennemi sur un spawner en fonciton du resultat
    local dice = love.math.random(1, #spawner.list)

    table.insert(spawner.entities, entitie.create(typeEnnemies[diceMob], spawner.list[dice].x, spawner.list[dice].y))

    -- if  spawner.entities ~= 0 then
    --     for i = 1, #spawner.entities do 
    --         -- print(spawner.entities[i].type)
    --     end
    -- end

end

function spawner.update(dt, lstEntities)
    timer = timer - dt
    if timer <= 0 then
        -- on gere le nb d'ennemie qui peuvent spawner a la fois
        if #lstEntities <= 5 then
            spawner.spawn()
            timer = delay
        end
    end
end


function spawner.draw()
    -- on boucle sur notre liste de spawner
    for nb = #spawner.list, 1, -1 do
        -- on formate notre variable
        local spwn = spawner.list[nb]
        -- on affiche les spawner a l écran
        love.graphics.draw(const.SPWN_GRAVE, spwn.x, spwn.y, 0, 3, 3)
    end
end

return spawner