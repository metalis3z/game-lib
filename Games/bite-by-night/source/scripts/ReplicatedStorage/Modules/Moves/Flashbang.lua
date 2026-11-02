-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

return {
    ["Activate"] = function()
        local v_u_1 = script.Ring:Clone()
        v_u_1.Parent = workspace
        task.delay(0.1, function()
            v_u_1:Play()
            task.delay(v_u_1.TimeLength, v_u_1.Destroy, v_u_1)
        end)
        local v2 = script.Flash:Clone()
        v2.Parent = game:GetService("Lighting")
        game:GetService("TweenService"):Create(v2, TweenInfo.new(8, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            ["Brightness"] = 0,
            ["Contrast"] = 0
        }):Play()
        task.delay(8, v2.Destroy, v2)
    end
}
