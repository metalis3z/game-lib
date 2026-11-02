-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GuiService = game:GetService("GuiService")
local HapticService = game:GetService("HapticService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ClientGlobals = require(ReplicatedStorage:WaitForChild("Client").ClientGlobals)
local Between = require(ReplicatedStorage.Shared.Utils.Spatial).Between
local Gamepad1 = Enum.UserInputType.Gamepad1
local Large = Enum.VibrationMotor.Large
local v1 = Random.new()
local v2 = 0
local v3 = {}

local function reachScale(v4) -- line 18 | captures: Players, Between
    local v5 = Between(Players.LocalPlayer, v4.Origin)
    if v5 then
        if v4.MaxDistance < v5 then
            return nil
        end
        if v5 <= v4.RollOffDistance then
            return 1
        end
        local v6 = v4.MaxDistance - v4.RollOffDistance
        if v6 == 0 then
            v6 = 0.001
        end
        local v7 = (v5 - v4.RollOffDistance) / v6
        local v8 = math.clamp(v7, 0, 1)
        if v8 >= 1 then
            return nil
        end
        return 1 - v8
    end
    return 1
end

local function rumbleWanted(v9) -- line 39 | captures: HapticService, ClientGlobals, Gamepad1
    if not v9 then
        if ClientGlobals.Console then
            return HapticService:IsVibrationSupported(Gamepad1)
        end
        if ClientGlobals.Mobile then
            return HapticService:IsVibrationSupported(Gamepad1)
        end
    end
    return false
end

local function drive(v10, v11, v12, v13, v14, v15) -- line 51 | captures: v2, HapticService, RunService, ClientGlobals, Gamepad1, Large, v1
    local v16 = os.clock()
    local v17 = os.clock()
    local CurrentCamera = workspace.CurrentCamera
    local v18, v19, v20 = nil, nil, Vector3.new()
    while true do
        local v21, v22, v23, v24
        if v2 == v10 then
            if v11 < os.clock() - v16 then
                v24 = true
            else
                local v25 = (os.clock() - v16) / v11
                if v19 then
                    if os.clock() - v17 < v13 then
                    end
                    v23 = v18
                    v21 = v17
                    v22 = v19
                else
                    v21 = os.clock()
                    local v26
                    if v14 then
                        local v27 = v25 * 3.141592653589793
                        v26 = math.sin(v27)
                    else
                        local v28 = (0.5 + v25 / 2) * 3.141592653589793
                        v26 = math.sin(v28)
                    end
                    local v29 = v1:NextNumber(-v26, v26) * v26 * v12
                    local v30 = v1:NextNumber(-v26, v26) * v26 * v12
                    local v31 = v1:NextNumber(-v26, v26) * v26 * v12
                    v22 = Vector3.new(v29, v30, v31)
                    if v15 then
                        v23 = false
                    else
                        if ClientGlobals.Console then
                            v23 = HapticService:IsVibrationSupported(Gamepad1)
                        else
                            local Mobile = ClientGlobals.Mobile
                            v23 = v18
                        end
                        if v23 then
                            HapticService:SetMotor(Gamepad1, Large, math.min(v12, 1) * v26)
                        end
                    end
                end
                v24 = false
            end
        else
            v24 = true
        end
        if v24 then
            break
        end
        CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(-v20) * CFrame.new(v22)
        RunService.RenderStepped:Wait()
        v18 = v23
        v17 = v21
        v19 = v22
        v20 = v22
    end
    CurrentCamera.CFrame *= CFrame.new(-v20)
    if not v15 and (ClientGlobals.Console or ClientGlobals.Mobile) and HapticService:IsVibrationSupported(Gamepad1) then
        HapticService:SetMotor(Gamepad1, Large, 0)
    end
end

local function begin(v32, v33, v34, v35, v36, v37) -- line 104 | captures: v2, Players, Between, drive
    v2 += 1
    local v38 = v35 == true
    local v39
    if v36 then
        local v40 = Between(Players.LocalPlayer, v36.Origin)
        if v40 then
            if v36.MaxDistance < v40 then
            elseif v40 <= v36.RollOffDistance then
                v39 = 1
            else
                local v41 = v36.MaxDistance - v36.RollOffDistance
                if v41 == 0 then
                    v41 = 0.001
                end
                local v42 = (v40 - v36.RollOffDistance) / v41
                local v43 = math.clamp(v42, 0, 1)
                if v43 >= 1 then
                else
                    v39 = 1 - v43
                end
            end
        else
            v39 = 1
        end
    else
        v39 = 1
    end
    if v39 ~= nil then
        task.spawn(drive, v2, v32 or 1, (v33 or 1) * v39, (v34 or 0) / 10, v38, v37)
    end
end

function v3.Play(v44, v45, v46, v47, v48, v49) -- line 117 | captures: v2, GuiService, Players, Between, drive
    if GuiService.ReducedMotionEnabled or workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
        return
    end
    v2 += 1
    local v50 = v47 == true
    local v51
    if v48 then
        local v52 = Between(Players.LocalPlayer, v48.Origin)
        if v52 then
            if v48.MaxDistance < v52 then
            elseif v52 <= v48.RollOffDistance then
                v51 = 1
            else
                local v53 = v48.MaxDistance - v48.RollOffDistance
                if v53 == 0 then
                    v53 = 0.001
                end
                local v54 = (v52 - v48.RollOffDistance) / v53
                local v55 = math.clamp(v54, 0, 1)
                if v55 >= 1 then
                else
                    v51 = 1 - v55
                end
            end
        else
            v51 = 1
        end
    else
        v51 = 1
    end
    if v51 ~= nil then
        task.spawn(drive, v2, v44 or 1, (v45 or 1) * v51, (v46 or 0) / 10, v50, v49)
    end
end

return v3
