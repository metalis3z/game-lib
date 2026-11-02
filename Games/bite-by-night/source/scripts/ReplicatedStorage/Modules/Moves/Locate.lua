-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

return {
    ["Activate"] = function(p1)
        local v2 = Instance.new("Highlight")
        v2.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        if p1:IsDescendantOf(workspace.PLAYERS.KILLER) then
            v2.FillColor = Color3.fromRGB(255, 0, 0)
            v2.OutlineColor = Color3.fromRGB(255, 0, 0)
        else
            v2.FillColor = Color3.fromRGB(255, 255, 255)
            v2.OutlineColor = Color3.fromRGB(255, 255, 255)
        end
        v2.OutlineTransparency = 0.65
        v2.FillTransparency = 0.65
        v2.Parent = p1
        game:GetService("TweenService"):Create(v2, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ["OutlineTransparency"] = 1,
            ["FillTransparency"] = 1
        }):Play()
        task.delay(5, v2.Destroy, v2)
    end
}
