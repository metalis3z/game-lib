-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

if RunService:IsServer() then
    error("Cannot use the client module on the server!")
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

local function alloc(v13) -- line 64 | captures: v1, v2, v3, v5
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

local function read(v17) -- line 82 | captures: v8
    local v18 = v8
    v8 += v17
    return v18
end

local function save() -- line 89 | captures: v1, v2, v3, v4, v6, v11
    return {
        buff = v1,
        used = v2,
        size = v3,
        inst = v4,
        outgoing_ids = v6,
        incoming_ids = v11
    }
end

local function load(v19) -- line 100 | captures: v1, v2, v3, v4, v6, v11
    v1 = v19.buff
    v2 = v19.used
    v3 = v19.size
    v4 = v19.inst
    v6 = v19.outgoing_ids
    v11 = v19.incoming_ids
end

local function load_empty() -- line 116 | captures: v1, v2, v3, v4, v6, v11
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
    local AVALOG_RELIABLE = ReplicatedStorage:WaitForChild("ZAP"):WaitForChild("AVALOG_RELIABLE")
    local RemoteEvent = AVALOG_RELIABLE:IsA("RemoteEvent")
    assert(RemoteEvent, "Expected AVALOG_RELIABLE to be a RemoteEvent")

    local function SendEvents() -- line 310 | captures: v1, v2, v3, v4, AVALOG_RELIABLE
        if v2 == 0 then
            return
        end
        local v23 = buffer.create(v2)
        buffer.copy(v23, 0, v1, 0, v2)
        AVALOG_RELIABLE:FireServer(v23, v4)
        v1 = buffer.create(64)
        v2 = 0
        v3 = 64
        table.clear(v4)
    end

    RunService.Heartbeat:Connect(SendEvents)
    local v24 = table.create(2)
    local v25 = table.create(2)
    local v26 = 0
    v25[0] = 0
    v25[1] = table.create(255)
    AVALOG_RELIABLE.OnClientEvent:Connect(function(v27, v28) -- line 331 | captures: v7, v8, v9, v10, v24, v25
        v7 = v27
        v9 = v28
        v8 = 0
        v10 = 0
        local v29 = buffer.len(v27)
        while v8 < v29 do
            local v30 = v8
            v8 += 1
            local v31 = buffer.readu8(v27, v30)
            if v31 == 0 then
                if v24[0] then
                    task.spawn(v24[0], nil)
                else
                    v25[0] += 1
                    if v25[0] > 16 then
                        warn((("[ZAP] %* events in queue for CloudConfigReset. Did you forget to attach a listener?"):format(v25[0])))
                    end
                end
            elseif v31 == 1 then
                local v32 = v7
                local v33 = v8
                v8 += 1
                local v34 = buffer.readu8(v32, v33)
                local v35 = v7
                local v36 = v8
                v8 += 1
                local v37 = buffer.readu8(v35, v36)
                local v38
                if bit32.btest(v37, 1) then
                    v38 = {}
                    local v39 = v7
                    local v40 = v8
                    v8 += 2
                    local v41 = buffer.readu16(v39, v40)
                    local readstring = buffer.readstring
                    local v42 = v7
                    local v43 = v8
                    v8 += v41
                    v38.latestVersion = readstring(v42, v43, v41)
                    local v44 = v7
                    local v45 = v8
                    v8 += 2
                    local v46 = buffer.readu16(v44, v45)
                    v38.featuredItems = table.create(v46)
                    for v47 = 1, v46 do
                        local v48 = v7
                        local v49 = v8
                        v8 += 1
                        local v50 = buffer.readu8(v48, v49)
                        local v51 = {}
                        local v52 = v7
                        local v53 = v8
                        v8 += 2
                        local v54 = buffer.readu16(v52, v53)
                        local readstring = buffer.readstring
                        local v55 = v7
                        local v56 = v8
                        v8 += v54
                        v51.itemId = readstring(v55, v56, v54)
                        if bit32.btest(v50, 1) then
                            v51.itemType = "Asset"
                        else
                            v51.itemType = "Bundle"
                        end
                        if bit32.btest(v50, 2) then
                            local v57 = v7
                            local v58 = v8
                            v8 += 2
                            local v59 = buffer.readu16(v57, v58)
                            local readstring = buffer.readstring
                            local v60 = v7
                            local v61 = v8
                            v8 += v59
                            v51.tintColor = readstring(v60, v61, v59)
                        else
                            v51.tintColor = nil
                        end
                        v38.featuredItems[v47] = v51
                    end
                    local v62 = v7
                    local v63 = v8
                    v8 += 2
                    local v64 = buffer.readu16(v62, v63)
                    v38.pinnedItems = table.create(v64)
                    for v65 = 1, v64 do
                        local v66 = v7
                        local v67 = v8
                        v8 += 1
                        local v68 = buffer.readu8(v66, v67)
                        local v69 = {}
                        local v70 = v7
                        local v71 = v8
                        v8 += 2
                        local v72 = buffer.readu16(v70, v71)
                        local readstring = buffer.readstring
                        local v73 = v7
                        local v74 = v8
                        v8 += v72
                        v69.itemId = readstring(v73, v74, v72)
                        if bit32.btest(v68, 1) then
                            v69.itemType = "Asset"
                        else
                            v69.itemType = "Bundle"
                        end
                        if bit32.btest(v68, 2) then
                            local v75 = v7
                            local v76 = v8
                            v8 += 2
                            local v77 = buffer.readu16(v75, v76)
                            local readstring = buffer.readstring
                            local v78 = v7
                            local v79 = v8
                            v8 += v77
                            v69.tintColor = readstring(v78, v79, v77)
                        else
                            v69.tintColor = nil
                        end
                        v38.pinnedItems[v65] = v69
                    end
                    local v80 = v7
                    local v81 = v8
                    v8 += 2
                    local v82 = buffer.readu16(v80, v81)
                    v38.promotedItems = table.create(v82)
                    for v83 = 1, v82 do
                        local v84 = v7
                        local v85 = v8
                        v8 += 1
                        local v86 = buffer.readu8(v84, v85)
                        local v87 = {}
                        local v88 = v7
                        local v89 = v8
                        v8 += 2
                        local v90 = buffer.readu16(v88, v89)
                        local readstring = buffer.readstring
                        local v91 = v7
                        local v92 = v8
                        v8 += v90
                        v87.itemId = readstring(v91, v92, v90)
                        if bit32.btest(v86, 1) then
                            v87.itemType = "Asset"
                        else
                            v87.itemType = "Bundle"
                        end
                        if bit32.btest(v86, 2) then
                            local v93 = v7
                            local v94 = v8
                            v8 += 2
                            local v95 = buffer.readu16(v93, v94)
                            local readstring = buffer.readstring
                            local v96 = v7
                            local v97 = v8
                            v8 += v95
                            v87.tintColor = readstring(v96, v97, v95)
                        else
                            v87.tintColor = nil
                        end
                        local v98 = v7
                        local v99 = v8
                        v8 += 2
                        local v100 = buffer.readu16(v98, v99)
                        local readstring_2 = buffer.readstring
                        local v101 = v7
                        local v102 = v8
                        v8 += v100
                        v87.promotionId = readstring_2(v101, v102, v100)
                        local v103 = v7
                        local v104 = v8
                        v8 += 4
                        v87.bid = buffer.readf32(v103, v104)
                        local v105 = v7
                        local v106 = v8
                        v8 += 4
                        v87.startTime = buffer.readf32(v105, v106)
                        local v107 = v7
                        local v108 = v8
                        v8 += 4
                        v87.endTime = buffer.readf32(v107, v108)
                        v38.promotedItems[v83] = v87
                    end
                end
                local v109 = v25[1][v34]
                if v109 then
                    task.spawn(v109, v38)
                end
                v25[1][v34] = nil
            else
                error("Unknown event id")
            end
        end
    end)
    table.freeze(v21)
    table.freeze(v22)
    local v110 = { SendEvents = SendEvents }
    local v111 = {}

    function v111.Fire(v112) -- line 445 | captures: v1, v5, alloc
        alloc(1)
        local v113 = v1
        local v114 = v5
        buffer.writeu8(v113, v114, 1)
        v113 = alloc(1)
        v114 = #v112.Accessories
        alloc(2)
        local v115 = v1
        local v116 = v5
        buffer.writeu16(v115, v116, v114)
        local v117, v118, v119, v120, v121, v122, v123
        for v124 = 1, v114 do
            v117 = alloc(1)
            v118 = v112.Accessories[v124]
            alloc(8)
            v119 = v1
            v120 = v5
            v121 = v118.AssetId
            buffer.writef64(v119, v120, v121)
            v123 = #v118.AccessoryType.EnumType
            alloc(2)
            v120 = v1
            v121 = v5
            buffer.writeu16(v120, v121, v123)
            alloc(v123)
            buffer.writestring(v1, v5, v118.AccessoryType.EnumType, v123)
            alloc(2)
            v120 = v1
            v121 = v5
            v122 = v118.AccessoryType.Value
            buffer.writeu16(v120, v121, v122)
            if v118.Order == nil then
                v119 = 0
            else
                v119 = bit32.bor(0, 1)
                alloc(2)
                v120 = v1
                v121 = v5
                v122 = v118.Order
                buffer.writeu16(v120, v121, v122)
            end
            if v118.Puffiness ~= nil then
                v119 = bit32.bor(v119, 2)
                alloc(4)
                v120 = v1
                v121 = v5
                v122 = v118.Puffiness
                buffer.writef32(v120, v121, v122)
            end
            if v118.IsLayered ~= nil then
                v119 = bit32.bor(v119, 4)
                if v118.IsLayered then
                    v119 = bit32.bor(v119, 8)
                end
            end
            if v118.Position ~= nil then
                v119 = bit32.bor(v119, 16)
                alloc(4)
                v120 = v1
                v121 = v5
                v122 = v118.Position.X
                buffer.writef32(v120, v121, v122)
                alloc(4)
                v120 = v1
                v121 = v5
                v122 = v118.Position.Y
                buffer.writef32(v120, v121, v122)
                alloc(4)
                v120 = v1
                v121 = v5
                v122 = v118.Position.Z
                buffer.writef32(v120, v121, v122)
            end
            if v118.Rotation ~= nil then
                v119 = bit32.bor(v119, 32)
                alloc(4)
                v120 = v1
                v121 = v5
                v122 = v118.Rotation.X
                buffer.writef32(v120, v121, v122)
                alloc(4)
                v120 = v1
                v121 = v5
                v122 = v118.Rotation.Y
                buffer.writef32(v120, v121, v122)
                alloc(4)
                v120 = v1
                v121 = v5
                v122 = v118.Rotation.Z
                buffer.writef32(v120, v121, v122)
            end
            if v118.Scale ~= nil then
                v119 = bit32.bor(v119, 64)
                alloc(4)
                v120 = v1
                v121 = v5
                v122 = v118.Scale.X
                buffer.writef32(v120, v121, v122)
                alloc(4)
                v120 = v1
                v121 = v5
                v122 = v118.Scale.Y
                buffer.writef32(v120, v121, v122)
                alloc(4)
                v120 = v1
                v121 = v5
                v122 = v118.Scale.Z
                buffer.writef32(v120, v121, v122)
            end
            v120 = v1
            buffer.writeu8(v120, v117, v119)
        end
        local v125 = nil
        v115 = 0
        local v126
        for v127, v128 in v112.Emotes do
            if v115 == 0 then
                v125 = alloc(2)
            end
            v115 += 1
            v119 = #v127
            alloc(2)
            v121 = v1
            v122 = v5
            buffer.writeu16(v121, v122, v119)
            alloc(v119)
            buffer.writestring(v1, v5, v127, v119)
            v120 = #v128
            alloc(2)
            v122 = v1
            v126 = v5
            buffer.writeu16(v122, v126, v120)
            for v129 = 1, v120 do
                local v130 = v128[v129]
                alloc(8)
                local v131 = v1
                local v132 = v5
                buffer.writef64(v131, v132, v130)
            end
        end
        local v133
        if v125 then
            local v134 = v1
            v118 = v115 - 1
            buffer.writeu16(v134, v125, v118)
            v133 = 0
        else
            v133 = bit32.bor(0, 1)
        end
        v116 = #v112.EquippedEmotes
        alloc(2)
        v117 = v1
        v118 = v5
        buffer.writeu16(v117, v118, v116)
        for v135 = 1, v116 do
            v123 = v112.EquippedEmotes[v135]
            v119 = #v123.Name
            alloc(2)
            v121 = v1
            v122 = v5
            buffer.writeu16(v121, v122, v119)
            alloc(v119)
            buffer.writestring(v1, v5, v123.Name, v119)
            alloc(2)
            v121 = v1
            v122 = v5
            v126 = v123.Slot
            buffer.writeu16(v121, v122, v126)
        end
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.Face
        buffer.writef64(v117, v118, v123)
        alloc(4)
        v117 = v1
        v118 = v5
        v123 = v112.Scale.BodyType
        buffer.writef32(v117, v118, v123)
        alloc(4)
        v117 = v1
        v118 = v5
        v123 = v112.Scale.Depth
        buffer.writef32(v117, v118, v123)
        alloc(4)
        v117 = v1
        v118 = v5
        v123 = v112.Scale.Head
        buffer.writef32(v117, v118, v123)
        alloc(4)
        v117 = v1
        v118 = v5
        v123 = v112.Scale.Height
        buffer.writef32(v117, v118, v123)
        alloc(4)
        v117 = v1
        v118 = v5
        v123 = v112.Scale.Proportion
        buffer.writef32(v117, v118, v123)
        alloc(4)
        v117 = v1
        v118 = v5
        v123 = v112.Scale.Width
        buffer.writef32(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.Animations.Walk
        buffer.writef64(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.Animations.Run
        buffer.writef64(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.Animations.Fall
        buffer.writef64(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.Animations.Climb
        buffer.writef64(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.Animations.Swim
        buffer.writef64(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.Animations.Idle
        buffer.writef64(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.Animations.Mood
        buffer.writef64(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.Animations.Jump
        buffer.writef64(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.BodyParts.Head
        buffer.writef64(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.BodyParts.Torso
        buffer.writef64(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.BodyParts.LeftArm
        buffer.writef64(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.BodyParts.RightArm
        buffer.writef64(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.BodyParts.LeftLeg
        buffer.writef64(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.BodyParts.RightLeg
        buffer.writef64(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.Head.R * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.Head.G * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.Head.B * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.Torso.R * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.Torso.G * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.Torso.B * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.LeftArm.R * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.LeftArm.G * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.LeftArm.B * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.RightArm.R * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.RightArm.G * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.RightArm.B * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.LeftLeg.R * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.LeftLeg.G * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.LeftLeg.B * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.RightLeg.R * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.RightLeg.G * 255
        buffer.writeu8(v117, v118, v123)
        alloc(1)
        v117 = v1
        v118 = v5
        v123 = v112.BodyPartColors.RightLeg.B * 255
        buffer.writeu8(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.Clothing.Shirt
        buffer.writef64(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.Clothing.TShirt
        buffer.writef64(v117, v118, v123)
        alloc(8)
        v117 = v1
        v118 = v5
        v123 = v112.Clothing.Pants
        buffer.writef64(v117, v118, v123)
        v117 = v1
        buffer.writeu8(v117, v113, v133)
    end

    v110.UpdateAvatar = v111
    local v136 = {}

    function v136.Fire(v137) -- line 697 | captures: v1, v5, alloc
        alloc(1)
        local v138 = v1
        local v139 = v5
        buffer.writeu8(v138, v139, 2)
        local v140 = alloc(1)
        local v141 = #v137.itemId
        alloc(2)
        local v142 = v1
        local v143 = v5
        buffer.writeu16(v142, v143, v141)
        alloc(v141)
        buffer.writestring(v1, v5, v137.itemId, v141)
        local v144
        if v137.itemType == "Asset" then
            v144 = bit32.bor(0, 1)
        else
            if v137.itemType ~= "Bundle" then
                error("Invalid enumerator")
            end
            v144 = 0
        end
        if v137.tintColor ~= nil then
            v144 = bit32.bor(v144, 2)
            local v145 = #v137.tintColor
            alloc(2)
            local v146 = v1
            local v147 = v5
            buffer.writeu16(v146, v147, v145)
            alloc(v145)
            buffer.writestring(v1, v5, v137.tintColor, v145)
        end
        local v148 = v1
        buffer.writeu8(v148, v140, v144)
    end

    v110.RecordPurchase = v136
    local v149 = {}

    function v149.Fire(v150) -- line 730 | captures: v1, v5, alloc
        alloc(1)
        local v151 = v1
        local v152 = v5
        buffer.writeu8(v151, v152, 3)
        local v153 = alloc(1)
        local v154
        if v150 then
            v154 = bit32.bor(0, 1)
        else
            v154 = 0
        end
        local v155 = v1
        buffer.writeu8(v155, v153, v154)
    end

    v110.RecordMenuToggle = v149
    local v156 = {}

    function v156.Call() -- line 742 | captures: v1, v5, v26, alloc, v25
        v26 += 1
        v26 %= 256
        if v25[1][v26] then
            v26 -= 1
            error("Zap has more than 256 calls awaiting a response, and therefore this packet has been dropped")
        end
        alloc(1)
        local v157 = v1
        local v158 = v5
        buffer.writeu8(v157, v158, 4)
        alloc(1)
        local v159 = v1
        local v160 = v5
        local v161 = v26
        buffer.writeu8(v159, v160, v161)
        v25[1][v26] = coroutine.running()
        return coroutine.yield()
    end

    v110.GetCloudConfig = v156
    local v162 = {}

    function v162.SetCallback(v163) -- line 779 | captures: v24, v25
        v24[0] = v163
        local v164 = v25[0]
        for v165 = 1, v164 do
            task.spawn(v163)
        end
        v25[0] = 0
        return function() -- line 785 | captures: v24
            v24[0] = nil
        end
    end

    v110.CloudConfigReset = v162
    local v166 = {}

    function v166.Fire(v167) -- line 791 | captures: v1, v5, alloc
        alloc(1)
        local v168 = v1
        local v169 = v5
        buffer.writeu8(v168, v169, 0)
        local v170 = #v167
        local v171 = v170 >= 1
        assert(v171, "value is less than 1!")
        local v172 = v170 <= 20
        assert(v172, "value is more than 20!")
        alloc(1)
        local v173 = v1
        local v174 = v5
        local v175 = v170 - 1
        buffer.writeu8(v173, v174, v175)
        for v176 = 1, v170 do
            local v177 = v167[v176]
            local v178 = #v177.Id
            alloc(2)
            local v179 = v1
            local v180 = v5
            buffer.writeu16(v179, v180, v178)
            alloc(v178)
            buffer.writestring(v1, v5, v177.Id, v178)
            local v181 = #v177.Type.EnumType
            alloc(2)
            local v182 = v1
            local v183 = v5
            buffer.writeu16(v182, v183, v181)
            alloc(v181)
            buffer.writestring(v1, v5, v177.Type.EnumType, v181)
            alloc(2)
            local v184 = v1
            local v185 = v5
            local Value = v177.Type.Value
            buffer.writeu16(v184, v185, Value)
        end
    end

    v110.BulkPurchaseAvatarItems = v166
    return v110
end

local function v186() -- line 132
end

return (table.freeze({
    SendEvents = v186,
    UpdateAvatar = table.freeze({ Fire = v186 }),
    RecordPurchase = table.freeze({ Fire = v186 }),
    RecordMenuToggle = table.freeze({ Fire = v186 }),
    GetCloudConfig = table.freeze({ Call = v186 }),
    CloudConfigReset = table.freeze({ SetCallback = v186 }),
    BulkPurchaseAvatarItems = table.freeze({ Fire = v186 })
}))
