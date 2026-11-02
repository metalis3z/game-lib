-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local TweenService = game:GetService("TweenService")
local function v_u_16(p2, p3, p4, p5)
    local v6 = p2:GetAttribute(p4 .. "_TweenParams")
    local v7 = {
        { "TweenStyle", p5 },
        { "TweenDirection", Enum.EasingDirection.Out }
    }
    local v_u_8 = {}
    if typeof(v6) == "string" then
        local v9 = { v6:match("(%a+),(%a+)") }
        for v10 = 1, 2 do
            local v_u_11 = v9[v10]
            local v12 = v7[v10]
            local v_u_13 = v12[1]
            local v14 = v12[2]
            if v_u_11 then
                if not pcall(function()
                    v_u_8[v_u_13] = Enum[v_u_13][v_u_11]
                end) then
                    v_u_8[v_u_13] = v14
                end
            else
                v_u_8[v_u_13] = v14
            end
        end
    else
        for _, v15 in v7 do
            v_u_8[v15[1]] = v15[2]
        end
    end
    return TweenInfo.new(p3, v_u_8.TweenStyle, v_u_8.TweenDirection)
end
return function(p17)
    local End = p17.Parent:FindFirstChild("End")
    if End then
        local v19 = p17:Clone()
        local Parent = p17.Parent
        local v21 = tonumber(Parent:GetAttribute("StartTransparency")) or 0
        if v19:IsA("MeshPart") then
            v19.Transparency = v21
        elseif v19:IsA("BasePart") and v19:FindFirstChildOfClass("Decal") then
            v19.Transparency = 1
        end
        v19.Parent = workspace.CurrentCamera
        local Parent_0 = p17.Parent
        local v23 = tonumber(Parent_0:GetAttribute("Duration")) or 0.1
        if v19:FindFirstChildOfClass("Decal") then
            TweenService:Create(v19, v_u_16(p17.Parent, v23, "Part", Enum.EasingStyle.Cubic), {
                ["Size"] = End.Size,
                ["CFrame"] = End.CFrame
            }):Play()
        else
            TweenService:Create(v19, v_u_16(p17.Parent, v23, "Part", Enum.EasingStyle.Cubic), {
                ["Size"] = End.Size,
                ["CFrame"] = End.CFrame,
                ["Transparency"] = 1
            }):Play()
        end
        local SpecialMesh = v19:FindFirstChildOfClass("SpecialMesh")
        local SpecialMesh_0 = End:FindFirstChildOfClass("SpecialMesh")
        if SpecialMesh and SpecialMesh_0 then
            TweenService:Create(SpecialMesh, v_u_16(p17.Parent, v23, "Mesh", Enum.EasingStyle.Sine), {
                ["Scale"] = SpecialMesh_0.Scale
            }):Play()
        end
        local Decal = v19:FindFirstChildOfClass("Decal")
        local Decal_0 = End:FindFirstChildOfClass("Decal")
        if Decal and Decal_0 then
            Decal.Transparency = v21
            TweenService:Create(Decal, v_u_16(p17.Parent, v23, "Decal", Enum.EasingStyle.Cubic), {
                ["Transparency"] = Decal_0.Transparency,
                ["Color3"] = Decal_0.Color3
            }):Play()
        end
        task.delay(v23, v19.Destroy, v19)
    else
        warn("Goal is not defined.")
    end
end
