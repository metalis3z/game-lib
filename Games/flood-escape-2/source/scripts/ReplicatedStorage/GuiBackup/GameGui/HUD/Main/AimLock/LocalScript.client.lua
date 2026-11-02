-- Decompiled using Krnl
local v3 = game:GetService("UserInputService")
local v4 = false
local v21 = script.Parent
v21.MouseButton1Click:Connect(function()
	local Checker = (script.Parent.BackgroundColor3 == Color3.fromRGB(46, 204, 113) and "On") or (script.Parent.BackgroundColor3 == Color3.fromRGB(22, 31, 40) and "Off")
	if Checker == "On" then
		script.Parent.BackgroundColor3 = Color3.fromRGB(22, 31, 40)
		EndForceShiftLock()
		return
	else
		script.Parent.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
		ForceShiftLock()
		return
	end	
end)
local v26 = (UserSettings()):GetService("UserGameSettings")
v21 = nil
local v27
function ForceShiftLock()
    local v34, v35 = pcall(function()
        return v26.RotationType
    end)
    _ = v34
    v27 = v35
    v35 = game
    v34 = v35:GetService("RunService").RenderStepped
    v21 = v34:Connect(function()
        pcall(function()
            v26.RotationType = Enum.RotationType.CameraRelative
        end)
    end)
end
function EndForceShiftLock()
    local v45 = v21
    if v45 then
        v45 = pcall
        v45(function()
            local v48 = v27
            if not v48 then
                v48 = Enum.RotationType.MovementRelative
            end
            v26.RotationType = v48
        end)
        v21:Disconnect()
    end
end
