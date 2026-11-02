--credit to leon games studio
local t = {}
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)

function t.Create(p1, p2, p3, p4, p5) --[[ Create | Line: 3 ]]
	local v1 = game.ReplicatedStorage.Assets.Reticule:Clone()

	v1.CFrame = p1
	v1.Size = Vector3.new(p2, 0.1, p2)

	local v2 = p5 or 1

	for v3, v4 in v1:GetDescendants() do
		if v4:IsA("Frame") then
			v4.BackgroundTransparency = v4.BackgroundTransparency * v2
			v4.BackgroundColor3 = p3

			continue
		end

		if v4:IsA("UIStroke") then
			v4.Color = p3
			v4.Transparency = v4.Transparency * v2
		end
	end

	v1.Parent = workspace
	game:GetService("TweenService"):Create(v1.SurfaceGui.Inner.UIScale, TweenInfo.new(p4), {
		Scale = 1
	}):Play()
	game.Debris:AddItem(v1, p4)
end
Networking.WeatherEffects.Reticule.OnClientEvent:Connect(t.Create)

return t