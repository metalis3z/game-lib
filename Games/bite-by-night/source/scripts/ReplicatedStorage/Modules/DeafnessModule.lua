-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v_u_1 = {}
local v_u_2 = false
function v_u_1.Activate(p3)
    if v_u_2 == true then
        v_u_1.Clear(true)
    end
    v_u_2 = true
    for _, v4 in game:GetService("SoundService"):GetChildren() do
        if v4:IsA("SoundGroup") then
            local v5 = Instance.new("EqualizerSoundEffect")
            v5.LowGain = 0
            v5.MidGain = 0
            v5.HighGain = 0
            v5.Parent = v4
            local v6 = 10 - p3
            local v7 = 1 - math.clamp(v6, 0, 10) / 10
            print(v7)
            game:GetService("TweenService"):Create(v5, TweenInfo.new(0.5), {
                ["LowGain"] = v7 * 5,
                ["HighGain"] = v7 * -80,
                ["MidGain"] = v7 * -80
            }):Play()
        end
    end
end

function v_u_1.Clear(p8)
    v_u_2 = false
    if p8 == true then
        for _, v9 in game:GetService("SoundService"):GetChildren() do
            if v9:IsA("SoundGroup") and v9:FindFirstChildOfClass("EqualizerSoundEffect") then
                for _, v10 in v9:QueryDescendants("EqualizerSoundEffect") do
                    game:GetService("TweenService"):Create(v10, TweenInfo.new(0), {
                        ["LowGain"] = 0,
                        ["HighGain"] = 0,
                        ["MidGain"] = 0
                    }):Play()
                    v10:Destroy()
                end
            end
        end
    else
        for _, v11 in game:GetService("SoundService"):GetChildren() do
            if v11:IsA("SoundGroup") then
                for _, v_u_12 in v11:QueryDescendants("EqualizerSoundEffect") do
                    game:GetService("TweenService"):Create(v_u_12, TweenInfo.new(0.5), {
                        ["LowGain"] = 0,
                        ["HighGain"] = 0,
                        ["MidGain"] = 0
                    }):Play()
                    task.delay(0.5, function()
                        v_u_12:Destroy()
                    end)
                end
            end
        end
    end
end
return v_u_1
