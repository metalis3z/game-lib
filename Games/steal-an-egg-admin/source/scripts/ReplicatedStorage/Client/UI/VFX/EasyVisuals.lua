-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dropshadow = require(script.Dropshadow)
local Gradient = require(script.Gradient)
require(script.Layers)
local GradientTemplates = require(script.GradientTemplates)
local Stroke = require(script.Stroke)
local t = require(ReplicatedStorage.Packages.t)
local VisibilityGate = require(script.VisibilityGate)
local v1 = {
    UIStroke = true,
    UIGradient = true
}
local v2 = {}

v2.__index = v2
v2.Gradient = Gradient
v2.Stroke = Stroke
v2.Dropshadow = Dropshadow
v2.Templates = GradientTemplates
v2.CurrentEffects = {}

local Presets = script.Presets
local GuiObject = t.instanceIsA("GuiObject")
local v3 = t.strict(t.union(GuiObject, t.instanceIsA("UIStroke")))
local v4 = t.strict(t.string)
local v5 = t.strict(t.number)
local v6 = t.strict(t.union(t.ColorSequence, t.Color3))
local v7 = t.strict(t.union(t.NumberSequence, t.number))

local function broadcast(v8, v9) -- line 29
    for v10, v11 in v8.EffectObjects do
        local v12 = v11[v9]
        if v12 then
            v12(v11)
        end
    end
end

local function absorb(v13, v14) -- line 41
    if v14 then
        for v15, v16 in v14 do
            v13[#v13 + 1] = v16
        end
    end
end

local function teardown(v17) -- line 52
    for v18, v19 in v17.detached do
        v19.Parent = v17.host
    end
    for v20, v21 in v17.watchers do
        if typeof(v21) == "table" then
            local Destroy = v21.Destroy
            if typeof(Destroy) == "function" then
                v21:Destroy()
            end
        else
            v21:Disconnect()
        end
    end
    table.clear(v17.detached)
    table.clear(v17.watchers)
    for v22, v23 in v17.EffectObjects do
        local Destroy = v23.Destroy
        if Destroy then
            Destroy(v23)
        end
    end
    v17.lifeWatch:Disconnect()
end

local function watchLifetime(v24) -- line 84 | captures: teardown
    local host = v24.host
    return host.AncestryChanged:Connect(function() -- line 86 | captures: v24, host, teardown
        if not host:IsDescendantOf(game) then
            teardown(v24)
        end
    end)
end

local function stashExisting(v25) -- line 93 | captures: v1
    local detached = v25.detached
    for v26, v27 in (v25.host:GetChildren()) do
        if v1[v27.ClassName] then
            detached[#detached + 1] = v27
            v27.Parent = nil
        end
    end
end

function v2.new(v28, v29, v30, v31, v32, v33, v34, v35, v36) -- line 105 | captures: VisibilityGate, v2, Presets, v3, v4, v5, v6, v7, teardown, stashExisting
    v3(v28)
    v4(v29)
    local v37 = Presets:FindFirstChild(v29)
    local v38 = ("EasyVisuals has no preset named %*"):format(v29)
    assert(v37, v38)
    if v30 then
        v5(v30)
    end
    if v31 then
        v5(v31)
    end
    if v33 then
        v6(v33)
    end
    if v34 then
        v7(v34)
    end
    local v39 = {
        isPaused = false,
        Diagnostic = "DIAGNOSTIC VALUE",
        host = v28,
        EffectObjects = {},
        detached = {},
        watchers = {}
    }
    if v35 == nil then
        v39.resumesWhenShown = true
    else
        v39.resumesWhenShown = v35
    end
    v39.drift = v30 or 0.007
    v39.width = v31 or 1
    local v40 = setmetatable(v39, v2)
    local v41 = require(v37)({
        Host = v28,
        Drift = v40.drift,
        Width = v40.width,
        Color = v33,
        Alpha = v34,
        Chain = v36
    })
    local v42 = typeof(v41) == "table"
    assert(v42, "an effect preset must hand back a table")
    if v32 then
        stashExisting(v40)
    end
    local watchers = v40.watchers
    local Connections = v41.Connections
    if Connections then
        for v43, v44 in Connections do
            watchers[#watchers + 1] = v44
        end
    end
    local EffectObjects = v40.EffectObjects
    local Effects = v41.Effects
    if Effects then
        for v45, v46 in Effects do
            EffectObjects[#EffectObjects + 1] = v46
        end
    end
    local host = v40.host
    local AncestryChanged = host.AncestryChanged
    v40.lifeWatch = AncestryChanged:Connect(function() -- line 170 | captures: v40, host, teardown
        if not host:IsDescendantOf(game) then
            teardown(v40)
        end
    end)
    local v47 = VisibilityGate.Watch(v28, function() -- line 176 | captures: v40
        for v48, v49 in v40.EffectObjects do
            local Suspend = v49.Suspend
            if Suspend then
                Suspend(v49)
            end
        end
    end, function() -- line 187 | captures: v40
        if v40.resumesWhenShown then
            for v50, v51 in v40.EffectObjects do
                local Wake = v51.Wake
                if Wake then
                    Wake(v51)
                end
            end
        end
    end)
    if v47 then
        local watchers = v40.watchers
        watchers[#watchers + 1] = v47
    end
    return v40
end

function v2.Destroy(v52) -- line 207 | captures: teardown
    teardown(v52)
end

local function Suspend(v53) -- line 210
    for v54, v55 in v53.EffectObjects do
        local Suspend = v55.Suspend
        if Suspend then
            Suspend(v55)
        end
    end
end

v2.Suspend = Suspend

local function Wake(v56) -- line 222
    for v57, v58 in v56.EffectObjects do
        local Wake = v58.Wake
        if Wake then
            Wake(v58)
        end
    end
end

v2.Wake = Wake
return table.freeze(v2)
