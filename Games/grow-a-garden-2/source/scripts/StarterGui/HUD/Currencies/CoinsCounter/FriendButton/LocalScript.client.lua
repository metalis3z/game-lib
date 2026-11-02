--credit to leon games studio
local SocialService = game:GetService("SocialService")
local LocalPlayer = game.Players.LocalPlayer

script.Parent.MouseButton1Click:Connect(function() --[[ Line: 4 | Upvalues: SocialService (copy), LocalPlayer (copy) ]]
	local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions")

	ExperienceInviteOptions.PromptMessage = "10% Sheckle Boost Per Invite!"
	SocialService:PromptGameInvite(LocalPlayer, ExperienceInviteOptions)
end)