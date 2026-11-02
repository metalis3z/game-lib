local UD2 = UDim2.new
local Button = script.Parent
local Shadow = script.Parent:WaitForChild("Shadow")
local Position = Button.Position
local Delay = 0.6
local function AnimateButton()
	while wait(Delay) do
		Button.Position = Position + UD2(0, 0, 0, 2)
		Shadow.Visible = false
		wait(Delay)
		Button.Position = Position
		Shadow.Visible = true
	end
end
AnimateButton()
