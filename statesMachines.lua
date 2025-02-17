local statesMachines = {}

function statesMachines.states(entities)
    -- Voici notre machine a etat pour tout nos mobs

    --NONE aucun statut en cours
    if entities.state == NONE then

    --WALK marche dnas la zone sans but
    elseif entities.state == WALK

    --PURSUIT notre entities poursuit le hero
    elseif entities.state == PURSUIT then

    --EAR Notre entities entend du bruit
    elseif entities.state == EAR then

    --GROWL notre entities hurle
    elseif entities.state == GROWL then

    --ATTACK notre entities passe à l'attack
    elseif entities.state == ATTACK then


    end
end


return statesMachines