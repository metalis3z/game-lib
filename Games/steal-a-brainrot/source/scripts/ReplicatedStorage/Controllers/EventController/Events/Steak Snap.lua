--  █████╗ ███╗   ██╗ ██████╗ ███████╗██╗     ██╗   ██╗███████╗    ██████╗ ███████╗ ██████╗  ██████╗ ███╗   ███╗██████╗ ██╗██╗     ███████╗███████╗
-- ██╔══██╗████╗  ██║██╔════╝ ██╔════╝██║     ██║   ██║██╔════╝    ██╔══██╗██╔════╝██╔════╝ ██╔═══██╗████╗ ████║██╔══██╗██║██║     ██╔════╝██╔════╝
-- ███████║██╔██╗ ██║██║  ███╗█████╗  ██║     ██║   ██║███████╗    ██║  ██║█████╗  ██║      ██║   ██║██╔████╔██║██████╔╝██║██║     █████╗  ███████╗
-- ██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██║     ██║   ██║╚════██║    ██║  ██║██╔══╝  ██║      ██║   ██║██║╚██╔╝██║██╔═══╝ ██║██║     ██╔══╝  ╚════██║
-- ██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗╚██████╔╝███████║    ██████╔╝███████╗╚██████╗ ╚██████╔╝██║ ╚═╝ ██║██║     ██║███████╗███████╗███████║
-- ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝ ╚═════╝ ╚══════╝    ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

-- @ Angelus Decompiles — @Chlorls & @imoRR
-- @ Discord : discord.gg/nDWm6PkFrT
-- @ Decompiled

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
require(ReplicatedStorage.Shared.EventTypes)
local t = {}
local SkullEmojiEffectController = require(ReplicatedStorage.Controllers.SkullEmojiEffectController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local ShakePresets = require(ReplicatedStorage.Shared.ShakePresets)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove = require(ReplicatedStorage.Packages.Trove)
local ViewportWindow = require(script.ViewportWindow)
local v1 = script.Name
local v2 = Trove.new()
local v3 = Trove.new()
local function spawnGroundCrack(p1) --[[ spawnGroundCrack | Line: 50 | Upvalues: v3 (copy), Players (copy), ViewportWindow (copy), HttpService (copy), RunService (copy) ]]
	v3:Clean()
	local v1 = v3:Add(Instance.new("Part"))
	v1.Anchored = true
	v1.CanCollide = false
	v1.CanQuery = false
	v1.CanTouch = false
	v1.Transparency = 1
	v1.Size = Vector3.new(40, 0.01, 40)
	v1.CFrame = p1
	v1.Parent = workspace
	local SurfaceGui = v3:Add(Instance.new("SurfaceGui"))
	SurfaceGui.Name = "SurfaceGui"
	SurfaceGui.Active = false
	SurfaceGui.ClipsDescendants = true
	SurfaceGui.Face = Enum.NormalId.Top
	SurfaceGui.LightInfluence = 1
	SurfaceGui.MaxDistance = 1000
	SurfaceGui.PixelsPerStud = 200
	SurfaceGui.ResetOnSpawn = false
	SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	SurfaceGui.ToolPunchThroughDistance = 0.01
	SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	SurfaceGui.Adornee = v1
	SurfaceGui.Parent = Players.LocalPlayer.PlayerGui
	local v2 = ViewportWindow.bindToSurfaceGui(SurfaceGui)
	v2.viewportFrame.LightColor = Color3.new(0/255, 0/255, 0/255)
	local v32 = v3:Clone(script.Objects)
	v32.Parent = v2.viewportFrame
	local v4 = ("SteakCrackPortal_%*"):format((HttpService:GenerateGUID(false)))
	RunService:BindToRenderStep(v4, Enum.RenderPriority.Character.Value, function() --[[ Line: 87 | Upvalues: v1 (copy), SurfaceGui (copy), v32 (copy), ViewportWindow (ref), v2 (copy) ]]
		if v1.Parent and SurfaceGui.Parent then
			v32:PivotTo(v1.CFrame)
			ViewportWindow.render(v2)
		end
	end)
	v3:Add(function() --[[ Line: 94 | Upvalues: RunService (ref), v4 (copy) ]]
		RunService:UnbindFromRenderStep(v4)
	end)
	v3:Add(task.delay(300, function() --[[ Line: 99 | Upvalues: v3 (ref) ]]
		v3:Destroy()
	end))
end
function t.OnStart(p1) --[[ OnStart | Line: 104 | Upvalues: EventController (copy), v1 (copy), ShakePresets (copy), v2 (copy), RunService (copy), Observers (copy), spawnGroundCrack (copy), SkullEmojiEffectController (copy), EffectController (copy) ]]
	local v12 = EventController:GetActiveEventData(v1)
	assert(v12)
	local function calculateTimeLeftFor(p1) --[[ calculateTimeLeftFor | Line: 108 | Upvalues: v12 (copy) ]]
		return v12.startedAt + p1 - workspace:GetServerTimeNow()
	end
	local v22 = ShakePresets.BumpS:Clone()
	v22.Amplitude = 0.5
	v22.Sustain = true
	local v3 = v2:Add(ShakePresets.BindShakeToCamera(v22, workspace.CurrentCamera))
	v2:Add(task.delay(1, function() --[[ Line: 119 | Upvalues: v22 (copy) ]]
		v22:Start()
	end))
	v2:Clone(script.Part).Parent = workspace
	local v4 = v2:Clone(script.Steak)
	v4.Parent = workspace
	local v5 = v2:Clone(script.Sound)
	v5.Parent = v4.HumanoidRootPart
	v5:Play()
	local v6 = script.StartCFrame.CFrame
	local v7 = script.EndCFrame.CFrame
	v4:PivotTo(v6)
	v4:ScaleTo(1)
	local Animator = v4.Humanoid.Animator
	local v8 = Animator:LoadAnimation(script.WalkAnimation)
	v8.Looped = true
	v2:Add(v8, "Stop")
	v2:Add(v8)
	v8:Play()
	local v9 = Animator:LoadAnimation(script.SnapAnimation)
	v9.Looped = false
	v2:Add(v9, "Stop")
	v2:Add(v9)
	local v10 = nil
	v10 = RunService.PostSimulation:Connect(function() --[[ Line: 159 | Upvalues: v12 (copy), v4 (copy), v6 (copy), v7 (copy), v22 (copy), v10 (ref) ]]
		local v2 = math.clamp((workspace:GetServerTimeNow() - v12.startedAt) / 5, 0, 1)
		v4:PivotTo(v6:Lerp(v7, v2))
		v4:ScaleTo((math.lerp(1, 6.95, v2)))
		v22.Amplitude = math.lerp(0.5, 3, v2)
		if not (v2 >= 1) then
			return
		end
		v10:Disconnect()
	end)
	v2:Add(v10)
	v2:Add(task.delay(v12.startedAt + 5 - workspace:GetServerTimeNow(), function() --[[ Line: 171 | Upvalues: v8 (copy), v9 (copy) ]]
		v8:Stop()
		v9:Play()
	end))
	local v11 = v2:Add(Observers.observeTag("HideInSteakSnap", function(p1) --[[ Line: 178 ]]
		local v1 = p1.Parent
		p1.Parent = script
		return function() --[[ Line: 181 | Upvalues: p1 (copy), v1 (copy) ]]
			pcall(function() --[[ Line: 182 | Upvalues: p1 (ref), v1 (ref) ]]
				p1.Parent = v1
			end)
		end
	end, { workspace, script }))
	v2:Add(task.delay(v12.startedAt + 6.300000000000001 - workspace:GetServerTimeNow(), function() --[[ Line: 188 | Upvalues: v2 (ref), v3 (copy), ShakePresets (ref), spawnGroundCrack (ref) ]]
		v2:Remove(v3)
		local v1 = ShakePresets.Explosion:Clone()
		v1.Amplitude = 8
		v1.SustainTime = math.max(0, 2.5 - v1.FadeInTime - v1.FadeOutTime)
		ShakePresets.BindShakeToCamera(v1, workspace.CurrentCamera)
		v1:Start()
		spawnGroundCrack(CFrame.new(-410.424, -9.3, -61.83))
	end))
	v2:Add(task.delay(v12.startedAt + 6.3500000000000005 - workspace:GetServerTimeNow(), function() --[[ Line: 203 | Upvalues: SkullEmojiEffectController (ref) ]]
		SkullEmojiEffectController:Play(1, "Lower")
	end))
	v2:Add(task.delay(v12.startedAt + 6.4 - workspace:GetServerTimeNow(), function() --[[ Line: 207 | Upvalues: EffectController (ref), v2 (ref), v4 (copy), v11 (copy) ]]
		EffectController:Activate("Blink")
		v2:Add(task.delay(0.35, function() --[[ Line: 210 | Upvalues: v2 (ref), v4 (ref), v11 (ref) ]]
			v2:Remove(v4)
			v2:Remove(v11)
		end))
	end))
end
function t.OnStop(p1) --[[ OnStop | Line: 217 | Upvalues: v2 (copy) ]]
	v2:Destroy()
end
function t.OnLoad(p1) --[[ OnLoad | Line: 221 | Upvalues: ContentProvider (copy) ]]
	task.spawn(pcall, function() --[[ Line: 222 | Upvalues: ContentProvider (ref) ]]
		ContentProvider:PreloadAsync(script:GetChildren())
	end)
end
return t