-- Un module qui nous renvoi une liste de "constantes". ps: simulacre de const en lua cela n'existe pas
local constantes = {
     -- 🎼🎼 music
     MSC_MANSION = love.audio.newSource("/sounds/Tunnel.wav", "stream"),
     -- 🔊🔊 sound effect
     SND_SHOOT_ECTOPLASM = love.audio.newSource("/sounds/Shot1.wav", "static"),
     SND_SHOOT_BOW = love.audio.newSource("/sounds/Crossbow.wav", "static"),
     SND_AXE_STRIKE = love.audio.newSource("/sounds/Sword4.wav", "static"),
     SND_DESTRUCTION = 0,
     SND_GROWL = love.audio.newSource("/sounds/Darkness5.wav", "static"),
     SND_ONI = love.audio.newSource("/sounds/Growl.wav", "static"),
     SND_DMG_MOBS = love.audio.newSource("/sounds/Damage3.wav", "static"),
     SND_DMG_SHOOT = love.audio.newSource("/sounds/Damage5.wav", "static"),
     SND_CANCEL = love.audio.newSource("/sounds/Cancel1.wav", "static"),
     SND_PAUSE = love.audio.newSource("/sounds/Decision1.wav", "static"),
     SND_PICK_WPN = love.audio.newSource("/sounds/Equip2.wav", "static"),
     SND_SWITCH_WPN = love.audio.newSource("/sounds/Equip1.wav", "static"),
     SND_DEFEAT = love.audio.newSource("/sounds/Defeat1.wav", "static"),
     -- 💻💻 Constantes de machine a etat
     NONE = "none",
     WALK = "walk",
     PURSUIT = "pursuit",
     EAR = "ear",
     GROWL = "growl",
     ATTACK = "attack",
     CHANGEDIR = "changedir",
     DEATH = "death",
     -- 👻👾🤖👺🪓 Constantes de entities type 
     HERO = "hero",
     MOB = "mob",
     GHOST = "ghost",
     ONI = "oni",
     BOW = "bow",
     AXE = "axe",
     -- 📁📁 Constantes de nom de fichier
     HERO_SPRT = "player_",
     MOB_SPRT = "monster_",
     GHOST_SPRT = "ghost_",
     ONI_SPRT = "boss_",
     BOW_SPRT = "bow_",
     AXE_SPRT = "axe_",
     -- 📺📺  Largeur et Hauteur de l'ecran de jeu
     SCREENWIDTH = love.graphics.getWidth(),
     SCREENHEIGHT = love.graphics.getHeight(),
     -- ⚾⚾ Constantes de projectile
     PRJTL_ECTOPLASM = love.graphics.newImage("/assets/ectoplasm.png"),
     PRJTL_ARROW = love.graphics.newImage("/assets/arrow.png"),
     -- 💭💭 Constantes State bubble
     BUBBLE_GROWL = love.graphics.newImage("/assets/growl.png"),
     BUBBLE_EAR = love.graphics.newImage("/assets/colere.png"),
     BUBBLE_PURSUIT = love.graphics.newImage("/assets/eye.png"),
     -- 💖💖 Constante life
     LEFT_HEART = love.graphics.newImage("/assets/leftHeart.png"),
     RIGHT_HEART = love.graphics.newImage("/assets/rightHeart.png"),
     -- 🏡🏡 Spawner  
     SPWN_GRAVE = love.graphics.newImage("/assets/grave.png"),
     -- 🪓🪓 Objet 
     OBJ_AXE = {
          love.graphics.newImage("/assets/axe_1.png "),
          love.graphics.newImage("/assets/axe_2.png"),
          love.graphics.newImage("/assets/axe_3.png")
     },
     OBJ_BOW = {
          love.graphics.newImage("/assets/bow_1.png "),
          love.graphics.newImage("/assets/bow_2.png"),
          love.graphics.newImage("/assets//bow_3.png")
     },
     -- 🚩🚩 Autre
     PANEL_ONE = love.graphics.newImage("/assets/panel1.png"),
     PANEL_PAUSE = love.graphics.newImage("/assets/panel2.png"),
     PANEL_INVENTORY = love.graphics.newImage("/assets/panel1.png"),
     FONT = love.graphics.newFont("/font/NameismudPersonalUseRegular-d9m5x.ttf"),
     TEXT_PROX = "PRESS E TO PICK UP"
          
}

--si besoin on ajoutera de nouvelles constantes
return constantes