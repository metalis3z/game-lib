local BadgeService = game:GetService("BadgeService")
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = game:GetService("Players").LocalPlayer

for _, Frame in pairs(script.Parent:GetChildren()) do

	if Frame:IsA('Frame') then

		if Frame:GetAttribute('Type') == 'Group' then

			pcall(function()

				if LocalPlayer:IsInGroup(Frame.ZIndex) then

					Frame.Info:WaitForChild('Owned', 10).Visible = true

				end

			end)

		end

	end

end