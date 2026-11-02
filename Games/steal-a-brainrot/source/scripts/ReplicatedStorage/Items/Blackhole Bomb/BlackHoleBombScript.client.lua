local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)
local Parent = script.Parent

Parent.Activated:Connect(function()
	local v10 = require(ReplicatedStorage.Packages.PlayerMouse)
    local l_CurrentCamera_0 = workspace.CurrentCamera
    local v12 = v10.Hit.Position - l_CurrentCamera_0.CFrame.Position
    if v12.Magnitude < 0.001 then
        return
    else
        v12 = v12.Unit
        local v13 = l_CurrentCamera_0.ViewportSize * 0.5
		local l_l_GuiService_0_GuiInset_0 = GuiService:GetGuiInset()
		local v15 = UserInputService:GetMouseLocation() - l_l_GuiService_0_GuiInset_0
        local v16 = Vector2.new(v15.X - v13.X, v15.Y - v13.Y)
        local v17 = math.min(v13.X, v13.Y)
        local v18 = math.clamp(v16.Magnitude / v17, 0, 1)
		Net:RemoteEvent("UseItem"):FireServer(v12, v18)
        return
    end
end)