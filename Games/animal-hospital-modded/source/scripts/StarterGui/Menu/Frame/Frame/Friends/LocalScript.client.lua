
local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local SocialService = game:GetService("SocialService")
local LocalPlayer = game.Players.LocalPlayer
local v1 = script.Parent
local ok, result = pcall(function() --[[ Line: 9 | Upvalues: SocialService (copy), LocalPlayer (copy) ]]
	return SocialService:CanSendGameInviteAsync(LocalPlayer)
end)

if not (ok and result) then
	v1.Visible = false
end

Lib.Buttons.OnActivate(v1, function() --[[ Line: 16 | Upvalues: SocialService (copy), LocalPlayer (copy) ]]
	SocialService:PromptGameInvite(LocalPlayer)
end)