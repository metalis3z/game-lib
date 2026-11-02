local player : Player = script.Parent.Parent.Parent.Parent.Parent.Parent
local button = script.Parent
local theme

button.MouseButton1Click:Connect(function()
	local test = Instance.new("Folder", workspace.Map.Ingame)
	theme = require(game.ReplicatedStorage.Modules.Sounds):PlayTheme("rbxassetid://130013349415979", {
		Parent = workspace.Themes,
		Priority = 500,
		Looped = true
	});
	test.Changed:Connect(function(str)
		if str == "Parent" then
			theme:Destroy()
		end
	end)
end)