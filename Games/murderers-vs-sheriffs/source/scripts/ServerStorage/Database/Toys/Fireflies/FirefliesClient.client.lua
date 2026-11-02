--Made by the thebrickplanetboy
local Tool = script.Parent
local FirefliesEvent = Tool:WaitForChild("FirefliesEvent")
local SetCursorEvent = Tool:WaitForChild("SetCursorEvent")

local function OnEquipped(Mouse)
	if Mouse ~= nil then
		Mouse.Icon = "rbxasset://textures\\GunCursor.png"
		Mouse.Button1Down:Connect(function()
			FirefliesEvent:FireServer()
		end)
		SetCursorEvent.OnClientEvent:Connect(function(MouseIcon)
			Mouse.Icon = MouseIcon
		end)
	end
end

Tool.Equipped:Connect(OnEquipped)