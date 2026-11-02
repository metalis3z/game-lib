-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Game_0 = script.Parent.Parent:WaitForChild("Game");
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_Inventory_0 = l_Game_0:WaitForChild("Inventory");
local l_Dock_0 = l_Game_0:WaitForChild("Dock");
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_ItemPopupService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemPopupService"));
local l_Modules_0 = game.ReplicatedStorage:WaitForChild("Modules");
local CurrentRoundClient = require(l_Modules_0.CurrentRoundClient)
local l_InventoryModule_0 = require(l_Modules_0:WaitForChild("InventoryModule"));
l_InventoryModule_0.GUI.MyInventory = {};
l_InventoryModule_0.GUI.MyInventory.Main = l_Inventory_0.Main;	
l_InventoryModule_0.GUI.MyInventory.Nav = l_Inventory_0.Nav;
l_InventoryModule_0.GUI.NewItem = l_Game_0.NewItem;
l_InventoryModule_0.GUI.EvoMenu = l_Inventory_0.Main.Weapons.EvoMenu;
l_InventoryModule_0.GUI.OutfitMenu = l_Inventory_0.Main.Outfits.OutfitPopup

for _, v9 in pairs({"Weapons", "Effects", "Perks", "Emotes", "Radios", "Pets", "Outfits"}) do
    for v10, _ in pairs(l_InventoryModule_0.CreateBlankInventoryTable()[v9]) do
        (l_Inventory_0.Main:FindFirstChild(v9).Items.Container:FindFirstChild(v10) or l_Inventory_0.Main:FindFirstChild(v9).Items.Container:FindFirstChild("Holiday").Container:FindFirstChild(v10)).Container:ClearAllChildren();
    end;
end;
l_InventoryModule_0.MyInventory = l_InventoryModule_0.GenerateInventory(l_Inventory_0, l_ProfileData_0);
local Players = game:GetService("Players")
local rankIcons = require(game.ReplicatedStorage:WaitForChild("RankIconsEmpty"))
local roman = {[0] = "", [1] = "I", [2] = "II", [3] = "III", [4] = "IV", [5] = "V", [6] = "VI", [7] = "VII", [8] = "VIII", [9] = "IX", [10] = "X"}

local function getLevel(xp)
	xp = tonumber(xp) or 0
	return math.floor((25 + math.sqrt(625 + 300 * xp)) / 50)
end

local function statText(value)
	value = tonumber(value) or 0
	return tostring(math.max(0, math.floor(value)))
end

local function findDescendant(parent, name)
	return parent and parent:FindFirstChild(name, true)
end

local function fillProfile()
	local page = l_Inventory_0.Main.Weapons.Items.Container:FindFirstChild("Profile")
	local box = findDescendant(page, "ProfileInfo")
	if not box then
		return
	end

	local player = Players.LocalPlayer
	local data = l_ProfileData_0
	local status = data.Status or {}
	local character = findDescendant(box, "Character")
	local stats = findDescendant(box, "Season1Stats")
	local username = findDescendant(box, "Username")

	if username then
		username.Text = player.Name .. " (You)"
	end

	if character then
		local icon = character:FindFirstChild("CharacterIcon")
		if icon then
			task.spawn(function()
				local ok, image = pcall(function()
					return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size352x352)
				end)
				if ok then
					icon.Image = image
				end
			end)

			local level = 100
			local levelContainer = findDescendant(icon, "LevelContainer")
			local levelIcon = levelContainer and levelContainer:FindFirstChild("Icon")
			if levelIcon then
				local levelText = levelIcon:FindFirstChild("Level")
				if levelText then
					levelText.Text = tostring(level)
				end
				if rankIcons[level] then
					levelIcon.Image = rankIcons[level]
				end
				local prestigeText = levelIcon:FindFirstChild("Prestige")
				if prestigeText then
					prestigeText.Visible = true
					prestigeText.Text = roman[10]
				end
			end
		end

		local elite = character:FindFirstChild("Elite")
		if elite then
			elite.Visible = data.Elite == true or player:GetAttribute("Elite") ~= nil
		end
	end

	if stats then
		local container = stats:FindFirstChild("Container")
		if container then
			local eliminations = container:FindFirstChild("Eliminations")
			local saves = container:FindFirstChild("Saves")
			local survivals = container:FindFirstChild("Survivals")
			if eliminations and eliminations:FindFirstChild("Amount") then
				eliminations.Amount.Text = statText(data.Eliminations or status.Murderer)
			end
			if saves and saves:FindFirstChild("Amount") then
				saves.Amount.Text = statText(data.Victories or status.Sheriffs)
			end
			if survivals and survivals:FindFirstChild("Amount") then
				survivals.Amount.Text = statText(data.Survivals or status.Innocents)
			end
		end
	end
end

fillProfile()
local profileChanged = l_Remotes_0.Inventory:FindFirstChild("ProfileDataChanged")
if profileChanged and profileChanged.Event then
	profileChanged.Event:Connect(fillProfile)
end
local l_Container_0 = l_Inventory_0.Main.Weapons.Items.Container;
l_Container_0.Holiday.Container.EventLayout:GetPropertyChangedSignal("AbsoluteContentSize"):connect(function() --[[ Line: 37 ]]
    l_Container_0.Holiday.Container.Size = UDim2.new(1, 0, 0, l_Container_0.Holiday.Container.EventLayout.AbsoluteContentSize.Y + 3);
    l_Container_0.Holiday.CanvasSize = UDim2.new(1, 0, 0, l_Container_0.Holiday.Container.EventLayout.AbsoluteContentSize.Y + 6);
end);

l_InventoryModule_0.ConnectNavButtons(l_Inventory_0.Nav, l_Inventory_0.Main);
l_InventoryModule_0.ConnectTabButtons(l_Inventory_0, "Weapons");
l_InventoryModule_0.UpdateMyEquip();
l_InventoryModule_0.ConnectEquipButtons();
l_InventoryModule_0.ConnectPetNaming(l_Inventory_0.Main.Pets.Equipped.Container.NameYourPet.Container2);
l_InventoryModule_0.ConnectCodeFrame(l_Inventory_0.Main.Weapons.Equipped.Container.Codes);
l_InventoryModule_0.ConnectEvoMenu();
l_InventoryModule_0.ConnectOutfitMenu()
l_WindowService_0:RegisterFrame(l_Game_0:WaitForChild("Inventory"), "Inventory");
l_Dock_0.Inventory.Activated:Connect(function()
    l_WindowService_0:ToggleFrame("Inventory");
end);
local l_SearchText_0 = l_Inventory_0.Main.Weapons.Items.Tabs.Search.Container.SearchText;
l_SearchText_0:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 65 ]]
    local l_Text_0 = l_SearchText_0.Text;
    l_Text_0 = string.gsub(l_Text_0, "S", "");
    local v15 = nil;
    for _, v17 in pairs(l_InventoryModule_0.MyInventory.Data.Weapons) do
		for _, v19 in v17 do
			if v19.Frame and v19.Frame.Parent then
				v19.Frame.Visible = string.find(string.lower(v19.Name), string.lower(l_Text_0)) ~= nil
				if not v15 then
					if v19.Frame.Parent.Parent:IsA("ScrollingFrame") then
						v15 = v19.Frame.Parent.Parent
					else
						v15 = v19.Frame.Parent.Parent.Parent.Parent
					end
				end
			end
		end
    end;
    if v15 then
        v15.CanvasPosition = Vector2.new(0, 0);
    end;
end);
local l_Processing_0 = l_Game_0.Processing;
_G.Process = function(v21) --[[ Line: 97 ]]
    if v21 then
        l_Processing_0.Title.Text = v21;
        spawn(function() --[[ Line: 100 ]]
            while l_Processing_0.Visible == true do
                l_Processing_0.Spinner.Rotation = l_Processing_0.Spinner.Rotation + 5;
                game:GetService("RunService").RenderStepped:wait();
            end;
        end);
        spawn(function() --[[ Line: 101 ]]
            while l_Processing_0.Visible == true do
                wait(0.2);
                l_Processing_0.Title.Text = l_Processing_0.Title.Text .. ".";
            end;
        end);
        l_Processing_0.Visible = true;
        return;
    else
        l_Processing_0.Visible = false;
        return;
    end;
end;
local CurrentRoundClient = require(l_Modules_0.CurrentRoundClient)
CurrentRoundClient.PlayerDataChanged.Event:Connect(function()
	local v22 = l_Inventory_0.Main.Outfits.Warning
	local v23 = CurrentRoundClient.PlayerData[game.Players.LocalPlayer.Name]
	if v23 then
		v23 = not CurrentRoundClient.PlayerData[game.Players.LocalPlayer.Name].Dead
	end
	v22.Visible = v23
end)
l_Remotes_0:WaitForChild("Inventory"):WaitForChild("ProfileDataChanged").Event:Connect(function(v22, _) --[[ Line: 116 ]]
    if v22 == "Uniques" then
        l_InventoryModule_0.UpdateInventory(l_Inventory_0, l_InventoryModule_0.MyInventory);
    end;
end);
l_Remotes_0:WaitForChild("Inventory"):WaitForChild("InventoryDataChanged").Event:Connect(function(Type, ItemID, Amount) --[[ Line: 121 ]]
	l_InventoryModule_0.UpdateInventory(l_Inventory_0, l_InventoryModule_0.MyInventory, Type, ItemID, Amount);
end);
l_Inventory_0.Main.Weapons.Equipped.Container.Crafting.ActionButton.Activated:Connect(function() --[[ Line: 126 ]]
    l_WindowService_0:AddToStack("Crafting");
end);
l_Inventory_0.Main.Radios.Equipped.Container.ViewSongs.ActionButton.Activated:Connect(function() --[[ Line: 131 ]]
    l_WindowService_0:AddToStack("Radio");
end);
local l_Attribute_0 = game.Players.LocalPlayer:GetAttribute("Radio");
l_Game_0.Inventory.Main.Radios.NoRadioCover.Visible = not l_Attribute_0;
game.ReplicatedStorage.Remotes.Shop.GetRadio.OnClientEvent:connect(function() --[[ Line: 139 ]]
    l_Game_0.Inventory.Main.Radios.NoRadioCover.Visible = false;
end);
l_Game_0.Inventory.Main.Radios.NoRadioCover.Buy.MouseButton1Click:connect(function() --[[ Line: 142 ]]
    game.ReplicatedStorage.Remotes.Shop.GetRadio:FireServer();
end);

--//Double Effect//--
local MarketplaceService = game:GetService("MarketplaceService")
local ButtonUI = l_Game_0.Inventory.Main.Effects.Equipped.Container.Item2.Locked.Buy

local l_Attribute_2 = game.Players.LocalPlayer:GetAttribute("DoubleEffect");
ButtonUI.Parent.Parent.Locked.Visible = not l_Attribute_2

game.ReplicatedStorage.Remotes.Shop.GetDoubleEffect.OnClientEvent:connect(function() --[[ Line: 139 ]]
	ButtonUI.Parent.Parent.Locked.Visible = false 
end);

local ButtonModule = require(game.ReplicatedStorage.ClientServices.Button)
ButtonModule.createButton(l_Game_0.Inventory.Main.Effects.Equipped.Container.Item2.Locked.Buy)

ButtonUI.Button.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.Remotes.Shop.GetDoubleEffect:FireServer();
end)
l_ItemPopupService_0.AnimationTargetLocation = l_Game_0:WaitForChild("Dock"):WaitForChild("Inventory");

--; -;
local function MyFavPositionIsSixtyNineOkay()
	local Position = game.Players.LocalPlayer:GetAttribute("KnifePosition")
	l_Game_0.Inventory.Main.Radios.Warning.Visible = (Position == "Back")
end
MyFavPositionIsSixtyNineOkay()

game.Players.LocalPlayer:GetAttributeChangedSignal("KnifePosition"):Connect(MyFavPositionIsSixtyNineOkay)