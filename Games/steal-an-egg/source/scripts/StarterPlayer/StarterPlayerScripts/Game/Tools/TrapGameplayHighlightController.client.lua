-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local GuardAreaLookupUtil = require(ReplicatedStorage.Library.Util.GuardAreaLookupUtil)
local Player = require(ReplicatedStorage.Library.Player)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)
local v1 = Color3.fromRGB(255, 255, 255)
local PLACED_TRAP = Constants.TAGS_MAP.Traps.PLACED_TRAP
local LocalPlayer = Players.LocalPlayer
local __OBJECTS = Workspace.__OBJECTS

assert(__OBJECTS:IsA("Folder"), "Workspace.__OBJECTS must be a Folder")

local Areas = __OBJECTS.Areas

assert(Areas:IsA("Folder"), "Workspace.__OBJECTS.Areas must be a Folder")

local SeparationLine = Areas.SeparationLine

assert(SeparationLine:IsA("BasePart"), "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")

local t = {}
local v5 = nil
local v6 = false

local function getOrCreateState(p1) --[[ getOrCreateState | Line: 57 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if v1 then
		return v1
	end

	local t2 = {
		Highlight = nil,
		Tween = nil,
		FadeOutVersion = 0
	}

	t[p1] = t2

	return t2
end

local function cancelTween(p1) --[[ cancelTween | Line: 72 ]]
	local Tween = p1.Tween

	if not Tween then
		return
	end

	p1.Tween = nil
	Tween:Cancel()
end

local function isOwnedTrap(p1) --[[ isOwnedTrap | Line: 80 | Upvalues: LocalPlayer (copy) ]]
	local isName = p1:GetAttribute("Owner") == LocalPlayer.Name

	return isName
end

local function showTrapHighlight(p1) --[[ showTrapHighlight | Line: 84 | Upvalues: LocalPlayer (copy), t (copy), v1 (copy), Tween (copy) ]]
	local isName = p1:GetAttribute("Owner") == LocalPlayer.Name

	if not isName then
		return
	end

	local v12 = t[p1]
	local v2

	if v12 then
		v2 = v12
	else
		local t2 = {
			Highlight = nil,
			Tween = nil,
			FadeOutVersion = 0
		}

		t[p1] = t2
		v2 = t2
	end

	v2.FadeOutVersion = v2.FadeOutVersion + 1

	local Tween2 = v2.Tween

	if Tween2 then
		v2.Tween = nil
		Tween2:Cancel()
	end

	local TrapGameplayHighlight = p1:FindFirstChild("TrapGameplayHighlight")
	local v3

	if TrapGameplayHighlight and TrapGameplayHighlight:IsA("Highlight") then
		v3 = TrapGameplayHighlight
	else
		local TrapGameplayHighlight2 = Instance.new("Highlight")

		TrapGameplayHighlight2.Name = "TrapGameplayHighlight"
		TrapGameplayHighlight2.Parent = p1
		v3 = TrapGameplayHighlight2
	end

	v3.Adornee = p1
	v3.DepthMode = Enum.HighlightDepthMode.Occluded
	v3.FillColor = v1
	v3.FillTransparency = 1
	v3.OutlineColor = v1
	v3.OutlineTransparency = 1
	v2.Highlight = v3
	v2.Tween = Tween(v3, {
		OutlineTransparency = 0.3
	}, { 0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })
end

local function hideTrapHighlight(p1) --[[ hideTrapHighlight | Line: 117 | Upvalues: t (copy), Tween (copy) ]]
	local v1 = t[p1]

	if not v1 then
		return
	end

	local Highlight = v1.Highlight

	if not Highlight then
		return
	end

	v1.FadeOutVersion = v1.FadeOutVersion + 1

	local FadeOutVersion = v1.FadeOutVersion
	local Tween2 = v1.Tween

	if Tween2 then
		v1.Tween = nil
		Tween2:Cancel()
	end

	local v2 = Tween(Highlight, {
		OutlineTransparency = 1
	}, { 0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })

	v1.Tween = v2
	v2.Completed:Once(function(p1) --[[ Line: 137 | Upvalues: v1 (copy), FadeOutVersion (copy), Highlight (copy) ]]
		if p1 ~= Enum.PlaybackState.Completed or v1.FadeOutVersion ~= FadeOutVersion then
			return
		end

		if Highlight.Parent then
			Highlight:Destroy()
		end

		v1.Highlight = nil
		v1.Tween = nil
	end)
end

local function setTrapHighlightsVisible(p1) --[[ setTrapHighlightsVisible | Line: 150 | Upvalues: t (copy), showTrapHighlight (copy), hideTrapHighlight (copy) ]]
	for k in pairs(t) do
		if p1 then
			showTrapHighlight(k)

			continue
		end

		hideTrapHighlight(k)
	end
end

local function cleanupTrap(p1) --[[ cleanupTrap | Line: 160 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if not v1 then
		return
	end

	local Tween = v1.Tween

	if Tween then
		v1.Tween = nil
		Tween:Cancel()
	end

	local Highlight = v1.Highlight

	if Highlight and Highlight.Parent then
		Highlight:Destroy()
	end

	t[p1] = nil
end

local function trackTrap(p1) --[[ trackTrap | Line: 174 | Upvalues: LocalPlayer (copy), t (copy), v6 (ref), showTrapHighlight (copy) ]]
	if not p1:IsA("BasePart") then
		return
	end

	local isName = p1:GetAttribute("Owner") == LocalPlayer.Name

	if not isName then
		return
	end

	if not t[p1] then
		t[p1] = {
			Highlight = nil,
			Tween = nil,
			FadeOutVersion = 0
		}
	end

	if v6 then
		showTrapHighlight(p1)
	end

	p1.Destroying:Once(function() --[[ Line: 187 | Upvalues: p1 (copy), t (ref) ]]
		local v1 = p1
		local v2 = t[v1]

		if not v2 then
			return
		end

		local Tween = v2.Tween

		if Tween then
			v2.Tween = nil
			Tween:Cancel()
		end

		local Highlight = v2.Highlight

		if Highlight and Highlight.Parent then
			Highlight:Destroy()
		end

		t[v1] = nil
	end)
end

local function untrackTrap(p1) --[[ untrackTrap | Line: 192 | Upvalues: v6 (ref), hideTrapHighlight (copy), t (copy) ]]
	if not p1:IsA("BasePart") then
		return
	end

	if v6 then
		hideTrapHighlight(p1)

		return
	end

	local v1 = t[p1]

	if not v1 then
		return
	end

	local Tween = v1.Tween

	if Tween then
		v1.Tween = nil
		Tween:Cancel()
	end

	local Highlight = v1.Highlight

	if Highlight and Highlight.Parent then
		Highlight:Destroy()
	end

	t[p1] = nil
end

for i, v in ipairs(CollectionService:GetTagged(PLACED_TRAP)) do
	trackTrap(v)
end

CollectionService:GetInstanceAddedSignal(PLACED_TRAP):Connect(trackTrap)
CollectionService:GetInstanceRemovedSignal(PLACED_TRAP):Connect(untrackTrap)
RenderStepped(function() --[[ Line: 211 | Upvalues: Player (copy), LocalPlayer (copy), v5 (ref), v6 (ref), GuardAreaLookupUtil (copy), SeparationLine (copy), t (copy), showTrapHighlight (copy), hideTrapHighlight (copy) ]]
	local v1 = Player.Optional.HumanoidRootPart(LocalPlayer)

	if v1 == nil or not v1:IsA("BasePart") then
		return false
	end

	local Position = v1.Position
	local v2 = v5

	v5 = Position

	if v2 == nil then
		v6 = GuardAreaLookupUtil.IsInGameplaySide(SeparationLine, Position)

		if not v6 then
			return false
		end

		for k in pairs(t) do
			showTrapHighlight(k)
		end
	elseif GuardAreaLookupUtil.HasCrossedGameplayEntryBoundary(SeparationLine, v2, Position) then
		v6 = true

		for k in pairs(t) do
			showTrapHighlight(k)
		end
	else
		if not GuardAreaLookupUtil.HasCrossedGameplayExitBoundary(SeparationLine, v2, Position) then
			return false
		end

		v6 = false

		for k in pairs(t) do
			hideTrapHighlight(k)
		end
	end

	return false
end)