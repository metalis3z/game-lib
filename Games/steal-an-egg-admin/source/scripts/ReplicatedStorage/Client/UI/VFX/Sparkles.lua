-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local Assets = ReplicatedStorage:WaitForChild("Assets")
local v1 = { layer = 99 }

v1.rootClasses = { "ScreenGui", "BillboardGui", "SurfaceGui" }
v1.size = NumberRange.new(0.15, 0.2)
v1.growSeconds = NumberRange.new(0.75, 1)
v1.shrinkSeconds = NumberRange.new(1.75, 2.5)
v1.gapSeconds = NumberRange.new(1, 2.5)
v1.nothing = UDim2.fromScale(0, 0)

local v2 = Random.new()

local function pick(v3, v4) -- line 18 | captures: v2
    return v2:NextNumber(v3.Min * v4, v3.Max * v4)
end

local function rootOf(v5) -- line 21 | captures: v1
    local v6
    local v7 = 0
    while v6 == nil do
        if #v1.rootClasses <= v7 then
            break
        end
        v7 += 1
        v6 = v5:FindFirstAncestorOfClass(v1.rootClasses[v7])
    end
    return v6
end

local function noop() -- line 33
end

return function(v8, v9, v10, v11, v12) -- line 34 | captures: Tween, Assets, v1, v2, pick, rootOf, noop
    local v13 = rootOf(v8)
    if v13 == nil then
        return noop
    end
    local v14 = v9 or 1
    local v15 = v12 or 1
    local v16 = false

    local function twinkle() -- line 42 | captures: v8, v14, v15, Tween, Assets, v1, v2
        local v17 = Assets.UI.Misc.Effects.Sparkle:Clone()
        local v18 = v2:NextNumber()
        v17.Position = UDim2.fromScale(v18, v2:NextNumber())
        v17.Size = v1.nothing
        v17.ZIndex = v1.layer
        v17.Parent = v8
        local size = v1.size
        local v19 = v2:NextNumber(size.Min * v14, size.Max * v14)
        local v20 = { Size = UDim2.fromScale(v19, v19) }
        local v21 = {}
        local growSeconds = v1.growSeconds
        v21[1] = v2:NextNumber(growSeconds.Min * 1, growSeconds.Max * 1) * 1 / v15
        v21[2] = "Quad"
        v21[3] = "Out"
        Tween(v17, v20, v21).Completed:Connect(function() -- line 59 | captures: v17, v15, Tween, v1, v2
            local v22 = { Size = v1.nothing }
            local v23 = {}
            local shrinkSeconds = v1.shrinkSeconds
            v23[1] = v2:NextNumber(shrinkSeconds.Min * 1, shrinkSeconds.Max * 1) * 1 / v15
            v23[2] = "Sine"
            v23[3] = "InOut"
            Tween(v17, v22, v23).Completed:Wait()
            v17:Destroy()
        end)
    end

    local v24 = v11 or 0
    local v25 = typeof(v24) == "number"
    assert(v25)
    local v26 = 1 + v24
    for v27 = 1, v26 do
        local spawn = task.spawn
        spawn(function() -- line 77 | captures: v16, v8, v13, twinkle, v1, pick
            while true do
                local v28
                if v16 then
                    v28 = true
                elseif v8 and v8.Parent then
                    if v13.Enabled then
                        twinkle()
                    end
                    v28 = false
                else
                    v28 = true
                end
                if v28 then
                    break
                end
                wait(pick(v1.gapSeconds, 1))
            end
        end)
    end
    return function() -- line 89 | captures: v16
        v16 = true
    end
end
