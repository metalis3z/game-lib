-- Ibrx Event Controller (client)
-- Le trait + l'annonce sont gérés côté serveur (EventService.Events.Ibrx) via NotificationService.
-- Ce module existe pour respecter l'architecture EventController / EventService du jeu
-- et peut accueillir des effets visuels supplémentaires plus tard.

local Ibrx = {}

function Ibrx.OnStart(_)
end

function Ibrx.OnStop(_)
end

return Ibrx
