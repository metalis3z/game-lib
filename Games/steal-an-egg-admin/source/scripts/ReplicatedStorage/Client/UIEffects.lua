-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HoverBob = require(script.HoverBob)
local Log = require(ReplicatedStorage.Packages.Log)
local SpriteSheet = require(script.SpriteSheet)
local TextGlitch = require(script.TextGlitch)
local v1 = Log.new()
local v2 = {}
local v3 = {
    HoverBob = HoverBob.Bind,
    SpriteSheet = SpriteSheet.Bind,
    TextGlitch = TextGlitch.Bind
}
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local v4 = {}
local v5 = {}

local function stopEffect(v6) -- line 18 | captures: v1, v4
    local v7 = v4[v6]
    if v7 == nil then
        return
    end
    v4[v6] = nil
    local v8, v9 = pcall(v7)
    if not v8 then
        local v10 = v6:GetFullName()
        v1:AtError():Log((("UI effect cleanup failed on %*: %*"):format(v10, v9)))
    end
end

local function startEffect(v11) -- line 31 | captures: v1, v3, v4
    local v12 = v4[v11]
    if v12 ~= nil then
        v4[v11] = nil
        local v13, v14 = pcall(v12)
        if not v13 then
            local v15 = v11:GetFullName()
            v1:AtError():Log((("UI effect cleanup failed on %*: %*"):format(v15, v14)))
        end
    end
    local UIEffect = v11:GetAttribute("UIEffect")
    if UIEffect ~= nil then
        if typeof(UIEffect) == "string" then
            local v16 = v3[UIEffect]
            if v16 == nil then
                local v17 = v11:GetFullName()
                v1:AtError():Log((("%* asks for unknown UIEffect \"%*\""):format(v17, UIEffect)))
            else
                local v18, v19 = pcall(v16, v11)
                if v18 then
                    v4[v11] = v19
                else
                    local v20 = v11:GetFullName()
                    v1:AtError():Log((("UI effect %* failed on %*: %*"):format(UIEffect, v20, v19)))
                end
            end
        else
            v1:AtError():Log((("%* UIEffect must be a string"):format((v11:GetFullName()))))
        end
    end
end

local function watch(v21) -- line 64 | captures: v1, v4, v5, startEffect
    if v5[v21] ~= nil then
        return
    end
    local UIEffect = v21:GetAttributeChangedSignal("UIEffect")
    v5[v21] = UIEffect:Connect(function() -- line 69 | captures: v21, startEffect
        startEffect(v21)
    end)
    v21.Destroying:Once(function() -- line 72 | captures: v21, v1, v4, v5
        local v22 = v5[v21]
        v5[v21] = nil
        if v22 ~= nil then
            v22:Disconnect()
        end
        local v23 = v4[v21]
        if v23 == nil then
            return
        end
        v4[v21] = nil
        local v24, v25 = pcall(v23)
        if not v24 then
            local v26 = v21:GetFullName()
            v1:AtError():Log((("UI effect cleanup failed on %*: %*"):format(v26, v25)))
        end
    end)
end

local function consider(v27) -- line 92 | captures: startEffect, watch
    if v27:GetAttribute("UIEffect") ~= nil then
        watch(v27)
        startEffect(v27)
    end
end

function v2.Bind(v28) -- line 99 | captures: startEffect, watch
    watch(v28)
    startEffect(v28)
end

function v2.Unbind(v29) -- line 103 | captures: v1, v4
    local v30 = v4[v29]
    if v30 == nil then
        return
    end
    v4[v29] = nil
    local v31, v32 = pcall(v30)
    if not v31 then
        local v33 = v29:GetFullName()
        v1:AtError():Log((("UI effect cleanup failed on %*: %*"):format(v33, v32)))
    end
end

for v34, v35 in PlayerGui:GetDescendants() do
    if v35:GetAttribute("UIEffect") ~= nil then
        watch(v35)
        startEffect(v35)
    end
end
PlayerGui.DescendantAdded:Connect(function(v36) -- line 122 | captures: startEffect, watch
    if v36:GetAttribute("UIEffect") ~= nil then
        task.defer(function() -- line 126 | captures: v36, startEffect, watch
            if v36.Parent ~= nil and v36:GetAttribute("UIEffect") ~= nil then
                watch(v36)
                startEffect(v36)
            end
        end)
    end
end)
return v2
