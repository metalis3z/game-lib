--credit to prince games studio
local Hotbar = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("BackpackGui"):WaitForChild("Backpack"):WaitForChild("Hotbar")
local RunService = game:GetService("RunService")

local function UPD() --[[ UPD | Line: 4 | Upvalues: Hotbar (copy) ]]
	local AbsoluteSize = Hotbar.AbsoluteSize
	local AbsolutePosition = Hotbar.AbsolutePosition
	local Y = workspace.CurrentCamera.ViewportSize.Y

	if not (AbsoluteSize.Y <= 0 or Y <= 0) then
		script.Parent.Position = UDim2.new(0.5, 0, 1, -(Y - (AbsolutePosition.Y + AbsoluteSize.Y)) - Y * 0.05)
	end
end

RunService.Heartbeat:Connect(UPD)