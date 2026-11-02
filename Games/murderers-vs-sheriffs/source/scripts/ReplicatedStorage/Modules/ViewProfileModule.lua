-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
local v_u_2 = require(game.ReplicatedStorage.Modules.InventoryModule)
local v_u_3 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"))
local v_u_4 = {
	[0] = "",
	[1] = "I",
	[2] = "II",
	[3] = "III",
	[4] = "IV",
	[5] = "V",
	[6] = "VI",
	[7] = "VII",
	[8] = "VIII",
	[9] = "IX",
	[10] = "X"
}
local v_u_5 = require(game.ReplicatedStorage.RankIconsEmpty)
local v_u_6 = { Color3.fromRGB(255, 170, 0), Color3.fromRGB(193, 218, 216), Color3.fromRGB(139, 58, 0) }
local v_u_7 = require(script.Parent.ItemModule)
v_u_1.GUI = {}
v_u_1.PlayerInventories = {}
function v_u_1.GenerateProfile(p8, p9, p10, p11)
	local v12 = v_u_1.GUI.ProfileContainer
	local v13 = v12.Character
	local v14 = v12.Profile.Season1Stats.Container
	local v15 = v12.Profile.Trophies
	local v16 = p9 == game.Players.LocalPlayer.Name and " (You)" or ""
	(v12:FindFirstChild("Username") or v12.Parent:FindFirstChild("Username")).Text = p9 .. v16
	local v17 = game.Players
	local v18 = game.Players[p9].userId
	local v19 = v17:GetUserThumbnailAsync(math.abs(v18), Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size352x352)
	v13.CharacterIcon.Image = v19
	p8.Nav.Profile.Icon.Image = v19
	v13.CharacterIcon.LevelFrame.LevelContainer.Icon.Level.Text = 100
	v13.CharacterIcon.LevelFrame.LevelContainer.Icon.Image = v_u_5[100]
	v13.CharacterIcon.LevelFrame.LevelContainer.Prestige.Visible = true
	v13.CharacterIcon.LevelFrame.LevelContainer.Prestige.Text = v_u_4[10]
	v13.Elite.Visible = p10.Elite == true
	v13.Admin.Visible = p10.Admin == true
	v13.Builder.Visible = p10.MapBuilder == true
	v13.WeaponDesigner.Visible = p10.WeaponDesigner == true
	v13.MM2Creator.Visible = p10.Nikilis == true
	v13.BetaTester.Visible = p10.BetaTester == true
	v13.Clown.Visible = p10.Clown == true
	v14.Eliminations.Amount.Text = p10.Eliminations
	v14.Saves.Amount.Text = p10.Victories
	v14.Survivals.Amount.Text = p10.Survivals
	v15.Visible = p10.Trophies ~= nil
	for _, v20 in v15.Container:GetChildren() do
		if v20:IsA("Frame") then
			v20:Destroy()
		end
	end
	if p10.Trophies then
		table.sort(p10.Trophies, function(a, b)
			local rankA = a.Rank or 999
			local rankB = b.Rank or 999
			return rankA < rankB
		end)

		for _, v21 in pairs(p10.Trophies) do
			local v22 = script.TrophyItem:Clone()
			local v23 = v21.ItemID
			local v24 = v21.Rank
			v22.Container.Icon.Image = v_u_7.GetImage(v_u_3.Weapons[v23].Image)
			v22.Container.Year.YearText.Text = v_u_3.Weapons[v23].Year or "?"
			v22.ItemName.Label.Text = v21.Rank and "Rank #" .. v21.Rank or v_u_3.Weapons[v23].ItemName
			if v_u_6[v24] then
				v22.ItemName.BackgroundColor3 = v_u_6[v24]
			else
				v22.ItemName.BackgroundColor3 = Color3.fromRGB(106, 106, 106) 
			end

			v22.Parent = v15.Container
		end
	end

	v_u_1.DisplayInventory(p8, p9, p11)
end
local v_u_25 = nil
function v_u_1.DisplayInventory(p26, p27, p28)
	for _, v29 in pairs({
		"Weapons",
		"Effects",
		"Perks",
		"Emotes",
		"Radios",
		"Pets"
		}) do
		local v30 = p26.Main:FindFirstChild(v29):FindFirstChild("Title")
		if v30 then
			v30.Username.Text = p27 .. "\'s " .. v29
		end
		for v31, _ in pairs(v_u_2.CreateBlankInventoryTable()[v29]) do
			(p26.Main:FindFirstChild(v29).Items.Container:FindFirstChild(v31) or p26.Main:FindFirstChild(v29).Items.Container:FindFirstChild("Holiday").Container:FindFirstChild(v31)).Container:ClearAllChildren()
		end
	end
	local v32 = game.ReplicatedStorage.Remotes.Extras.GetFullInventory:InvokeServer(p27)
	local v_u_33 = v_u_2.GenerateInventory(p26, v32, nil, p28)
	v_u_1.PlayerInventories[p27] = v_u_33
	if v_u_25 then
		v_u_25:disconnect()
	end
	local v_u_34 = v_u_1.GUI.SearchFrameTextBox
	v_u_25 = v_u_34:GetPropertyChangedSignal("Text"):connect(function()
		local v35 = v_u_34.Text
		local v36 = string.gsub(v35, "S", "")
		for _, v37 in pairs(v_u_33.Data.Weapons) do
			for _, v38 in pairs(v37) do
				v38.Frame.Visible = string.find(string.lower(v38.Name), string.lower(v36))
				if v38.Frame.Parent.Parent:IsA("ScrollingFrame") then
					v38.Frame.Parent.Parent.CanvasPosition = Vector2.new(0, 0)
				else
					v38.Frame.Parent.Parent.Parent.Parent.CanvasPosition = Vector2.new(0, 0)
				end
			end
		end
	end)
end
function v_u_1.DisplayInventoryFromData(p39, p40, p41)
	for _, v42 in pairs({
		"Weapons",
		"Effects",
		"Perks",
		"Emotes",
		"Radios",
		"Pets"
		}) do
		local v43 = p39.Main:FindFirstChild(v42):FindFirstChild("Title")
		if v43 then
			v43.Username.Text = p40 .. "\'s " .. v42
		end
		for v44, _ in pairs(v_u_2.CreateBlankInventoryTable()[v42]) do
			(p39.Main:FindFirstChild(v42).Items.Container:FindFirstChild(v44) or p39.Main:FindFirstChild(v42).Items.Container:FindFirstChild("Holiday").Container:FindFirstChild(v44)).Container:ClearAllChildren()
		end
	end
	local v45 = v_u_2.GenerateInventory(p39, p41)
	v_u_1.PlayerInventories[p40] = v45
end
function v_u_1.DisplayInventoryFromProfile() end
function v_u_1.ConnectViewProfile(p46)
	v_u_2.ConnectNavButtons(p46.Nav, p46.Main)
	v_u_2.ConnectTabButtons(p46, "Weapons")
end
return v_u_1