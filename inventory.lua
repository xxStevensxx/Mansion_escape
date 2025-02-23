local inventory = {}


function inventory.addObj(entitie, weapon)

    table.insert(entitie.inventory, weapon)
    weapon.pick = true

end

return inventory