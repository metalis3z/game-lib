local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_Parent_0 = script.Parent.Parent;
local l_Modules_0 = game:GetService("ReplicatedStorage"):WaitForChild("Modules")
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local l_Lobby_0 = l_Parent_0:WaitForChild("Lobby");
local l_Screens_0 = l_Lobby_0:WaitForChild("Screens");
local l_Inventory_0 = l_Screens_0.Inventory;
local l_Modules_0 = game.ReplicatedStorage.Modules;
local v9 = require(l_Modules_0.InventoryModule);
v9.GUI.MyInventory = {};
v9.GUI.MyInventory.Main = l_Inventory_0.Main;
v9.GUI.MyInventory.Nav = l_Inventory_0.Nav;
v9.GUI.NewItem = l_Parent_0.NewItem;
v9.GUI.EvoMenu = l_Inventory_0.Main.Weapons.EvoMenu;
v9.GUI.OutfitMenu = l_Inventory_0.Main.Outfits.OutfitPopup
v9.GUI.ItemGridLayout = l_Modules_0.InventoryModule.Phone.PhoneGridLayout;
for _, v11 in pairs({
    "Weapons", 
    "Effects", 
    "Perks", 
    "Emotes", 
    "Radios", 
    "Pets",
	"Outfits"
}) do
    for v12, _ in pairs(v9.CreateBlankInventoryTable()[v11]) do
        (l_Inventory_0.Main:FindFirstChild(v11).Items.Container:FindFirstChild(v12) or l_Inventory_0.Main:FindFirstChild(v11).Items.Container:FindFirstChild("Holiday").Container:FindFirstChild(v12)).Container:ClearAllChildren();
    end;
end;
v9.MyInventory = v9.GenerateInventory(l_Inventory_0, l_ProfileData_0);
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
l_Container_0.Holiday.Container.EventLayout:GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
    l_Container_0.Holiday.Container.Size = UDim2.new(1, 0, 0, l_Container_0.Holiday.Container.EventLayout.AbsoluteContentSize.Y + 3);
    l_Container_0.Holiday.CanvasSize = UDim2.new(1, 0, 0, l_Container_0.Holiday.Container.EventLayout.AbsoluteContentSize.Y + 6);
end);
v9.ConnectNavButtons(l_Inventory_0.Nav, l_Inventory_0.Main);
v9.ConnectTabButtons(l_Inventory_0, "Weapons");
v9.UpdateMyEquip();
v9.ConnectEquipButtons();
v9.ConnectPetNaming(l_Inventory_0.Main.Pets.Equipped.Container.NameYourPet.Container2);
v9.ConnectCodeFrame(l_Inventory_0.Nav.Main.Codes);
v9.ConnectEvoMenu();
v9.ConnectOutfitMenu()

local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
l_WindowService_0:RegisterFrame(l_Inventory_0, "Inventory")

local l_SearchText_0 = l_Inventory_0.Main.Weapons.TitleBar.Container.Search.Container.SearchText;
l_SearchText_0:GetPropertyChangedSignal("Text"):Connect(function()
	local l_Text_0 = l_SearchText_0.Text;
	l_Text_0 = string.gsub(l_Text_0, "S", "");
	local v15 = nil;
	for _, v17 in pairs(v9.MyInventory.Data.Weapons) do
		for _, v19 in v17 do
			if v19.Frame and v19.Frame.Parent then
				v19.Frame.Visible = string.find(string.lower(v19.Name), string.lower(l_Text_0));
			if not v15 then
				if v19.Frame.Parent.Parent:IsA("ScrollingFrame") then
					v15 = v19.Frame.Parent.Parent;
				else
					v15 = v19.Frame.Parent.Parent.Parent.Parent;
				end;
			end;
			end
		end;
	end;
	if v15 then
		v15.CanvasPosition = Vector2.new(0, 0);
	end;
end);
local l_Processing_0 = l_Screens_0.Processing;
_G.Process = function(v22)
    if v22 then
        l_Processing_0.Title.Text = v22;
        spawn(function()
            while l_Processing_0.Visible == true do
                l_Processing_0.Spinner.Rotation = l_Processing_0.Spinner.Rotation + 5;
                game:GetService("RunService").RenderStepped:wait();
            end;
        end);
        spawn(function()
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
l_Remotes_0:WaitForChild("Inventory"):WaitForChild("ProfileDataChanged").Event:Connect(function(v23, _)
    if v23 == "Uniques" then
        v9.UpdateInventory(l_Inventory_0, v9.MyInventory);
    end;
end);
l_Remotes_0:WaitForChild("Inventory"):WaitForChild("InventoryDataChanged").Event:Connect(function()
    v9.UpdateInventory(l_Inventory_0, v9.MyInventory);
end);
local l_Attribute_0 = game.Players.LocalPlayer:GetAttribute("Radio");
l_Inventory_0.Main.Radios.NoRadioCover.Visible = not l_Attribute_0;
game.ReplicatedStorage.Remotes.Shop.GetRadio.OnClientEvent:connect(function()
    l_Inventory_0.Main.Radios.NoRadioCover.Visible = false;
end);
l_Inventory_0.Main.Radios.NoRadioCover.Buy.MouseButton1Click:connect(function()
    game.ReplicatedStorage.Remotes.Shop.GetRadio:FireServer();
end);
_G.CoinBagFull = false;

--//Double Effect//--
local MarketplaceService = game:GetService("MarketplaceService")
local ButtonUI = l_Inventory_0.Main.Effects.Equipped.Container.Item2.Locked.Buy

local l_Attribute_2 = game.Players.LocalPlayer:GetAttribute("DoubleEffect");
ButtonUI.Parent.Parent.Locked.Visible = not l_Attribute_2

game.ReplicatedStorage.Remotes.Shop.GetDoubleEffect.OnClientEvent:connect(function() --[[ Line: 139 ]]
	ButtonUI.Parent.Parent.Locked.Visible = false 
end);

local ButtonModule = require(game.ReplicatedStorage.ClientServices.Button)
ButtonModule.createButton(l_Inventory_0.Main.Effects.Equipped.Container.Item2.Locked.Buy)

ButtonUI.Button.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.Remotes.Shop.GetDoubleEffect:FireServer();
end)

--; -;
local function MyFavPositionIsSixtyNineOkay()
	local Position = game.Players.LocalPlayer:GetAttribute("KnifePosition")
	l_Inventory_0.Main.Radios.Warning.Visible = (Position == "Back")
end
MyFavPositionIsSixtyNineOkay()

game.Players.LocalPlayer:GetAttributeChangedSignal("KnifePosition"):Connect(MyFavPositionIsSixtyNineOkay)