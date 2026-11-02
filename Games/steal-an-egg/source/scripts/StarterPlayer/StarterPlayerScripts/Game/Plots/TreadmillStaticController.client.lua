-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Library.Audio)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local BaseUpgradeTransitionLifecycle = require(ReplicatedStorage.Library.Client.BaseUpgradeTransitionLifecycle)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Easing = require(ReplicatedStorage.Library.Functions.Easing)
local Emit = require(ReplicatedStorage.Library.Functions.Emit)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local LocalPlotUpgradeVisibility = require(ReplicatedStorage.Library.Client.LocalPlotUpgradeVisibility)
local Lock = require(ReplicatedStorage.Library.Functions.Lock)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local PlotCmds = require(ReplicatedStorage.Library.Client.PlotCmds)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local RuntimeInstanceRegistry = require(ReplicatedStorage.Library.Modules.RuntimeInstanceRegistry)
local Save = require(ReplicatedStorage.Library.Client.Save)
local TreadmillStaticCover = require(ReplicatedStorage.Library.Client.UI.TreadmillStaticCover)
local Render = require(script.Render)

require(script.Types.Interface)

local TreadmillVideoController = require(ReplicatedStorage.Library.Client.TreadmillVideoController)
local PreloadAssets = require(ReplicatedStorage.Library.Functions.PreloadAssets)
local LocalPlayer = Players.LocalPlayer
local v1 = Log.new()
local Treadmills = Constants.NETWORK_MAP.Treadmills
local TreadmillUpgrade = ReplicatedStorage.Assets.Particles.TreadmillUpgrade
local __ClientTreadmillRenders = Instance.new("Folder")

__ClientTreadmillRenders.Name = "__ClientTreadmillRenders"
__ClientTreadmillRenders.Parent = Workspace
task.spawn(PreloadAssets, TreadmillUpgrade)

local v2 = nil
local t = {}
local v3 = false
local v4 = Lock()
local v5 = false
local v6 = 0
local v7 = true
local v8 = 0
local v9 = 0
local v10 = false
local v11 = false
local v12 = false
local t2 = {}
local t3 = {}
local t4 = {}

local function destroyRender(p1) --[[ destroyRender | Line: 80 | Upvalues: t3 (copy), LocalPlayer (copy), RuntimeInstanceRegistry (copy) ]]
	local v1 = t3[p1]

	if v1 == nil then
		return
	end

	t3[p1] = nil

	if v1.OwnerUserId == LocalPlayer.UserId then
		RuntimeInstanceRegistry.Clear("TreadmillPlotRender", (tostring(p1)))

		if RuntimeInstanceRegistry.Get("Treadmill", v1.TreadmillId) == v1.Model then
			RuntimeInstanceRegistry.Clear("Treadmill", v1.TreadmillId)
		end
	end

	if v1.Cover ~= nil then
		v1.Cover:Destroy()
	end

	v1.Model:Destroy()
end

local function resolveLocalRender() --[[ resolveLocalRender | Line: 98 | Upvalues: PlotCmds (copy), t3 (copy) ]]
	local v1 = PlotCmds.GetMySlot()

	if v1 == nil then
		return nil
	end

	return t3[v1]
end

local function animateScale(p1, p2, p3, p4, p5) --[[ animateScale | Line: 103 | Upvalues: RenderStepped (copy), Easing (copy), Render (copy) ]]
	RenderStepped(function(p12, p22) --[[ Line: 110 | Upvalues: p1 (copy), Easing (ref), p5 (copy), Render (ref), p2 (copy), p3 (copy) ]]
		if p1.Model.Parent == nil then
			return true
		end

		Render.SetGroundedScale(p1, p2 + (p3 - p2) * Easing(p22, p5, Enum.EasingDirection.Out))

		return false
	end, p4, true):Wait()

	if p1.Model.Parent == nil then
		return
	end

	Render.SetGroundedScale(p1, p3)
end

local function runLocalUpgradeAnimation(p1, p2) --[[ runLocalUpgradeAnimation | Line: 124 | Upvalues: TweenService (copy), TreadmillUpgrade (copy), Emit (copy), Audio (copy), Message (copy), animateScale (copy) ]]
	local Root = p1.Model.Root
	local v1 = Root:IsA("BasePart")

	assert(v1, (("Treadmill \"%*\" Root must be a BasePart"):format(p1.TreadmillId)))

	local Highlight = Instance.new("Highlight")

	Highlight.Adornee = p1.Model
	Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	Highlight.FillColor = Color3.new(255/255, 255/255, 255/255)
	Highlight.FillTransparency = 1
	Highlight.OutlineColor = Color3.new(255/255, 255/255, 255/255)
	Highlight.OutlineTransparency = 1
	Highlight.Parent = p1.Model

	local v3 = TweenService:Create(Highlight, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		FillTransparency = 0.15,
		OutlineTransparency = 0
	})
	local v4 = TweenService:Create(Highlight, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		FillTransparency = 1,
		OutlineTransparency = 1
	})

	v3.Completed:Once(function() --[[ Line: 145 | Upvalues: v4 (copy) ]]
		v4:Play()
	end)
	v4.Completed:Once(function() --[[ Line: 148 | Upvalues: Highlight (copy) ]]
		Highlight:Destroy()
	end)
	v3:Play()
	Emit(Root, nil, TreadmillUpgrade:Clone():GetChildren())
	Audio.Play(130233661094961, script, { 0.9, 1.1 }, 1.5)
	Message.Bottom({
		Message = "Successfully upgraded your treadmill!",
		Time = 0.7,
		Color = Color3.fromRGB(0, 255, 47)
	})
	animateScale(p1, p2 * 0.8, p2, 0.55, Enum.EasingStyle.Elastic)
end

local function replaceRender(p1, p2, p3, p4) --[[ replaceRender | Line: 170 | Upvalues: t4 (copy), t3 (copy), animateScale (copy), destroyRender (copy), Render (copy), LocalPlayer (copy), __ClientTreadmillRenders (copy), RuntimeInstanceRegistry (copy), v2 (ref), TreadmillStaticCover (copy), runLocalUpgradeAnimation (copy) ]]
	local v1 = (t4[p1] or 0) + 1

	t4[p1] = v1

	local v22 = t3[p1]

	if p4 and v22 ~= nil then
		local v3 = v22.Model:GetScale()

		animateScale(v22, v3, v3 * 0.8, 0.22, Enum.EasingStyle.Quad)

		if t4[p1] ~= v1 then
			return
		end
	end

	destroyRender(p1)

	local v5, v6, v7, v8

	if p2 == LocalPlayer.UserId then
		v5 = p1
		v6 = p2
		v7 = p3
		v8 = true
	else
		v5 = p1
		v6 = p2
		v7 = p3
		v8 = false
	end

	local v9 = Render.Build(v5, v6, v7, if p4 then 0.8 else 1, v8, __ClientTreadmillRenders)

	t3[p1] = v9

	if p2 == LocalPlayer.UserId then
		RuntimeInstanceRegistry.Set("TreadmillPlotRender", tostring(p1), v9.Model)
		v9.RateSign.Enabled = v2 == nil

		local Cover = v9.Cover

		if Cover ~= nil then
			TreadmillStaticCover.SetEnabled(Cover, v2 == nil)
		end

		if v2 ~= nil then
			RuntimeInstanceRegistry.Set("Treadmill", v9.TreadmillId, v9.Model)
		end
	end

	if not p4 then
		return
	end

	runLocalUpgradeAnimation(v9, v9.Model:GetScale() / 0.8)
end

local function refreshSlot(p1, p2, p3) --[[ refreshSlot | Line: 213 | Upvalues: t4 (copy), destroyRender (copy), LocalPlayer (copy), t (copy), Players (copy), Save (copy), PlotCmds (copy), v12 (ref), v6 (ref), BaseUpgradeTransitionLifecycle (copy), replaceRender (copy) ]]
	if p2 == nil then
		t4[p1] = (t4[p1] or 0) + 1
		destroyRender(p1)

		return
	end

	if p2 ~= LocalPlayer.UserId and t[p2] ~= true then
		t4[p1] = (t4[p1] or 0) + 1
		destroyRender(p1)

		return
	end

	local v1 = Players:GetPlayerByUserId(p2)

	if v1 == nil then
		return
	end

	local v2 = Save.Get(v1)

	if v2 == nil or PlotCmds.GetSlotOwner(p1) ~= p2 then
		return
	end

	if v2.BaseUpgradeLevel == 0 then
		destroyRender(p1)

		return
	end

	if p2 == LocalPlayer.UserId and (v12 or v6 == 0 and BaseUpgradeTransitionLifecycle.IsPlaying()) then
		v12 = true
		destroyRender(p1)
	else
		replaceRender(p1, p2, v2, p3)
	end
end

local function refreshPlayerRender(p1, p2) --[[ refreshPlayerRender | Line: 250 | Upvalues: PlotCmds (copy), refreshSlot (copy) ]]
	for k, v in pairs(PlotCmds.GetState()) do
		if v == p1.UserId then
			refreshSlot(k, v, p2)

			return
		end
	end
end

local function applyRemoteSessionTransition(p1, p2, p3) --[[ applyRemoteSessionTransition | Line: 259 | Upvalues: v8 (ref), LocalPlayer (copy), t (copy), refreshPlayerRender (copy) ]]
	if p3 <= v8 then
		return
	end

	v8 = p3

	if p1 == LocalPlayer then
		return
	end

	if p2 then
		t[p1.UserId] = true
	else
		t[p1.UserId] = nil
	end

	refreshPlayerRender(p1, false)
end

local function synchronizeRemoteSessionSnapshot() --[[ synchronizeRemoteSessionSnapshot | Line: 275 | Upvalues: Network (copy), Treadmills (copy), Asserts (copy), t (copy), LocalPlayer (copy), v8 (ref), t2 (copy), v7 (ref), refreshPlayerRender (copy) ]]
	local v1, v2 = Network.Invoke(Treadmills.REQUEST_ACTIVE_RENDER_SNAPSHOT)

	Asserts.array.uniqueInteger(v1)
	Asserts.number(v2)
	table.clear(t)

	for i, v in ipairs(v1) do
		if v ~= LocalPlayer.UserId then
			t[v] = true
		end
	end

	v8 = v2
	table.sort(t2, function(p1, p2) --[[ Line: 286 ]]
		return p1.Revision < p2.Revision
	end)
	v7 = false

	for i, v in ipairs(t2) do
		local Player = v.Player
		local Active = v.Active
		local Revision = v.Revision

		if not (Revision <= v8) then
			v8 = Revision

			if Player ~= LocalPlayer then
				if Active then
					t[Player.UserId] = true
				else
					t[Player.UserId] = nil
				end

				refreshPlayerRender(Player, false)
			end
		end
	end

	table.clear(t2)
end

local function refreshLocalRender(p1) --[[ refreshLocalRender | Line: 296 | Upvalues: v5 (ref), refreshPlayerRender (copy), LocalPlayer (copy) ]]
	v5 = true
	refreshPlayerRender(LocalPlayer, p1)
	v5 = false
end

local function consumePendingUpgradeRefresh() --[[ consumePendingUpgradeRefresh | Line: 302 | Upvalues: v3 (ref), v10 (ref), v2 (ref), v11 (ref), v5 (ref), refreshPlayerRender (copy), LocalPlayer (copy), v9 (ref), Workspace (copy) ]]
	if v3 and (v10 and v2 == nil) then
		local v1 = v11

		v3 = false
		v10 = false
		v11 = false
		v5 = true
		refreshPlayerRender(LocalPlayer, v1)
		v5 = false
		v9 = Workspace:GetServerTimeNow() + 1.25
	end
end

local function refreshPlotUpgradeVisibility() --[[ refreshPlotUpgradeVisibility | Line: 314 | Upvalues: LocalPlotUpgradeVisibility (copy), v6 (ref) ]]
	LocalPlotUpgradeVisibility.Refresh("TreadmillUpgrade", v6 > 0)
end

local function revealFirstExpansionTreadmill() --[[ revealFirstExpansionTreadmill | Line: 318 | Upvalues: Save (copy), v6 (ref), v12 (ref), LocalPlotUpgradeVisibility (copy), v5 (ref), refreshPlayerRender (copy), LocalPlayer (copy), v9 (ref), Workspace (copy) ]]
	local v1 = Save.Get()

	assert(v1 ~= nil, "First expansion treadmill reveal requires local save data")

	if v1.BaseUpgradeLevel == 0 then
		return
	end

	v6 = v1.BaseUpgradeLevel
	v12 = false
	LocalPlotUpgradeVisibility.Refresh("TreadmillUpgrade", v6 > 0)
	v5 = true
	refreshPlayerRender(LocalPlayer, true)
	v5 = false
	v9 = Workspace:GetServerTimeNow() + 1.25
end

local function tryEnterStaticTreadmill() --[[ tryEnterStaticTreadmill | Line: 332 | Upvalues: PlotCmds (copy), t3 (copy), v2 (ref), v3 (ref), v5 (ref), Workspace (copy), v9 (ref), LocalPlayer (copy), v4 (copy), RuntimeInstanceRegistry (copy), Network (copy), Treadmills (copy), v1 (copy) ]]
	local v12 = PlotCmds.GetMySlot()
	local v22 = if v12 == nil then nil else t3[v12]

	if v2 ~= nil or (v3 or (v5 or v22 == nil)) then
		return
	end

	local v32 = Workspace:GetServerTimeNow()

	if v32 < v9 then
		return
	end

	local Character = LocalPlayer.Character
	local v42 = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")

	if v42 == nil or not v42:IsA("BasePart") then
		return
	end

	local v52 = RaycastParams.new()

	v52.FilterType = Enum.RaycastFilterType.Include
	v52.FilterDescendantsInstances = { v22.Model, v22.Bottom }

	if Workspace:Raycast(v42.Position, Vector3.new(0, -8, 0), v52) ~= nil then
		v9 = v32 + 1.25
		v4(function() --[[ Line: 354 | Upvalues: RuntimeInstanceRegistry (ref), v22 (copy), Network (ref), Treadmills (ref), v1 (ref) ]]
			RuntimeInstanceRegistry.Set("Treadmill", v22.TreadmillId, v22.Model)

			local v12, v2 = Network.Invoke(Treadmills.REQUEST_EQUIP_STATIC)

			if v12 == true then
				return
			end

			RuntimeInstanceRegistry.Clear("Treadmill", v22.TreadmillId)
			v1:AtWarning():Log((("Static treadmill entry rejected: %*"):format(v2)))
		end)
	end
end

if not Save.IsLocalDataLoaded() then
	Save.LoadedStats:Wait()
end

local v13 = Save.Get()

assert(if v13 == nil then false else true, "Static treadmill controller requires local save data")

local TreadmillUpgradeLevel = v13.TreadmillUpgradeLevel

v6 = v13.BaseUpgradeLevel
Network.Fired(Treadmills.ACTIVE_RENDER_STATE_EVENT):Connect(function(p1, p2, p3) --[[ Line: 375 | Upvalues: Asserts (copy), v7 (ref), t2 (copy), v8 (ref), LocalPlayer (copy), t (copy), refreshPlayerRender (copy) ]]
	Asserts.Player(p1)
	Asserts.boolean(p2)
	Asserts.number(p3)

	if v7 then
		table.insert(t2, {
			Active = p2,
			Player = p1,
			Revision = p3
		})

		return
	end

	if p3 <= v8 then
		return
	end

	v8 = p3

	if p1 == LocalPlayer then
		return
	end

	if p2 then
		t[p1.UserId] = true
	else
		t[p1.UserId] = nil
	end

	refreshPlayerRender(p1, false)
end)
synchronizeRemoteSessionSnapshot()

for k, v in pairs(PlotCmds.GetState()) do
	task.spawn(refreshSlot, k, v, false)
end

local v16 = if v6 > 0 then true else false

LocalPlotUpgradeVisibility.Refresh("TreadmillUpgrade", v16)
PlotCmds.OnAnyPlotUpdated:Connect(function(p1, p2) --[[ Line: 395 | Upvalues: LocalPlotUpgradeVisibility (copy), v6 (ref), refreshSlot (copy) ]]
	LocalPlotUpgradeVisibility.Refresh("TreadmillUpgrade", if v6 > 0 then true else false)
	task.spawn(refreshSlot, p1, p2, false)
end)
PlotCmds.OnPlotsFolderUpdated:Connect(function() --[[ Line: 399 | Upvalues: LocalPlotUpgradeVisibility (copy), v6 (ref), PlotCmds (copy), refreshSlot (copy) ]]
	LocalPlotUpgradeVisibility.Refresh("TreadmillUpgrade", v6 > 0)

	for k, v in pairs(PlotCmds.GetState()) do
		task.spawn(refreshSlot, k, v, false)
	end
end)
Players.PlayerAdded:Connect(function(p1) --[[ Line: 405 | Upvalues: refreshPlayerRender (copy) ]]
	task.spawn(refreshPlayerRender, p1, false)
end)
Players.PlayerRemoving:Connect(function(p1) --[[ Line: 408 | Upvalues: t (copy), t3 (copy), t4 (copy), destroyRender (copy) ]]
	t[p1.UserId] = nil

	for k, v in pairs(t3) do
		if v and v.OwnerUserId == p1.UserId then
			t4[k] = (t4[k] or 0) + 1
			destroyRender(k)
		end
	end
end)
Save.LoadedOtherStats:Connect(function(p1) --[[ Line: 417 | Upvalues: refreshPlayerRender (copy) ]]
	refreshPlayerRender(p1, false)
end)
Save.OtherStatChanged:Connect(function(p1, p2) --[[ Line: 420 | Upvalues: refreshPlayerRender (copy), Save (copy), t3 (copy), TreadmillStaticCover (copy) ]]
	if p2 == "TreadmillUpgradeLevel" then
		refreshPlayerRender(p1, false)

		return
	end

	if p2 ~= "TreadmillMediaFeedState" then
		return
	end

	local v1 = Save.Get(p1, false)

	if v1 == nil then
		return
	end

	for k, v in pairs(t3) do
		if v and (v.OwnerUserId == p1.UserId and v.Cover ~= nil) then
			TreadmillStaticCover.ApplyFeed(v.Cover, v1.TreadmillMediaFeedState)
		end
	end
end)
Save.GetStatChangedSignal("TreadmillUpgradeLevel"):Connect(function() --[[ Line: 434 | Upvalues: Save (copy), TreadmillUpgradeLevel (ref), LocalPlotUpgradeVisibility (copy), v6 (ref), v2 (ref), v3 (ref), v10 (ref), v11 (ref), v5 (ref), refreshPlayerRender (copy), LocalPlayer (copy), v9 (ref), Workspace (copy) ]]
	local v1 = Save.Get()

	assert(v1 ~= nil, "Local treadmill upgrade requires save data")

	local v32 = TreadmillUpgradeLevel < v1.TreadmillUpgradeLevel

	TreadmillUpgradeLevel = v1.TreadmillUpgradeLevel
	LocalPlotUpgradeVisibility.Refresh("TreadmillUpgrade", if v6 > 0 then true else false)

	if v2 == nil and not v3 then
		v5 = true
		refreshPlayerRender(LocalPlayer, v32)
		v5 = false

		return
	end

	v10 = true
	v11 = v11 or v32

	if not (v3 and v10) then
		return
	end

	if v2 ~= nil then
		return
	end

	local v62 = v11

	v3 = false
	v10 = false
	v11 = false
	v5 = true
	refreshPlayerRender(LocalPlayer, v62)
	v5 = false
	v9 = Workspace:GetServerTimeNow() + 1.25
end)
Save.GetStatChangedSignal("BaseUpgradeLevel"):Connect(function() --[[ Line: 448 | Upvalues: Save (copy), v6 (ref), LocalPlotUpgradeVisibility (copy), BaseUpgradeTransitionLifecycle (copy), v12 (ref), v5 (ref), refreshPlayerRender (copy), LocalPlayer (copy), v9 (ref), Workspace (copy) ]]
	local v1 = Save.Get()

	assert(v1 ~= nil, "Local base upgrade requires save data")

	local v3 = if v6 == 0 then if v1.BaseUpgradeLevel > 0 then true else false else false

	v6 = v1.BaseUpgradeLevel

	if v3 then
		if BaseUpgradeTransitionLifecycle.IsPlaying() then
			v6 = 0
			v12 = true
			LocalPlotUpgradeVisibility.Refresh("TreadmillUpgrade", v6 > 0)
		else
			local v62 = Save.Get()

			assert(v62 ~= nil, "First expansion treadmill reveal requires local save data")

			if v62.BaseUpgradeLevel == 0 then
				return
			end

			v6 = v62.BaseUpgradeLevel
			v12 = false
			LocalPlotUpgradeVisibility.Refresh("TreadmillUpgrade", v6 > 0)
			v5 = true
			refreshPlayerRender(LocalPlayer, true)
			v5 = false
			v9 = Workspace:GetServerTimeNow() + 1.25
		end
	else
		LocalPlotUpgradeVisibility.Refresh("TreadmillUpgrade", v6 > 0)
	end
end)
BaseUpgradeTransitionLifecycle.Completed:Connect(function() --[[ Line: 466 | Upvalues: v12 (ref), Save (copy), v6 (ref), LocalPlotUpgradeVisibility (copy), v5 (ref), refreshPlayerRender (copy), LocalPlayer (copy), v9 (ref), Workspace (copy) ]]
	if not v12 then
		return
	end

	local v1 = Save.Get()

	assert(v1 ~= nil, "First expansion treadmill reveal requires local save data")

	if v1.BaseUpgradeLevel == 0 then
		return
	end

	v6 = v1.BaseUpgradeLevel
	v12 = false
	LocalPlotUpgradeVisibility.Refresh("TreadmillUpgrade", v6 > 0)
	v5 = true
	refreshPlayerRender(LocalPlayer, true)
	v5 = false
	v9 = Workspace:GetServerTimeNow() + 1.25
end)
Network.Fired(Treadmills.ACTIVE_TREADMILL_EVENT):Connect(function(p1, p2, p3, p4, p5) --[[ Line: 472 | Upvalues: v2 (ref), PlotCmds (copy), t3 (copy), RuntimeInstanceRegistry (copy), v9 (ref), Workspace (copy), v3 (ref), v10 (ref), v11 (ref), v5 (ref), refreshPlayerRender (copy), LocalPlayer (copy), TreadmillStaticCover (copy) ]]
	v2 = p1

	if p1 == nil then
		RuntimeInstanceRegistry.Clear("Treadmill")
		v9 = Workspace:GetServerTimeNow() + 1.25

		if p5 == true then
			v3 = true

			if v3 and (v10 and p1 == nil) then
				local v1 = v11

				v3 = false
				v10 = false
				v11 = false
				v5 = true
				refreshPlayerRender(LocalPlayer, v1)
				v5 = false
				v9 = Workspace:GetServerTimeNow() + 1.25
			end
		end
	else
		local v22 = PlotCmds.GetMySlot()
		local v32 = if v22 == nil then nil else t3[v22]
		local v4 = if v32 == nil then false elseif v32.TreadmillId == p1 then true else false

		assert(v4, (("Missing active treadmill render \"%*\""):format(p1)))
		RuntimeInstanceRegistry.Set("Treadmill", p1, v32.Model)
	end

	local v6 = PlotCmds.GetMySlot()
	local v7 = if v6 == nil then nil else t3[v6]

	if v7 == nil then
		return
	end

	v7.RateSign.Enabled = p1 == nil

	local Cover = v7.Cover

	if Cover == nil then
		return
	end

	TreadmillStaticCover.SetEnabled(Cover, p1 == nil)
end)
TreadmillVideoController.MediaChanged:Connect(function(p1) --[[ Line: 505 | Upvalues: PlotCmds (copy), t3 (copy), TreadmillStaticCover (copy) ]]
	local v1 = PlotCmds.GetMySlot()
	local v2 = if v1 == nil then nil else t3[v1]

	if v2 == nil then
		return
	end

	local Cover = v2.Cover

	if Cover == nil then
		return
	end

	TreadmillStaticCover.ApplyMedia(Cover, p1)
end)
RunService.Heartbeat:Connect(tryEnterStaticTreadmill)