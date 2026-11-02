local library = script.Parent.Parent
local booksfolder = library:FindFirstChild("Books")

if not library then
	return
end

library.PickupItem.ModulePrompt.Triggered:Connect(function(plr)

	if not plr.Backpack:FindFirstChild("HintPaper") and not plr.Character:FindFirstChild("HintPaper") then
		game.ServerStorage.HintPaper:Clone().Parent = plr.Character
	end

end)

local Tablelol = {
	library.Assets.BookSelfBook1,
	library.Assets.BookSelfBook2,
	library.Assets.BookSelfBook3,
	library.Assets.BookSelfBook4,
	library.Assets.BookSelfBook5,
	library.Assets.BookSelfBook6,
	library.Assets.BookSelfBook7,
	library.Assets.BookSelfBook8,
	library.Assets.BookSelfBook9,
	library.Assets.BookSelfBook10,
	library.Assets.BookSelfBook11,
	library.Assets.BookSelfBook12,
	library.Assets.BookSelfBook13,
	library.Assets.BookSelfBook14,
	library.Assets.BookSelfBook15,
	library.Assets.BookSelfBook16,
}

for i, v in pairs(booksfolder:GetChildren()) do

	if v:IsA("Model") and v.Name == "LiveHintBook" then

		local random_element_pos = math.random(1, #Tablelol)
		local RandomTable = Tablelol[random_element_pos]

		local randomC = Tablelol[random_element_pos]
		v:PivotTo(randomC:FindFirstChild("HintBook").CFrame)
		--v.Parent = game.Workspace

		require(game.ServerScriptService.Game.Controls.Interactions):SettingHintBook(v)

		wait(0.5)
		table.remove(Tablelol, random_element_pos)

	end

	--booksfolder:Destroy()
end