-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")
local v1 = {}
local v2
local v3 = 0
local v4 = {
    ImageLabel = "Image",
    ImageButton = "Image",
    Decal = "Texture",
    Texture = "Texture",
    ParticleEmitter = "Texture",
    Beam = "Texture",
    Trail = "Texture",
    Sound = "SoundId",
    Animation = "AnimationId",
    StringValue = "Value"
}

local function propertyFor(v5) -- line 46 | captures: v4
    for v6, v7 in pairs(v4) do
        if v5:IsA(v6) then
            return v7
        end
    end
    return nil
end

function v1.ReadFolder(v8) -- line 56 | captures: v1, v4
    local v9 = {}
    if typeof(v8) == "Instance" then
        for v10, v11 in ipairs(v8:GetDescendants()) do
            local Name = v11.Name
            local v12 = tonumber(Name)
            local v13
            if v12 == nil then
            else
                local v14
                for v15, v16 in pairs(v4) do
                    if v11:IsA(v15) then
                        v14 = v16
                        break
                    end
                    v14 = nil
                end
                v13 = v14 or nil
            end
            if v13 ~= nil then
                local pcall_2 = pcall
                local v17 = v11
                local v18 = v13
                local v19, v20 = pcall_2(function() -- line 65 | captures: v17, v18
                    return v17[v18]
                end)
                local v21 = v19 and v1.ToId(v20) or nil
                if v21 ~= nil and v21 ~= v12 then
                    v9[v12] = v21
                end
            end
        end
    end
    return v9
end

local function loadMap() -- line 80 | captures: HttpService, ReplicatedStorage, RunService, ServerStorage, v1
    if RunService:IsServer() then
        local AssetOverrides = ServerStorage:FindFirstChild("AssetOverrides")
        if AssetOverrides == nil then
            return nil
        end
        return v1.ReadFolder(AssetOverrides)
    end
    local AssetOverridesData = ReplicatedStorage.Shared:FindFirstChild("AssetOverridesData")
    if not (AssetOverridesData ~= nil and AssetOverridesData:IsA("StringValue")) then
        return nil
    end
    if AssetOverridesData.Value == "" then
        return {}
    end
    local v22, v23 = pcall(HttpService.JSONDecode, HttpService, AssetOverridesData.Value)
    if not (v22 and type(v23) == "table") then
        warn("[AssetOverrides] the published override map could not be read:", v23)
        return {}
    end
    local v24 = {}
    for v25, v26 in pairs(v23) do
        local v27 = v1.ToId(v25)
        local v28 = v1.ToId(v26)
        if v27 ~= nil and v28 ~= nil and v27 ~= v28 then
            v24[v27] = v28
        end
    end
    return v24
end

local function ToId(v29) -- line 113
    if type(v29) == "number" then
        if v29 % 1 ~= 0 or v29 <= 0 then
            return nil
        end
        return v29
    end
    if type(v29) == "string" then
        local v30 = string.match(v29, "^rbxassetid://(%d+)$") or string.match(v29, "^http://www%.roblox%.com/asset/%?id=(%d+)$") or string.match(v29, "^(%d+)$")
        local v31 = tonumber(v30)
        if v31 == nil or v31 <= 0 then
            return nil
        end
        return v31
    end
    return nil
end

v1.ToId = ToId

local v32 = table.freeze({})

function v1.Map() -- line 135 | captures: v2, v3, loadMap, v32
    if v2 == nil then
        local v33 = os.clock()
        if v33 < v3 then
            return v32
        end
        v3 = v33 + 0.5
        v2 = loadMap()
        return v2 or v32
    end
    return v2
end

function v1.IsEmpty() -- line 148 | captures: v1
    return next(v1.Map()) == nil
end

function v1.Resolve(v34) -- line 153 | captures: v1
    local v35 = v1.ToId(v34)
    if v35 == nil then
        return v34
    end
    local v36 = v1.Map()[v35]
    if v36 == nil then
        return v34
    end
    if type(v34) == "number" then
        return v36
    end
    return "rbxassetid://" .. v36
end

function v1.ApplyToInstance(v37) -- line 170 | captures: v1, v4
    local v38 = false
    local v39
    for v40, v41 in pairs(v4) do
        if v37:IsA(v40) then
            v39 = v41
            v38 = true
            break
        end
    end
    if not v38 then
        v39 = nil
    end
    if v39 ~= nil then
        local v42 = v39
        local v43, v44 = pcall(function() -- line 175 | captures: v37, v42
            return v37[v42]
        end)
        if v43 and type(v44) == "string" and v44 ~= "" then
            local v45 = v1.Resolve(v44)
            if v45 == v44 then
                return false
            end
            local v46 = v39
            pcall(function() -- line 185 | captures: v37, v45, v46
                v37[v46] = v45
            end)
            return true
        end
    end
    return false
end

function v1.ApplyToTable(v47, v48) -- line 196 | captures: v1
    if typeof(v47) == "Instance" then
        if v1.ApplyToInstance(v47) then
            return 1
        end
    elseif type(v47) == "table" then
        local v49 = v48 or {}
        if v49[v47] then
            return 0
        end
        v49[v47] = true
        local v50 = 0
        for v51, v52 in pairs(v47) do
            v50 += v1.ApplyToTable(v52, v49)
        end
        return v50
    end
    return 0
end

function v1.ApplyToDirectories() -- line 217 | captures: ReplicatedStorage, v1
    if v1.IsEmpty() then
        return 0
    end
    local Data = ReplicatedStorage:FindFirstChild("Data")
    if Data == nil then
        return 0
    end
    local v53 = {}
    local v54 = 0
    for v55, v56 in ipairs({ "Assets", "Guards" }) do
        local v57 = Data:FindFirstChild(v56)
        if v57 ~= nil and v57:IsA("ModuleScript") then
            local v58, v59 = pcall(require, v57)
            if v58 and type(v59) == "table" then
                v54 += v1.ApplyToTable(v59, v53)
            end
        end
    end
    return v54
end

function v1.Watch(v60) -- line 241 | captures: v1
    if v1.IsEmpty() or not (typeof(v60) == "Instance") then
        return nil
    end
    v1.ApplyToInstance(v60)
    for v61, v62 in ipairs(v60:GetDescendants()) do
        v1.ApplyToInstance(v62)
    end
    return v60.DescendantAdded:Connect(function(v63) -- line 249 | captures: v1
        v1.ApplyToInstance(v63)
    end)
end

return v1
