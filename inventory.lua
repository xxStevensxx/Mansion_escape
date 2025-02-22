inventory = {}

function inventory.addObj(entitie, wpn, nbMun)
    local objet = {
        dropRange = 50
        weapon = wpn
        mun = nbMun
    }

    table.insert(entitie.inventory, objet)
end

return inventory