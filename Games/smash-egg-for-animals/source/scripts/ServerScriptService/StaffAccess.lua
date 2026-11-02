-- StaffAccess : qui a le droit aux onglets sensibles du panneau admin (Give, Cutscenes, Cutscene-Event).
-- Seulement les joueurs qui ont le tag "DEV" ou "Creator" dans TagConfig_Old (pas "CONTENT CREATOR"), plus le propriétaire.
-- Les autres admins gardent le reste du panneau. Vérifié par CHAQUE script serveur concerné (pas seulement l'onglet caché).
local ServerScriptService = game:GetService("ServerScriptService")
local Tags = require(ServerScriptService:WaitForChild("TagConfig_Old"))
local OWNER_ID = 3160444354 -- drax
local STAFF_TAGS = {DEV = true, CREATOR = true}
local M = {}
function M.isStaff(player)
	if typeof(player) ~= "Instance" or not player:IsA("Player") then return false end
	if player.UserId == OWNER_ID then return true end
	local tag = Tags[player.Name]
	return type(tag) == "string" and STAFF_TAGS[string.upper(tag)] == true
end
return M
