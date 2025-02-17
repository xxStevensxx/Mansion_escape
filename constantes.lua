local constantes

-- Un fonction qui nous renvoi une liste de "constantes". ps: simulacre de const en lua cela n'existe pas

function constantes.lst()

    --si besoin on ajoutera de nouvelles constantes
    local const = {
        -- Constantes de machine a etat
        NONE = "none",
        WALK = "walk",
        PURSUIT = "pursuit",
        EAR = "ear",
        GROWL = "growl",
        ATTACK = "attack",

        -- Constantes de entities type 
        HERO = "hero",
        MOB = "mob",

        -- Constantes de nom de fichier
        HERO_SPRT = "player_",
        MOB_SPRT = "monster_"

    }

    return const
end


return constantes