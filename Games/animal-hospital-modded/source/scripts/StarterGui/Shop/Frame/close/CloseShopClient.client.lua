local button = script.Parent
local frame = button.Parent

button.Active = true
button.AutoButtonColor = true
button.Selectable = true

local function closeShop()
    frame.Visible = false
end

button.Activated:Connect(closeShop)
button.MouseButton1Click:Connect(closeShop)
