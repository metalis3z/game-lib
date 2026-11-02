-- Ajusta el CanvasSize horizontal del ScrollingFrame al ancho real de la fila de
-- botones (Cash) para que el scroll del mouse recorra TODOS los productos.
local inv    = script.Parent
local frame  = inv:WaitForChild("inv")
local cash   = frame:WaitForChild("Cash")
local layout = cash:WaitForChild("UIListLayout")

inv.ScrollingDirection = Enum.ScrollingDirection.X
inv.ScrollingEnabled = true
frame.ClipsDescendants = false
cash.ClipsDescendants = false

local function update()
	inv.CanvasSize = UDim2.fromOffset(layout.AbsoluteContentSize.X + 30, 0)
end
update()
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(update)
inv:GetPropertyChangedSignal("AbsoluteSize"):Connect(update)
task.delay(1, update)
task.delay(3, update)
