-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Component)
local v_u_3 = require(v1.Packages.Trove)
local v4 = v2.new({
    ["Tag"] = "DualAudio",
    ["Ancestors"] = { workspace }
})
function v4.Construct(p5)
    -- upvalues: (copy) v_u_3
    local v6 = p5.Instance:GetAttribute("ID") or 0
    p5._trove = v_u_3.new()
    p5.DualAudio = p5.Instance:Clone()
    p5.DualAudio:RemoveTag("DualAudio")
    p5.DualAudio.Name = p5.DualAudio.Name .. "_DualAudio"
    p5.DualAudio.Parent = workspace
    p5.DualAudio.SoundId = v6
end
function v4.Start(p_u_7)
    p_u_7._trove:Add(p_u_7.Instance.Played:Connect(function()
        -- upvalues: (copy) p_u_7
        p_u_7:PlayDualAudio()
    end))
    p_u_7._trove:Add(p_u_7.Instance:GetPropertyChangedSignal("Volume"):Connect(function()
        -- upvalues: (copy) p_u_7
        p_u_7.DualAudio.Volume = p_u_7.Instance.Volume
    end))
    p_u_7._trove:Add(p_u_7.Instance:GetPropertyChangedSignal("TimePosition"):Connect(function()
        -- upvalues: (copy) p_u_7
        p_u_7:PlayDualAudio()
    end))
    if p_u_7.Instance.IsPlaying then
        p_u_7:PlayDualAudio()
    end
end
function v4.PlayDualAudio(p8)
    p8.DualAudio.TimePosition = p8.Instance.TimePosition
    p8.DualAudio.Volume = p8.Instance.Volume
    if p8.Instance.IsPlaying then
        p8.DualAudio:Play()
    end
end
function v4.Stop(p9)
    p9._trove:Destroy()
end
return v4