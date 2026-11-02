-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
require(script.Parent.Types.Interface)
local v1 = Log.new()
local v2 = {}

local function clearSlot(v3) -- line 11
    v3.Frame:Pause()
    v3.Frame.TimePosition = 0
    v3.Frame.Volume = 0
    v3.Frame.Visible = false
    v3.Frame.Video = ""
    v3.MediaIndex = nil
    v3.VideoUri = nil
end

local function assignSlot(v4, v5, v6) -- line 20
    if v4.MediaIndex == v5 then
        if v4.VideoUri ~= v6.Video then
            v4.Frame:Pause()
            v4.Frame.TimePosition = 0
            v4.Frame.Volume = 0
            v4.Frame.Visible = false
            v4.Frame.Video = ""
            v4.MediaIndex = nil
            v4.VideoUri = nil
            v4.MediaIndex = v5
            v4.VideoUri = v6.Video
            v4.Frame.Video = v6.Video
        end
    else
        v4.Frame:Pause()
        v4.Frame.TimePosition = 0
        v4.Frame.Volume = 0
        v4.Frame.Visible = false
        v4.Frame.Video = ""
        v4.MediaIndex = nil
        v4.VideoUri = nil
        v4.MediaIndex = v5
        v4.VideoUri = v6.Video
        v4.Frame.Video = v6.Video
    end
end

local function primeHiddenSlot(v7, v8, v9) -- line 48 | captures: v1
    if v7.MediaIndex == v8 then
        if v7.VideoUri ~= v9.Video then
            v7.Frame:Pause()
            v7.Frame.TimePosition = 0
            v7.Frame.Volume = 0
            v7.Frame.Visible = false
            v7.Frame.Video = ""
            v7.MediaIndex = nil
            v7.VideoUri = nil
            v7.MediaIndex = v8
            v7.VideoUri = v9.Video
            v7.Frame.Video = v9.Video
        end
    else
        v7.Frame:Pause()
        v7.Frame.TimePosition = 0
        v7.Frame.Volume = 0
        v7.Frame.Visible = false
        v7.Frame.Video = ""
        v7.MediaIndex = nil
        v7.VideoUri = nil
        v7.MediaIndex = v8
        v7.VideoUri = v9.Video
        v7.Frame.Video = v9.Video
    end
    v7.Frame.Visible = false
    v7.Frame.Volume = 0
    v7.Frame.TimePosition = 0
    local v10, v11 = pcall(function() -- line 76 | captures: v7
        v7.Frame:Play()
        v7.Frame:Pause()
        v7.Frame.TimePosition = 0
    end)
    if v10 then
        return true
    end
    v1:AtWarning():Log((("Failed to prime treadmill VideoFrame %*: %*"):format(v9.Video, v11)))
    return false
end

local function createCloneSlot(v12, v13) -- line 87
    local v14 = v12:Clone()
    v14.Name = ("MainVideoPreload%*"):format(v13)
    v14.Visible = false
    v14.Video = ""
    v14.Volume = 0
    v14.TimePosition = 0
    v14.Parent = v12.Parent
    return { Frame = v14 }
end

function v2.new(v15) -- line 97 | captures: primeHiddenSlot
    v15.Looped = false
    local v16 = {}
    v16[1] = { Frame = v15 }
    local v17
    local v18 = false
    local v19 = v15:Clone()
    v19.Name = ("MainVideoPreload%*"):format(2)
    v19.Visible = false
    v19.Video = ""
    v19.Volume = 0
    v19.TimePosition = 0
    v19.Parent = v15.Parent
    local v20 = { Frame = v19 }
    table.insert(v16, v20)
    local v21 = v15:Clone()
    v21.Name = ("MainVideoPreload%*"):format(3)
    v21.Visible = false
    v21.Video = ""
    v21.Volume = 0
    v21.TimePosition = 0
    v21.Parent = v15.Parent
    local v22 = { Frame = v21 }
    table.insert(v16, v22)

    local function findSlotByMediaIndex(v23) -- line 121 | captures: v16
        for v24, v25 in v16 do
            if v25.MediaIndex == v23 then
                return v25
            end
        end
        return nil
    end

    local function acquireInactiveSlot(v26) -- line 132 | captures: v17, v16
        for v27, v28 in v16 do
            if v28.MediaIndex == v26 then
                if v28 == nil then
                    for v29, v30 in v16 do
                        if v30 ~= v17 and v30.MediaIndex == nil then
                            return v30
                        end
                    end
                    for v31, v32 in v16 do
                        if v32 ~= v17 then
                            v32.Frame:Pause()
                            v32.Frame.TimePosition = 0
                            v32.Frame.Volume = 0
                            v32.Frame.Visible = false
                            v32.Frame.Video = ""
                            v32.MediaIndex = nil
                            v32.VideoUri = nil
                            return v32
                        end
                    end
                    error("Treadmill VideoFrame pool has no inactive slot available")
                    return
                end
                return v28
            end
        end
    end

    local v33 = {}

    function v33.Activate(v34, v35) -- line 173 | captures: v17, v18, v15, v16, acquireInactiveSlot
        if v18 then
            return v15
        end
        for v36, v37 in v16 do
            if v37.MediaIndex == v34 then
                local v38 = v37 or acquireInactiveSlot(v34)
                if v38.MediaIndex == v34 then
                    if v38.VideoUri == v35.Video then
                    end
                else
                    v38.Frame:Pause()
                    v38.Frame.TimePosition = 0
                    v38.Frame.Volume = 0
                    v38.Frame.Visible = false
                    v38.Frame.Video = ""
                    v38.MediaIndex = nil
                    v38.VideoUri = nil
                    v38.MediaIndex = v34
                    v38.VideoUri = v35.Video
                    v38.Frame.Video = v35.Video
                end
                for v39, v40 in v16 do
                    local v41 = v40 == v38
                    v40.Frame.Visible = v41
                    if v40 ~= v38 then
                        v40.Frame:Pause()
                        v40.Frame.Volume = 0
                        v40.Frame.TimePosition = 0
                    end
                end
                v17 = v38
                v38.Frame.Volume = v35.Volume or 1
                v38.Frame.TimePosition = 0
                return v38.Frame
            end
        end
    end

    function v33.ClearActive() -- line 220 | captures: v17
        local v42 = v17
        v17 = nil
        if v42 == nil then
            return
        end
        v42.Frame:Pause()
        v42.Frame.TimePosition = 0
        v42.Frame.Volume = 0
        v42.Frame.Visible = false
        v42.Frame.Video = ""
        v42.MediaIndex = nil
        v42.VideoUri = nil
    end

    function v33.ClearAll() -- line 234 | captures: v17, v16
        v17 = nil
        for v43, v44 in v16 do
            v44.Frame:Pause()
            v44.Frame.TimePosition = 0
            v44.Frame.Volume = 0
            v44.Frame.Visible = false
            v44.Frame.Video = ""
            v44.MediaIndex = nil
            v44.VideoUri = nil
        end
    end

    function v33.Destroy() -- line 249 | captures: v17, v18, v16
        v18 = true
        v17 = nil
        for v45, v46 in v16 do
            v46.Frame:Pause()
            v46.Frame.TimePosition = 0
            v46.Frame.Volume = 0
            v46.Frame.Visible = false
            v46.Frame.Video = ""
            v46.MediaIndex = nil
            v46.VideoUri = nil
        end
        local v47 = #v16
        for v48 = 2, v47 do
            v16[v48].Frame:Destroy()
        end
    end

    function v33.GetActiveFrame() -- line 270 | captures: v17, v15
        local v49 = v17
        if v49 == nil then
            return v15
        end
        return v49.Frame
    end

    function v33.Preload(v50) -- line 277 | captures: v17, v18, v16, acquireInactiveSlot, primeHiddenSlot
        if v18 then
            return
        end
        local v51 = {}
        local v52 = if v17 == nil then 3 else 2
        local v53 = 0
        for v54, v55 in ipairs(v50) do
            if v52 <= v53 then
                break
            end
            v51[v55.MediaIndex] = v55.MediaEntry
            v53 += 1
        end
        for v56, v57 in v16 do
            if v57 ~= v17 and v57.MediaIndex ~= nil and v51[v57.MediaIndex] == nil then
                v57.Frame:Pause()
                v57.Frame.TimePosition = 0
                v57.Frame.Volume = 0
                v57.Frame.Visible = false
                v57.Frame.Video = ""
                v57.MediaIndex = nil
                v57.VideoUri = nil
            end
        end
        for v58, v59 in ipairs(v50) do
            if v51[v59.MediaIndex] == nil then
                break
            end
            local spawn = task.spawn
            local v60 = v59
            spawn(function() -- line 314 | captures: v60, v18, acquireInactiveSlot, primeHiddenSlot
                if not v18 then
                    local v61 = acquireInactiveSlot(v60.MediaIndex)
                    primeHiddenSlot(v61, v60.MediaIndex, v60.MediaEntry)
                end
            end)
        end
    end

    return v33
end

return v2
