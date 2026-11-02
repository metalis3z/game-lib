local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local Observers = require(ReplicatedStorage.Packages.Observers)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Spr = require(ReplicatedStorage.Packages.Spr)
local Net = require(ReplicatedStorage.Packages.Net)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local SAnimals = require(ReplicatedStorage.Shared.Animals)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local Animals = require(ReplicatedStorage.Datas.Animals)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local ScriptName = script.Name

require(ReplicatedStorage.Shared.EventTypes)
require(ReplicatedStorage.Shared.Index)
require(ReplicatedStorage.Datas.Mutations)
require(ReplicatedStorage.Shared.Updates)
require(ReplicatedStorage.Shared.Animals)
require(ReplicatedStorage.Utils.TimeUtils)
require(ReplicatedStorage.Shared.VFX)
require(ReplicatedStorage.Controllers.CharacterController)
require(ReplicatedStorage.Controllers.SoundController)
require(ReplicatedStorage.Controllers.PlotController)
require(ReplicatedStorage.Controllers.NotificationController)
require(ReplicatedStorage.Controllers.NewPlayersController)
require(ReplicatedStorage.Packages.Timer)
require(ReplicatedStorage.Packages.Moonlite)
require(ReplicatedStorage.Packages.Squash)

game:GetService("ContentProvider")
game:GetService("SoundService")
game:GetService("TweenService")
game:GetService("HttpService")
game:GetService("RunService")
game:GetService("StarterGui")

local v40 = {
    ["Setup"] = function(_)
		local v_u_19 = PlayerGui:WaitForChild("FestiveLuckyBlock").Frame
        local v20 = v_u_19.Spawn
        local v21 = v_u_19.Header.Close
        v_u_19.Visible = false
		local v22 = InterfaceController:Register("FestiveLuckyBlockMachine", v_u_19, "TopQuint")
        v22:AttachCloseButton(v21)
        v22:Close()
		local v_u_23 = Synchronizer:Wait(LocalPlayer)
        if v_u_23 then
            (function(p24, p25)
				local v26 = Animals[p25]
                if v26 then
					local v27 = Rarities[v26.Rarity]
                    p24.Title.Text = p25
                    if v27.GradientPreset then
                        p24.UIStroke.Color = Color3.new(1, 1, 1)
                        p24.Title.TextColor3 = Color3.new(1, 1, 1)
						Gradients.apply(p24.UIStroke, v27.GradientPreset)
						Gradients.apply(p24.Title, v27.GradientPreset)
                    else
                        p24.UIStroke.Color = v27.Color
                        p24.Title.TextColor3 = v27.Color
                    end
                    p24.Visible = true
					SAnimals:AttachOnViewport(p25, p24.ViewportFrame, true)
                end
            end)(v_u_19.Mid, "Festive Lucky Block")
			Gradients.apply(v_u_19.Mid.Title, "GreenRed")
			local v28 = AnimatedButton.new(v20)
            v28:Animate()
            v28.OnActivated:Connect(function()
				Net:RemoteEvent((("EventService/%*/Spawn"):format(ScriptName))):FireServer()
				InterfaceController:SetState("FestiveLuckyBlockMachine", false)
            end)
            local function v_u_39()
				local v29 = FFlags:GetInstant("ChristmasEventSpawnFestiveLuckyBlockRequirement", 300)
                local v30 = v_u_23:Get("ChristmasEvent.CandyCane") or 0
				v_u_19.Progress.Label.Text = ("%*/%*"):format(NumberUtils:Comma(v30), v29)
				local v31 = Spr.target
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
            v_u_23:OnChanged("ChristmasEvent.CandyCane", v_u_39, true)
			FFlags:OnUpdate(function()
                v_u_39()
            end)
        end
    end
}
local v_u_41 = Trove.new()
function v40.OnStart(_) end
function v40.OnStop(_)
    v_u_41:Clean()
end
function v40.OnLoad(p42)
    task.spawn(p42.Setup, p42)
	Observers.observeTag("FestiveLuckyBlockAmount", function(p_u_43)
		local v_u_44 = Trove.new()
        v_u_44:Add(task.spawn(function()
			local v_u_45 = Synchronizer:Wait(LocalPlayer)
            if v_u_45 then
                v_u_44:Add(v_u_45:OnChanged("ChristmasEvent.CandyCane", function()
					local v46 = FFlags:GetInstant("ChristmasEventSpawnFestiveLuckyBlockRequirement", 300)
					p_u_43.Text = ("%*/%*"):format(NumberUtils:Comma(v_u_45:Get("ChristmasEvent.CandyCane") or 0), v46)
                end, true))
				v_u_44:Add(FFlags:OnUpdate(function()
					local v47 = FFlags:GetInstant("ChristmasEventSpawnFestiveLuckyBlockRequirement", 300)
					p_u_43.Text = ("%*/%*"):format(NumberUtils:Comma(v_u_45:Get("ChristmasEvent.CandyCane") or 0), v47)
                end))
            end
        end))
        return v_u_44:WrapClean()
    end)
	Observers.observeTag("FestiveLuckyBlockMachinePrompt", function(p48)
        local v_u_49 = p48.Triggered:Connect(function()
			if Synchronizer:Get(LocalPlayer) then
				InterfaceController:Toggle("FestiveLuckyBlockMachine")
            end
        end)
        return function()
            v_u_49:Disconnect()
        end
    end)
end
return v40