local randomPainting = math.random(1, 17)
local Image = script.Parent.ImageLabel
local Number = Instance.new("NumberValue")
Number.Value = randomPainting
Number.Name = "Number"
Number.Parent = script.Parent
local TitleNumber = Instance.new("StringValue")
TitleNumber.Value = randomPainting
TitleNumber.Name = "Title"
TitleNumber.Parent = script.Parent

script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
	game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This isnt a painting.')
end)