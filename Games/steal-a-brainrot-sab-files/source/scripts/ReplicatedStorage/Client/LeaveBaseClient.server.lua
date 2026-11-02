
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(v1.Classes.PlotClient)
local v_u_3 = require(v1.Controllers.PlotController)
local v_u_4 = require(v1.Shared.Friends)
local v_u_5 = require(v1.UserGenerated.ABTests)
local v_u_6 = require(v1.Packages.Net)
local v_u_7 = OverlapParams.new()
v_u_7.FilterDescendantsInstances = {}
v_u_7.FilterType = Enum.RaycastFilterType.Include
v_u_7.MaxParts = 1
local function v_u_10(p8)
    for _, v9 in pairs(v_u_3:GetPlots()) do
        if v9:GetOwner() then
            v_u_7.FilterDescendantsInstances = { v9.PlotModel.StealHitbox }
            if #workspace:GetPartBoundsInBox(p8, Vector3.new(0.01, 0.01, 0.01), v_u_7) > 0 then
                return v9, 1
            end
        end
    end
    return nil, 0
end
local v_u_11 = { "BlockEndTimeFirstFloor", "BlockEndTimeSecondFloor", "BlockEndTimeThirdFloor" }
local function v_u_17(p12, p13, _)
    local v14 = p13:GetOwner()
    if not v14 then
        return false
    end
    if v14 == p12 then
        return false
    end
    if p12:GetAttribute("IgnoreLasers") then
        return false
    end
    local v15 = false
    for _, v16 in ipairs(v_u_11) do
        if p13.Channel:Get(v16) ~= nil then
            v15 = true
            break
        end
    end
    if v15 then
        return (p13.Channel:Get("FriendsAllowed") ~= true or not table.find(v_u_4:GetInGameFriends(p12), v14)) and true or false
    else
        return false
    end
end
local function v_u_23(p18)
    if v_u_5.GetAttribute(p18, "LeaveBaseButton", false) then
        if p18:GetAttribute("InNorthPole") then
            return false
        elseif p18:GetAttribute("Web") then
            return false
        elseif p18:GetAttribute("Freeze") then
            return false
        elseif p18:GetAttribute("Stealing") then
            return false
        else
            local v19 = p18.Character
            local v20, v21
            if v19 and v19.PrimaryPart then
                local v22 = v19:FindFirstChildOfClass("Humanoid")
                if v22 and v22.Health > 0 then
                    v20, v21 = v_u_10((v19:GetPivot()))
                else
                    v20 = nil
                    v21 = 0
                end
            else
                v20 = nil
                v21 = 0
            end
            if v20 then
                return v_u_17(p18, v20, v21) and true or false
            else
                return false
            end
        end
    else
        return false
    end
end
local v_u_24 = v2.LocalPlayer
local toolframes = v_u_24.PlayerGui:WaitForChild("ToolsFrames")
local v_u_25 = toolframes:WaitForChild("LeaveBase", 30)
task.spawn(function()
    while true do
        v_u_25.Visible = v_u_23(v_u_24)
        task.wait(0.1)
    end
end)
v_u_25.Activate.Activated:Connect(function()
    if v_u_25.Visible then
        v_u_6:RemoteEvent("PlotService/Leave"):FireServer()
    end
end)