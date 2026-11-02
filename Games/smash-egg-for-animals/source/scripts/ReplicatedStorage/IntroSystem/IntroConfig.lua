-- Réglages de la cinématique d'arrivée (lus par IntroServer et IntroClient).
-- Elle est jouée aux nouveaux joueurs (attribut TutorialDone = false, posé par TutorialServer), avant le tutoriel.
-- Pour la revoir : poser l'attribut PlayIntro = true sur le joueur (depuis le serveur).
local IntroConfig = {}

IntroConfig.Boss = "Pumpking" -- le gardien de la dernière zone (modèle de ServerStorage.ZoneBosses)
IntroConfig.LeapTime = 0.5    -- durée d'un bond d'arbre en arbre
IntroConfig.PerchTime = 0.16  -- pause accroupie sur chaque cime
IntroConfig.RoarTime = 3.0    -- atterrissage devant la caméra, deux rugissements, titre
IntroConfig.ZoneShotTime = 3.8 -- plan sur la dernière zone
IntroConfig.FlyTime = 14      -- survol de toutes les zones, de la dernière à la première (environ une seconde par zone)
IntroConfig.MaxTime = 70      -- sécurité côté serveur : après ce délai tout est remis en place

return IntroConfig
