
local v_u_1 = game:GetService("RunService")
local v_u_2 = false
local function v_u_3() end
local v_u_4 = {}
local function v_u_9(p5)
    if not v_u_2 then
        return v_u_3
    end
    local v_u_6 = Instance.new("CylinderHandleAdornment")
    v_u_6.Adornee = workspace.Terrain
    v_u_6.Color3 = p5
    v_u_6.Transparency = v_u_1:IsClient() and 0.7 or 0.4
    v_u_6.Parent = workspace.Terrain
    return function(p7, p8)
        if p7 == nil then
            v_u_6:Destroy()
        else
            v_u_6.CFrame = CFrame.new(p7) * CFrame.Angles(1.5707963267948966, 0, 0)
            v_u_6.Radius = p8
        end
    end
end
local function v_u_14(p10)
    if not v_u_2 then
        return v_u_3
    end
    local v_u_11 = Instance.new("BoxHandleAdornment")
    v_u_11.Adornee = workspace.Terrain
    v_u_11.Color3 = p10
    v_u_11.Transparency = v_u_1:IsClient() and 0.7 or 0.4
    v_u_11.Parent = workspace.Terrain
    return function(p12, p13)
        if p12 == nil then
            v_u_11:Destroy()
        else
            v_u_11.CFrame = p12
            v_u_11.Size = p13
        end
    end
end
local v_u_15 = {}
function v_u_4.drawHitbox(p16)
    if v_u_2 then
        local v_u_17 = v_u_9(Color3.fromRGB(55, 255, 0))
        v_u_17(p16, 5)
        local v18 = v_u_15
        table.insert(v18, function()
            v_u_17(nil)
        end)
    end
end
function v_u_4.drawTsunami(p19, p20)
    if v_u_2 then
        local v_u_21 = v_u_14(Color3.fromRGB(255, 0, 0))
        v_u_21(p19, p20)
        local v22 = v_u_15
        table.insert(v22, function()
            v_u_21(nil)
        end)
    end
end
function v_u_4.drawTsunamiMutationArea(p23, p24, p25)
    if v_u_2 then
        local v_u_26 = v_u_14(Color3.fromRGB(255, 247, 0))
        v_u_26(p23, p24)
        task.delay(p25, function()
            v_u_26(nil)
        end)
    end
end
function v_u_4.clear()
    for _, v27 in v_u_15 do
        v27()
    end
    table.clear(v_u_15)
end
function v_u_4.getEnabled()
    return v_u_2
end
function v_u_4.setEnabled(p28)
    v_u_2 = p28
    if v_u_1:IsServer() then
        script:SetAttribute("Enabled", p28)
    end
end
if v_u_1:IsClient() then
    script:GetAttributeChangedSignal("Enabled"):Connect(function()
        v_u_4.setEnabled(script:GetAttribute("Enabled"))
    end)
end
return v_u_4