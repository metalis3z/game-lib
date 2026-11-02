--credit to leon games studio
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("TweenService")

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Networking = require(ReplicatedStorage.SharedModules.Networking)

require(ReplicatedStorage.ClientModules.Signal).new()

local t = {}
local t2 = {}
local t3 = {}
local t4 = {}
local v1 = false
local v2 = nil
local v3 = 0
local v4 = 0
local v5 = nil
local v6 = OverlapParams.new()

v6.FilterType = Enum.RaycastFilterType.Include
v6.FilterDescendantsInstances = {}

local function rebuildOverlapFilter() --[[ rebuildOverlapFilter | Line: 39 | Upvalues: Players (copy), v6 (copy) ]]
	local t = {}

	for v1, v2 in Players:GetPlayers() do
		if v2.Character then
			table.insert(t, v2.Character)
		end
	end

	v6.FilterDescendantsInstances = t
end

Players.PlayerAdded:Connect(rebuildOverlapFilter)
Players.PlayerRemoving:Connect(rebuildOverlapFilter)
task.spawn(function() --[[ Line: 52 | Upvalues: rebuildOverlapFilter (copy) ]]
	while true do
		rebuildOverlapFilter()
		task.wait(5)
	end
end)
function t.GetPlantFromFruit(p1, p2) --[[ GetPlantFromFruit | Line: 59 ]]
	local v1 = p2.Parent

	if not v1 or v1 and v1.Name ~= "Fruits" then
		return
	end

	return v1.Parent
end
function t.UpdateAppearance(p1, p2, p3) --[[ UpdateAppearance | Line: 65 | Upvalues: ReplicatedStorage (copy), CollectionService (copy) ]]
	if p3 then
		local BurningVFX = ReplicatedStorage.Assets.VFX.StatusVFX:FindFirstChild("BurningVFX")

		if BurningVFX == nil then
			return
		end

		for v1, v2 in BurningVFX:GetChildren() do
			local v3 = v2:Clone()

			v3.Parent = p2:FindFirstChild("Torso") or p2.PrimaryPart
			v3.Enabled = true
			v3:AddTag("GhostPepperAppearance")
		end
	else
		for v5, v6 in CollectionService:GetTagged("GhostPepperAppearance") do
			if v6:IsDescendantOf(p2) then
				v6:RemoveTag("GhostPepperAppearance")

				if v6:IsA("ParticleEmitter") then
					v6.Enabled = false
					game.Debris:AddItem(v6, 1)
				end
			end
		end
	end
end
function t.StartLocalBurnEffects(p1) --[[ StartLocalBurnEffects | Line: 95 | Upvalues: v1 (ref), v3 (ref), v4 (ref), LocalPlayer (copy), v5 (ref), v2 (ref), RunService (copy) ]]
	if v1 then
		return
	end

	v1 = true
	v3 = tick()
	v4 = 0

	local Character = LocalPlayer.Character
	local v12 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

	if v12 then
		v12.WalkSpeed = v12.WalkSpeed + 7
		v5 = v12
	end

	v2 = RunService.Heartbeat:Connect(function() --[[ Line: 113 | Upvalues: v3 (ref), LocalPlayer (ref), v4 (ref) ]]
		local v1 = tick() - v3
		local Character = LocalPlayer.Character
		local v2 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

		if v2 and v2.Health > 0 then
			v2.Jump = true
		end

		if not (v2 and (v2.Health > 0 and v1 - v4 >= 0.1)) then
			return
		end

		v4 = v1
		v2:TakeDamage(1)
	end)
end
function t.StopLocalBurnEffects(p1) --[[ StopLocalBurnEffects | Line: 132 | Upvalues: v1 (ref), v2 (ref), v5 (ref) ]]
	if not v1 then
		return
	end

	v1 = false

	if v2 then
		v2:Disconnect()
		v2 = nil
	end

	if not (v5 and v5.Parent) then
		v5 = nil

		return
	end

	v5.WalkSpeed = v5.WalkSpeed - 7
	v5 = nil
end
LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 152 | Upvalues: v1 (ref), v2 (ref), v5 (ref) ]]
	if not v1 then
		return
	end

	v1 = false

	if v2 then
		v2:Disconnect()
		v2 = nil
	end

	v5 = nil
end)
function t.StartOrRefreshBurn(p1, p2, p3) --[[ StartOrRefreshBurn | Line: 165 | Upvalues: t3 (copy), t (copy), LocalPlayer (copy), Networking (copy), t4 (copy) ]]
	if not (if table.find(t3, p2) == nil then false else true) then
		table.insert(t3, p2)
		t:UpdateAppearance(p2.Character, true)

		if p2 == LocalPlayer then
			t:StartLocalBurnEffects()
		end

		if p3 then
			Networking.GhostPepperService.TouchBegan:Fire(p2.Character, p3)
		end
	end

	local t2 = {}

	t4[p2] = t2
	task.delay(5, function() --[[ Line: 185 | Upvalues: t4 (ref), p2 (copy), t2 (copy), t (ref) ]]
		if t4[p2] == t2 then
			t4[p2] = nil
			t:EndBurn(p2)
		end
	end)
end
function t.EndBurn(p1, p2) --[[ EndBurn | Line: 194 | Upvalues: t3 (copy), t (copy), LocalPlayer (copy), Networking (copy) ]]
	local v1 = table.find(t3, p2)

	if not v1 then
		return
	end

	table.remove(t3, v1)

	if p2.Character then
		t:UpdateAppearance(p2.Character, false)
	end

	if p2 ~= LocalPlayer then
		Networking.GhostPepperService.TouchEnded:Fire(p2.Character)

		return
	end

	t:StopLocalBurnEffects()
	Networking.GhostPepperService.TouchEnded:Fire(p2.Character)
end
function t.RegisterPoisonObject(p1, p2) --[[ RegisterPoisonObject | Line: 211 | Upvalues: t2 (copy) ]]
	table.insert(t2, {
		Object = p2
	})
end
function t.UnregisterPoisonObject(p1, p2) --[[ UnregisterPoisonObject | Line: 217 | Upvalues: t2 (copy) ]]
	for v1, v2 in t2 do
		if v2.Object == p2 then
			table.remove(t2, v1)

			return
		end
	end
end
function t.GetTouchingParts(p1, p2) --[[ GetTouchingParts | Line: 226 | Upvalues: Players (copy), v6 (copy), t (copy), LocalPlayer (copy) ]]
	local Position = p2.Position
	local v1 = false

	for v2, v3 in Players:GetPlayers() do
		local Character = v3.Character
		local v4 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

		if v4 and (v4.Position - Position).Magnitude < 30 then
			v1 = true

			break
		end
	end

	if not v1 then
		return
	end

	local v5 = workspace:GetPartsInPart(p2, v6)

	if #v5 == 0 then
		return
	end

	local t2 = {}

	for v62, v7 in v5 do
		if v7.Parent then
			local v8 = v7:FindFirstAncestorWhichIsA("Model")
			local v9 = if v8 then Players:GetPlayerFromCharacter(v8) else nil

			if v9 and not t2[v9] then
				local v10 = t:GetPlantFromFruit(p2.Parent)

				if v10 then
					local v11 = v10:GetAttribute("UserId")

					if v11 and (not v11 or v11 ~= LocalPlayer.UserId) then
						t2[v9] = true
						t:StartOrRefreshBurn(v9, p2.Parent and p2.Parent:GetAttribute("FruitId") or nil)
					end
				end
			end
		end
	end
end
function t.Routine(p1) --[[ Routine | Line: 264 | Upvalues: t2 (copy), t (copy) ]]
	for v1, v2 in t2 do
		t:GetTouchingParts(v2.Object)
	end
end
function t.Init(p1) --[[ Init | Line: 273 | Upvalues: CollectionService (copy), t (copy) ]]
	for v1, v2 in CollectionService:GetTagged("GhostPepper") do
		t:RegisterPoisonObject(v2)
	end

	CollectionService:GetInstanceAddedSignal("GhostPepper"):Connect(function(p1) --[[ Line: 278 | Upvalues: t (ref) ]]
		t:RegisterPoisonObject(p1)
	end)
	CollectionService:GetInstanceRemovedSignal("GhostPepper"):Connect(function(p1) --[[ Line: 282 | Upvalues: t (ref) ]]
		t:UnregisterPoisonObject(p1)
	end)
	task.spawn(function() --[[ Line: 286 | Upvalues: t (ref) ]]
		while true do
			t:Routine()
			task.wait(0.5)
		end
	end)
end

return t