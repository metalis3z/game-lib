local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("RunService")
local v_u_2 = game:GetService("Lighting")
game:GetService("Players")
require(v_u_1.Shared.EventTypes)
local v3 = {}
local v_u_4 = require(v_u_1.Controllers.EffectController)
local v_u_5 = require(v_u_1.Controllers.SoundController)
local v_u_6 = require(v_u_1.Controllers.EventController)
local v_u_7 = require(v_u_1.Controllers.CycleController)
local v_u_8 = require(v_u_1.Packages.Observers)
local v9 = require(v_u_1.Packages.Trove)
local v_u_10 = require(v_u_1.Packages.Spr)
local v_u_11 = require(v_u_1.Shared.VFX)
local v_u_12 = script.Name
local v_u_13 = v9.new()
function v3.OnStart(_)
	local v14 = v_u_6:GetActiveEventData(v_u_12)
	assert(v14)
	local v_u_15 = v_u_2:FindFirstChild("Atmosphere")
	if v_u_15 then
		v_u_15.Parent = script
		v_u_13:Add(function()
			v_u_15.Parent = v_u_2
		end)
	end
	v_u_13:Clone(script.AtmosphereRadioactive).Parent = v_u_2
	local v_u_16 = v_u_2:FindFirstChild("Cartoon")
	if v_u_16 then
		v_u_16.Parent = script
		v_u_13:Add(function()
			v_u_16.Parent = v_u_2
		end)
	end
	v_u_13:Clone(script.SkyRadioactive).Parent = v_u_2
	local v_u_17 = true
	v_u_13:Add(function()
		v_u_17 = false
	end)
	v_u_4:Activate("Blink")
	v_u_13:Add(function()
		v_u_4:Activate("Blink")
	end)
	v_u_4:Run("RadioactiveEvent", "GrassRecolor")
	v_u_13:Add(function()
		v_u_4:Stop("RadioactiveEvent", "GrassRecolor")
	end)
	v_u_4:Run("RadioactiveEvent", "WallRecolor")
	v_u_13:Add(function()
		v_u_4:Stop("RadioactiveEvent", "WallRecolor")
	end)
	v_u_4:Run("RadioactiveEvent", "WallBottomRecolor")
	v_u_13:Add(function()
		v_u_4:Stop("RadioactiveEvent", "WallBottomRecolor")
	end)
	local v_u_18 = v_u_13:Clone(script.RadioactiveMap)
	v_u_18.Parent = workspace
	local function v31()
		local v19 = v_u_1:GetAttribute("RadioactiveAlpha") or 0
		local v20 = math.clamp(v19, 0, 1) * 10
		local v21 = math.floor(v20)
		for _, v22 in v_u_18.CaveSign.PowerGui.SurfaceGui.Bar:GetChildren() do
			if v22:IsA("GuiObject") then
				if not v_u_17 then
					break
				end
				local v23 = v22.Name
				local v24 = tonumber(v23)
				if v24 then
					local v25 = v22:FindFirstChild("Visual")
					if v25 then
						local v26 = v25:GetAttribute("DefaultColor")
						if not v26 then
							v26 = v25.BackgroundColor3
							v25:SetAttribute("DefaultColor", v26)
						end
						local v27 = v_u_10.target
						local v28 = 1
						local v29 = 2
						local v30 = {}
						if v21 < v24 then
							v26 = Color3.new(0, 0, 0)
						end
						v30.BackgroundColor3 = v26
						v27(v25, v28, v29, v30)
						task.wait(0.2)
					end
				end
			end
		end
	end
	task.spawn(function()
		for _, v32 in v_u_18.CaveSign.PowerGui.SurfaceGui.Bar:GetChildren() do
			if v32:IsA("GuiObject") then
				if not v32.Visual:GetAttribute("DefaultColor") then
					local v33 = v32.Visual.BackgroundColor3
					v32.Visual:SetAttribute("DefaultColor", v33)
				end
				v32.Visual.BackgroundColor3 = Color3.new(0, 0, 0)
			end
		end
	end)
	v_u_13:Add(v_u_1:GetAttributeChangedSignal("RadioactiveAlpha"):Connect(v31))
	task.spawn(v31)
	local v_u_34 = script.RadioactiveWeather:Clone()
	v_u_34.Parent = workspace
	v_u_13:Add(function()
		v_u_11.disable(v_u_34)
		task.wait(4)
		v_u_34:Destroy()
	end)
	v_u_13:Add(v_u_8.observeTag("HideInRadioactive", function(p_u_35)
		local v_u_36 = p_u_35.Parent
		p_u_35.Parent = script
		return function()
			pcall(function()
				p_u_35.Parent = v_u_36
			end)
		end
	end, { workspace, script }))
	v_u_7:Update()
	v_u_5:UpdateOST()
end
function v3.OnStop(_)
	v_u_13:Destroy()
end
function v3.OnLoad(_) end
return v3