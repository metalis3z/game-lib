-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserService = game:GetService("UserService")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local v1 = require(ReplicatedStorage.Packages.Log).new()
local Signal = require(ReplicatedStorage.Packages.Signal)
local t = require(ReplicatedStorage.Packages.t)
local v2 = {}
local v3 = {}
local v4 = {}
local v5 = {}

local function readThrough(v6, v7, v9) -- line 17
    local v10 = v6[v7]
    if v10 == nil then
        local v11 = v9(v7)
        v6[v7] = v11
        return v11
    end
    return v10
end

local function fetchName(v12) -- line 26 | captures: Players
    local v13 = Players:GetPlayerByUserId(v12)
    if v13 then
        return v13.Name
    end
    local v14 = Players:GetNameFromUserIdAsync(v12)
    local v15 = type(v14) == "string"
    assert(v15)
    local v16 = if #v14 > 0 then #v14 <= 20 else false
    assert(v16)
    return v14
end

local function fetchDisplayName(v17) -- line 38 | captures: Players, UserService
    local v18 = Players:GetPlayerByUserId(v17)
    if v18 then
        return v18.DisplayName
    end
    local v19 = UserService:GetUserInfosByUserIdsAsync({ v17 })[1]
    local v20 = v19 ~= nil
    local v21 = ("no user record came back for %*"):format(v17)
    assert(v20, v21)
    local DisplayName = v19.DisplayName
    local v22 = type(DisplayName) == "string"
    local v23 = ("the display name for %* was not a string"):format(v17)
    assert(v22, v23)
    local v24 = #DisplayName > 0
    local v25 = ("the display name for %* was empty"):format(v17)
    assert(v24, v25)
    return DisplayName
end

local function fetchThumbnail(v26) -- line 53 | captures: Players
    local v27 = string.split(v26, "-")
    local v28 = v27[1]
    local v29 = tonumber(v28)
    local v30 = ("the thumbnail key %* carries no user id"):format(v26)
    assert(v29, v30)
    local v31 = Enum.ThumbnailType[v27[2]]
    local v32 = ("the thumbnail key %* carries no thumbnail type"):format(v26)
    assert(v31, v32)
    local v33 = Enum.ThumbnailSize[v27[3]]
    local v34 = ("the thumbnail key %* carries no thumbnail size"):format(v26)
    assert(v33, v34)
    local v35 = Players:GetUserThumbnailAsync(v29, v31, v33)
    local v36 = type(v35) == "string"
    local v37 = ("the thumbnail for %* was not a string"):format(v26)
    assert(v36, v37)
    local v38 = if #v35 > 0 then #v35 <= 100 else false
    local v39 = ("the thumbnail url for %* was an implausible length"):format(v26)
    assert(v38, v39)
    return v35
end

function v2.Name(v40) -- line 68 | captures: Players, v3
    local v41 = v3[v40]
    if v41 == nil then
        local v42 = Players:GetPlayerByUserId(v40)
        local v43
        if v42 then
            v43 = v42.Name
        else
            v43 = Players:GetNameFromUserIdAsync(v40)
            local v44 = type(v43) == "string"
            assert(v44)
            local v45 = if #v43 > 0 then #v43 <= 20 else false
            assert(v45)
        end
        v3[v40] = v43
        return v43
    end
    return v41
end

function v2.DisplayName(v46) -- line 89 | captures: v4, fetchDisplayName
    local v47 = v4[v46]
    if v47 == nil then
        v47 = fetchDisplayName(v46)
        v4[v46] = v47
    end
    local v48 = type(v47) == "string"
    local v49 = ("the cached display name for %* was not a string"):format(v46)
    assert(v48, v49)
    return v47
end

function v2.Thumbnail(v50, v51, v52) -- line 104 | captures: v5, fetchThumbnail
    local v53 = table.concat({
        v50,
        v51.Name,
        v52.Name
    }, "-")
    local v54 = v5[v53]
    if v54 == nil then
        local v55 = fetchThumbnail(v53)
        v5[v53] = v55
        return v55
    end
    return v54
end

function v2.FromTool(v56) -- line 115 | captures: Players, t
    t.strict(t.instanceIsA("Tool"))(v56)
    local Parent = v56.Parent
    if Parent then
        if Parent:IsA("Player") then
            return Parent
        end
        if Parent:IsA("Model") then
            return (Players:GetPlayerFromCharacter(Parent))
        end
    end
    return nil
end

function v2.NearestWithin(v57, v58, v59) -- line 139 | captures: Players, t
    t.strict(t.instanceIsA("Player"))(v57)
    t.strict(t.number)(v58)
    local Character = v57.Character
    local v60 = Character and Character:FindFirstChild("HumanoidRootPart")
    if v60 then
        local v61 = {}
        for v62, v63 in Players:GetPlayers() do
            local Character
            if v63 == v57 then
            else
                Character = v63.Character
            end
            local v64 = Character and Character:FindFirstChild("HumanoidRootPart")
            local v65 = if v64 then v64.Position - v60.Position else nil
            if v65 and v65.Magnitude <= v8 then
                local v66 = {
                    player = v63,
                    delta = v65,
                    distance = v65.Magnitude
                }
                table.insert(v61, v66)
            end
        end
        table.sort(v61, function(v67, v68) -- line 174
            return v67.distance < v68.distance
        end)
        local v69
        if v59 then
            local v70 = math.floor(v59)
            v69 = math.max(0, v70)
        else
            v69 = 1
        end
        if v69 > 1 then
            local v71 = {}
            local v72 = #v61
            local v73 = math.min(v69, v72)
            for v74 = 1, v73 do
                v71[v74] = v61[v74]
            end
            return v71
        end
        local v75 = v61[1]
        if v75 then
            return v75.player, v75.delta
        end
        return nil, (Vector3.new(1, 0, 0))
    end
    return nil, (Vector3.new(1, 0, 0))
end

v2.RosterUpdated = Signal.new()

local v76 = {}

local function fetchRoster(v77) -- line 205 | captures: Players, Constants, v1, v2, v76
    local v78, v79 = pcall(function() -- line 207 | captures: v77, Players, Constants
        local v80 = Players:GetFriendsAsync(v77.UserId)
        local v81 = {}
        while true do
            for v82, v83 in v80:GetCurrentPage() do
                local Id = v83.Id
                table.insert(v81, Id)
            end
            if v80.IsFinished then
                break
            end
            v80:AdvanceToNextPageAsync()
            if Constants.IS_CLIENT then
                task.wait(0.05)
            end
        end
        return v81
    end)
    local v84 = if v78 then v79 else {}
    if v77.Parent then
        v76[v77] = { List = v84 }
    end
    if not v78 then
        local v85 = ("no friend list for %*: %*, cache:"):format(v77.Name, v79)
        v1:AtWarning():Log(v85, v76)
    end
    v2.RosterUpdated:Fire(v77)
end

Players.PlayerAdded:Connect(fetchRoster)
Players.PlayerRemoving:Connect(function(v86) -- line 239 | captures: v76
    v76[v86] = nil
end)
for v87, v88 in Players:GetPlayers() do
    task.spawn(fetchRoster, v88)
end

function v2.CountPresent(v89) -- line 245 | captures: Players, v76
    local v90 = v76[v89]
    local v91 = if v90 then v90.List else {}
    local v92 = 0
    for v93, v94 in v91 do
        local v95 = if Players:GetPlayerByUserId(v94) == nil then 0 else 1
        v92 += v95
    end
    return v92
end

function v2.IdList(v96) -- line 266 | captures: v76
    local v97 = v76[v96]
    if v97 then
        return (table.clone(v97.List))
    end
    return {}
end

return table.freeze(v2)
