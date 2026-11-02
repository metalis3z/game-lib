-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

MarketplaceService = Game:GetService("MarketplaceService")
HttpService = Game:GetService("HttpService")
Workspace = Game:GetService("Workspace")
Tool = script.Parent.Parent
Libraries = Tool:WaitForChild("Libraries")
Support = require(Libraries:WaitForChild("SupportLibrary"))
RegionModule = require(Libraries:WaitForChild("Region"))

local v1 = if Tool.Parent:IsA("Plugin") then "Plugin" else "Tool"

Security = {}
Security.AreaHeight = 500
Security.AllowPublicBuilding = true
Security.AllowedLocations = { Workspace }
Security.Areas = Workspace:FindFirstChild("[Private Building Areas]")
Workspace.ChildAdded:Connect(function(v2) -- line 29
    if not Security.Areas and v2.Name == "[Private Building Areas]" then
        Security.Areas = v2
    end
end)
Workspace.ChildRemoved:Connect(function(v3) -- line 34
    if Security.Areas and v3.Name == "[Private Building Areas]" then
        Security.Areas = nil
    end
end)

local function IsAreaAuthorizedForPlayer(v4, v5) -- line 40
    local v6 = v4:FindFirstChild("[Permissions]")
    if not v6 then
        return
    end
    local v7 = require(v6)
    if not v7 then
        return
    end
    for v8, v9 in pairs(v7) do
        if v9.Type == "Group" then
            if v5:IsInGroup(v9.GroupId) then
                if not v9.Ranks then
                    return true
                end
                if v9.Ranks then
                    local Ranks = v9.Ranks
                    local v10, v11 = tostring(Ranks):match("([<>]?=?)([0-9]+)")
                    local v12 = v5:GetRankInGroup(v9.GroupId)
                    local v13 = tonumber(v11)
                    if not v10 and v12 == v13 then
                        return true
                    end
                    if v10 == "=" and v12 == v13 then
                        return true
                    end
                    if v10 == ">" and v13 < v12 then
                        return true
                    end
                    if v10 == "<" and v12 < v13 then
                        return true
                    end
                    if v10 == ">=" and v13 <= v12 then
                        return true
                    end
                    if v10 == "<=" and v12 <= v13 then
                        return true
                    end
                end
            end
        elseif v9.Type == "Player" or v9.Type == "Owner" then
            if v5.userId == v9.PlayerId or v5.Name == v9.PlayerName then
                return true
            end
        else
            if v9.Type == "Anybody" then
                return true
            end
            if v9.Type == "Friends" then
                if v5:IsFriendsWith(v9.PlayerId) then
                    return true
                end
            elseif v9.Type == "Asset" then
                if MarketplaceService:PlayerOwnsAsset(v5, v9.AssetId) then
                    return true
                end
            elseif v9.Type == "Team" then
                if v9.Team and v5.Team == v9.Team then
                    return true
                end
                if v9.TeamColor and v5.Team and v5.Team.TeamColor == v9.TeamColor then
                    return true
                end
                if v9.TeamName and v5.Team and v5.Team.Name == v9.TeamName then
                    return true
                end
            elseif v9.Type == "NoBC" then
                if v5.MembershipType == Enum.MembershipType.None then
                    return true
                end
            elseif v9.Type == "AnyBC" then
                if v5.MembershipType ~= Enum.MembershipType.None then
                    return true
                end
            elseif v9.Type == "BC" then
                if v5.MembershipType == Enum.MembershipType.BuildersClub then
                    return true
                end
            elseif v9.Type == "TBC" then
                if v5.MembershipType == Enum.MembershipType.TurboBuildersClub then
                    return true
                end
            elseif v9.Type == "OBC" then
                if v5.MembershipType == Enum.MembershipType.OutrageousBuildersClub then
                    return true
                end
            elseif v9.Type == "Callback" then
                return v9.Callback(v5)
            end
        end
    end
    return false
end

Security.IsAreaAuthorizedForPlayer = IsAreaAuthorizedForPlayer

local function IsItemAllowed(v14, v15) -- line 162
    local Folder, v16
    if v14:IsA("BasePart") then
        local v17 = not v14:IsA("Terrain")
        if v17 then
            Folder = v17
            v16 = true
        elseif v14:IsA("Model") then
            local v18 = not v14:IsA("Workspace")
            if v18 then
                Folder = v18
                v16 = true
            else
                v16 = false
            end
        else
            v16 = false
        end
    elseif v14:IsA("Model") then
        local v19 = not v14:IsA("Workspace")
        if v19 then
            Folder = v19
            v16 = true
        else
            v16 = false
        end
    else
        v16 = false
    end
    if not v16 then
        Folder = v14:IsA("Folder") or v14:IsA("Smoke") or v14:IsA("Fire") or v14:IsA("Sparkles") or v14:IsA("DataModelMesh") or v14:IsA("Decal") or v14:IsA("Texture") or v14:IsA("Light")
    end
    if Folder then
        for v20, v21 in pairs(Security.AllowedLocations) do
            if v14:IsDescendantOf(v21) then
                return true
            end
        end
    end
    return false
end

Security.IsItemAllowed = IsItemAllowed

local function IsLocationAllowed(v22, v23) -- line 192
    for v24, v25 in pairs(Security.AllowedLocations) do
        if v25 == v22 or v22:IsDescendantOf(v25) then
            return true
        end
    end
    return false
end

Security.IsLocationAllowed = IsLocationAllowed

local v26 = v1

local function AreAreasEnabled() -- line 206 | captures: v26
    return Security.Areas and v26 == "Tool"
end

Security.AreAreasEnabled = AreAreasEnabled

local function ArePartsViolatingAreas(v27, v28, v29, v30) -- line 217
    if Security.AreAreasEnabled() and next(v27) then
        local v31 = v30 or {}
        local v32, v33 = Security.GetSelectionAreas(v27, true)
        for v34, v35 in pairs(v32) do
            if v31[v35] == nil then
                v31[v35] = Security.IsAreaAuthorizedForPlayer(v35, v28)
            end
            if v29 then
                if v31[v35] then
                    for v36, v37 in pairs(v33) do
                        if v36.Area == v35 and Support.CountKeys(v27) == #v37 then
                            return false
                        end
                    end
                end
            elseif v31[v35] == false then
                return true
            end
        end
        if #v32 == 0 then
            return not Security.AllowPublicBuilding
        end
        if v29 then
            return true
        end
        if v33 and not Security.AllowPublicBuilding then
            local v38 = {}
            for v39, v40 in pairs(v33) do
                for v41, v42 in pairs(v40) do
                    v38[v42] = v38[v42] or 0
                    for v43, v44 in pairs(Support.GetPartCorners(v42)) do
                        if v39:CastPoint(v44.p) then
                            v38[v42] += 1
                        end
                    end
                end
            end
            for v45, v46 in pairs(v38) do
                if v46 ~= 8 then
                    return true
                end
            end
        end
    end
    return false
end

Security.ArePartsViolatingAreas = ArePartsViolatingAreas

local function GetSelectionAreas(v47, v48) -- line 308
    if Security.AreAreasEnabled() then
        local v49 = v48 and {} or nil
        local v50 = {}
        for v51, v52 in pairs(Security.Areas:GetChildren()) do
            local new = RegionModule.new
            local v53 = v52.CFrame * CFrame.new(0, Security.AreaHeight / 2 - v52.Size.Y / 2, 0)
            local X = v52.Size.X
            local v54 = Security.AreaHeight + v52.Size.Y
            local Z = v52.Size.Z
            local v55 = new(v53, (Vector3.new(X, v54, Z)))
            v55.Area = v52
            local v56 = v55:CastParts(v47)
            if #v56 > 0 then
                table.insert(v50, v52)
                if v49 then
                    v49[v55] = v56
                end
            end
        end
        return v50, v49
    end
    return {}
end

Security.GetSelectionAreas = GetSelectionAreas

local function GetPermissions(v57, v58) -- line 347
    if not Security.AreAreasEnabled() then
        return
    end
    local v59 = {}
    for v60, v61 in pairs(v57) do
        v59[v61] = Security.IsAreaAuthorizedForPlayer(v61, v58)
    end
    return v59
end

Security.GetPermissions = GetPermissions
return Security
