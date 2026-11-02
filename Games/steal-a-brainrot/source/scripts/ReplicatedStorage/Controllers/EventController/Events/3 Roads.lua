local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
game:GetService("TweenService")
game:GetService("RunService")
game:GetService("Lighting")
local v3 = game:GetService("Players")
game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v4 = {}
require(v_u_1.Controllers.EncryptedAssetsController)
require(v_u_1.Controllers.AnimalController)
local v_u_5 = require(v_u_1.Controllers.EffectController)
require(v_u_1.Controllers.CameraController)
require(v_u_1.Controllers.SoundController)
require(v_u_1.Controllers.EventController)
require(v_u_1.Controllers.CycleController)
require(v_u_1.Shared.SharedEventUtils)
require(v_u_1.Packages.CreateTween)
require(v_u_1.Shared.TweenPivot)
local v_u_6 = require(v_u_1.Packages.Observers)
require(v_u_1.Utils.MathUtils)
require(v_u_1.Shared.Animals)
require(v_u_1.Packages.Signal)
require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Shake)
require(v_u_1.Packages.Timer)
require(v_u_1.Packages.Spr)
require(v_u_1.Packages.Net)
require(v_u_1.Shared.VFX)
local _ = v3.LocalPlayer
local _ = workspace.CurrentCamera
local _ = script.Name
function v4.OnStart(_) end
function v4.OnStop(_) end
function v4.OnLoad(_)
    -- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_5, (copy) v_u_6
    task.spawn(pcall, function()
        -- upvalues: (ref) v_u_2
        v_u_2:PreloadAsync(script:GetChildren())
    end)
    local v_u_7 = nil
    local v_u_8 = nil
    local function v16(p9)
        -- upvalues: (ref) v_u_1, (ref) v_u_5, (ref) v_u_7, (ref) v_u_8, (ref) v_u_6
        if v_u_1:GetAttribute("3RoadsEvent") then
            if not p9 then
                v_u_5:Activate("Blink")
            end
            if v_u_7 then
                v_u_7()
                v_u_7 = nil
            end
            if not v_u_8 then
                v_u_8 = v_u_6.observeTag("HideIn3Roads", function(p_u_10)
                    local v_u_11 = p_u_10.Parent
                    p_u_10.Parent = script
                    return function()
                        -- upvalues: (copy) p_u_10, (copy) v_u_11
                        pcall(function()
                            -- upvalues: (ref) p_u_10, (ref) v_u_11
                            p_u_10.Parent = v_u_11
                        end)
                    end
                end, { workspace, script })
                return
            end
        else
            if not p9 then
                v_u_5:Activate("Blink")
            end
            if not v_u_7 then
                v_u_7 = v_u_6.observeTag("ShowIn3Roads", function(p_u_12)
                    local v_u_13 = p_u_12.Parent
                    local v_u_14 = false
                    local v_u_15 = v_u_13.Destroying:Once(function()
                        -- upvalues: (ref) v_u_14, (copy) p_u_12
                        v_u_14 = true
                        p_u_12:Destroy()
                    end)
                    p_u_12.Parent = script
                    return function()
                        -- upvalues: (copy) v_u_15, (ref) v_u_14, (copy) p_u_12, (copy) v_u_13
                        v_u_15:Disconnect()
                        if not v_u_14 then
                            pcall(function()
                                -- upvalues: (ref) p_u_12, (ref) v_u_13
                                p_u_12.Parent = v_u_13
                            end)
                        end
                    end
                end, { workspace, script })
            end
            if v_u_8 then
                v_u_8()
                v_u_8 = nil
            end
        end
    end
    v_u_1:GetAttributeChangedSignal("3RoadsEvent"):Connect(v16)
    task.spawn(v16, true)
end
return v4