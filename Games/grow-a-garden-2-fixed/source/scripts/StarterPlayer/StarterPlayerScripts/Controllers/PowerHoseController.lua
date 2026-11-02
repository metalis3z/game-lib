--credit to quartz games studio
local t = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer

function t.Init(p1) --[[ Init | Line: 9 ]] end
function t.Start(p1) --[[ Start | Line: 12 | Upvalues: LocalPlayer (copy), Networking (copy) ]]
	local Character = LocalPlayer.Character

	if Character then
		p1:SetupCharacter(Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(p12) --[[ Line: 17 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	Networking.PowerHose.KnockbackFx.OnClientEvent:Connect(function(p12) --[[ Line: 21 | Upvalues: p1 (copy) ]]
		p1:PlayKnockbackFx(p12)
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 26 ]]
	local t = {}

	local function tryConnect(p12) --[[ tryConnect | Line: 29 | Upvalues: t (copy), p1 (copy) ]]
		if not p12:IsA("Tool") or (not p12:GetAttribute("PowerHose") or t[p12]) then
			return
		end

		t[p12] = true
		p12.Activated:Connect(function() --[[ Line: 32 | Upvalues: p1 (ref), p12 (copy) ]]
			p1:OnToolActivated(p12)
		end)
	end

	p2.ChildAdded:Connect(tryConnect)

	for v1, v2 in p2:GetChildren() do
		tryConnect(v2)
	end
end
function t.OnToolActivated(p1, p2) --[[ OnToolActivated | Line: 44 | Upvalues: LocalPlayer (copy), Networking (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	if p2.Parent ~= Character then
		return
	end

	local v1 = p2:GetAttribute("CooldownEnd")

	if not (v1 and os.clock() < v1) then
		Networking.PowerHose.Activate:Fire(p2)

		local v2 = p2:GetAttribute("Cooldown") or 10

		p2:SetAttribute("CooldownEnd", os.clock() + v2)
	end
end
function t.PlayKnockbackFx(p1, p2) --[[ PlayKnockbackFx | Line: 58 ]] end

return t