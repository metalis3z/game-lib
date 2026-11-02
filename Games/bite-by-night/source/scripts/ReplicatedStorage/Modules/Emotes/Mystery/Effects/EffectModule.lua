-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v_u_1 = {}
local TweenService = game:GetService("TweenService")
function v_u_1.Effects(p_u_3)
    local v4 = v_u_1
    local v5 = setmetatable({}, v4)
    local function v_u_10(p_u_6, p7, p8)
        p_u_6.Transparency = 0
        p_u_6.Size = Vector3.new(2.7, 0, 1.6)
        p7.C0 = CFrame.new(0, 0, 0)
        local v9 = TweenService:Create(p7, p8, {
            ["C0"] = CFrame.new(0, -1, 0)
        })
        TweenService:Create(p_u_6, p8, {
            ["Size"] = Vector3.new(2.7, 0.2, 1.6)
        }):Play()
        v9:Play()
        v9.Completed:Once(function()
            p_u_6.Transparency = 1
        end)
    end
    local function v_u_15(p_u_11, p12, p13)
        p_u_11.Transparency = 0
        p_u_11.Size = Vector3.new(1.3, 0.2, 1.3)
        p12.C0 = CFrame.new(0, 1, 0)
        local v14 = TweenService:Create(p12, p13, {
            ["C0"] = CFrame.new(0, -1, 0)
        })
        TweenService:Create(p_u_11, p13, {
            ["Size"] = Vector3.new(1.3, 0, 1.3)
        }):Play()
        v14:Play()
        v14.Completed:Once(function()
            p_u_11.Transparency = 1
        end)
    end
    local function v_u_20(p_u_16, p17, p18)
        p_u_16.Transparency = 0
        p_u_16.Size = Vector3.new(1.3, 0, 1.3)
        p17.C0 = CFrame.new(0, -1, 0)
        local v19 = TweenService:Create(p17, p18, {
            ["C0"] = CFrame.new(0, 1, 0)
        })
        TweenService:Create(p_u_16, p18, {
            ["Size"] = Vector3.new(1.3, 0.5, 1.3)
        }):Play()
        v19:Play()
        v19.Completed:Once(function()
            p_u_16.Transparency = 1
        end)
    end
    local function v_u_25(p_u_21, p22, p23)
        p_u_21.Transparency = 0
        p_u_21.Size = Vector3.new(2.7, 0.2, 1.6)
        p22.C0 = CFrame.new(0, -1, 0)
        local v24 = TweenService:Create(p22, p23, {
            ["C0"] = CFrame.new(0, 0, 0)
        })
        TweenService:Create(p_u_21, p23, {
            ["Size"] = Vector3.new(2.7, 0, 1.6)
        }):Play()
        v24:Play()
        v24.Completed:Once(function()
            p_u_21.Transparency = 1
        end)
    end
    function v5.Effect1()
        v_u_10(p_u_3.TorsoRing.Ring1, p_u_3.TorsoRing["Ring1 Weld"], TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out))
        task.delay(0.1, function()
            v_u_10(p_u_3.TorsoRing.Ring2, p_u_3.TorsoRing["Ring2 Weld"], TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out))
        end)
        task.wait(0.1)
        local v_u_26 = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        local v_u_27 = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
        v_u_15(p_u_3["LeftLeg Ring"].Ring5, p_u_3["LeftLeg Ring"]["Ring5 Weld"], v_u_26)
        v_u_15(p_u_3["RightLeg Ring"].Ring3, p_u_3["RightLeg Ring"]["Ring3 Weld"], v_u_26)
        task.delay(0.05, function()
            v_u_15(p_u_3["LeftLeg Ring"].Ring6, p_u_3["LeftLeg Ring"]["Ring6 Weld"], v_u_26)
            v_u_15(p_u_3["RightLeg Ring"].Ring4, p_u_3["RightLeg Ring"]["Ring4 Weld"], v_u_26)
            task.delay(0.1, function()
                v_u_20(p_u_3["LeftLeg Ring"].Ring6, p_u_3["LeftLeg Ring"]["Ring6 Weld"], v_u_27)
                v_u_20(p_u_3["RightLeg Ring"].Ring4, p_u_3["RightLeg Ring"]["Ring4 Weld"], v_u_27)
                task.delay(0.1, function()
                    v_u_25(p_u_3.TorsoRing.Ring2, p_u_3.TorsoRing["Ring2 Weld"], TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out))
                end)
            end)
        end)
        task.delay(0.1, function()
            v_u_20(p_u_3["LeftLeg Ring"].Ring5, p_u_3["LeftLeg Ring"]["Ring5 Weld"], v_u_27)
            v_u_20(p_u_3["RightLeg Ring"].Ring3, p_u_3["RightLeg Ring"]["Ring3 Weld"], v_u_27)
            task.delay(0.1, function()
                v_u_25(p_u_3.TorsoRing.Ring1, p_u_3.TorsoRing["Ring1 Weld"], TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out))
            end)
        end)
    end
    function v5.Effect2()
        task.spawn(function()
            v_u_20(p_u_3["RightLeg Ring"].Ring3, p_u_3["RightLeg Ring"]["Ring3 Weld"], TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In))
            task.wait(0.1)
            v_u_25(p_u_3.TorsoRing.Ring2, p_u_3.TorsoRing["Ring2 Weld"], TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
            task.wait(0.1)
            v_u_10(p_u_3.TorsoRing.Ring2, p_u_3.TorsoRing["Ring2 Weld"], TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
            task.wait(0.1)
            v_u_15(p_u_3["LeftLeg Ring"].Ring5, p_u_3["LeftLeg Ring"]["Ring5 Weld"], TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out))
        end)
        task.wait(0.05)
        v_u_20(p_u_3["RightLeg Ring"].Ring4, p_u_3["RightLeg Ring"]["Ring4 Weld"], TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In))
        task.wait(0.1)
        v_u_25(p_u_3.TorsoRing.Ring1, p_u_3.TorsoRing["Ring1 Weld"], TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
        task.wait(0.1)
        v_u_10(p_u_3.TorsoRing.Ring1, p_u_3.TorsoRing["Ring1 Weld"], TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
        task.wait(0.1)
        v_u_15(p_u_3["LeftLeg Ring"].Ring6, p_u_3["LeftLeg Ring"]["Ring6 Weld"], TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out))
    end
    return v5
end
return v_u_1
