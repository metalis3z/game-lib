-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local v1 = require(ReplicatedStorage.Packages.Log).new()
local v2 = {}
local v3 = {}
local v4 = {}
local v5 = 1
local v6 = 0
local v7 = false
local v8 = 0
local v9 = 1
local v10 = os.clock()

local function getTargetColor(v11) -- line 20
    if v11:IsA("BasePart") then
    end
    return v11.Color
end

local function setTargetColor(v12, v13) -- line 26
    if v12:IsA("BasePart") then
    end
    v12.Color = v13
end

local function getOriginalHsv(v14) -- line 33
    local OriginalColor = v14:GetAttribute("OriginalColor")
    if typeof(OriginalColor) == "Vector3" then
        return OriginalColor
    end
    if v14:IsA("BasePart") then
    end
    local Color = v14.Color
    local v15, v16, v17 = Color3.toHSV(Color)
    local v18 = Vector3.new(v15, v16, v17)
    v14:SetAttribute("OriginalColor", v18)
    return v18
end

local function addTarget(v19) -- line 49 | captures: v2, v3
    if v3[v19] ~= nil then
        return
    end
    local OriginalColor = v19:GetAttribute("OriginalColor")
    if typeof(OriginalColor) ~= "Vector3" then
        if v19:IsA("BasePart") then
        end
        local Color = v19.Color
        local v20, v21, v22 = Color3.toHSV(Color)
        v19:SetAttribute("OriginalColor", (Vector3.new(v20, v21, v22)))
    end
    table.insert(v2, v19)
    v3[v19] = #v2
end

local function removeTarget(v23) -- line 67 | captures: v9, v1, v2, v3
    local v24 = v3[v23]
    if v24 == nil then
        v1:AtWarning():Log((("Rainbow target %* not found in active targets."):format((v23:GetFullName()))))
    else
        local OriginalColor = v23:GetAttribute("OriginalColor")
        if typeof(OriginalColor) == "Vector3" then
            local v25 = Color3.fromHSV(OriginalColor.X, OriginalColor.Y, OriginalColor.Z)
            if v23:IsA("BasePart") then
            end
            v23.Color = v25
        end
        local v26 = v2[#v2]
        v2[v24] = v26
        v3[v26] = v24
        table.remove(v2)
        v3[v23] = nil
        if #v2 < v9 then
            v9 = 1
        end
    end
end

local function drainQueue() -- line 91 | captures: v5, v6, v7, v2, v3, v4, removeTarget
    while true do
        if v5 <= v6 then
            local v27 = v4[v5]
            v5 += 1
            if v27.Add then
                local Target = v27.Target
                if v3[Target] == nil then
                    local OriginalColor = Target:GetAttribute("OriginalColor")
                    if typeof(OriginalColor) ~= "Vector3" then
                        if Target:IsA("BasePart") then
                        end
                        local Color = Target.Color
                        local v28, v29, v30 = Color3.toHSV(Color)
                        Target:SetAttribute("OriginalColor", (Vector3.new(v28, v29, v30)))
                    end
                    table.insert(v2, Target)
                    v3[Target] = #v2
                end
            else
                removeTarget(v27.Target)
            end
        else
            break
        end
    end
    table.clear(v4)
    v5 = 1
    v6 = 0
    v7 = false
end

local function enqueue(v31, v32) -- line 121 | captures: v6, v7, v4, drainQueue
    v6 += 1
    v4[v6] = {
        Target = v31,
        Add = v32
    }
    if not v7 then
        v7 = true
        task.defer(drainQueue)
    end
end

local function requireRainbowTarget(v33) -- line 130
    local v34 = v33:IsA("BasePart") or v33:IsA("SurfaceAppearance")
    local v35 = ("RainbowPart tag requires a BasePart or SurfaceAppearance, got %*"):format(v33.ClassName)
    assert(v34, v35)
    return v33
end

local function preRender(v36) -- line 138 | captures: v8, v9, v2, v10
    local v37 = v8 + math.min(v36, 0.06666666666666667)
    v8 = math.min(v37, 0.25)
    if v8 < 0.05 then
        return
    end
    v8 -= 0.05
    local v38 = #v2
    if v38 == 0 then
        return
    end
    debug.profilebegin("WorkspaceRainbowParts :: PreRender")
    local v39 = (os.clock() - v10) * 0.5 % 1
    local v40 = v9 + 50 - 1
    local v41 = math.min(v40, v38)
    local v42 = v9
    for v43 = v42, v41 do
        local v44 = v2[v43]
        if v44.Parent ~= nil then
            local OriginalColor = v44:GetAttribute("OriginalColor")
            if typeof(OriginalColor) ~= "Vector3" then
                if v44:IsA("BasePart") then
                end
                local Color = v44.Color
                local v45, v46, v47 = Color3.toHSV(Color)
                OriginalColor = Vector3.new(v45, v46, v47)
                v44:SetAttribute("OriginalColor", OriginalColor)
            end
            local Y = OriginalColor.Y
            local Z = OriginalColor.Z
            if Y <= 0.05 then
                if Z >= 0.9725490196078431 then
                    Z = 1
                end
                Y = 1
            end
            local v48 = Color3.fromHSV(v39, Y, Z)
            if v44:IsA("BasePart") then
            end
            v44.Color = v48
        end
    end
    v9 = v41 + 1
    if v38 < v9 then
        v9 = 1
    end
    debug.profileend()
end

CollectionService:GetInstanceAddedSignal("RainbowPart"):Connect(function(v49) -- line 195 | captures: v6, v7, ReplicatedStorage, v4, drainQueue
    if v49:IsDescendantOf(ReplicatedStorage) then
        return
    end
    local v50 = v49:IsA("BasePart") or v49:IsA("SurfaceAppearance")
    local v51 = ("RainbowPart tag requires a BasePart or SurfaceAppearance, got %*"):format(v49.ClassName)
    assert(v50, v51)
    v6 += 1
    v4[v6] = {
        Add = true,
        Target = v49
    }
    if not v7 then
        v7 = true
        task.defer(drainQueue)
    end
end)
CollectionService:GetInstanceRemovedSignal("RainbowPart"):Connect(function(v52) -- line 213 | captures: v6, v7, ReplicatedStorage, v4, drainQueue
    if v52:IsDescendantOf(ReplicatedStorage) then
        return
    end
    local v53 = v52:IsA("BasePart") or v52:IsA("SurfaceAppearance")
    local v54 = ("RainbowPart tag requires a BasePart or SurfaceAppearance, got %*"):format(v52.ClassName)
    assert(v53, v54)
    v6 += 1
    v4[v6] = {
        Add = false,
        Target = v52
    }
    if not v7 then
        v7 = true
        task.defer(drainQueue)
    end
end)
for v55, v56 in CollectionService:GetTagged("RainbowPart") do
    if not v56:IsDescendantOf(ReplicatedStorage) then
        local v57 = v56:IsA("BasePart") or v56:IsA("SurfaceAppearance")
        local v58 = ("RainbowPart tag requires a BasePart or SurfaceAppearance, got %*"):format(v56.ClassName)
        assert(v57, v58)
        if v3[v56] == nil then
            local OriginalColor = v56:GetAttribute("OriginalColor")
            if typeof(OriginalColor) ~= "Vector3" then
                if v56:IsA("BasePart") then
                end
                local Color = v56.Color
                local v59, v60, v61 = Color3.toHSV(Color)
                v56:SetAttribute("OriginalColor", (Vector3.new(v59, v60, v61)))
            end
            table.insert(v2, v56)
            v3[v56] = #v2
        end
    end
end
RunService.PreRender:Connect(preRender)
