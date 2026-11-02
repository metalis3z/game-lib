game:GetService("ServerScriptService")
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
game:GetService("TweenService")
game:GetService("SoundService")
game:GetService("HttpService")
game:GetService("StarterGui")
local v_u_3 = game:GetService("RunService")
game:GetService("Lighting")
game:GetService("Players")
game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v4 = {}
local v_u_5 = require(v_u_1.Controllers.SkullEmojiEffectController)
require(v_u_1.Controllers.CharacterController)
local v_u_6 = require(v_u_1.Controllers.EffectController)
require(v_u_1.Controllers.AnimalController)
require(v_u_1.Controllers.SoundController)
require(v_u_1.Controllers.CycleController)
local v_u_7 = require(v_u_1.Controllers.EventController)
require(v_u_1.Controllers.EventController.ClientEventUtils)
require(v_u_1.Shared.SharedEventUtils)
require(v_u_1.Packages.Serialization)
require(v_u_1.Packages.CreateTween)
require(v_u_1.Shared.ShakePresets)
require(v_u_1.Packages.TopbarPlus)
require(v_u_1.Packages.Observers)
require(v_u_1.Packages.Moonlite)
require(v_u_1.Utils.MathUtils)
require(v_u_1.Packages.Squash)
require(v_u_1.Packages.Shake)
local v8 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Net)
require(v_u_1.Packages.Spr)
local v_u_9 = require(v_u_1.Shared.VFX)
local _ = workspace.RenderedMovingAnimals
local v_u_10 = script.Name
local v_u_11 = v8.new()
function v4.OnStart(_)
    local v_u_12 = v_u_7:GetActiveEventData(v_u_10)
    assert(v_u_12)

    -- === Sammy Setup ===
    local v_u_13 = v_u_11:Clone(script.Sammy)
    v_u_13.Parent = workspace

    local fireSound = v_u_11:Clone(v_u_1.Sounds.Events["Phase 5: Sammy Snap"].Fire)
    fireSound.Parent = v_u_13.HumanoidRootPart
    fireSound:Play()

    local walkSound = v_u_11:Clone(v_u_1.Sounds.Events["Phase 5: Sammy Snap"].Walk)
    walkSound.Parent = v_u_13.HumanoidRootPart
    walkSound:Play()

    local animator = v_u_13.AnimationController.Animator

    local walkTrack = animator:LoadAnimation(script.WalkAnimation)
    walkTrack.Looped = true
    v_u_11:Add(walkTrack, "Stop")
    v_u_11:Add(walkTrack)

    local snapTrack = animator:LoadAnimation(script.SnapAnimation)
    snapTrack.Looped = false
    v_u_11:Add(snapTrack, "Stop")
    v_u_11:Add(snapTrack)

    snapTrack:GetMarkerReachedSignal("Freeze"):Connect(function()
        snapTrack:AdjustSpeed(0)
    end)

    walkTrack:Play()

    -- Sammy moves forward and grows throughout the snap sequence.
    local baseYOffset = 2.974
    local movementDuration = 9
    local startCFrame = workspace.Road.StartGround.CFrame
    local endCFrame = startCFrame + Vector3.new(0, 0, 150)
    v_u_11:Add(v_u_3.PostSimulation:Connect(function()
        debug.profilebegin("Sammy Snap:Update")

        local progress = math.clamp((workspace:GetServerTimeNow() - v_u_12.startedAt) / movementDuration, 0, 1)
        local currentScale = math.lerp(1, 13.9, progress * progress)

        v_u_13:PivotTo(startCFrame:Lerp(endCFrame, progress) + Vector3.new(0, baseYOffset * currentScale, 0))
        v_u_13:ScaleTo(currentScale)

        debug.profileend()
    end))

    v_u_11:Add(task.delay(v_u_12.startedAt + 9 - workspace:GetServerTimeNow(), function()
        walkTrack:Stop()
        snapTrack:Play()
    end))

    v_u_11:Add(task.delay(v_u_12.startedAt + 9.5 - workspace:GetServerTimeNow(), function()
        v_u_5:Play(2.5, "Lower")
    end))

    v_u_11:Add(task.delay(v_u_12.startedAt + 9.5 - workspace:GetServerTimeNow(), function()
        v_u_1.Sounds.Events["Phase 5: Sammy Snap"].Snap:Play()

        -- Snap VFX on Sammy's LeftHand
        local leftHand = v_u_13:FindFirstChild("LeftHand")
        if leftHand then
            local snapVfx = v_u_11:Clone(script.Snap)
            snapVfx.CFrame = leftHand.CFrame
            snapVfx.Parent = workspace
            local weld = Instance.new("Weld")
            weld.Part0 = snapVfx
            weld.Part1 = leftHand
            weld.Parent = snapVfx
            v_u_9.emit(snapVfx)
        end

    end))

    v_u_11:Add(task.delay(v_u_12.startedAt + 12 - workspace:GetServerTimeNow(), function()
        v_u_5:Stop()
        v_u_6:Activate("Blink")
        v_u_11:Remove(v_u_13)
    end))
end
function v4.OnStop(_)
    -- upvalues: (copy) v_u_11
    v_u_11:Destroy()
end
function v4.OnLoad(_)
    -- upvalues: (copy) v_u_2, (copy) v_u_1
    task.spawn(pcall, function()
        -- upvalues: (ref) v_u_2
        v_u_2:PreloadAsync(script:GetChildren())
    end)
    task.spawn(pcall, function()
        -- upvalues: (ref) v_u_2, (ref) v_u_1
        v_u_2:PreloadAsync(v_u_1.Models.Events["Phase 5: Sammy Snap"])
    end)
end
return v4