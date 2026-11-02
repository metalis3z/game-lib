-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
require(script:FindFirstAncestor("Effects").Parent.Types)
local v2 = {}
local v_u_3 = require(v_u_1.Controllers.EffectController)
local v_u_4 = require(v_u_1.Controllers.SoundController)
local v_u_5 = require(v_u_1.Controllers.CycleController)
local v6 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Net)
local _ = script.Name
local v_u_7 = v6.new()
local _ = workspace.CurrentCamera
function v2.OnStart(_)
    -- upvalues: (copy) v_u_1, (copy) v_u_7, (copy) v_u_4, (copy) v_u_5, (copy) v_u_3
    v_u_1:SetAttribute("Effect_Space", true)
    v_u_7:Add(function()
        -- upvalues: (ref) v_u_1
        v_u_1:SetAttribute("Effect_Space", nil)
    end)
    v_u_4:UpdateOST()
    v_u_5:Update()
    local v_u_8 = v_u_7:Extend()
    local v_u_9 = true
    v_u_7:Add(function()
        -- upvalues: (ref) v_u_9
        v_u_9 = false
    end)
    local v_u_10 = nil
    local function v15()
        -- upvalues: (ref) v_u_1, (ref) v_u_9, (ref) v_u_10, (ref) v_u_3, (ref) v_u_4, (ref) v_u_5, (copy) v_u_8
        local v11 = v_u_1:GetAttribute("NyanCatsEvent")
        local v12
        if v_u_9 then
            if v11 then
                v12 = script.Nyan
            else
                v12 = script.Space
            end
        else
            v12 = nil
        end
        if v12 ~= v_u_10 then
            v_u_10 = v12
            v_u_3:Activate("Blink")
            v_u_4:UpdateOST()
            v_u_5:Update()
            v_u_8:Destroy()
            if v12 then
                local v13 = v_u_8:Clone(v12)
                v13.Parent = workspace
                v13.spacemeshbg.Transparency = 0
                for _, v14 in v13:GetDescendants() do
                    if v14:IsA("ParticleEmitter") or v14:IsA("Beam") then
                        v14.Enabled = true
                    end
                end
            end
        end
    end
    v_u_1:GetAttributeChangedSignal("NyanCatsEvent"):Connect(v15)
    v_u_7:Add(task.spawn(v15))
    v_u_7:Add(v15)
end
function v2.OnStop(_)
    -- upvalues: (copy) v_u_7
    v_u_7:Destroy()
end
function v2.OnLoad(_) end
return v2