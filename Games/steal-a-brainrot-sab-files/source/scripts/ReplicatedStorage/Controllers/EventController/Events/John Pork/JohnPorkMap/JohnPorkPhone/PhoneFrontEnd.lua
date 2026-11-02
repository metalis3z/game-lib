
local v1 = {}
local u2 = game:GetService("ContentProvider")
local u3 = game:GetService("ReplicatedStorage")
local u4 = script.Parent
u4:WaitForChild("Control")
local v5 = u4:WaitForChild("Rotate")
local v6 = u4:WaitForChild("AnimationController")
local u7 = u4:WaitForChild("Screen"):WaitForChild("SurfaceLight")
local u8 = v5:WaitForChild("RingVFX")
local v9 = v6:WaitForChild("Animator")
local u10 = u4:GetPivot()
local u11 = u10 * CFrame.new(0, 200, 0)
local u12 = script.Parent:WaitForChild("SpawnIntro")
local u13 = script.Parent:WaitForChild("HoverLoop")
local u14 = script.Parent:WaitForChild("Ring")
local u15 = require(u3.Controllers.SoundController)
task.spawn(function()
    u2:PreloadAsync({ u12, u13, u14 })
end)
local u16 = v9:LoadAnimation(u12)
local u17 = v9:LoadAnimation(u13)
local u18 = v9:LoadAnimation(u14)
u16.Priority = Enum.AnimationPriority.Action
u17.Priority = Enum.AnimationPriority.Action
u18.Priority = Enum.AnimationPriority.Action2
u17.Looped = true
u18.Looped = false
local u19 = nil
local function u25(p20)
    for _, u21 in ipairs(p20:GetDescendants()) do
        local u22 = u21:GetAttribute("EmitCount") or 10
        local v23 = u21:GetAttribute("EmitDelay") or 0
        local u24 = u21:GetAttribute("EmitDuration") or 0
        if u21:IsA("ParticleEmitter") then
            task.delay(v23, function()
                if u24 > 0 then
                    u21.Enabled = true
                    task.delay(u24, function()
                        u21.Enabled = false
                    end)
                else
                    u21:Emit(u22)
                end
            end)
        elseif u21:IsA("Beam") then
            task.delay(v23, function()
                u21.Enabled = true
                task.delay(u24 > 0 and u24 or 0.1, function()
                    u21.Enabled = false
                end)
            end)
        end
    end
end
local function u26()
    while true do
        for _ = 1, 5 do
            u7.Enabled = true
            task.wait(0.05)
            u7.Enabled = false
            task.wait(0.05)
        end
        task.wait(0.5)
        if u19 == nil then
            return
        end
    end
end
function v1.Start()
    if u19 then
        task.cancel(u19)
        u19 = nil
    end
    u7.Enabled = false
    u16:Stop()
    u17:Stop()
    u18:Stop()
    u16:Play()
    task.wait(0.2)
    u4:PivotTo(u11)
    u16.Stopped:Once(function()
        u17:Play()
    end)
end
local u27 = nil
function v1.Ring()
    u15:PlaySound(u3.Sounds.Events["John Pork"].RingD, nil, false)
    if u19 then
        task.cancel(u19)
        u19 = nil
    end
    u7.Enabled = false
    if u27 then
        u27:Disconnect()
        u27 = nil
    end
    u16:Stop()
    u18:Stop()
    u4:PivotTo(u11)
    u25(u8)
    u18:Play()
    u19 = task.spawn(u26)
    u27 = u18.Stopped:Once(function()
        if u19 then
            task.cancel(u19)
            u19 = nil
        end
        u7.Enabled = false
    end)
end
function v1.Stop()
    if u19 then
        task.cancel(u19)
        u19 = nil
    end
    u7.Enabled = false
    u16:Stop()
    u17:Stop()
    u18:Stop()
    task.defer(function()
        u4:PivotTo(u10)
    end)
end
return v1