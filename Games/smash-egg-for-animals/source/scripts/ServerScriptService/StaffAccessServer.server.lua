-- StaffAccessServer : pose l'attribut joueur "IsStaff" (true / false) : le panneau admin cache Give, Cutscenes et
-- Cutscene-Event à ceux qui ne l'ont pas. (Le serveur revérifie à chaque demande : StaffAccess.)
local Players = game:GetService("Players")
local StaffAccess = require(script.Parent:WaitForChild("StaffAccess"))
local function set(player) player:SetAttribute("IsStaff", StaffAccess.isStaff(player)) end
Players.PlayerAdded:Connect(set)
for _, p in Players:GetPlayers() do set(p) end
