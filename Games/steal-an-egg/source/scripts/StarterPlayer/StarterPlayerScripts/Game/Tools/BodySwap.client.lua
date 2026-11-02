-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ToolSetup = require(ReplicatedStorage.Library.Util.ToolSetup)
local ToolCooldownUtil = require(ReplicatedStorage.Library.Util.ToolCooldownUtil)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local BodySwap = require(ReplicatedStorage.Directory.Gears._Index.Other.BodySwap)
local BodySwap2 = Constants.NETWORK_MAP.BodySwap
local COOLDOWN = BodySwap.COOLDOWN
local LocalPlayer = Players.LocalPlayer
local v2 = nil
local t = {}
local v3 = nil
local v4 = Trove.new()

local function playSwapVFX(p1) --[[ playSwapVFX | Line: 32 | Upvalues: Asserts (copy), v1 (copy), ReplicatedStorage (copy) ]]
	Asserts.Player(p1)

	local Character = p1.Character

	if not Character then
		v1:AtError():Log("[BodySwap] Character not found")

		return
	end

	local t = {}

	for k, v in pairs(Character:GetChildren()) do
		if v:IsA("BasePart") then
			local v12 = ReplicatedStorage.Assets:FindFirstChild("BeeHit"):Clone()

			v12.Parent = v
			table.insert(t, v12)

			for k2, v2 in pairs(v12:GetChildren()) do
				if v2:IsA("ParticleEmitter") then
					v2:Emit(v2:GetAttribute("EmitCount") or 10)
				end
			end
		end
	end

	task.delay(2, function() --[[ Line: 56 | Upvalues: t (copy) ]]
		for i, v in ipairs(t) do
			v:Destroy()
		end
	end)
end

local function playSwapSFX() --[[ playSwapSFX | Line: 63 ]] end

local function removePlayerHighlights(p1) --[[ removePlayerHighlights | Line: 66 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.Player(p1)

	local v1 = t[p1]

	if not v1 then
		return
	end

	for v2, v3 in v1 do
		if v3 and v3.Parent then
			v3:Destroy()
		end
	end

	t[p1] = nil
end

local function addPlayerHighlights(p1) --[[ addPlayerHighlights | Line: 80 | Upvalues: Asserts (copy), removePlayerHighlights (copy), BodySwap (copy), t (copy) ]]
	Asserts.Player(p1)

	local Character = p1.Character

	if Character then
		removePlayerHighlights(p1)

		local Highlight = Instance.new("Highlight")

		Highlight.OutlineColor = BodySwap.HIGHLIGHT_COLOR
		Highlight.FillTransparency = BodySwap.HIGHLIGHT_FILL_TRANSPARENCY
		Highlight.OutlineTransparency = BodySwap.HIGHLIGHT_OUTLINE_TRANSPARENCY
		Highlight.Parent = Character
		t[p1] = { Highlight }
	end
end

local function findClosestTarget() --[[ findClosestTarget | Line: 99 | Upvalues: LocalPlayer (copy), BodySwap (copy), Players (copy) ]]
	local Character = LocalPlayer.Character

	if not (Character and Character.PrimaryPart) then
		return nil
	end

	local Position = Character.PrimaryPart.Position
	local MAX_RANGE = BodySwap.MAX_RANGE
	local v1 = nil

	for v2, v3 in Players:GetPlayers() do
		if v3 ~= LocalPlayer and (v3.Character and v3.Character.PrimaryPart) then
			local Magnitude = (v3.Character.PrimaryPart.Position - Position).Magnitude

			if Magnitude <= MAX_RANGE then
				MAX_RANGE = Magnitude
				v1 = v3
			end
		end
	end

	return v1
end

local function updateTargeting() --[[ updateTargeting | Line: 123 | Upvalues: v2 (ref), ToolCooldownUtil (copy), v3 (ref), removePlayerHighlights (copy), findClosestTarget (copy), addPlayerHighlights (copy) ]]
	local v1 = v2:GetCurrentTool()

	if v1 and not ToolCooldownUtil.IsOnCooldown(v1) then
		local v22 = findClosestTarget()

		if v22 == v3 then
			return
		end

		if v3 then
			removePlayerHighlights(v3)
		end

		if v22 then
			addPlayerHighlights(v22)
		end

		v3 = v22
	else
		if not v3 then
			return
		end

		removePlayerHighlights(v3)
		v3 = nil
	end
end

local function onActivated(p1) --[[ onActivated | Line: 148 | Upvalues: v3 (ref), ToolCooldownUtil (copy), v1 (copy), Network (copy), BodySwap2 (copy) ]]
	if not v3 then
		return
	end

	if ToolCooldownUtil.IsOnCooldown(p1) then
		v1:AtInfo():Log("[BodySwap] Tool is on cooldown")
	else
		Network.Fire(BodySwap2.REQUEST_SWAP, v3)
	end
end

local function onEquipped(p1) --[[ onEquipped | Line: 161 | Upvalues: v4 (copy), RunService (copy), updateTargeting (copy) ]]
	v4:Clean()
	v4:Add(RunService.Heartbeat:Connect(updateTargeting))
end

local function onUnequipped() --[[ onUnequipped | Line: 166 | Upvalues: v4 (copy), v3 (ref), t (copy), removePlayerHighlights (copy) ]]
	v4:Clean()
	v3 = nil

	for k in pairs(t) do
		removePlayerHighlights(k)
	end
end

v2 = ToolSetup.Initialize(BodySwap.DisplayName, {
	onActivated = onActivated,
	onEquipped = onEquipped,
	onUnequipped = onUnequipped
})
Network.Fired(BodySwap2.PLAY_VFX):Connect(function(p1, p2) --[[ Line: 182 | Upvalues: Asserts (copy), playSwapVFX (copy), LocalPlayer (copy), ToolSetup (copy), v2 (ref), COOLDOWN (copy) ]]
	Asserts.Player(p1)
	Asserts.Player(p2)
	playSwapVFX(p1)
	playSwapVFX(p2)

	if p1 ~= LocalPlayer then
		return
	end

	ToolSetup.StartCooldown(v2, COOLDOWN)
end)
Network.Fired(BodySwap2.PLAY_SFX):Connect(function() --[[ Line: 194 ]] end)