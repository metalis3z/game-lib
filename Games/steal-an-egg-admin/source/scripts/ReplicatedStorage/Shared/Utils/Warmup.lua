-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreProfileManager = require(ReplicatedStorage.Shared.Modules.CoreProfileManager)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}
local v2

function v2(v3, v4) -- line 12 | captures: v2
    local v5 = typeof(v4)
    if v5 == "table" then
        for v6, v7 in v4 do
            v2(v3, v7)
        end
    elseif v5 == "number" then
        local v8 = "rbxassetid://" .. v4
        table.insert(v3, v8)
    else
        if v5 ~= "string" and v5 ~= "Instance" then
            error((("a %* is not something that can be preloaded"):format(v5)))
        end
        table.insert(v3, v4)
    end
end

function v1.ResolveAssetId(v9) -- line 32 | captures: ReplicatedStorage
    local v10
    if type(v9) == "number" then
        v10 = v9
    else
        local v11 = string.match(v9, "^rbxassetid://(%d+)$") or string.match(v9, "^http://www%.roblox%.com/asset/%?id=(%d+)$")
        v10 = tonumber(v9)
        if not v10 then
            if v11 then
                v10 = tonumber(v11)
            else
                v10 = nil
            end
        end
    end
    if v10 ~= nil and v10 % 1 == 0 and v10 ~= (1/0) then
        if v10 > 0 then
            return (require(ReplicatedStorage.Shared.Utils.AssetOverrides).Resolve(v10))
        end
        return nil
    end
    return nil
end

function v1.WarmAssets(...) -- line 62 | captures: v2, ContentProvider
    local function v12(v13, ...)
        table.insert(v13, ...)
    end

    local v14 = {}
    local v15 = {}
    local v16 = select("#", ...)
    for v17 = 1, v16 do
        v2(v15, (select(v17, ...)))
    end
    local v18 = debug.traceback()
    local v19 = table.clone(v15)
    for v20 = 1, 3 do
        v14[1] = {}
        local v21, v22 = pcall(((function(v23)
            return function() -- line 76 | captures: v23, v19, ContentProvider
                ContentProvider:PreloadAsync(v19, ((function(v24)
                    return function(v25, v26) -- line 77 | captures: v24
                        if v26 ~= Enum.AssetFetchStatus.Success then
                            local v27 = v24[1]
                            table.insert(v27, v25)
                        end
                    end
                end)(v23)))
            end
        end)(v14)))
        if not v21 then
            local v28 = ("preloading threw on attempt %*: %*"):format(v20, v22)
            warn(v28, v18)
            v14[1] = v19
        end
        if #v14[1] == 0 then
            return v15
        end
        v19 = v14[1]
        if v20 < 3 then
            task.wait(v20 * 0.5)
        end
        local v29 = v14[1]
        local v30 = {}
        v30[1] = v29
        v14 = v30
    end
    ("still unresolved after %* preload attempts:"):format(3)
    local v31 = {}
    for v32, v33 in ipairs(v19) do
        if v32 > 15 then
            v12(v31, ("...and %d more"):format(#v19 - 15))
            break
        end
        local v34 = tostring(v33)
        table.insert(v31, v34)
    end
    return v15
end

function v1.WarmSounds(...) -- line 110 | captures: v2, ContentProvider
    local v35 = {}
    local v36 = select("#", ...)
    for v37 = 1, v36 do
        v2(v35, (select(v37, ...)))
    end
    local v38 = table.create(#v35)
    local v39 = #v35
    for v40 = 1, v39 do
        local Sound = Instance.new("Sound")
        Sound.SoundId = v35[v40]
        v38[v40] = Sound
    end
    ContentProvider:PreloadAsync(v38)
end

local v41 = t.tuple(t.table, t.optional(t.table))

local function locateProfile(v42, v43, v44) -- line 129 | captures: CoreProfileManager
    local _profileManager = v42._profileManager
    if _profileManager then
        if CoreProfileManager.is(_profileManager) then
            return _profileManager:Get(v44)
        end
    else
        local ProfileContainer = v43.ProfileContainer
        if typeof(v44) == "Instance" and v44:IsA("Player") then
            local UserId = v44.UserId
            if v43.GetPlayerInstance then
                UserId = v44
            elseif v43.StringUserId then
                UserId = tostring(UserId)
            end
            return ProfileContainer[UserId]
        end
        if type(v44) == "string" then
            return ProfileContainer[v44]
        end
        if type(v44) == "number" then
            return ProfileContainer[v44]
        end
        return nil
    end
end

local function assembleDispatch(v45, v46) -- line 156 | captures: locateProfile
    return function(v47, v48, ...) -- line 157 | captures: v45, v46, locateProfile
        local v49 = if v46.AutoDestroyIfNoIndex then v48 or "Destroy" else v48
        if type(v49) == "string" then
            local v50 = locateProfile(v45, v46, v47)
            if type(v50) == "table" then
                return v50[v49](v50, ...)
            end
        end
        return nil
    end
end

function v1.BuildProfileDispatch(v51, v52) -- line 176 | captures: v41, locateProfile
    if v41(v51, v52) then
        return function(v53, v54, ...) -- line 178 | captures: v51, v52, locateProfile
            local v55 = if v52.AutoDestroyIfNoIndex then v54 or "Destroy" else v54
            if type(v55) == "string" then
                local v56 = locateProfile(v51, v52, v53)
                if type(v56) == "table" then
                    return v56[v55](v56, ...)
                end
            end
            return nil
        end
    end
    return nil
end

return table.freeze(v1)
