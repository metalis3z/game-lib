-- Kinoshi Event Controller (client)
-- Le trait + l'annonce sont gérés côté serveur (EventService.Events.Kinoshi) via NotificationService.
-- Ce module existe pour respecter l'architecture EventController / EventService du jeu
-- et peut accueillir des effets visuels supplémentaires plus tard.

local Kinoshi = {}

function Kinoshi.OnStart(_)
end

function Kinoshi.OnStop(_)
end

return Kinoshi
