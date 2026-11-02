-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ToolGameplayGuard = require(ReplicatedStorage.Library.Client.ToolGameplayGuard)
local LocalPlayer = Players.LocalPlayer

LocalPlayer:GetMouse()

local v1 = script.Parent
local v2 = 0
local BeeLauncherRemote = script.Parent:WaitForChild("BeeLauncherRemote")
local v3 = nil
local t = {}

local function removePlayerHighlights(p1) --[[ removePlayerHighlights | Line: 21 | Upvalues: t (ref) ]]
	if not t[p1] then
		return
	end

	for k, v in pairs(t[p1]) do
		if v and v.Parent then
			v:Destroy()
		end
	end

	t[p1] = nil
end

local function addPlayerHighlights(p1) --[[ addPlayerHighlights | Line: 32 | Upvalues: removePlayerHighlights (copy), t (ref) ]]
	local Character = p1.Character

	if Character then
		removePlayerHighlights(p1)

		local t2 = {}
		local Highlight = Instance.new("Highlight")

		Highlight.OutlineColor = Color3.new(1, 0.933333, 0)
		Highlight.Parent = Character
		table.insert(t2, Highlight)
		t[p1] = t2
	end
end

local function onUnequipped() --[[ onUnequipped | Line: 50 | Upvalues: v3 (ref), t (ref) ]]
	if v3 then
		v3:Disconnect()
		v3 = nil
	end

	for k, v in pairs(t) do
		for k2, v2 in pairs(v) do
			if v2 and v2.Parent then
				v2:Destroy()
			end
		end
	end

	t = {}
end

local function onEquipped() --[[ onEquipped | Line: 66 | Upvalues: v3 (ref), RunService (copy), LocalPlayer (copy), onUnequipped (copy), Players (copy), t (ref), addPlayerHighlights (copy), removePlayerHighlights (copy) ]]
	if not v3 then
		v3 = RunService.Heartbeat:Connect(function() --[[ Line: 71 | Upvalues: LocalPlayer (ref), onUnequipped (ref), Players (ref), t (ref), addPlayerHighlights (ref), removePlayerHighlights (ref) ]]
			if not (LocalPlayer.Character and LocalPlayer.Character.PrimaryPart) then
				onUnequipped()

				return
			end

			local Position = LocalPlayer.Character.PrimaryPart.Position
			local t2 = {}

			for k2, v in pairs(Players:GetPlayers()) do
				if v ~= LocalPlayer and (v.Character and v.Character.PrimaryPart) then
					if (v.Character.PrimaryPart.Position - Position).Magnitude <= 30 then
						table.insert(t2, v)

						if not t[v] then
							addPlayerHighlights(v)
						end

						continue
					end

					removePlayerHighlights(v)
				end
			end

			for k2, v in pairs(t) do
				if not table.find(t2, k2) and k2 ~= LocalPlayer then
					removePlayerHighlights(k2)
				end
			end
		end)

		return
	end

	v3:Disconnect()
	v3 = RunService.Heartbeat:Connect(function() --[[ Line: 71 | Upvalues: LocalPlayer (ref), onUnequipped (ref), Players (ref), t (ref), addPlayerHighlights (ref), removePlayerHighlights (ref) ]]
		if not (LocalPlayer.Character and LocalPlayer.Character.PrimaryPart) then
			onUnequipped()

			return
		end

		local Position = LocalPlayer.Character.PrimaryPart.Position
		local t2 = {}

		for k2, v in pairs(Players:GetPlayers()) do
			if v ~= LocalPlayer and (v.Character and v.Character.PrimaryPart) then
				if (v.Character.PrimaryPart.Position - Position).Magnitude <= 30 then
					table.insert(t2, v)

					if not t[v] then
						addPlayerHighlights(v)
					end

					continue
				end

				removePlayerHighlights(v)
			end
		end

		for k2, v in pairs(t) do
			if not table.find(t2, k2) and k2 ~= LocalPlayer then
				removePlayerHighlights(k2)
			end
		end
	end)
end

local function onActivated() --[[ onActivated | Line: 103 | Upvalues: ToolGameplayGuard (copy), v1 (copy), LocalPlayer (copy), v2 (ref), Players (copy), BeeLauncherRemote (copy) ]]
	if not ToolGameplayGuard.CanActivateLocal(v1) then
		return
	end

	if not (LocalPlayer.Character and LocalPlayer.Character.PrimaryPart) then
		return
	end

	local Position = LocalPlayer.Character.PrimaryPart.Position
	local v12 = tick()

	if v12 - v2 < 60 then
		return
	end

	v2 = v12

	for k, v in pairs(Players:GetPlayers()) do
		if v ~= LocalPlayer and (v.Character and v.Character.PrimaryPart) then
			local _ = (v.Character.PrimaryPart.Position - Position).Magnitude <= 30
		end
	end

	BeeLauncherRemote:FireServer(Position)
end

v1.Equipped:Connect(onEquipped)
v1.Unequipped:Connect(onUnequipped)
v1.Activated:Connect(onActivated)
LocalPlayer.CharacterRemoving:Connect(function() --[[ Line: 137 | Upvalues: onUnequipped (copy) ]]
	onUnequipped()
end)