local inventory = {}


function inventory.addObj(entitie, weapon)

    table.insert(entitie.inventory, weapon)
    print(entitie.inventory[1].name)
    weapon.pick = true

end

return inventory