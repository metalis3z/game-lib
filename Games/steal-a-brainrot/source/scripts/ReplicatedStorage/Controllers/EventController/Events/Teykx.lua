-- Teykx Event Controller (client)
-- Le trait + l'annonce sont gérés côté serveur (EventService.Events.Teykx) via NotificationService.
-- Ce module existe pour respecter l'architecture EventController / EventService du jeu
-- et peut accueillir des effets visuels supplémentaires plus tard.

local Teykx = {}

function Teykx.OnStart(_)
end

function Teykx.OnStop(_)
end

return Teykx
