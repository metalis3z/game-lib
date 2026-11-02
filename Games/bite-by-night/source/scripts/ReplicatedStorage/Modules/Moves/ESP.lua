-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

return {
    ["Activate"] = function(p_u_1)
        for _, v_u_2 in workspace.PLAYERS.ALIVE:GetChildren() do
            task.spawn(function()
                local v3 = Instance.new("Highlight")
                v3.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                v3.FillColor = Color3.fromRGB(255, 255, 255)
                v3.OutlineColor = Color3.fromRGB(255, 255, 255)
                v3.OutlineTransparency = 0.5
                v3.FillTransparency = 0.5
                if v_u_2:GetAttribute("Crouching") == true then
                    v3.OutlineTransparency = 0.65
                    v3.FillTransparency = 0.65
                end
                if v_u_2:HasTag("UNDETECTABLE") then
                    v3.OutlineTransparency = 0.8
                    v3.FillTransparency = 0.8
                end
                v3.OutlineColor = Color3.fromRGB(255, 255, 255)
                v3.Parent = v_u_2
                local v4 = p_u_1 or 5
                game:GetService("TweenService"):Create(v3, TweenInfo.new(v4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    ["OutlineTransparency"] = 1,
                    ["FillTransparency"] = 1
                }):Play()
                task.delay(v4, v3.Destroy, v3)
            end)
        end
    end
}
