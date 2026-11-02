-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
game:GetService("TweenService")
local v_u_3 = game:GetService("GuiService")
local v4 = v1:WaitForChild("Packages")
local v5 = require(v4.Net)
local v6 = v1:WaitForChild("Controllers")
local v_u_7 = require(v6.SoundController)
local v_u_8 = require(v1.Packages.Gradients)
local v_u_9 = require(v1.Packages.CreateTween)
local v_u_10 = v2.LocalPlayer.PlayerGui
local v_u_11 = v_u_10:WaitForChild("Notification").Notification
local v_u_12 = v_u_11.Template
local v_u_13 = v5:RemoteEvent("NotificationService/Notify")
local v_u_14 = TweenInfo.new(1, Enum.EasingStyle.Linear)
local v_u_15 = {}
local v_u_16 = {
    "rainbow",
    "og",
    "yellowred",
    "zebra",
    "greenred",
    "slowgreenred"
}
local function v_u_23(p17)
    -- upvalues: (copy) v_u_16
    local v18 = {}
    for _, v19 in v_u_16 do
        local v20 = ("<%*>(.-)</%*>"):format(v19, v19)
        local v21, v22 = string.gsub(p17, v20, "<stroke transparency=\"0\"><font transparency=\"0\">%1</font></stroke>")
        if v22 > 0 then
            p17 = string.gsub(p17, v20, "<stroke transparency=\"1\"><font transparency=\"1\">%1</font></stroke>")
            table.insert(v18, {
                ["tag"] = v19,
                ["text"] = v21
            })
        end
    end
    return p17, v18
end
function v_u_15.Error(_, p24)
    -- upvalues: (copy) v_u_15
    v_u_15:Notify(("<font color=\"#FA0103\">%*</font>"):format(p24), 5, "Sounds.Sfx.Error")
end
function v_u_15.Success(_, p25)
    -- upvalues: (copy) v_u_15
    v_u_15:Notify(("<font color=\"#92FF67\">%*</font>"):format(p25), 5, "Sounds.Sfx.Success")
end
local v_u_26 = {}
function v_u_15.Notify(_, p_u_27, p_u_28, p_u_29, p_u_30, _, p_u_31, p_u_32)
    -- upvalues: (copy) v_u_23, (copy) v_u_26, (copy) v_u_7, (copy) v_u_8, (copy) v_u_12, (copy) v_u_10, (copy) v_u_11, (copy) v_u_9, (copy) v_u_14
    task.spawn(function()
        -- upvalues: (ref) v_u_23, (copy) p_u_27, (ref) p_u_28, (copy) p_u_32, (copy) p_u_31, (ref) v_u_26, (copy) p_u_29, (ref) v_u_7, (ref) v_u_8, (ref) v_u_12, (copy) p_u_30, (ref) v_u_10, (ref) v_u_11, (ref) v_u_9, (ref) v_u_14
        local v_u_33, v_u_34 = v_u_23(p_u_27)
        p_u_28 = p_u_28 or 5
        if p_u_32 and (p_u_31 ~= nil and v_u_26[p_u_31]) then
            v_u_26[p_u_31]:Destroy()
            v_u_26[p_u_31] = nil
            return
        elseif v_u_33 == "" then
            if p_u_29 then
                v_u_7:PlaySound(p_u_29)
            end
            return
        else
            local function v40(p35, p36)
                -- upvalues: (copy) v_u_33, (copy) v_u_34, (ref) v_u_8
                if p36 then
                    for _, v37 in p35:GetChildren() do
                        if v37:IsA("TextLabel") then
                            v37:Destroy()
                        end
                    end
                end
                p35.Text = v_u_33
                for _, v38 in v_u_34 do
                    local v39 = p35:Clone()
                    v39:ClearAllChildren()
                    v39.Text = ("<stroke transparency=\"1\"><font transparency=\"1\">%*</font></stroke>"):format(v38.text)
                    v39.Size = UDim2.fromScale(1, 1)
                    v39.Position = UDim2.fromScale(0.5, 0.5)
                    v39.AnchorPoint = Vector2.new(0.5, 0.5)
                    v39.Parent = p35
                    if v38.tag == "rainbow" then
                        v_u_8.apply(v39, "Rainbow")
                    elseif v38.tag == "zebra" then
                        v_u_8.apply(v39, "Zebra")
                    elseif v38.tag == "og" then
                        v_u_8.apply(v39, "OG")
                    elseif v38.tag == "yellowred" then
                        v_u_8.apply(v39, "YellowRed")
                    elseif v38.tag == "greenred" then
                        v_u_8.apply(v39, "GreenRed")
                    elseif v38.tag == "slowgreenred" then
                        v_u_8.apply(v39, "SlowGreenRed")
                    end
                end
            end
            local v41
            if p_u_31 == nil then
                v41 = false
            else
                v41 = v_u_26[p_u_31]
            end
            if v41 then
                v40(v41, true)
                return
            else
                local v42 = v_u_12:Clone()
                if p_u_31 ~= nil then
                    v_u_26[p_u_31] = v42
                end
                if p_u_29 then
                    v_u_7:PlaySound(p_u_29)
                end
                v42.Visible = true
                v40(v42, false)
                local v43
                if p_u_30 == "Top" then
                    v43 = v_u_10:WaitForChild("TopNotification").TopNotification
                else
                    v43 = v_u_11
                end
                v42.Parent = v43
                task.wait(p_u_28)
                if v42:IsDescendantOf(v_u_10) then
                    for _, v44 in v42:GetChildren() do
                        if v44:IsA("TextLabel") then
                            v_u_9(v42, v_u_14, {
                                ["TextTransparency"] = 1
                            })
                            v_u_9(v42.UIStroke, v_u_14, {
                                ["Transparency"] = 1
                            })
                        end
                    end
                    task.wait(v_u_14.Time)
                    v42:Destroy()
                    if p_u_31 ~= nil then
                        v_u_26[p_u_31] = nil
                    end
                elseif p_u_31 ~= nil then
                    v_u_26[p_u_31] = nil
                end
            end
        end
    end)
end
function v_u_15.Start(_)
    -- upvalues: (copy) v_u_13, (copy) v_u_15, (copy) v_u_10, (copy) v_u_3
    v_u_13.OnClientEvent:Connect(function(...)
        -- upvalues: (ref) v_u_15
        v_u_15:Notify(...)
    end)
    local function v45()
        -- upvalues: (ref) v_u_10, (ref) v_u_3
        v_u_10:WaitForChild("TopNotification").TopNotification.Position = UDim2.fromScale(0.5, 0.075) + UDim2.fromOffset(0, v_u_3.TopbarInset.Height)
    end
    v_u_3:GetPropertyChangedSignal("TopbarInset"):Connect(v45)
    v_u_10:WaitForChild("TopNotification").TopNotification.Position = UDim2.fromScale(0.5, 0.075) + UDim2.fromOffset(0, v_u_3.TopbarInset.Height)
end
return v_u_15