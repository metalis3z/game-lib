


local v_u_1 = game:GetService("TweenService")
local v_u_2 = game:GetService("RunService")
game:GetService("ContentProvider")
local v_u_3 = {}
v_u_3.__index = v_u_3
local v_u_4 = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local function v_u_8(p5, p6, p7)
    v_u_1:Create(p5, v_u_4, {
        ["Transparency"] = p7
    }):Play()
    v_u_1:Create(p6, v_u_4, {
        ["Transparency"] = p7
    }):Play()
end
function v_u_3.new(p9)
    local v10 = v_u_3
    local v11 = setmetatable({}, v10)
    v11.Model = p9
    v11.RootPart = p9.RootPart
    v11.Drones = p9.Drones
    v11.Drones001 = p9:FindFirstChild("Drones.001")
    v11.AnimationController = p9.AnimationController
    v11.Animator = v11.AnimationController.Animator
    v11.Animation = script.Animation
    v11.AnimationTrack = nil
    v11.Connections = {}
    v11.FlashThreadToken = 0
    v11.YellowThreadToken = 0
    v11.OrangeThreadToken = 0
    v11.RedThreadToken = 0
    v11.ExplosionThreadToken = 0
    return v11
end
function v_u_3.DisconnectAll(p12)
    for _, v13 in ipairs(p12.Connections) do
        if v13.Connected then
            v13:Disconnect()
        end
    end
    table.clear(p12.Connections)
end
function v_u_3.StopAllColorDrivers(p14)
    p14.FlashThreadToken = p14.FlashThreadToken + 1
    p14.YellowThreadToken = p14.YellowThreadToken + 1
    p14.OrangeThreadToken = p14.OrangeThreadToken + 1
    p14.RedThreadToken = p14.RedThreadToken + 1
    p14.ExplosionThreadToken = p14.ExplosionThreadToken + 1
end
function v_u_3.StartRainbowFlash(p_u_15)
    p_u_15.FlashThreadToken = p_u_15.FlashThreadToken + 1
    local v_u_16 = p_u_15.FlashThreadToken
    local v_u_17 = p_u_15.Drones001
    task.spawn(function()
        local v18 = 0
        while v_u_16 == p_u_15.FlashThreadToken do
            v18 = v18 + 0.08
            v_u_17.Color = Color3.fromHSV(v18 % 1, 1, 1)
            task.wait(0.1)
        end
    end)
end
function v_u_3.StartSolidFlash(p_u_19, p_u_20, p_u_21, p_u_22)
    p_u_19[p_u_20] = p_u_19[p_u_20] + 1
    local v_u_23 = p_u_19[p_u_20]
    local v_u_24 = p_u_19.Drones001
    task.spawn(function()
        local v25 = false
        while v_u_23 == p_u_19[p_u_20] do
            v25 = not v25
            v_u_24.Color = v25 and p_u_21 or p_u_22
            task.wait(0.1)
        end
    end)
end
function v_u_3.StartExplosionTweenLoop(p_u_26)
    p_u_26.ExplosionThreadToken = p_u_26.ExplosionThreadToken + 1
    local v_u_27 = p_u_26.ExplosionThreadToken
    local v_u_28 = p_u_26.Drones001
    task.spawn(function()
        local v29 = Color3.fromRGB(255, 40, 40)
        local v30 = Color3.fromRGB(255, 140, 0)
        local v31 = Color3.fromRGB(0, 0, 0)
        v_u_28.Color = v29
        while v_u_27 == p_u_26.ExplosionThreadToken do
            local v32 = v_u_1:Create(v_u_28, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                ["Color"] = v30
            })
            v32:Play()
            v32.Completed:Wait()
            if v_u_27 ~= p_u_26.ExplosionThreadToken then
                break
            end
            local v33 = v_u_1:Create(v_u_28, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
                ["Color"] = v31
            })
            v33:Play()
            v33.Completed:Wait()
            if v_u_27 ~= p_u_26.ExplosionThreadToken then
                break
            end
            v_u_28.Color = v29
            v_u_2.Heartbeat:Wait()
        end
    end)
end
function v_u_3.BindMarkers(p_u_34, p35)
    local v36 = p_u_34.Connections
    local v37 = p35:GetMarkerReachedSignal("FadeIn")
    local function v40()
        local v38 = p_u_34.Drones
        local v39 = p_u_34.Drones001
        v38.Transparency = 1
        v39.Transparency = 1
        v_u_8(p_u_34.Drones, p_u_34.Drones001, 0)
    end
    table.insert(v36, v37:Connect(v40))
    local v41 = p_u_34.Connections
    local v42 = p35:GetMarkerReachedSignal("FadeOut")
    local function v45()
        local v43 = p_u_34.Drones
        local v44 = p_u_34.Drones001
        v43.Transparency = 0
        v44.Transparency = 0
        v_u_8(p_u_34.Drones, p_u_34.Drones001, 1)
    end
    table.insert(v41, v42:Connect(v45))
    local v46 = p_u_34.Connections
    local v47 = p35:GetMarkerReachedSignal("Flash")
    table.insert(v46, v47:Connect(function(p48)
        local v49 = not p48 and "" or tostring(p48)
        if v49 == "Start" then
            p_u_34:StopAllColorDrivers()
            p_u_34:StartRainbowFlash()
        elseif v49 == "Stop" then
            local v50 = p_u_34
            v50.FlashThreadToken = v50.FlashThreadToken + 1
        end
    end))
    local v51 = p_u_34.Connections
    local v52 = p35:GetMarkerReachedSignal("Yellow")
    table.insert(v51, v52:Connect(function(p53)
        local v54 = not p53 and "" or tostring(p53)
        if v54 == "Start" then
            p_u_34:StopAllColorDrivers()
            p_u_34:StartSolidFlash("YellowThreadToken", Color3.fromRGB(255, 255, 120), Color3.fromRGB(255, 200, 0))
        elseif v54 == "Stop" then
            local v55 = p_u_34
            v55.YellowThreadToken = v55.YellowThreadToken + 1
        end
    end))
    local v56 = p_u_34.Connections
    local v57 = p35:GetMarkerReachedSignal("Orange")
    table.insert(v56, v57:Connect(function(p58)
        local v59 = not p58 and "" or tostring(p58)
        if v59 == "Start" then
            p_u_34:StopAllColorDrivers()
            p_u_34:StartSolidFlash("OrangeThreadToken", Color3.fromRGB(255, 200, 120), Color3.fromRGB(255, 120, 0))
        elseif v59 == "Stop" then
            local v60 = p_u_34
            v60.OrangeThreadToken = v60.OrangeThreadToken + 1
        end
    end))
    local v61 = p_u_34.Connections
    local v62 = p35:GetMarkerReachedSignal("Red")
    table.insert(v61, v62:Connect(function(p63)
        local v64 = not p63 and "" or tostring(p63)
        if v64 == "Start" then
            p_u_34:StopAllColorDrivers()
            p_u_34:StartSolidFlash("RedThreadToken", Color3.fromRGB(255, 120, 120), Color3.fromRGB(255, 0, 0))
        elseif v64 == "Stop" then
            local v65 = p_u_34
            v65.RedThreadToken = v65.RedThreadToken + 1
        end
    end))
    local v66 = p_u_34.Connections
    local v67 = p35:GetMarkerReachedSignal("Explosion")
    table.insert(v66, v67:Connect(function(p68)
        local v69 = not p68 and "" or tostring(p68)
        if v69 == "Start" then
            p_u_34:StopAllColorDrivers()
            p_u_34:StartExplosionTweenLoop()
        elseif v69 == "Stop" then
            local v70 = p_u_34
            v70.ExplosionThreadToken = v70.ExplosionThreadToken + 1
            p_u_34.Drones001.Color = Color3.fromRGB(0, 0, 0)
        end
    end))
    local v71 = p_u_34.Connections
    local v72 = p35.Stopped
    table.insert(v71, v72:Connect(function()
        p_u_34:StopAllColorDrivers()
    end))
end
function v_u_3.Play(p_u_73, p_u_74)
    p_u_73:DisconnectAll()
    p_u_73:StopAllColorDrivers()
    local v_u_75 = p_u_73.Animator:LoadAnimation(p_u_73.Animation)
    v_u_75.Looped = false
    p_u_73.AnimationTrack = v_u_75
    p_u_73:BindMarkers(v_u_75)
    v_u_75:Play(0)
    v_u_75.TimePosition = p_u_74()
    task.spawn(function()
        if v_u_75.Length == 0 then
            while v_u_75.Length == 0 and p_u_73.AnimationTrack == v_u_75 do
                task.wait()
            end
            v_u_75.TimePosition = p_u_74()
        end
    end)
end
function v_u_3.Stop(p76)
    if p76.AnimationTrack then
        p76.AnimationTrack:Stop()
    end
    p76:StopAllColorDrivers()
end
function v_u_3.Destroy(p77)
    p77:Stop()
    p77:DisconnectAll()
    if p77.AnimationTrack then
        p77.AnimationTrack:Destroy()
        p77.AnimationTrack = nil
    end
end
return v_u_3