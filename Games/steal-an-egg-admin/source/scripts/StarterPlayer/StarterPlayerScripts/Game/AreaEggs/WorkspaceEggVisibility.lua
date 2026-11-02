-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
local Signal = require(ReplicatedStorage.Packages.Signal)
local v1 = {}
local v2

local function eggContainer() -- line 19 | captures: v2, Workspace
    if v2 ~= nil and v2.Parent == Workspace then
        return v2
    end
    local v3 = Workspace:WaitForChild("AreaEggSlotsClient", 15)
    if not (v3 ~= nil and v3:IsA("Folder")) then
        warn("[WorkspaceEggVisibility] Workspace.AreaEggSlotsClient never arrived; creating a local one")
        v3 = Instance.new("Folder")
        v3.Name = "AreaEggSlotsClient"
        v3.Parent = Workspace
    end
    v2 = v3
    return v3
end

local v4 = { ModelAdded = Signal.new() }

function v4.ApplyModelHidden(v5, v6) -- line 38 | captures: t
    t.strict(t.instanceIsA("Model"))(v5)
    t.strict(t.boolean)(v6)
    for v7, v8 in ipairs(v5:GetDescendants()) do
        if v8:IsA("BasePart") then
            if v6 then
                v8.LocalTransparencyModifier = 1
            else
                v8.LocalTransparencyModifier = 0
            end
        end
    end
end

function v4.ResolveModel(v9) -- line 56 | captures: t, eggContainer
    t.strict(t.string)(v9)
    local v10 = eggContainer():FindFirstChild(v9)
    if v10 == nil then
        return nil
    end
    local Model = v10:IsA("Model")
    local v11 = ("Area egg %* must be a Model"):format(v9)
    assert(Model, v11)
    return v10
end

function v4.Container() -- line 69 | captures: eggContainer
    return (eggContainer())
end

function v4.SetHidden(v12, v13) -- line 72 | captures: t, v1, eggContainer, v4
    t.strict(t.string)(v12)
    t.strict(t.boolean)(v13)
    if v13 then
        v1[v12] = true
    else
        v1[v12] = nil
    end
    for v14, v15 in ipairs(eggContainer():GetChildren()) do
        if v15.Name == v12 and v15:IsA("Model") then
            v4.ApplyModelHidden(v15, v13)
        end
    end
end

function v4.Start() -- line 88 | captures: v1, eggContainer, v4
    local v16 = eggContainer()
    v16.ChildAdded:Connect(function(v17) -- line 90 | captures: v16, v1, v4
        if v17:IsA("Model") and v17.Parent == v16 then
            if v1[v17.Name] == true then
                v4.ApplyModelHidden(v17, true)
            end
        else
            return
        end
        v4.ModelAdded:Fire(v17)
    end)
end

return table.freeze(v4)
