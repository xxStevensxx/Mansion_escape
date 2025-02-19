-- Un module qui nous renvoi une liste de "constantes". ps: simulacre de const en lua cela n'existe pas
local constantes = {
     --music
     MSC_MANSION = love.audio.newSource("/sounds/lavanville_sinister_remix_16bit.wav", "stream"),
     -- sound effect
     SND_SHOOT = 0,
     SND_DESTRUCTION = 0,
     SND_GROWL = love.audio.newSource("/sounds/ghost_growl.wav", "static"),
     -- Constantes de machine a etat
     NONE = "none",
     WALK = "walk",
     PURSUIT = "pursuit",
     EAR = "ear",
     GROWL = "growl",
     ATTACK = "attack",
     CHANGEDIR = "changedir",
     -- Constantes de entities type 
     HERO = "hero",
     MOB = "mob",
     GHOST = "ghost",
     -- Constantes de nom de fichier
     HERO_SPRT = "player_",
     MOB_SPRT = "monster_",
     GHOST_SPRT = "ghost_",
     SCREENWIDTH = love.graphics.getWidth(),
     SCREENHEIGHT = love.graphics.getHeight(),
     -- Constantes de projectile
     PRJTL_ECTOPLASM = love.graphics.newImage("/assets/ectoplasm.png")
    
}

--si besoin on ajoutera de nouvelles constantes
return constantes