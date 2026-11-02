local v1 = game:GetService("ReplicatedStorage")
game:GetService("ContentProvider")
game:GetService("SoundService")
local v_u_2 = game:GetService("TweenService")
game:GetService("HttpService")
local v_u_3 = game:GetService("RunService")
game:GetService("StarterGui")
local v4 = game:GetService("Players")
require(v1.Packages.Serialization)
local v_u_5 = require(v1.Packages.Synchronizer)
require(v1.Packages.CreateTween)
require(v1.Packages.TopbarPlus)
local v_u_6 = require(v1.Packages.Gradients)
local v_u_7 = require(v1.Packages.Observers)
require(v1.Packages.FFlags)
require(v1.Packages.Timer)
local v8 = require(v1.Packages.Trove)
local v_u_9 = require(v1.Packages.Spr)
local v_u_10 = require(v1.Packages.Net)
require(v1.Controllers.NotificationController)
require(v1.Controllers.NewPlayersController)
local v_u_11 = require(v1.Controllers.InterfaceController)
require(v1.Controllers.CharacterController)
require(v1.Controllers.SoundController)
require(v1.Controllers.PlotController)
require(v1.Utils.NumberUtils)
require(v1.Utils.TimeUtils)
require(v1.Classes.AnimatedButton)
require(v1.Shared.Updates)
require(v1.Shared.Animals)
require(v1.Shared.VFX)
local SAnimals = require(v1.Shared.Animals)
local v_u_13 = require(v1.Shared.Index)
require(v1.Datas.Mutations)
local v_u_14 = require(v1.Datas.Rarities)
local v_u_15 = require(v1.Datas.Animals)
local v_u_16 = require(v1.Datas.Index)
local v_u_17 = v4.LocalPlayer
local v_u_18 = v_u_17.PlayerGui
local _ = script.Name
require(v1.Shared.EventTypes)
local v48 = {
	["Setup"] = function(_)
		local v_u_19 = v_u_18:WaitForChild("TacoBase").TacoBase
		local _ = v_u_19.Main.Content.Base
		local v20 = v_u_19.Main.Header.Close
		v_u_19.Visible = false
		local v21 = v_u_11:Register("TacoBase", v_u_19, "TopQuint")
		v21:AttachCloseButton(v20)
		v21:Close()
		local v_u_22 = v_u_5:Wait(v_u_17)
		if v_u_22 then
			local function v27(p23, p24)
				local v25 = v_u_15[p24]
				if v25 then
					local v26 = v_u_14[v25.Rarity]
					p23.Title.Text = p24
					p23.RarityLabel.Text = v25.Rarity
					if v26.GradientPreset then
						p23.RarityLabel.TextColor3 = Color3.new(1, 1, 1)
						v_u_6.apply(p23.RarityLabel, v26.GradientPreset)
					else
						p23.RarityLabel.TextColor3 = v26.Color
					end
					p23.Visible = true
					SAnimals:AttachOnViewport(p24, p23.ViewportFrame, true)
				end
			end
			local v28 = SAnimals:GetList("Generation", true)
			local v29 = v_u_16.Taco.Index
			local v30 = assert(v29)
			for v31 = 1, #v28 do
				local v_u_32 = v28[v31]
				if v30[v_u_32] and v_u_15[v_u_32] then
					local v_u_33 = v_u_19.Main.Content.Holder.List.Template:Clone()
					v_u_33.LayoutOrder = v31
					v27(v_u_33, v_u_32)
					v_u_33.Visible = true
					local v_u_34 = v_u_33.ViewportFrame
					local function v37()
						local v35 = v_u_22:Get({ "Index", v_u_32 })
						local v36 = v35 ~= nil and v35.Taco or nil
						v_u_33.Title.Visible = v36
						v_u_34.ImageColor3 = not v36 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
					end
					v_u_22:OnChanged({ "Index", v_u_32 }, v37, true)
					task.spawn(v37)
					v_u_33.Parent = v_u_19.Main.Content.Holder.List
				end
			end
			local function v47()
				local v38, v39, v40 = v_u_13:GetIndexAnimals(v_u_17, "Taco")
				assert(v38, v39, v40)
				v_u_13:IsComplete(v_u_17, "Taco")
				v_u_19.Main.Content.Base.AmountLabel.Text = ("%*/%*"):format(v38, v39)
				v_u_19.Main.Content.Base.Claim.Label.Text = v_u_22:Get("UnlockedBaseSkins.Taco") and "Claimed" or "Claim"
				local v41 = v_u_9.target
				local v42 = v_u_19.Main.Content.Base.Claim
				local v43 = 1
				local v44 = 5
				local v45 = {}
				local v46
				if v39 <= v38 and not v_u_22:Get("UnlockedBaseSkins.Taco") then
					v46 = Color3.fromRGB(81, 158, 86)
				else
					v46 = Color3.fromRGB(112, 112, 112)
				end
				v45.BackgroundColor3 = v46
				v41(v42, v43, v44, v45)
			end
			v_u_19.Main.Content.Base.Claim.Activated:Connect(function()
				v_u_10:RemoteEvent("TacoBase/Claim"):FireServer()
			end)
			v_u_22:OnChanged("AnimalAddedOrRemoved", v47)
			v_u_22:OnDictionaryInserted("UnlockedBaseSkins", v47)
			v_u_22:OnDictionaryRemoved("UnlockedBaseSkins", v47)
			v47()
		end
	end
}
local v_u_49 = v8.new()
function v48.OnStart(_) end
function v48.OnStop(_)
	v_u_49:Clean()
end
function v48.OnLoad(p50)
	task.spawn(p50.Setup, p50)
	v_u_7.observeTag("TacoBaseMotor", function(p_u_51)
		local v_u_52 = os.clock() + 15
		local v_u_53 = nil
		local v_u_54 = nil
		local v_u_55 = os.clock()
		local v_u_71 = v_u_3.PostSimulation:Connect(function()
			local v56 = os.clock()
			local v57 = p_u_51
			local v58 = CFrame.new
			local v59 = v56 * 2
			v57.Transform = v58(0, math.sin(v59) * 0.25, 0)
			if v_u_52 < v56 then
				v_u_54 = 0
				v_u_52 = v56 + 15
			elseif v_u_54 ~= nil then
				v_u_54 = v_u_54 + (v56 - v_u_55)
				local v60 = v_u_54 / 2
				local v61 = v_u_2:GetValue(v60, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
				local v62 = p_u_51
				v62.Transform = v62.Transform * CFrame.Angles(0, v61 * 3 * 3.141592653589793 * 2, 0)
				if v60 > 0.75 and not v_u_53 then
					v_u_53 = 0
				end
				if v_u_54 >= 2 then
					v_u_54 = nil
				end
			end
			if v_u_53 ~= nil then
				v_u_53 = v_u_53 + (v56 - v_u_55)
				local v63
				if v_u_54 == nil then
					local v64 = v_u_53 / 2
					v63 = 1 - math.clamp(v64, 0, 1)
				else
					local v65 = (v_u_54 / 2 - 0.5) / 0.5
					v63 = math.clamp(v65, 0, 1)
				end
				local v66 = v56 * 14
				local v67 = 0.04 * v63
				local v68 = 0.025 * v63
				local v69 = CFrame.new(math.noise(v66, 0, 0) * v67, math.noise(0, v66, 0) * v67, 0) * CFrame.Angles(math.noise(v66, v66, 0) * v68, 0, math.noise(0, v66, v66) * v68)
				local v70 = p_u_51
				v70.Transform = v70.Transform * v69
				if v_u_54 == nil and v_u_53 >= 2 then
					v_u_53 = nil
				end
			end
			v_u_55 = v56
		end)
		return function()
			v_u_71:Disconnect()
			p_u_51.Transform = CFrame.identity
		end
	end)
	v_u_7.observeTag("TacoBasePrompt", function(p72)
		local v_u_73 = p72.Triggered:Connect(function()
			if v_u_5:Get(v_u_17) then
				v_u_11:Toggle("TacoBase")
			end
		end)
		return function()
			v_u_73:Disconnect()
		end
	end)
end
return v48