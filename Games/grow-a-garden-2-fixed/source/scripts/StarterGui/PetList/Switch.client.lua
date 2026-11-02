--credit to prince games studio
local OpenButton = script.Parent:WaitForChild("Exit"):WaitForChild("OpenButton")
local Frame = script.Parent:WaitForChild("Frame")
local MenuOpenClose = game.SoundService.SFX.MenuOpenClose
local v1 = false

function UPD() --[[ UPD | Line: 8 | Upvalues: v1 (ref), OpenButton (copy), Frame (copy), MenuOpenClose (copy) ]]
	if v1 == true then
		OpenButton.Close.Visible = true
		OpenButton.Vector.Visible = false
		Frame.Position = UDim2.new(0.01, 0, 0.5, 0)
		OpenButton.Position = UDim2.new(1.025, 0, 0.5, 0)
	else
		OpenButton.Close.Visible = false
		OpenButton.Vector.Visible = true
		Frame.Position = UDim2.new(-0.5, 0, 0.5, 0)
		OpenButton.Position = UDim2.new(0, 0, 0.5, 0)
	end

	MenuOpenClose.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	MenuOpenClose.TimePosition = 0
	MenuOpenClose.Playing = true
end
function Toggle() --[[ Toggle | Line: 25 | Upvalues: v1 (ref) ]]
	v1 = not v1
	UPD()
end
UPD()
OpenButton.MouseButton1Click:Connect(function() --[[ Line: 32 ]]
	Toggle()
end)