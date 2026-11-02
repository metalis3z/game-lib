-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v_u_1 = {}
local v_u_2
if game:GetService("RunService"):IsClient() then
    v_u_2 = nil
else
    require(game:GetService("ServerStorage").Modules.Types)
    v_u_2 = require(game:GetService("ServerStorage").Modules.General.Fighter)
end
function v_u_1.new(p3)
    local v4 = v_u_1
    local v_u_5 = setmetatable({}, v4)
    v_u_5.Playing = true
    v_u_5.Assets = {}
    v_u_5.Players = p3
    v_u_5.Looped = true
    v_u_5.StartTick = tick()
    v_u_5.Anims = {}
    v_u_5.NAME = ""
    v_u_5.Traversal = false
    v_u_5.Mute = false
    function v_u_5.CheckFunc()
        if not game:GetService("RunService"):IsClient() then
            for _, v6 in v_u_5.Players do
                v6:AddTag("KillAnims")
                local v7 = v_u_2.getFighterByCharacter(v6)
                if v7 then
                    for _, v8 in v7.Abilites do
                        if v8.equipped and v8.equipped == true then
                            v8.equip()
                        end
                    end
                end
            end
        end
    end
    function v_u_5.EmoteFunc() end
    function v_u_5.Stop()
        v_u_5.Playing = false
        if not game:GetService("RunService"):IsClient() then
            for _, v9 in v_u_5.Players do
                v9:RemoveTag("KillAnims")
                local v10 = v_u_2.getFighterByCharacter(v9)
                if v10 then
                    v10.Emote = nil
                    v10.InEmote = false
                end
            end
        end
        for _, v11 in v_u_5.Anims do
            v11:Stop()
        end
        for _, v12 in v_u_5.Assets do
            v12:Destroy()
        end
        v_u_5.Assets = {}
        v_u_5.Anims = {}
        v_u_5.Players = {}
    end
    local v_u_13 = {}
    for _, v_u_14 in v_u_5.Players do
        v_u_13[#v_u_13 + 1] = v_u_14:GetAttributeChangedSignal("InAbility"):Connect(function()
            if v_u_14:GetAttribute("InAbility") then
                v_u_5:Stop()
                for _, v15 in v_u_13 do
                    v15:Disconnect()
                end
            end
        end)
        v_u_13[#v_u_13 + 1] = v_u_14:GetAttributeChangedSignal("Stun"):Connect(function()
            if v_u_14:GetAttribute("Stun") then
                v_u_5:Stop()
                for _, v16 in v_u_13 do
                    v16:Disconnect()
                end
            end
        end)
        v_u_13[#v_u_13 + 1] = v_u_14:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("Jump"):Connect(function()
            if v_u_14:FindFirstChildOfClass("Humanoid").Jump == true and v_u_5.Playing == true then
                v_u_5:Stop()
                for _, v17 in v_u_13 do
                    v17:Disconnect()
                end
            end
        end)
        v_u_13[#v_u_13 + 1] = v_u_14:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function()
            if v_u_14:FindFirstChildOfClass("Humanoid").Health <= 0 and v_u_5.Playing == true then
                v_u_5:Stop()
                for _, v18 in v_u_13 do
                    v18:Disconnect()
                end
            end
        end)
        v_u_13[#v_u_13 + 1] = v_u_14.HumanoidRootPart:GetPropertyChangedSignal("Anchored"):Connect(function()
            if v_u_14.HumanoidRootPart.Anchored and v_u_5.Playing == true then
                v_u_5:Stop()
                for _, v19 in v_u_13 do
                    v19:Disconnect()
                end
            end
        end)
        if v_u_5.Traversal == false then
            v_u_13[#v_u_13 + 1] = v_u_14:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("MoveDirection"):Connect(function()
                if v_u_14:FindFirstChildOfClass("Humanoid").MoveDirection ~= Vector3.new(0, 0, 0) and (v_u_5.Traversal == false and v_u_5.Playing == true) then
                    v_u_5:Stop()
                    for _, v20 in v_u_13 do
                        v20:Disconnect()
                    end
                end
            end)
        end
    end
    function v_u_5.AddPlayer(p_u_21)
        local Players = v_u_5.Players
        table.insert(Players, p_u_21)
        v_u_13[#v_u_13 + 1] = p_u_21:GetAttributeChangedSignal("InAbility"):Connect(function()
            if p_u_21:GetAttribute("InAbility") then
                v_u_5:Stop()
                for _, v23 in v_u_13 do
                    v23:Disconnect()
                end
            end
        end)
        v_u_13[#v_u_13 + 1] = p_u_21:GetAttributeChangedSignal("Stun"):Connect(function()
            if p_u_21:GetAttribute("Stun") then
                v_u_5:Stop()
                for _, v24 in v_u_13 do
                    v24:Disconnect()
                end
            end
        end)
        v_u_13[#v_u_13 + 1] = p_u_21:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function()
            if p_u_21:FindFirstChildOfClass("Humanoid").Health <= 0 and v_u_5.Playing == true then
                v_u_5:Stop()
                for _, v25 in v_u_13 do
                    v25:Disconnect()
                end
            end
        end)
        v_u_13[#v_u_13 + 1] = p_u_21:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("Jump"):Connect(function()
            if p_u_21:FindFirstChildOfClass("Humanoid").Jump == true and v_u_5.Playing == true then
                v_u_5:Stop()
                for _, v26 in v_u_13 do
                    v26:Disconnect()
                end
            end
        end)
        v_u_13[#v_u_13 + 1] = p_u_21:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("MoveDirection"):Connect(function()
            if p_u_21:FindFirstChildOfClass("Humanoid").MoveDirection ~= Vector3.new(0, 0, 0) and (v_u_5.Traversal == false and v_u_5.Playing == true) then
                v_u_5:Stop()
                for _, v27 in v_u_13 do
                    v27:Disconnect()
                end
            end
        end)
    end
    return v_u_5
end
return v_u_1
