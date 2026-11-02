--credit to prince games studio
local t = {}
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local v1 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)

function t.Init(p1) --[[ Init | Line: 7 | Upvalues: Networking (copy), t (copy), LocalPlayer (copy) ]]
	Networking.Mushrooms.SetInvisiblity.OnClientEvent:Connect(function(p1) --[[ Line: 8 | Upvalues: t (ref), LocalPlayer (ref) ]]
		t:SetInvisible(LocalPlayer.Character, p1)
	end)
	Networking.Mushrooms.PlayFX.OnClientEvent:Connect(function(p1) --[[ Line: 11 | Upvalues: t (ref), LocalPlayer (ref) ]]
		t:PlayFX(LocalPlayer.Character, p1)
	end)
end
function t.PlayFX(p1, p2, p3) --[[ PlayFX | Line: 16 | Upvalues: TweenService (copy), v1 (copy) ]]
	local Highlight = Instance.new("Highlight")

	Highlight.FillColor = p3
	Highlight.Parent = p2
	Highlight.FillTransparency = 0
	Highlight.OutlineTransparency = 1
	Highlight:SetAttribute("InvisiblityHighlight", true)
	Highlight.Adornee = p2

	local v12 = TweenService:Create(Highlight, v1, {
		FillTransparency = 1
	})

	v12:Play()
	game.Debris:AddItem(v12, v1.Time)
	game.Debris:AddItem(Highlight, v1.Time)
end
function t.SetInvisible(p1, p2, p3) --[[ SetInvisible | Line: 31 ]]
	if p3 == true then
		local Highlight = Instance.new("Highlight")

		Highlight.Parent = p2
		Highlight.FillTransparency = 0.5
		Highlight.OutlineTransparency = 0.9967
		Highlight.FillColor = Color3.new(255/255, 255/255, 255/255)
		Highlight:SetAttribute("InvisiblityHighlight", true)
		Highlight.Adornee = p2

		return
	end

	for v1, v2 in p2:GetChildren() do
		if v2:IsA("Highlight") and v2:GetAttribute("InvisiblityHighlight") then
			v2:Destroy()
		end
	end
end

return t