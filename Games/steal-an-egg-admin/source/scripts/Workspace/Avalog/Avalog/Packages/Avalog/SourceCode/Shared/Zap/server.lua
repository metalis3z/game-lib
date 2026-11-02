-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

if RunService:IsClient() then
    error("Cannot use the server module on the client!")
end

if _G.__ZAP then
    if _G.__ZAP.ZAP then
        if _G.__ZAP.ZAP.AVALOG ~= nil then
            error((("There is already an instance of Zap with the same remote_scope of AVALOG, remote_folder of ZAP and the version of %*. Change the remote_scope or remote_folder option of both Zap instances"):format(_G.__ZAP.ZAP.AVALOG)))
        end
    else
        _G.__ZAP.ZAP = {}
    end
else
    _G.__ZAP = {
        ZAP = {}
    }
end
_G.__ZAP.ZAP.AVALOG = "0.6.28"

local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
local v12 = {
    CFrame.Angles(0, 0, 0),
    CFrame.Angles(1.5707963267948966, 0, 0),
    CFrame.Angles(0, 3.141592653589793, 3.141592653589793),
    CFrame.Angles(-1.5707963267948966, 0, 0),
    CFrame.Angles(0, 3.141592653589793, 1.5707963267948966),
    CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966),
    CFrame.Angles(0, 0, 1.5707963267948966),
    CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966),
    CFrame.Angles(-1.5707963267948966, -1.5707963267948966, 0),
    CFrame.Angles(0, -1.5707963267948966, 0),
    CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0),
    CFrame.Angles(0, 1.5707963267948966, 3.141592653589793),
    CFrame.Angles(0, -1.5707963267948966, 3.141592653589793),
    CFrame.Angles(0, 3.141592653589793, 0),
    CFrame.Angles(-1.5707963267948966, -3.141592653589793, 0),
    CFrame.Angles(0, 0, 3.141592653589793),
    CFrame.Angles(1.5707963267948966, 3.141592653589793, 0),
    CFrame.Angles(0, 0, -1.5707963267948966),
    CFrame.Angles(0, -1.5707963267948966, -1.5707963267948966),
    CFrame.Angles(0, -3.141592653589793, -1.5707963267948966),
    CFrame.Angles(0, 1.5707963267948966, -1.5707963267948966),
    CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0),
    CFrame.Angles(0, 1.5707963267948966, 0),
    CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0)
}

local function alloc(v13) -- line 66 | captures: v1, v2, v3, v5
    local v14 = v2 + v13
    if v3 < v14 then
        while true do
            local v15 = v2 + v13
            if v3 < v15 then
                v3 *= 2
                continue
            end
            break
        end
        local v16 = buffer.create(v3)
        buffer.copy(v16, 0, v1, 0, v2)
        v1 = v16
    end
    v5 = v2
    v2 += v13
    return v5
end

local function read(v17) -- line 84 | captures: v8
    local v18 = v8
    v8 += v17
    return v18
end

local function save() -- line 91 | captures: v1, v2, v3, v4, v6, v11
    return {
        buff = v1,
        used = v2,
        size = v3,
        inst = v4,
        outgoing_ids = v6,
        incoming_ids = v11
    }
end

local function load(v19) -- line 102 | captures: v1, v2, v3, v4, v6, v11
    v1 = v19.buff
    v2 = v19.used
    v3 = v19.size
    v4 = v19.inst
    v6 = v19.outgoing_ids
    v11 = v19.incoming_ids
end

local function load_empty() -- line 118 | captures: v1, v2, v3, v4, v6, v11
    v1 = buffer.create(64)
    v2 = 0
    v3 = 64
    v4 = {}
    v6 = {}
    v11 = {}
end

load_empty()
local v20 = {}
local v21 = {}
local v22 = {}

if RunService:IsRunning() then
    local ZAP = ReplicatedStorage:FindFirstChild("ZAP")
    if ZAP == nil then
        ZAP = Instance.new("Folder")
        ZAP.Name = "ZAP"
        ZAP.Parent = ReplicatedStorage
    end
    local AVALOG_RELIABLE = ZAP:FindFirstChild("AVALOG_RELIABLE")
    local AVALOG_RELIABLE_2 = AVALOG_RELIABLE
    if AVALOG_RELIABLE == nil then
        AVALOG_RELIABLE = Instance.new("RemoteEvent")
        AVALOG_RELIABLE_2 = AVALOG_RELIABLE
        AVALOG_RELIABLE.Name = "AVALOG_RELIABLE"
        AVALOG_RELIABLE.Parent = ZAP
    end
    local v23 = {}

    local function load_player(v24) -- line 178 | captures: v1, v2, v3, v4, v6, v11, load_empty, v23
        if v23[v24] then
            local v25 = v23[v24]
            v1 = v25.buff
            v2 = v25.used
            v3 = v25.size
            v4 = v25.inst
            v6 = v25.outgoing_ids
            v11 = v25.incoming_ids
        else
            load_empty()
        end
    end

    Players.PlayerRemoving:Connect(function(v26) -- line 186 | captures: v23
        v23[v26] = nil
    end)

    local function SendEvents() -- line 339 | captures: AVALOG_RELIABLE_2, v23
        for v27, v28 in v23 do
            if v28.used > 0 then
                local v29 = buffer.create(v28.used)
                buffer.copy(v29, 0, v28.buff, 0, v28.used)
                AVALOG_RELIABLE_2:FireClient(v27, v29, v28.inst)
                v28.buff = buffer.create(64)
                v28.used = 0
                v28.size = 64
                table.clear(v28.inst)
            end
        end
    end

    RunService.Heartbeat:Connect(SendEvents)
    local v30 = table.create(5)
    AVALOG_RELIABLE_2.OnServerEvent:Connect(function(v31, v32, v33) -- line 358 | captures: v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, alloc, load_empty, v23, v30
        v7 = v32
        v9 = v33
        v8 = 0
        v10 = 0
        local v34 = buffer.len(v32)
        while v8 < v34 do
            local v35 = v8
            v8 += 1
            local v36 = buffer.readu8(v32, v35)
            if v36 == 1 then
                local v37 = v7
                local readstring = v8
                v8 += 1
                v35 = buffer.readu8(v37, readstring)
                local v38 = {}
                readstring = v7
                local BodyPartColors = v8
                v8 += 2
                v37 = buffer.readu16(readstring, BodyPartColors)
                v38.Accessories = table.create(v37)
                local v39, v40, v41, AccessoryType, v42, v43
                for v44 = 1, v37 do
                    v40 = v7
                    v41 = v8
                    v8 += 1
                    v39 = buffer.readu8(v40, v41)
                    v40 = {}
                    AccessoryType = v7
                    v43 = v8
                    v8 += 8
                    v40.AssetId = buffer.readf64(AccessoryType, v43)
                    v40.AccessoryType = {}
                    AccessoryType = v7
                    v43 = v8
                    v8 += 2
                    v41 = buffer.readu16(AccessoryType, v43)
                    AccessoryType = v40.AccessoryType
                    v43 = buffer.readstring
                    v42 = v7
                    local v45 = v8
                    v8 += v41
                    AccessoryType.EnumType = v43(v42, v45, v41)
                    AccessoryType = v40.AccessoryType
                    v42 = v7
                    v45 = v8
                    v8 += 2
                    AccessoryType.Value = buffer.readu16(v42, v45)
                    if bit32.btest(v39, 1) then
                        v43 = v7
                        v42 = v8
                        v8 += 2
                        v40.Order = buffer.readu16(v43, v42)
                    else
                        v40.Order = nil
                    end
                    if bit32.btest(v39, 2) then
                        v43 = v7
                        v42 = v8
                        v8 += 4
                        v40.Puffiness = buffer.readf32(v43, v42)
                    else
                        v40.Puffiness = nil
                    end
                    if bit32.btest(v39, 4) then
                        v40.IsLayered = bit32.btest(v39, 8)
                    else
                        v40.IsLayered = nil
                    end
                    local v46, v47
                    if bit32.btest(v39, 16) then
                        v42 = v7
                        v45 = v8
                        v8 += 4
                        v43 = buffer.readf32(v42, v45)
                        v45 = v7
                        v46 = v8
                        v8 += 4
                        v42 = buffer.readf32(v45, v46)
                        v46 = v7
                        v47 = v8
                        v8 += 4
                        v45 = buffer.readf32(v46, v47)
                        v40.Position = Vector3.new(v43, v42, v45)
                    else
                        v40.Position = nil
                    end
                    if bit32.btest(v39, 32) then
                        v42 = v7
                        v45 = v8
                        v8 += 4
                        v43 = buffer.readf32(v42, v45)
                        v45 = v7
                        v46 = v8
                        v8 += 4
                        v42 = buffer.readf32(v45, v46)
                        v46 = v7
                        v47 = v8
                        v8 += 4
                        v45 = buffer.readf32(v46, v47)
                        v40.Rotation = Vector3.new(v43, v42, v45)
                    else
                        v40.Rotation = nil
                    end
                    if bit32.btest(v39, 64) then
                        v42 = v7
                        v45 = v8
                        v8 += 4
                        v43 = buffer.readf32(v42, v45)
                        v45 = v7
                        v46 = v8
                        v8 += 4
                        v42 = buffer.readf32(v45, v46)
                        v46 = v7
                        v47 = v8
                        v8 += 4
                        v45 = buffer.readf32(v46, v47)
                        v40.Scale = Vector3.new(v43, v42, v45)
                    else
                        v40.Scale = nil
                    end
                    v38.Accessories[v44] = v40
                end
                v38.Emotes = {}
                if not bit32.btest(v35, 1) then
                    v40 = v7
                    v41 = v8
                    v8 += 2
                    readstring = buffer.readu16(v40, v41) + 1
                    for v48 = 1, readstring do
                        AccessoryType = v7
                        v43 = v8
                        v8 += 2
                        v41 = buffer.readu16(AccessoryType, v43)
                        AccessoryType = buffer.readstring
                        v43 = v7
                        v42 = v8
                        v8 += v41
                        AccessoryType = AccessoryType(v43, v42, v41)
                        v43 = v7
                        v42 = v8
                        v8 += 2
                        local v49 = buffer.readu16(v43, v42)
                        v43 = table.create(v49)
                        for v50 = 1, v49 do
                            local v51 = v7
                            local v52 = v8
                            v8 += 8
                            v43[v50] = buffer.readf64(v51, v52)
                        end
                        v38.Emotes[AccessoryType] = v43
                    end
                end
                BodyPartColors = v7
                local v53 = v8
                v8 += 2
                readstring = buffer.readu16(BodyPartColors, v53)
                v38.EquippedEmotes = table.create(readstring)
                for v54 = 1, readstring do
                    v40 = {}
                    AccessoryType = v7
                    v43 = v8
                    v8 += 2
                    v41 = buffer.readu16(AccessoryType, v43)
                    AccessoryType = buffer.readstring
                    v43 = v7
                    v42 = v8
                    v8 += v41
                    v40.Name = AccessoryType(v43, v42, v41)
                    v43 = v7
                    v42 = v8
                    v8 += 2
                    v40.Slot = buffer.readu16(v43, v42)
                    v38.EquippedEmotes[v54] = v40
                end
                v53 = v7
                v39 = v8
                v8 += 8
                v38.Face = buffer.readf64(v53, v39)
                v38.Scale = {}
                BodyPartColors = v38.Scale
                v39 = v7
                v40 = v8
                v8 += 4
                BodyPartColors.BodyType = buffer.readf32(v39, v40)
                BodyPartColors = v38.Scale
                v39 = v7
                v40 = v8
                v8 += 4
                BodyPartColors.Depth = buffer.readf32(v39, v40)
                BodyPartColors = v38.Scale
                v39 = v7
                v40 = v8
                v8 += 4
                BodyPartColors.Head = buffer.readf32(v39, v40)
                BodyPartColors = v38.Scale
                v39 = v7
                v40 = v8
                v8 += 4
                BodyPartColors.Height = buffer.readf32(v39, v40)
                BodyPartColors = v38.Scale
                v39 = v7
                v40 = v8
                v8 += 4
                BodyPartColors.Proportion = buffer.readf32(v39, v40)
                BodyPartColors = v38.Scale
                v39 = v7
                v40 = v8
                v8 += 4
                BodyPartColors.Width = buffer.readf32(v39, v40)
                v38.Animations = {}
                BodyPartColors = v38.Animations
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.Walk = buffer.readf64(v39, v40)
                BodyPartColors = v38.Animations
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.Run = buffer.readf64(v39, v40)
                BodyPartColors = v38.Animations
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.Fall = buffer.readf64(v39, v40)
                BodyPartColors = v38.Animations
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.Climb = buffer.readf64(v39, v40)
                BodyPartColors = v38.Animations
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.Swim = buffer.readf64(v39, v40)
                BodyPartColors = v38.Animations
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.Idle = buffer.readf64(v39, v40)
                BodyPartColors = v38.Animations
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.Mood = buffer.readf64(v39, v40)
                BodyPartColors = v38.Animations
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.Jump = buffer.readf64(v39, v40)
                v38.BodyParts = {}
                BodyPartColors = v38.BodyParts
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.Head = buffer.readf64(v39, v40)
                BodyPartColors = v38.BodyParts
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.Torso = buffer.readf64(v39, v40)
                BodyPartColors = v38.BodyParts
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.LeftArm = buffer.readf64(v39, v40)
                BodyPartColors = v38.BodyParts
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.RightArm = buffer.readf64(v39, v40)
                BodyPartColors = v38.BodyParts
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.LeftLeg = buffer.readf64(v39, v40)
                BodyPartColors = v38.BodyParts
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.RightLeg = buffer.readf64(v39, v40)
                v38.BodyPartColors = {}
                BodyPartColors = v38.BodyPartColors
                v53 = Color3.fromRGB
                v40 = v7
                v41 = v8
                v8 += 1
                v39 = buffer.readu8(v40, v41)
                v41 = v7
                AccessoryType = v8
                v8 += 1
                v40 = buffer.readu8(v41, AccessoryType)
                AccessoryType = v7
                v43 = v8
                v8 += 1
                BodyPartColors.Head = v53(v39, v40, (buffer.readu8(AccessoryType, v43)))
                BodyPartColors = v38.BodyPartColors
                v53 = Color3.fromRGB
                v40 = v7
                v41 = v8
                v8 += 1
                v39 = buffer.readu8(v40, v41)
                v41 = v7
                AccessoryType = v8
                v8 += 1
                v40 = buffer.readu8(v41, AccessoryType)
                AccessoryType = v7
                v43 = v8
                v8 += 1
                BodyPartColors.Torso = v53(v39, v40, (buffer.readu8(AccessoryType, v43)))
                BodyPartColors = v38.BodyPartColors
                v53 = Color3.fromRGB
                v40 = v7
                v41 = v8
                v8 += 1
                v39 = buffer.readu8(v40, v41)
                v41 = v7
                AccessoryType = v8
                v8 += 1
                v40 = buffer.readu8(v41, AccessoryType)
                AccessoryType = v7
                v43 = v8
                v8 += 1
                BodyPartColors.LeftArm = v53(v39, v40, (buffer.readu8(AccessoryType, v43)))
                BodyPartColors = v38.BodyPartColors
                v53 = Color3.fromRGB
                v40 = v7
                v41 = v8
                v8 += 1
                v39 = buffer.readu8(v40, v41)
                v41 = v7
                AccessoryType = v8
                v8 += 1
                v40 = buffer.readu8(v41, AccessoryType)
                AccessoryType = v7
                v43 = v8
                v8 += 1
                BodyPartColors.RightArm = v53(v39, v40, (buffer.readu8(AccessoryType, v43)))
                BodyPartColors = v38.BodyPartColors
                v53 = Color3.fromRGB
                v40 = v7
                v41 = v8
                v8 += 1
                v39 = buffer.readu8(v40, v41)
                v41 = v7
                AccessoryType = v8
                v8 += 1
                v40 = buffer.readu8(v41, AccessoryType)
                AccessoryType = v7
                v43 = v8
                v8 += 1
                BodyPartColors.LeftLeg = v53(v39, v40, (buffer.readu8(AccessoryType, v43)))
                BodyPartColors = v38.BodyPartColors
                v53 = Color3.fromRGB
                v40 = v7
                v41 = v8
                v8 += 1
                v39 = buffer.readu8(v40, v41)
                v41 = v7
                AccessoryType = v8
                v8 += 1
                v40 = buffer.readu8(v41, AccessoryType)
                AccessoryType = v7
                v43 = v8
                v8 += 1
                BodyPartColors.RightLeg = v53(v39, v40, (buffer.readu8(AccessoryType, v43)))
                v38.Clothing = {}
                BodyPartColors = v38.Clothing
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.Shirt = buffer.readf64(v39, v40)
                BodyPartColors = v38.Clothing
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.TShirt = buffer.readf64(v39, v40)
                BodyPartColors = v38.Clothing
                v39 = v7
                v40 = v8
                v8 += 8
                BodyPartColors.Pants = buffer.readf64(v39, v40)
                if v30[1] then
                    task.spawn(v30[1], v31, v38)
                end
            elseif v36 == 2 then
                local v55 = v7
                local readstring = v8
                v8 += 1
                local v56 = buffer.readu8(v55, readstring)
                local v57 = {}
                readstring = v7
                local BodyPartColors = v8
                v8 += 2
                v55 = buffer.readu16(readstring, BodyPartColors)
                readstring = buffer.readstring
                BodyPartColors = v7
                local v58 = v8
                v8 += v55
                v57.itemId = readstring(BodyPartColors, v58, v55)
                if bit32.btest(v56, 1) then
                    v57.itemType = "Asset"
                else
                    v57.itemType = "Bundle"
                end
                if bit32.btest(v56, 2) then
                    BodyPartColors = v7
                    v58 = v8
                    v8 += 2
                    readstring = buffer.readu16(BodyPartColors, v58)
                    BodyPartColors = buffer.readstring
                    v58 = v7
                    local v59 = v8
                    v8 += readstring
                    v57.tintColor = BodyPartColors(v58, v59, readstring)
                else
                    v57.tintColor = nil
                end
                if v30[2] then
                    task.spawn(v30[2], v31, v57)
                end
            elseif v36 == 3 then
                local v60 = v7
                local readstring = v8
                v8 += 1
                v35 = buffer.readu8(v60, readstring)
                v60 = bit32.btest(v35, 1)
                if v30[3] then
                    task.spawn(v30[3], v31, v60)
                end
            elseif v36 == 0 then
                local v61 = v7
                local BodyPartColors = v8
                v8 += 1
                local v62 = buffer.readu8(v61, BodyPartColors) + 1
                v61 = v62 >= 1
                assert(v61, "value is less than 1!")
                local readstring = v62 <= 20
                assert(readstring, "value is more than 20!")
                local v63 = table.create(v62)
                for v64 = 1, v62 do
                    local v65 = {}
                    local v66 = v7
                    local v67 = v8
                    v8 += 2
                    local v68 = buffer.readu16(v66, v67)
                    v66 = buffer.readstring
                    v67 = v7
                    local AccessoryType = v8
                    v8 += v68
                    v65.Id = v66(v67, AccessoryType, v68)
                    v65.Type = {}
                    v67 = v7
                    AccessoryType = v8
                    v8 += 2
                    v66 = buffer.readu16(v67, AccessoryType)
                    v67 = v65.Type
                    AccessoryType = buffer.readstring
                    local v69 = v7
                    local v70 = v8
                    v8 += v66
                    v67.EnumType = AccessoryType(v69, v70, v66)
                    v67 = v65.Type
                    v69 = v7
                    v70 = v8
                    v8 += 2
                    v67.Value = buffer.readu16(v69, v70)
                    v63[v64] = v65
                end
                if v30[0] then
                    task.spawn(v30[0], v31, v63)
                end
            elseif v36 == 4 then
                local v71 = v8
                v8 += 1
                local v72 = buffer.readu8(v32, v71)
                if v30[4] then
                    task.spawn(function(v73, v74, v75) -- line 529 | captures: v1, v2, v3, v4, v5, v6, v11, alloc, load_empty, v23, v30
                        local v76 = v30[4](v73, v75)
                        if v23[v73] then
                            local v77 = v23[v73]
                            v1 = v77.buff
                            v2 = v77.used
                            v3 = v77.size
                            v4 = v77.inst
                            v6 = v77.outgoing_ids
                            v11 = v77.incoming_ids
                        else
                            load_empty()
                        end
                        alloc(1)
                        local v78 = v1
                        local v79 = v5
                        buffer.writeu8(v78, v79, 1)
                        alloc(1)
                        local v80 = v1
                        local v81 = v5
                        buffer.writeu8(v80, v81, v74)
                        local v82 = alloc(1)
                        local v83
                        if v76 == nil then
                            v83 = 0
                        else
                            v83 = bit32.bor(0, 1)
                            local v84 = #v76.latestVersion
                            alloc(2)
                            local v85 = v1
                            local v86 = v5
                            buffer.writeu16(v85, v86, v84)
                            alloc(v84)
                            buffer.writestring(v1, v5, v76.latestVersion, v84)
                            local v87 = #v76.featuredItems
                            alloc(2)
                            local v88 = v1
                            local v89 = v5
                            buffer.writeu16(v88, v89, v87)
                            for v90 = 1, v87 do
                                local v91 = alloc(1)
                                local v92 = v76.featuredItems[v90]
                                local v93 = #v92.itemId
                                alloc(2)
                                local v94 = v1
                                local v95 = v5
                                buffer.writeu16(v94, v95, v93)
                                alloc(v93)
                                buffer.writestring(v1, v5, v92.itemId, v93)
                                local v96
                                if v92.itemType == "Asset" then
                                    v96 = bit32.bor(0, 1)
                                else
                                    if v92.itemType ~= "Bundle" then
                                        error("Invalid enumerator")
                                    end
                                    v96 = 0
                                end
                                if v92.tintColor ~= nil then
                                    v96 = bit32.bor(v96, 2)
                                    local v97 = #v92.tintColor
                                    alloc(2)
                                    local v98 = v1
                                    local v99 = v5
                                    buffer.writeu16(v98, v99, v97)
                                    alloc(v97)
                                    buffer.writestring(v1, v5, v92.tintColor, v97)
                                end
                                local v100 = v1
                                buffer.writeu8(v100, v91, v96)
                            end
                            local v101 = #v76.pinnedItems
                            alloc(2)
                            local v102 = v1
                            local v103 = v5
                            buffer.writeu16(v102, v103, v101)
                            for v104 = 1, v101 do
                                local v105 = alloc(1)
                                local v106 = v76.pinnedItems[v104]
                                local v107 = #v106.itemId
                                alloc(2)
                                local v108 = v1
                                local v109 = v5
                                buffer.writeu16(v108, v109, v107)
                                alloc(v107)
                                buffer.writestring(v1, v5, v106.itemId, v107)
                                local v110
                                if v106.itemType == "Asset" then
                                    v110 = bit32.bor(0, 1)
                                else
                                    if v106.itemType ~= "Bundle" then
                                        error("Invalid enumerator")
                                    end
                                    v110 = 0
                                end
                                if v106.tintColor ~= nil then
                                    v110 = bit32.bor(v110, 2)
                                    local v111 = #v106.tintColor
                                    alloc(2)
                                    local v112 = v1
                                    local v113 = v5
                                    buffer.writeu16(v112, v113, v111)
                                    alloc(v111)
                                    buffer.writestring(v1, v5, v106.tintColor, v111)
                                end
                                local v114 = v1
                                buffer.writeu8(v114, v105, v110)
                            end
                            local v115 = #v76.promotedItems
                            alloc(2)
                            local v116 = v1
                            local v117 = v5
                            buffer.writeu16(v116, v117, v115)
                            for v118 = 1, v115 do
                                local v119 = alloc(1)
                                local v120 = v76.promotedItems[v118]
                                local v121 = #v120.itemId
                                alloc(2)
                                local v122 = v1
                                local v123 = v5
                                buffer.writeu16(v122, v123, v121)
                                alloc(v121)
                                buffer.writestring(v1, v5, v120.itemId, v121)
                                local v124
                                if v120.itemType == "Asset" then
                                    v124 = bit32.bor(0, 1)
                                else
                                    if v120.itemType ~= "Bundle" then
                                        error("Invalid enumerator")
                                    end
                                    v124 = 0
                                end
                                if v120.tintColor ~= nil then
                                    v124 = bit32.bor(v124, 2)
                                    local v125 = #v120.tintColor
                                    alloc(2)
                                    local v126 = v1
                                    local v127 = v5
                                    buffer.writeu16(v126, v127, v125)
                                    alloc(v125)
                                    buffer.writestring(v1, v5, v120.tintColor, v125)
                                end
                                local v128 = #v120.promotionId
                                alloc(2)
                                local v129 = v1
                                local v130 = v5
                                buffer.writeu16(v129, v130, v128)
                                alloc(v128)
                                buffer.writestring(v1, v5, v120.promotionId, v128)
                                alloc(4)
                                local v131 = v1
                                local v132 = v5
                                local bid = v120.bid
                                buffer.writef32(v131, v132, bid)
                                alloc(4)
                                local v133 = v1
                                local v134 = v5
                                local startTime = v120.startTime
                                buffer.writef32(v133, v134, startTime)
                                alloc(4)
                                local v135 = v1
                                local v136 = v5
                                local endTime = v120.endTime
                                buffer.writef32(v135, v136, endTime)
                                local v137 = v1
                                buffer.writeu8(v137, v119, v124)
                            end
                        end
                        local v138 = v1
                        buffer.writeu8(v138, v82, v83)
                        v23[v73] = {
                            buff = v1,
                            used = v2,
                            size = v3,
                            inst = v4,
                            outgoing_ids = v6,
                            incoming_ids = v11
                        }
                    end, v31, v72, nil)
                end
            else
                error("Unknown event id")
            end
        end
    end)
    table.freeze(v21)
    table.freeze(v22)
    local v139 = { SendEvents = SendEvents }
    local v140 = {}

    function v140.SetCallback(v141) -- line 659 | captures: v30
        v30[1] = v141
        return function() -- line 720 | captures: v30
            v30[1] = nil
        end
    end

    v139.UpdateAvatar = v140
    local v142 = {}

    function v142.SetCallback(v143) -- line 726 | captures: v30
        v30[2] = v143
        return function() -- line 732 | captures: v30
            v30[2] = nil
        end
    end

    v139.RecordPurchase = v142
    local v144 = {}

    function v144.SetCallback(v145) -- line 738 | captures: v30
        v30[3] = v145
        return function() -- line 740 | captures: v30
            v30[3] = nil
        end
    end

    v139.RecordMenuToggle = v144
    local v146 = {}

    function v146.SetCallback(v147) -- line 746 | captures: v30
        v30[4] = v147
        return function() -- line 769 | captures: v30
            v30[4] = nil
        end
    end

    v139.GetCloudConfig = v146
    local v148 = {}

    function v148.Fire(v149) -- line 775 | captures: v1, v2, v3, v4, v5, v6, v11, alloc, load_empty, v23
        if v23[v149] then
            local v150 = v23[v149]
            v1 = v150.buff
            v2 = v150.used
            v3 = v150.size
            v4 = v150.inst
            v6 = v150.outgoing_ids
            v11 = v150.incoming_ids
        else
            load_empty()
        end
        alloc(1)
        local v151 = v1
        local v152 = v5
        buffer.writeu8(v151, v152, 0)
        v23[v149] = {
            buff = v1,
            used = v2,
            size = v3,
            inst = v4,
            outgoing_ids = v6,
            incoming_ids = v11
        }
    end

    function v148.FireAll() -- line 781 | captures: v1, v2, v3, v4, v5, v6, v11, Players, alloc, load_empty, v23
        load_empty()
        alloc(1)
        local v153 = v1
        local v154 = v5
        buffer.writeu8(v153, v154, 0)
        local v155 = v1
        local v156 = v2
        local v157 = v4
        for v158, v159 in Players:GetPlayers() do
            if v23[v159] then
                local v160 = v23[v159]
                v1 = v160.buff
                v2 = v160.used
                v3 = v160.size
                v4 = v160.inst
                v6 = v160.outgoing_ids
                v11 = v160.incoming_ids
            else
                load_empty()
            end
            alloc(v156)
            buffer.copy(v1, v5, v155, 0, v156)
            table.move(v157, 1, #v157, #v4 + 1, v4)
            v23[v159] = {
                buff = v1,
                used = v2,
                size = v3,
                inst = v4,
                outgoing_ids = v6,
                incoming_ids = v11
            }
        end
    end

    function v148.FireExcept(v161) -- line 794 | captures: v1, v2, v3, v4, v5, v6, v11, Players, alloc, load_empty, v23
        load_empty()
        alloc(1)
        local v162 = v1
        local v163 = v5
        buffer.writeu8(v162, v163, 0)
        local v164 = v1
        local v165 = v2
        local v166 = v4
        for v167, v168 in Players:GetPlayers() do
            if v168 ~= v161 then
                if v23[v168] then
                    local v169 = v23[v168]
                    v1 = v169.buff
                    v2 = v169.used
                    v3 = v169.size
                    v4 = v169.inst
                    v6 = v169.outgoing_ids
                    v11 = v169.incoming_ids
                else
                    load_empty()
                end
                alloc(v165)
                buffer.copy(v1, v5, v164, 0, v165)
                table.move(v166, 1, #v166, #v4 + 1, v4)
                v23[v168] = {
                    buff = v1,
                    used = v2,
                    size = v3,
                    inst = v4,
                    outgoing_ids = v6,
                    incoming_ids = v11
                }
            end
        end
    end

    function v148.FireList(v170) -- line 809 | captures: v1, v2, v3, v4, v5, v6, v11, alloc, load_empty, v23
        load_empty()
        alloc(1)
        local v171 = v1
        local v172 = v5
        buffer.writeu8(v171, v172, 0)
        local v173 = v1
        local v174 = v2
        local v175 = v4
        for v176, v177 in v170 do
            if v23[v177] then
                local v178 = v23[v177]
                v1 = v178.buff
                v2 = v178.used
                v3 = v178.size
                v4 = v178.inst
                v6 = v178.outgoing_ids
                v11 = v178.incoming_ids
            else
                load_empty()
            end
            alloc(v174)
            buffer.copy(v1, v5, v173, 0, v174)
            table.move(v175, 1, #v175, #v4 + 1, v4)
            v23[v177] = {
                buff = v1,
                used = v2,
                size = v3,
                inst = v4,
                outgoing_ids = v6,
                incoming_ids = v11
            }
        end
    end

    function v148.FireSet(v179) -- line 822 | captures: v1, v2, v3, v4, v5, v6, v11, alloc, load_empty, v23
        load_empty()
        alloc(1)
        local v180 = v1
        local v181 = v5
        buffer.writeu8(v180, v181, 0)
        local v182 = v1
        local v183 = v2
        local v184 = v4
        for v185 in v179 do
            if v23[v185] then
                local v186 = v23[v185]
                v1 = v186.buff
                v2 = v186.used
                v3 = v186.size
                v4 = v186.inst
                v6 = v186.outgoing_ids
                v11 = v186.incoming_ids
            else
                load_empty()
            end
            alloc(v183)
            buffer.copy(v1, v5, v182, 0, v183)
            table.move(v184, 1, #v184, #v4 + 1, v4)
            v23[v185] = {
                buff = v1,
                used = v2,
                size = v3,
                inst = v4,
                outgoing_ids = v6,
                incoming_ids = v11
            }
        end
    end

    v139.CloudConfigReset = v148
    local v187 = {}

    function v187.SetCallback(v188) -- line 837 | captures: v30
        v30[0] = v188
        return function() -- line 845 | captures: v30
            v30[0] = nil
        end
    end

    v139.BulkPurchaseAvatarItems = v187
    return v139
end

local function v189() -- line 134
end

return (table.freeze({
    SendEvents = v189,
    UpdateAvatar = table.freeze({ SetCallback = v189 }),
    RecordPurchase = table.freeze({ SetCallback = v189 }),
    RecordMenuToggle = table.freeze({ SetCallback = v189 }),
    GetCloudConfig = table.freeze({ SetCallback = v189 }),
    CloudConfigReset = table.freeze({
        Fire = v189,
        FireAll = v189,
        FireExcept = v189,
        FireList = v189,
        FireSet = v189
    }),
    BulkPurchaseAvatarItems = table.freeze({ SetCallback = v189 })
}))
