-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = require(ReplicatedStorage.Shared.Player)
local TrappedBackpackLock = require(script.Parent.Parent.Parent.GUI.TrappedBackpackLock)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local v1 = Trove.new()
local v2 = false

local function unequipLocalTools() -- line 14 | captures: Player, LocalPlayer
    local v3 = Player.Optional.Humanoid(LocalPlayer)
    if v3 then
        v3:UnequipTools()
    end
end

local function setTrapBackpackLocked(v4) -- line 20 | captures: v2, Player, TrappedBackpackLock, LocalPlayer
    if v2 == v4 then
        if v4 then
            local v5 = Player.Optional.Humanoid(LocalPlayer)
            if v5 then
                v5:UnequipTools()
            end
        end
    else
        v2 = v4
        if v4 then
            TrappedBackpackLock.SetLocked(true)
            local v6 = Player.Optional.Humanoid(LocalPlayer)
            if v6 then
                v6:UnequipTools()
            end
        else
            TrappedBackpackLock.SetLocked(false)
        end
    end
end

local function refreshCharacterTrapState(v7) -- line 42 | captures: v2, Player, TrappedBackpackLock, LocalPlayer
    local v8 = v7:GetAttribute("IsTrapped") == true
    if v2 == v8 then
        if v8 then
            local v9 = Player.Optional.Humanoid(LocalPlayer)
            if v9 then
                v9:UnequipTools()
            end
        end
    else
        v2 = v8
        if v8 then
            TrappedBackpackLock.SetLocked(true)
            local v10 = Player.Optional.Humanoid(LocalPlayer)
            if v10 then
                v10:UnequipTools()
            end
        else
            TrappedBackpackLock.SetLocked(false)
        end
    end
end

local function bindCharacter(v11) -- line 68 | captures: v2, Player, TrappedBackpackLock, LocalPlayer, v1
    v1:Clean()
    v1:Add(function() -- line 71 | captures: v2, TrappedBackpackLock
        if v2 ~= false then
            v2 = false
            TrappedBackpackLock.SetLocked(false)
        end
    end)
    local IsTrapped = v11:GetAttributeChangedSignal("IsTrapped")
    v1:Connect(IsTrapped, function() -- line 79 | captures: v11, v2, Player, TrappedBackpackLock, LocalPlayer
        local v12 = v11:GetAttribute("IsTrapped") == true
        if v2 == v12 then
            if v12 then
                local v13 = Player.Optional.Humanoid(LocalPlayer)
                if v13 then
                    v13:UnequipTools()
                end
            end
        else
            v2 = v12
            if v12 then
                TrappedBackpackLock.SetLocked(true)
                local v14 = Player.Optional.Humanoid(LocalPlayer)
                if v14 then
                    v14:UnequipTools()
                end
            else
                TrappedBackpackLock.SetLocked(false)
            end
        end
    end)
    v1:Connect(v11.ChildAdded, function(v15) -- line 105 | captures: v2, Player, LocalPlayer
        if v2 and v15:IsA("Tool") then
            local v16 = Player.Optional.Humanoid(LocalPlayer)
            if v16 then
                v16:UnequipTools()
            end
        end
    end)
    local v17 = v11:GetAttribute("IsTrapped") == true
    if v2 == v17 then
        if v17 then
            local v18 = Player.Optional.Humanoid(LocalPlayer)
            if v18 then
                v18:UnequipTools()
            end
        end
    else
        v2 = v17
        if v17 then
            TrappedBackpackLock.SetLocked(true)
            local v19 = Player.Optional.Humanoid(LocalPlayer)
            if v19 then
                v19:UnequipTools()
            end
        else
            TrappedBackpackLock.SetLocked(false)
        end
    end
end

LocalPlayer.CharacterAdded:Connect(bindCharacter)
local v20 = Player.Optional.Character(LocalPlayer)

if v20 then
    bindCharacter(v20)
end
