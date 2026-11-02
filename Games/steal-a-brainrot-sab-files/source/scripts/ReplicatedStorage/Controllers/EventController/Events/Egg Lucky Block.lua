local v1 = game:GetService("ReplicatedStorage")
game:GetService("ContentProvider")
game:GetService("SoundService")
game:GetService("TweenService")
game:GetService("HttpService")
game:GetService("RunService")
game:GetService("StarterGui")
local v2 = game:GetService("Players")
require(v1.Packages.Serialization)
local v_u_3 = require(v1.Packages.Synchronizer)
require(v1.Packages.CreateTween)
require(v1.Packages.TopbarPlus)
local v_u_4 = require(v1.Packages.Gradients)
local v_u_5 = require(v1.Packages.Observers)
require(v1.Packages.Moonlite)
require(v1.Packages.Squash)
local v_u_6 = require(v1.Packages.FFlags)
require(v1.Packages.Timer)
local v_u_7 = require(v1.Packages.Trove)
local v_u_8 = require(v1.Packages.Spr)
local v_u_9 = require(v1.Packages.Net)
require(v1.Controllers.NotificationController)

local v_u_10 = require(v1.Controllers.InterfaceController)
require(v1.Controllers.CharacterController)
require(v1.Controllers.SoundController)
require(v1.Controllers.PlotController)
local v_u_11 = require(v1.Utils.NumberUtils)
require(v1.Utils.TimeUtils)
require(v1.Shared.VFX)
local v_u_12 = require(v1.Classes.AnimatedButton)
require(v1.Shared.Updates)
require(v1.Shared.Animals)
local v_u_13 = require(v1.Shared.Animals)
require(v1.Shared.Index)
require(v1.Datas.Mutations)
local v_u_14 = require(v1.Datas.Rarities)
local v_u_15 = require(v1.Datas.Animals)
local v_u_16 = v2.LocalPlayer
local v_u_17 = v_u_16.PlayerGui
local v_u_18 = script.Name
require(v1.Shared.EventTypes)

local v40 = {
	["Setup"] = function(_)

		local v_u_19 = v_u_17:WaitForChild("EggLuckyBlock").Frame
		local v20 = v_u_19.Spawn
		local v21 = v_u_19.Header.Close
		v_u_19.Visible = false
		local v22 = v_u_10:Register("EggLuckyBlockMachine", v_u_19, "TopQuint")
		v22:AttachCloseButton(v21)
		v22:Close()

		local v_u_23 = v_u_3:Wait(v_u_16)
		if v_u_23 then

			(function(p24, p25)
				local v26 = v_u_15[p25]
				if v26 then
					local v27 = v_u_14[v26.Rarity]
					p24.Title.Text = p25
					if v27.GradientPreset then
						p24.UIStroke.Color = Color3.new(1, 1, 1)
						p24.Title.TextColor3 = Color3.new(1, 1, 1)
						v_u_4.apply(p24.UIStroke, v27.GradientPreset)
						v_u_4.apply(p24.Title, v27.GradientPreset)
					else
						p24.UIStroke.Color = v27.Color
						p24.Title.TextColor3 = v27.Color
					end
					p24.Visible = true
					v_u_13:AttachOnViewportWithOptimizations(p25, p24.ViewportFrame)
				end
			end)(v_u_19.Mid, "Egg Lucky Block")

			local v28 = v_u_12.new(v20)
			v28:Animate()
			v28.OnActivated:Connect(function()

				v_u_9:RemoteEvent((("EventService/Egg/Spawn"):format(v_u_18))):FireServer()
				v_u_10:SetState("EggLuckyBlockMachine", false)
			end)

			local function v_u_39()
				local v29 = v_u_6:GetInstant("EasterEventSpawnEggLuckyBlockRequirement", 250)
				local v30 = v_u_23:Get("EasterEvent.BunnyCoins") or 0
				


				v_u_19.Subtitle.Text = ("Collect <font color=\"rgb(255, 204, 1)\">%* Bunny Coins</font> to spawn a\n<font color=\"rgb(111, 255, 248)\">Egg Lucky Block</font>"):format(v29)
				v_u_19.Progress.Label.Text = ("%*/%*"):format(v_u_11:Comma(v30), v29)
				
				local v31 = v_u_8.target
				local v32 = v_u_19.Progress.Fill
				local v33 = {}
				local v34 = UDim2.fromScale
				local v35 = v30 / v29
				v33.Size = v34(math.clamp(v35, 0, 1), 1)
				v31(v32, 1, 5, v33)
				
				local v36 = v29 <= v30
				v_u_19.Spawn.Interactable = v36
				local v37 = v_u_19.Spawn
				local v38
				if v36 then
					v38 = Color3.fromRGB(81, 158, 86)
				else
					v38 = Color3.fromRGB(127, 127, 127)
				end
				v37.BackgroundColor3 = v38
			end

			v_u_23:OnChanged("EasterEvent.BunnyCoins", v_u_39, true)
			
			v_u_6:OnUpdate(function()

				v_u_39()
			end)
		end
	end
}

local v_u_41 = v_u_7.new()
function v40.OnStart(_) end
function v40.OnStop(_)
	v_u_41:Clean()
end

function v40.OnLoad(p42)

	task.spawn(p42.Setup, p42)
	
	v_u_5.observeTag("EggLuckyBlockAmount", function(p_u_43)

		local v_u_44 = v_u_7.new()
		v_u_44:Add(task.spawn(function()
			local v_u_45 = v_u_3:Wait(v_u_16)
			if v_u_45 then
				v_u_44:Add(v_u_45:OnChanged("EasterEvent.BunnyCoins", function()
					local v46 = v_u_6:GetInstant("EasterEventSpawnEggLuckyBlockRequirement", 250)
					p_u_43.Text = ("%*/%*"):format(v_u_11:Comma(v_u_45:Get("EasterEvent.BunnyCoins") or 0), v46)
				end, true))
				
				v_u_44:Add(v_u_6:OnUpdate(function()
					local v47 = v_u_6:GetInstant("EasterEventSpawnEggLuckyBlockRequirement", 250)
					p_u_43.Text = ("%*/%*"):format(v_u_11:Comma(v_u_45:Get("EasterEvent.BunnyCoins") or 0), v47)
				end))
			end
		end))
		return v_u_44:WrapClean()
	end)

	v_u_5.observeTag("EggLuckyBlockMachinePrompt", function(p48)

		local v_u_49 = p48.Triggered:Connect(function()
			if v_u_3:Get(v_u_16) then

				v_u_10:Toggle("EggLuckyBlockMachine")
			end
		end)
		return function()
			v_u_49:Disconnect()
		end
	end)
end

return v40