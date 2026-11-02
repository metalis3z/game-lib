--credit to prince games studio
local t = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer

function t.Init(p1) --[[ Init | Line: 11 ]] end
function t.Start(p1) --[[ Start | Line: 14 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if Character then
		p1:SetupCharacter(Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(p12) --[[ Line: 19 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 24 ]]
	local function tryConnect(p12) --[[ tryConnect | Line: 25 | Upvalues: p1 (copy) ]]
		if not (p12:IsA("Tool") and p12:GetAttribute("Ladder")) then
			return
		end

		p12.Activated:Connect(function() --[[ Line: 27 | Upvalues: p1 (ref), p12 (copy) ]]
			p1:OnToolActivated(p12)
		end)
	end

	p2.ChildAdded:Connect(tryConnect)

	for v1, v2 in p2:GetChildren() do
		if v2:IsA("Tool") and v2:GetAttribute("Ladder") then
			v2.Activated:Connect(function() --[[ Line: 27 | Upvalues: p1 (copy), v2 (copy) ]]
				p1:OnToolActivated(v2)
			end)
		end
	end
end
function t.OnToolActivated(p1, p2) --[[ OnToolActivated | Line: 39 | Upvalues: LocalPlayer (copy), Networking (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	if p2.Parent ~= Character then
		return
	end

	local v1 = p2:GetAttribute("CooldownEnd")

	if v1 and os.clock() < v1 then
		return
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		Networking.Place.PlaceLadder:Fire(HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 6, p2:GetAttribute("Ladder"), p2)
		p2:SetAttribute("CooldownEnd", os.clock() + 60)
	end
end

return t