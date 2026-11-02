-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TweenService = game:GetService("TweenService")
local v1 = {}
local v2 = {}
local v3 = {}

v3.__index = v3

local function slideSeconds(v4) -- line 11
    local SlideSeconds = v4:GetAttribute("SlideSeconds")
    if typeof(SlideSeconds) == "number" then
        return SlideSeconds
    end
    return 0.3
end

local function enterInfo(v5) -- line 18
    local SlideSeconds = v5:GetAttribute("SlideSeconds")
    if typeof(SlideSeconds) ~= "number" then
        SlideSeconds = 0.3
    end
    return TweenInfo.new(SlideSeconds, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end

local function exitInfo(v6) -- line 28
    local SlideSeconds = v6:GetAttribute("SlideSeconds")
    if typeof(SlideSeconds) ~= "number" then
        SlideSeconds = 0.3
    end
    return TweenInfo.new(SlideSeconds * 0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
end

local function stop(v7) -- line 38
    if v7.tween ~= nil then
        v7.tween:Cancel()
        v7.tween = nil
    end
end

local function offscreenDistance(v8, v9) -- line 44
    local LayerCollector = v8.frame:FindFirstAncestorWhichIsA("LayerCollector")
    local v10 = LayerCollector ~= nil
    local v11 = ("%* must live under a ScreenGui to slide"):format((v8.frame:GetFullName()))
    assert(v10, v11)
    local v12 = LayerCollector.AbsoluteSize.X - (v8.frame.AbsolutePosition.X - (v8.frame.Position.X.Offset - v8.home.X.Offset))
    return math.max(v12, 0) + v9
end

local function awayPosition(v13, v14) -- line 50 | captures: offscreenDistance
    local v15 = offscreenDistance(v13, v14)
    return v13.home + UDim2.fromOffset(v15, 0)
end

local function play(v16, v17, v18) -- line 54 | captures: TweenService
    if v16.tween ~= nil then
        v16.tween:Cancel()
        v16.tween = nil
    end
    local v19 = TweenService:Create(v16.frame, v18, { Position = v17 })
    v16.tween = v19
    v19:Play()
    return v19
end

local function EscortFramesOf(v20) -- line 64
    local v21 = {}
    for v22, v23 in v20 do
        local Parent = v23.Parent
        if Parent ~= nil and Parent:IsA("GuiObject") and table.find(v21, Parent) == nil then
            table.insert(v21, Parent)
        end
    end
    return v21
end

v3.EscortFramesOf = EscortFramesOf

function v3.new(v24, v25, v26) -- line 78 | captures: v1, v2, v3
    local v27 = {
        _generation = 0,
        _root = v24,
        _panel = {
            frame = v25,
            home = v25.Position
        },
        _escorts = {}
    }
    local v28 = setmetatable(v27, v3)
    for v29, v30 in v26 do
        local v31 = v1[v30]
        if v31 == nil then
            v1[v30] = {
                frame = v30,
                home = v30.Position
            }
            v2[v30] = 0
        end
        local _escorts = v28._escorts
        table.insert(_escorts, v31)
    end
    return v28
end

local function IsOpen(v32) -- line 99
    return v32._open == true
end

v3.IsOpen = IsOpen

function v3.SetOpen(v33, v34, v35) -- line 103 | captures: TweenService, v2, offscreenDistance
    if v33._open == v34 then
        return
    end
    v33._open = v34
    v33._generation += 1
    local _generation = v33._generation
    local frame = v33._panel.frame
    for v36, v37 in v33._escorts do
        local v38 = v2[v37.frame]
        local v39
        if v34 then
            v39 = v38 + 1
        else
            local v40 = v38 - 1
            v39 = math.max(v40, 0)
        end
        v2[v37.frame] = v39
        local v41 = v39 > 0
        if v35 then
            if v37.tween ~= nil then
                v37.tween:Cancel()
                v37.tween = nil
            end
            local v42
            if v41 then
                local v43 = offscreenDistance(v37, 12)
                v42 = v37.home + UDim2.fromOffset(v43, 0)
            else
                v42 = v37.home
            end
            v37.frame.Position = v42
        elseif v41 then
            offscreenDistance(v37, 12)
            local SlideSeconds = frame:GetAttribute("SlideSeconds")
            if typeof(SlideSeconds) ~= "number" then
                SlideSeconds = 0.3
            end
            local v44 = TweenInfo.new(SlideSeconds * 0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            if v37.tween ~= nil then
                v37.tween:Cancel()
                v37.tween = nil
            end
            local v45 = TweenService:Create(v37.frame, v44, { Position = v37.home + UDim2.fromOffset(SlideSeconds, 0) })
            v37.tween = v45
            v45:Play()
        else
            local SlideSeconds = frame:GetAttribute("SlideSeconds")
            if typeof(SlideSeconds) ~= "number" then
                SlideSeconds = 0.3
            end
            local v46 = TweenInfo.new(SlideSeconds, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            if v37.tween ~= nil then
                v37.tween:Cancel()
                v37.tween = nil
            end
            local v47 = TweenService:Create(v37.frame, v46, { Position = v37.home })
            v37.tween = v47
            v47:Play()
        end
    end
    local _panel = v33._panel
    local v48 = frame.AbsoluteSize.X * 0.3 + 12
    if v34 then
        local v49 = not v33._root.Enabled
        v33._root.Enabled = true
        if v35 then
            if _panel.tween ~= nil then
                _panel.tween:Cancel()
                _panel.tween = nil
            end
            _panel.frame.Position = _panel.home
        else
            if v49 then
                local frame = _panel.frame
                local home = _panel.home
                local v50 = offscreenDistance(_panel, v48)
                frame.Position = home + UDim2.fromOffset(v50, 0)
            end
            local SlideSeconds = frame:GetAttribute("SlideSeconds")
            if typeof(SlideSeconds) ~= "number" then
                SlideSeconds = 0.3
            end
            local v51 = TweenInfo.new(SlideSeconds, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            if _panel.tween ~= nil then
                _panel.tween:Cancel()
                _panel.tween = nil
            end
            local v52 = TweenService:Create(_panel.frame, v51, { Position = _panel.home })
            _panel.tween = v52
            v52:Play()
        end
    elseif v35 then
        if _panel.tween ~= nil then
            _panel.tween:Cancel()
            _panel.tween = nil
        end
        _panel.frame.Position = _panel.home
        v33._root.Enabled = false
    else
        local home = _panel.home
        offscreenDistance(_panel, v48)
        local SlideSeconds = frame:GetAttribute("SlideSeconds")
        if typeof(SlideSeconds) ~= "number" then
            SlideSeconds = 0.3
        end
        local v53 = TweenInfo.new(SlideSeconds * 0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        if _panel.tween ~= nil then
            _panel.tween:Cancel()
            _panel.tween = nil
        end
        local v54 = TweenService:Create(_panel.frame, v53, { Position = home + UDim2.fromOffset(SlideSeconds, 0) })
        _panel.tween = v54
        v54:Play()
        v54.Completed:Once(function(v55) -- line 198 | captures: v33, _generation, _panel
            if not (v33._generation == _generation and v55 == Enum.PlaybackState.Completed) then
                return
            end
            _panel.tween = nil
            v33._root.Enabled = false
            _panel.frame.Position = _panel.home
        end)
    end
end

return v3
