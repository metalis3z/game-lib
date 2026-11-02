-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Trove = require(script.Parent.Parent.Trove)
local Signal = require(script.Parent.Parent.Signal)
local v1 = {}

v1.__index = v1

function v1.new(v2, v3) -- line 10 | captures: Trove, Signal, v1
    local v4 = {}
    setmetatable(v4, v1)
    v4._trove = Trove.new()
    v4._shown = v4._trove:Construct(Signal)
    v4._shownTrove = Trove.new()
    v4._trove:Add(v4._shownTrove)
    v4.Instance = v2:FindFirstChild(v3)

    local function OnInstanceSet() -- line 18 | captures: v4
        local Instance = v4.Instance
        if typeof(Instance) ~= "Instance" then
            return
        end
        v4._shown:Fire(Instance, v4._shownTrove)
        local Parent = Instance:GetPropertyChangedSignal("Parent")
        v4._shownTrove:Connect(Parent, function() -- line 23 | captures: Instance, v4
            if not Instance.Parent then
                v4._shownTrove:Clean()
            end
        end)
        v4._shownTrove:Add(function() -- line 28 | captures: Instance, v4
            if v4.Instance == Instance then
                v4.Instance = nil
            end
        end)
    end

    v4._trove:Connect(v2.ChildAdded, function(v5) -- line 35 | captures: v3, v4, OnInstanceSet
        if v5.Name == v3 and not v4.Instance then
            v4.Instance = v5
            OnInstanceSet()
        end
    end)
    if v4.Instance then
        OnInstanceSet()
    end
    return v4
end

function v1.primary(v6) -- line 46 | captures: Trove, Signal, v1
    local v7 = {}
    setmetatable(v7, v1)
    v7._trove = Trove.new()
    v7._shown = v7._trove:Construct(Signal)
    v7._shownTrove = Trove.new()
    v7._trove:Add(v7._shownTrove)
    v7.Instance = v6.PrimaryPart
    v7._trove:Connect(v6:GetPropertyChangedSignal("PrimaryPart"), function() -- line 57 | captures: v6, v7
        local PrimaryPart = v6.PrimaryPart
        v7._shownTrove:Clean()
        v7.Instance = PrimaryPart
        if PrimaryPart then
            v7._shown:Fire(PrimaryPart, v7._shownTrove)
        end
    end)
    if v7.Instance then
        local PrimaryPart = v6.PrimaryPart
        v7._shownTrove:Clean()
        v7.Instance = PrimaryPart
        if PrimaryPart then
            v7._shown:Fire(PrimaryPart, v7._shownTrove)
        end
    end
    return v7
end

local function Observe(v8, v9) -- line 75
    if v8.Instance then
        task.spawn(v9, v8.Instance, v8._shownTrove)
    end
    return v8._shown:Connect(v9)
end

v1.Observe = Observe

local function Destroy(v10) -- line 81
    v10._trove:Destroy()
end

v1.Destroy = Destroy
return v1
