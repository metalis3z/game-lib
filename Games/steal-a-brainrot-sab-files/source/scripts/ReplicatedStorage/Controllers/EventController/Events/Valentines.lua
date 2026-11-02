


local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
game:GetService("TweenService")
game:GetService("RunService")
local v_u_3 = game:GetService("Lighting")
game:GetService("Players")
require(v_u_1.Shared.EventTypes)
local v4 = {}
local v_u_5 = require(v_u_1.Controllers.EventController.ClientEventUtils)
require(v_u_1.Controllers.AnimalController)
local v_u_6 = require(v_u_1.Controllers.EffectController)
local v_u_7 = require(v_u_1.Controllers.SoundController)
local v_u_8 = require(v_u_1.Controllers.EventController)
local v_u_9 = require(v_u_1.Controllers.CycleController)
require(v_u_1.Shared.ShakePresets)
local v_u_10 = require(v_u_1.Packages.Observers)
local v_u_11 = require(v_u_1.Datas.ServerData)
local v12 = require(v_u_1.Packages.Trove)
local v13 = require(v_u_1.Packages.Net)
require(v_u_1.Shared.VFX)
local v_u_14 = script.Name
local v_u_15 = v13:RemoteEvent("EventService/Valentines/Hit")
local v_u_16 = v12.new()
function v4.OnStart(_)
    local v17 = v_u_8:GetActiveEventData(v_u_14)
    assert(v17)
    v_u_1:SetAttribute("ValentinesEvent", true)
    v_u_16:Add(function()
        v_u_1:SetAttribute("ValentinesEvent", nil)
    end)
    local v18
    v18 = v_u_16:Clone(script.Map)

    v18.Parent = workspace
    v_u_6:Activate("Blink")
    v_u_16:Add(function()
        v_u_6:Activate("Blink")
    end)
    local v_u_19 = v_u_3:FindFirstChild("Atmosphere")
    if v_u_19 then
        v_u_19.Parent = script
        v_u_16:Add(function()
            v_u_19.Parent = v_u_3
        end)
    end
    v_u_16:Clone(script.AtmosphereValentines).Parent = v_u_3
    local v_u_20 = v_u_3:FindFirstChild("Cartoon")
    if v_u_20 then
        v_u_20.Parent = script
        v_u_16:Add(function()
            v_u_20.Parent = v_u_3
        end)
    end
    v_u_16:Clone(script.SkyValentines).Parent = v_u_3
    v_u_16:Add(v_u_10.observeTag("HideInValentines", function(p_u_21)
        local v_u_22 = p_u_21.Parent
        p_u_21.Parent = script
        return function()
            pcall(function()
                p_u_21.Parent = v_u_22
            end)
        end
    end, { workspace, script }))
    v_u_9:Update()
    v_u_7:UpdateOST()
    v_u_7:UpdateAmbience()
    v_u_6:Run("ValentinesEvent", "GrassRecolor")
    v_u_16:Add(function()
        v_u_6:Stop("ValentinesEvent", "GrassRecolor")
    end)
    v_u_6:Run("ValentinesEvent", "WallRecolor")
    v_u_16:Add(function()
        v_u_6:Stop("ValentinesEvent", "WallRecolor")
    end)
    v_u_6:Run("ValentinesEvent", "WallBottomRecolor")
    v_u_16:Add(function()
        v_u_6:Stop("ValentinesEvent", "WallBottomRecolor")
    end)
end
function v4.OnStop(_)
    v_u_16:Destroy()
end
function v4.OnLoad(_)
    task.spawn(pcall, function()
        v_u_2:PreloadAsync(script:GetChildren())
    end)
    task.spawn(pcall, function()
        v_u_2:PreloadAsync({ v_u_1.Sounds.Events.Valentines })
    end)
    v_u_15.OnClientEvent:Connect(function(p23)
        v_u_5.playBurst(script.Burst, p23, { v_u_1.Sounds.Events.Valentines.Hit })
    end)
end
return v4