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
return function(p17, p18)
    local End = p17.Parent:FindFirstChild("End")
    if End then
        local v20 = p17:Clone()
        local Parent = p17.Parent
        local v22 = tonumber(Parent:GetAttribute("StartTransparency")) or 0
        if v20.Material == Enum.Material.Glass and v22 >= 1 then
            local v23 = Instance.new("Highlight")
            v23.Enabled = false
            v23.Parent = v20
            print(v23)
        end
        if v20:IsA("MeshPart") then
            v20.Transparency = v22
        elseif v20:IsA("BasePart") and v20:FindFirstChildOfClass("Decal") then
            v20.Transparency = 1
        end
        v20.Parent = workspace.CurrentCamera
        local Parent_0 = p17.Parent
        local v25 = tonumber(Parent_0:GetAttribute("Duration")) or 0.1
        if v20:FindFirstChildOfClass("Decal") then
            TweenService:Create(v20, v_u_16(p17.Parent, v25, "Part", Enum.EasingStyle.Cubic), {
                ["Size"] = End.Size,
                ["CFrame"] = End.CFrame
            }):Play()
        else
            TweenService:Create(v20, v_u_16(p17.Parent, v25, "Part", Enum.EasingStyle.Cubic), {
                ["Size"] = End.Size,
                ["CFrame"] = End.CFrame,
                ["Color"] = End.Color
            }):Play()
            if p18 == true then
                TweenService:Create(v20, v_u_16(p17.Parent, v25, "Part", Enum.EasingStyle.Cubic), {
                    ["Transparency"] = 1
                }):Play()
            else
                v20.Transparency = 0
            end
        end
        local SpecialMesh = v20:FindFirstChildOfClass("SpecialMesh")
        local SpecialMesh_0 = End:FindFirstChildOfClass("SpecialMesh")
        if SpecialMesh and SpecialMesh_0 then
            TweenService:Create(SpecialMesh, v_u_16(p17.Parent, v25, "Mesh", Enum.EasingStyle.Sine), {
                ["Scale"] = SpecialMesh_0.Scale
            }):Play()
        end
        local Decal = v20:FindFirstChildOfClass("Decal")
        local Decal_0 = End:FindFirstChildOfClass("Decal")
        if Decal and Decal_0 then
            Decal.Transparency = v22
            TweenService:Create(Decal, v_u_16(p17.Parent, v25, "Decal", Enum.EasingStyle.Cubic), {
                ["Color3"] = Decal_0.Color3
            }):Play()
            if p18 == true then
                TweenService:Create(Decal, v_u_16(p17.Parent, v25, "Decal", Enum.EasingStyle.Cubic), {
                    ["Transparency"] = 1
                }):Play()
            else
                Decal.Transparency = 0
            end
        end
        task.delay(v25, v20.Destroy, v20)
    else
        warn("Goal is not defined.")
    end
end
