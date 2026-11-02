-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Library = game:GetService("ReplicatedStorage").Library
local UIOffsetScaler = require(Library.Functions.UIOffsetScaler)
local Client = Library.Client
local Settings = require(Client.Settings)
local FFlags = require(Client.FFlags)
local ScreenResolution = require(Client.ScreenResolution)
local InstanceChangeQueue = require(Library.Modules.InstanceChangeQueue)
local t = {}
local t2 = {}
local v1 = false
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = InstanceChangeQueue.new({
	MaxInstancesPerStep = 128,
	MaxStepTime = 0.0025,
	StepInterval = 1 / 60,
	OnAdded = function(p1) --[[ OnAdded | Line: 46 | Upvalues: v3 (ref) ]]
		v3(p1)
	end
})
local v7 = InstanceChangeQueue.new({
	MaxInstancesPerStep = 128,
	MaxStepTime = 0.0025,
	StepInterval = 1 / 60,
	Filter = function(p1) --[[ Filter | Line: 54 | Upvalues: v4 (ref) ]]
		return v4(p1)
	end,
	OnAdded = function(p1) --[[ OnAdded | Line: 57 | Upvalues: v2 (ref) ]]
		v2.Track(p1)
	end
})

v4 = function(p1) --[[ Line: 66 ]]
	return p1:IsA("BillboardGui") or p1:IsA("SurfaceGui")
end
v3 = function(p1) --[[ Line: 70 | Upvalues: v2 (ref), Settings (copy) ]]
	debug.profilebegin("InterfaceScaling :: QueueApplyScaling")
	v2.ApplyScaling(p1)

	if not (Settings.ScaleRichText and p1:IsA("TextLabel")) then
		debug.profileend()

		return
	end

	v2.TrackRichText(p1)
	debug.profileend()
end
v2 = {
	ResolutionRatioMultiplier = 0.5,
	ScreenGuiIgnoreList = { "Chat", "TouchGui" },
	UIOffsetScaler = UIOffsetScaler({
		Stroke = Settings.ScaleStrokes,
		RichText = Settings.ScaleRichText,
		NineSlice = Settings.Scale9Slice,
		Padding = Settings.ScalePadding,
		List = Settings.ScaleLists,
		Grid = Settings.ScaleGrids,
		ScrollBar = Settings.ScaleScrollbars
	}),
	ComputeScale = function() --[[ ComputeScale | Line: 93 | Upvalues: ScreenResolution (copy), v2 (ref) ]]
		return 1 - (1 - ScreenResolution.GetScale()) * v2.ResolutionRatioMultiplier
	end,
	ApplyScaling = function(p1, p2) --[[ ApplyScaling | Line: 96 | Upvalues: FFlags (copy), v2 (ref) ]]
		debug.profilebegin("InterfaceScaling :: ApplyScaling")

		if not FFlags.Get(FFlags.Keys.InterfaceScaling) then
			debug.profileend()

			return
		end

		v2.UIOffsetScaler(p1, v2.ComputeScale(), p2)
		debug.profileend()
	end,
	TrackRichText = function(p1) --[[ TrackRichText | Line: 103 | Upvalues: t2 (copy), v2 (ref) ]]
		if not t2[p1] and p1:IsA("TextLabel") then
			t2[p1] = true
			p1.Destroying:Connect(function() --[[ Line: 109 | Upvalues: t2 (ref), p1 (copy) ]]
				t2[p1] = nil
			end)
			p1:GetAttributeChangedSignal("Text"):Connect(function() --[[ Line: 113 | Upvalues: v2 (ref), p1 (copy) ]]
				v2.ApplyScaling(p1)
			end)
		end
	end,
	Track = function(p1) --[[ Track | Line: 117 | Upvalues: t (copy), v2 (ref), Settings (copy), v6 (copy) ]]
		debug.profilebegin("InterfaceScaling :: Track")

		if t[p1] or not p1.Parent then
			debug.profileend()

			return
		end

		t[p1] = true
		p1.Destroying:Connect(function() --[[ Line: 125 | Upvalues: t (ref), p1 (copy) ]]
			t[p1] = nil
		end)
		v2.ApplyScaling(p1)

		if Settings.ScaleRichText and p1:IsA("TextLabel") then
			v2.TrackRichText(p1)
		end

		v6:QueueDescendantsAdded(p1, false)
		p1.DescendantAdded:Connect(function(p1) --[[ Line: 137 | Upvalues: v6 (ref) ]]
			v6:QueueAdded(p1)
		end)
		debug.profileend()
	end,
	ApplyScalingAll = function() --[[ ApplyScalingAll | Line: 143 | Upvalues: t (copy), v2 (ref) ]]
		debug.profilebegin("InterfaceScaling :: ApplyScalingAll")

		for v1 in t do
			v2.ApplyScaling(v1)
		end

		debug.profileend()
	end,
	WorldRootTrack = function(...) --[[ WorldRootTrack | Line: 150 | Upvalues: v7 (copy), v4 (ref), v2 (ref) ]]
		debug.profilebegin("InterfaceScaling :: WorldRootTrack")

		for i, v in ipairs(table.pack(...)) do
			v7:QueueDescendantsAdded(v, false)
			v.DescendantAdded:Connect(function(p1) --[[ Line: 155 | Upvalues: v4 (ref), v2 (ref) ]]
				if not v4(p1) then
					return
				end

				v2.Track(p1)
			end)
		end

		debug.profileend()
	end,
	DeepCheckScreenGui = function(p1) --[[ DeepCheckScreenGui | Line: 163 | Upvalues: v5 (ref) ]]
		v5(p1)
	end
}
v5 = function(p1) --[[ Line: 168 | Upvalues: v5 (ref), v2 (ref) ]]
	debug.profilebegin("InterfaceScaling :: DeepCheckScreenGui")

	if p1:IsA("Folder") then
		for i, v in ipairs(p1:GetChildren()) do
			v5(v)
		end
	elseif p1:IsA("ScreenGui") and not table.find(v2.ScreenGuiIgnoreList, p1.Name) then
		v2.Track(p1)
	end

	debug.profileend()
end
task.spawn(function() --[[ Line: 185 | Upvalues: Players (copy), v2 (ref) ]]
	local PlayerGui = Players.LocalPlayer.PlayerGui

	for i, v in ipairs(PlayerGui:GetChildren()) do
		v2.DeepCheckScreenGui(v)
	end

	PlayerGui.ChildAdded:Connect(function(p1) --[[ Line: 190 | Upvalues: v2 (ref) ]]
		v2.DeepCheckScreenGui(p1)
	end)
end)
ScreenResolution.Changed:Connect(function() --[[ Line: 195 | Upvalues: v1 (ref) ]]
	v1 = true
end)
RunService.RenderStepped:Connect(function() --[[ Line: 199 | Upvalues: v1 (ref), v2 (ref) ]]
	if v1 then
		v1 = false
		v2.ApplyScalingAll()
	end
end)

return v2