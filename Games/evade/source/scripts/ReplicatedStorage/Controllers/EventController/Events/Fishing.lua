---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
game:GetService("TweenService")
game:GetService("RunService")
game:GetService("Lighting")
local v3 = game:GetService("Players")
game:GetService("Debris")
require(v1.Shared.EventTypes)
local v4 = {}
require(v1.Controllers.EncryptedAssetsController)
local v_u_5 = require(v1.Controllers.InterfaceController)
require(v1.Controllers.AnimalController)
local v_u_6 = require(v1.Controllers.EffectController)
require(v1.Controllers.CameraController)
local v_u_7 = require(v1.Controllers.SoundController)
local v_u_8 = require(v1.Controllers.EventController)
local v_u_9 = require(v1.Controllers.CycleController)
require(v1.Shared.SharedEventUtils)
require(v1.Packages.CreateTween)
local v_u_10 = require(v1.Shared.TweenPivot)
local v_u_11 = require(v1.Packages.Observers)
local v_u_12 = require(v1.Datas.Mutations)
local v_u_13 = require(v1.Shared.Mutations)
require(v1.Utils.MathUtils)
require(v1.Packages.Signal)
require(v1.Packages.Spring)
local v14 = require(v1.Packages.Trove)
require(v1.Packages.Shake)
require(v1.Packages.Net)
local v_u_15 = require(v1.Packages.Spr)
require(v1.Shared.VFX)
local _ = v3.LocalPlayer
local _ = workspace.CurrentCamera
local v_u_16 = script.Name
local v_u_17 = v14.new()
function v4.OnStart(_)
	-- upvalues: (copy) v_u_8, (copy) v_u_16, (copy) v_u_17, (copy) v_u_6, (copy) v_u_9, (copy) v_u_7, (copy) v_u_10, (copy) v_u_11, (copy) v_u_5, (copy) v_u_13, (copy) v_u_12, (copy) v_u_15
	local v18 = v_u_8:GetActiveEventData(v_u_16)
	assert(v18)
	v_u_17:Add(function()
		-- upvalues: (ref) v_u_6, (ref) v_u_9, (ref) v_u_7
		v_u_6:Activate("Blink")
		v_u_9:Update()
		v_u_7:UpdateOST()
	end)
	local v_u_19 = v_u_17:Clone(script.FishingMap)
	v_u_19.Parent = workspace
	v_u_6:Activate("Blink")
	v_u_9:Update()
	v_u_7:UpdateOST()
	local v20 = v_u_19.Flood:GetPivot()
	v_u_19.Flood:PivotTo(v20 - Vector3.new(0, 3, 0))
	v_u_17:Add(v_u_10(v_u_19.Flood, TweenInfo.new(v18.startedAt + 3 - workspace:GetServerTimeNow(), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), v20)):Play()
	v_u_17:Add(v_u_11.observeTag("FishermanPrompt", function(p21)
		-- upvalues: (ref) v_u_5
		local v_u_22 = p21.Triggered:Connect(function()
			-- upvalues: (ref) v_u_5
			v_u_5:Toggle("RodsShop")
		end)
		return function()
			-- upvalues: (copy) v_u_22
			v_u_22:Disconnect()
		end
	end))
	local function v34()
		-- upvalues: (ref) v_u_13, (ref) v_u_12, (ref) v_u_15, (copy) v_u_19
		local v23 = v_u_13.get()
		if v23 then
			local v24 = v_u_12[v23]
			v_u_15.target(v_u_19.Flood.TopWater["Water.001"], 1, 4, {
				["Color"] = v24.MainColor
			})
			local v25 = v_u_15.target
			local v26 = v_u_19.Flood.Water["Water.001"]
			local v27 = {}
			local v28 = v24.MainColor
			local v29 = math.clamp(0.5, 0, 1)
			local v30, v31, v32 = v28:ToHSV()
			local v33 = v32 * v29
			v27.Color = Color3.fromHSV(v30, v31, v33)
			v25(v26, 1, 4, v27)
		else
			v_u_15.target(v_u_19.Flood.TopWater["Water.001"], 1, 4, {
				["Color"] = Color3.fromRGB(73, 161, 255)
			})
			v_u_15.target(v_u_19.Flood.Water["Water.001"], 1, 4, {
				["Color"] = Color3.fromRGB(0, 103, 172)
			})
		end
	end
	v_u_17:Add(v_u_13.watch(v34))
	v34()
end
function v4.OnStop(_)
	-- upvalues: (copy) v_u_17
	v_u_17:Destroy()
end
function v4.OnLoad(_)
	-- upvalues: (copy) v_u_2
	task.spawn(pcall, function()
		-- upvalues: (ref) v_u_2
		v_u_2:PreloadAsync(script:GetChildren())
	end)
end
return v4
