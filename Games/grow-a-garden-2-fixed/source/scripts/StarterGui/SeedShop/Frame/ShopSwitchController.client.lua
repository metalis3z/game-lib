--credit to leon games studio
local Frame = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("SeedShop"):WaitForChild("Frame")
local Header = Frame:WaitForChild("Header")
local DefaultButton = Header:WaitForChild("DefaultButton")
local ExclusiveShop = Frame:WaitForChild("ExclusiveShop")
local NormalShop = Frame:WaitForChild("NormalShop")
local ExitButton = Header:WaitForChild("ExitButton")
local v1 = false

local function UpdateVisibility() --[[ UpdateVisibility | Line: 17 | Upvalues: DefaultButton (copy), v1 (ref), ExclusiveButton (copy), ExclusiveShop (copy), NormalShop (copy) ]]
	DefaultButton.Visible = v1
	ExclusiveShop.Visible = v1
	NormalShop.Visible = not v1
end

local function ToggleShop() --[[ ToggleShop | Line: 24 | Upvalues: v1 (ref), DefaultButton (copy), ExclusiveButton (copy), ExclusiveShop (copy), NormalShop (copy) ]]
	v1 = not v1
	DefaultButton.Visible = v1
	ExclusiveShop.Visible = v1
	NormalShop.Visible = not v1
end

DefaultButton.MouseButton1Click:Connect(function() --[[ Line: 29 | Upvalues: v1 (ref), DefaultButton (copy), ExclusiveButton (copy), ExclusiveShop (copy), NormalShop (copy) ]]
	v1 = not v1
	DefaultButton.Visible = v1
	ExclusiveShop.Visible = v1
	NormalShop.Visible = not v1
end)
ExitButton.MouseButton1Click:Connect(function() --[[ Line: 37 | Upvalues: v1 (ref), DefaultButton (copy), ExclusiveButton (copy), ExclusiveShop (copy), NormalShop (copy) ]]
	v1 = false
	DefaultButton.Visible = v1
	ExclusiveShop.Visible = v1
	NormalShop.Visible = not v1
end)