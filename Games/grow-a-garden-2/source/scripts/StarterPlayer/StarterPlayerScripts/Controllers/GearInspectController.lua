--credit to quartz games studio
local t = {}
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local v1 = script:WaitForChild("Player"):Clone()
local LocalPlayer = Players.LocalPlayer

if LocalPlayer and LocalPlayer.UserId then
	task.spawn(function() --[[ Line: 21 | Upvalues: Players (copy), LocalPlayer (copy), v1 (copy) ]]
		local ok, result = pcall(Players.GetHumanoidDescriptionFromUserIdAsync, Players, LocalPlayer.UserId)

		if not (ok and result) then
			return
		end

		v1.Parent = script
		v1.Humanoid:ApplyDescriptionResetAsync(result)
	end)
end

local Trove = require(game.ReplicatedStorage.ClientModules.Trove)
local GuiController = require(script.Parent:WaitForChild("GuiController"))
local SceneApi = require(script:WaitForChild("SceneApi"))
local DevProductController = require(script.Parent:WaitForChild("DevProductController"))
local Networking = require(game.ReplicatedStorage.SharedModules:WaitForChild("Networking"))
local RobuxShopContent = require(game.ReplicatedStorage.SharedModules:WaitForChild("RobuxShopContent"))
local DevProducts = require(game.ReplicatedStorage.SharedModules:WaitForChild("DevProducts"))
local NumberUtils = require(game.ReplicatedStorage.SharedModules:WaitForChild("NumberUtils"))
local GearCinematicBars = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("GearCinematicBars")
local BottomBar = GearCinematicBars:WaitForChild("BottomBar")
local TopBar = GearCinematicBars:WaitForChild("TopBar")
local Prizes = GearCinematicBars:WaitForChild("PrizesUI"):WaitForChild("Prizes")
local BuyButton = BottomBar:WaitForChild("BuyButton")
local GiftButton = BottomBar:WaitForChild("GiftButton")
local PlayerSelector = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PlayerSelector")
local GearShopData = require(game.ReplicatedStorage.SharedModules:WaitForChild("GearShopData"))
local Items = game.ReplicatedStorage:WaitForChild("StockValues"):WaitForChild("GearShop"):WaitForChild("Items")
local t2 = {}

for v2, v3 in GearShopData.Data do
	t2[v3.ItemName] = v3
end

local t3 = {}

for v4, v5 in RobuxShopContent.Gears do
	if v5.GamepassKey then
		t3[v5.Name] = v5.GamepassKey
	end
end

local t4 = {}
local v6 = false
local v7 = false
local v8 = Instance.new("BindableEvent")
local t5 = {}
local v9 = nil
local v10 = nil

local function EnsureOwnershipReady() --[[ EnsureOwnershipReady | Line: 80 | Upvalues: v6 (ref), v7 (ref), v8 (copy), Networking (copy), t4 (copy) ]]
	if v6 then
		return
	end

	if v7 then
		v8.Event:Wait()

		return
	end

	v7 = true

	local ok, result = pcall(function() --[[ Line: 88 | Upvalues: Networking (ref) ]]
		return Networking.GearShop.RequestEquippableState:Fire()
	end)

	if ok and typeof(result) == "table" and typeof(result.OwnedEquippableGears) == "table" then
		for v1 in result.OwnedEquippableGears do
			t4[v1] = true
		end
	end

	v6 = true
	v7 = false
	v8:Fire()
end

task.spawn(EnsureOwnershipReady)
Networking.GearShop.GearEquipState.OnClientEvent:Connect(function(p1, p2) --[[ Line: 103 | Upvalues: t4 (copy), v9 (ref), v10 (ref) ]]
	if type(p1) ~= "string" then
		return
	end

	if p2 then
		t4[p1] = true
	end

	if p1 ~= v9 or not v10 then
		return
	end

	v10()
end)
LocalPlayer:GetAttributeChangedSignal("OwnedGamepasses"):Connect(function() --[[ Line: 113 | Upvalues: v10 (ref) ]]
	if not v10 then
		return
	end

	v10()
end)

local function IsOneTimePurchase(p1) --[[ IsOneTimePurchase | Line: 119 | Upvalues: t3 (copy), t2 (copy) ]]
	if t3[p1] then
		return true
	end

	local v1 = t2[p1]

	return if v1 == nil then false else v1.EquippableGear == true
end

local function OwnsGear(p1) --[[ OwnsGear | Line: 125 | Upvalues: t4 (copy), t3 (copy), LocalPlayer (copy) ]]
	if t4[p1] then
		return true
	end

	if not t3[p1] then
		return false
	end

	local v1 = LocalPlayer:GetAttribute("OwnedGamepasses")

	if type(v1) ~= "string" or v1 == "" then
		return false
	end

	for v2 in v1:gmatch("[^,]+") do
		if v2 == p1 then
			return true
		end
	end

	return false
end

local function GetRobuxPriceForGear(p1) --[[ GetRobuxPriceForGear | Line: 136 | Upvalues: t3 (copy), DevProducts (copy), DevProductController (copy), t5 (copy), MarketplaceService (copy) ]]
	local v1 = t3[p1]

	if v1 then
		local v2 = DevProducts.GetGamepassByKey(v1)

		if not v2 then
			DevProductController:WaitForGamepassesReady()
			v2 = DevProducts.GetGamepassByKey(v1)
		end

		if not v2 then
			return nil
		end

		local GamepassId = v2.GamepassId

		if type(GamepassId) ~= "number" then
			return nil
		end

		if t5[GamepassId] then
			return t5[GamepassId]
		end

		local ok, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, GamepassId, Enum.InfoType.GamePass)

		if not (ok and result) then
			return nil
		end

		if type(result.PriceInRobux) == "number" then
			t5[GamepassId] = result.PriceInRobux

			return result.PriceInRobux
		end

		return nil
	end

	local v4 = DevProductController:WaitForPreloadedProductInfo(("Gear:%*:1"):format(p1), 5)

	if not v4 then
		return nil
	end

	if type(v4.PriceInRobux) == "number" then
		return v4.PriceInRobux
	end

	return nil
end

local v11 = Trove.new()
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = nil

local function GetSceneCache() --[[ GetSceneCache | Line: 187 | Upvalues: v16 (ref) ]]
	if v16 then
		return v16
	end

	v16 = {}

	for v1, v2 in script:WaitForChild("GearScenes"):GetChildren() do
		local v3 = string.lower(v2.Name)

		if v2:IsA("Folder") or v2:IsA("Model") then
			local v4 = v2:FindFirstChild("Scene") or v2:FindFirstChildWhichIsA("ModuleScript")
			local FakePlot = v2:FindFirstChild("FakePlot")

			if v4 and v4:IsA("ModuleScript") then
				v16[v3] = {
					Module = v4,
					FakePlot = FakePlot
				}
			end

			continue
		end

		if v2:IsA("ModuleScript") then
			v16[v3] = {
				FakePlot = nil,
				Module = v2
			}
		end
	end

	return v16
end

local function ResolveScene(p1) --[[ ResolveScene | Line: 220 | Upvalues: GetSceneCache (copy) ]]
	local v1 = GetSceneCache()
	local default = v1.default
	local v2 = v1[string.lower(p1)] or default

	if not v2 then
		return nil, nil
	end

	local v3 = v2.FakePlot or (if default then default.FakePlot or nil else nil)

	return require(v2.Module), v3
end

local function GetInspectableGearNames() --[[ GetInspectableGearNames | Line: 231 | Upvalues: GetSceneCache (copy), t2 (copy) ]]
	local t = {}

	for v1, v2 in GetSceneCache() do
		if v1 ~= "default" then
			for v3, v4 in t2 do
				if string.lower(v3) == v1 then
					table.insert(t, v3)

					break
				end
			end
		end
	end

	return t
end

local function GetProductKeyForGear(p1) --[[ GetProductKeyForGear | Line: 249 | Upvalues: t3 (copy) ]]
	local v1 = t3[p1]

	if v1 then
		return v1, true
	end

	return ("Gear:%*:1"):format(p1), false
end

local function HandleGiftButton(p1, p2) --[[ HandleGiftButton | Line: 258 | Upvalues: PlayerSelector (copy), Players (copy), Networking (copy), DevProductController (copy) ]]
	local v1 = nil

	task.spawn(function() --[[ Line: 260 | Upvalues: PlayerSelector (ref), v1 (ref) ]]
		local v12 = PlayerSelector.PlayerSelected.Event:Wait()

		v1 = if v12 == nil then "cancelled" else v12
	end)
	PlayerSelector.Enabled = true

	repeat
		task.wait()
	until v1 ~= nil

	if v1 == "cancelled" then
		return
	end

	if p2 then
		local Player = v1.Player

		if not (Player and Player:IsDescendantOf(Players)) then
			game.ReplicatedStorage:FindFirstChild("Notify"):Fire("That player went offline.")

			return
		end
	end

	local ok, result = pcall(function() --[[ Line: 283 | Upvalues: Networking (ref), v1 (ref) ]]
		Networking.DevProducts.SetGiftTarget:Fire(v1.UserId)
	end)

	if not ok then
		warn((("[GearInspectController] SetGiftTarget fire failed (%*): %*"):format(p1, result)))
	end

	local ok2, result2 = pcall(function() --[[ Line: 289 | Upvalues: DevProductController (ref), p1 (copy) ]]
		DevProductController:PromptPurchase((("%*:Gift"):format(p1)))
	end)

	if ok2 then
		return
	end

	warn((("[GearInspectController] Gift purchase prompt failed (%*): %*"):format(p1, result2)))
end

local function WirePurchaseButtons(p1) --[[ WirePurchaseButtons | Line: 298 | Upvalues: EnsureOwnershipReady (copy), t3 (copy), BuyButton (copy), t2 (copy), OwnsGear (copy), GetRobuxPriceForGear (copy), NumberUtils (copy), v9 (ref), v10 (ref), v11 (copy), DevProductController (copy), GiftButton (copy), HandleGiftButton (copy) ]]
	EnsureOwnershipReady()

	local v1 = t3[p1]
	local v2, v3

	if v1 then
		v2 = true
		v3 = v1
	else
		v3 = ("Gear:%*:1"):format(p1)
		v2 = false
	end

	local Price = BuyButton:FindFirstChild("Price")
	local v4 = Price and Price:FindFirstChild("TextLabel")

	local function SetLabel(p1) --[[ SetLabel | Line: 306 | Upvalues: Price (copy), v4 (copy) ]]
		if Price and Price.Parent then
			Price.Text = p1
		end

		if not (v4 and v4.Parent) then
			return
		end

		v4.Text = p1
	end

	local function ApplyState() --[[ ApplyState | Line: 315 | Upvalues: p1 (copy), t3 (ref), t2 (ref), OwnsGear (ref), Price (copy), v4 (copy), GetRobuxPriceForGear (ref), NumberUtils (ref) ]]
		local v1 = p1
		local v2

		if t3[v1] then
			v2 = true
		else
			local v3 = t2[v1]

			v2 = if v3 == nil then false else v3.EquippableGear == true
		end

		if v2 and OwnsGear(p1) then
			if Price and Price.Parent then
				Price.Text = "OWNED"
			end

			if not (v4 and v4.Parent) then
				return
			end

			v4.Text = "OWNED"
		else
			local v42 = GetRobuxPriceForGear(p1)

			if v42 then
				local v5 = ("\238\128\130%*"):format((NumberUtils.FormatWithCommas(v42)))

				if Price and Price.Parent then
					Price.Text = v5
				end

				local v6 = v5

				if v4 and v4.Parent then
					v4.Text = v6
				end
			else
				if Price and Price.Parent then
					Price.Text = "..."
				end

				if not (v4 and v4.Parent) then
					return
				end

				v4.Text = "..."
			end
		end
	end

	BuyButton.Visible = true
	ApplyState()
	v9 = p1
	v10 = ApplyState
	v11:Add(function() --[[ Line: 333 | Upvalues: v9 (ref), p1 (copy), v10 (ref) ]]
		if v9 ~= p1 then
			return
		end

		v9 = nil
		v10 = nil
	end)
	v11:Add(BuyButton.Activated:Connect(function() --[[ Line: 340 | Upvalues: p1 (copy), t3 (ref), t2 (ref), OwnsGear (ref), ApplyState (copy), v2 (copy), DevProductController (ref), v3 (copy) ]]
		local v1 = p1
		local v22

		if t3[v1] then
			v22 = true
		else
			local v32 = t2[v1]

			v22 = if v32 == nil then false else v32.EquippableGear == true
		end

		if v22 and OwnsGear(p1) then
			ApplyState()

			return
		end

		if v2 then
			DevProductController:PromptGamepassPurchase(v3)
		else
			DevProductController:PromptPurchase(v3)
		end
	end))
	v11:Add(GiftButton.Activated:Connect(function() --[[ Line: 352 | Upvalues: HandleGiftButton (ref), v3 (copy), v2 (copy) ]]
		HandleGiftButton(v3, v2)
	end))
end

local function IsGearInStock(p1) --[[ IsGearInStock | Line: 358 | Upvalues: Items (copy) ]]
	local v1 = Items:FindFirstChild(p1)

	return v1 and v1.Value > 0 and true or false
end

local function PopulateGearSidePanel(p1) --[[ PopulateGearSidePanel | Line: 364 | Upvalues: GetInspectableGearNames (copy), Items (copy), Prizes (copy), t2 (copy), v11 (copy), v12 (ref), t (copy) ]]
	local t3 = {}

	for v2, v3 in GetInspectableGearNames() do
		local v1

		if v3 ~= p1 then
			local v4 = Items:FindFirstChild(v3)

			v1 = v4 and v4.Value > 0 and true or false

			if v1 then
				table.insert(t3, v3)
			end
		end
	end

	local count = 1

	while Prizes:FindFirstChild((("Item%*"):format(count))) do
		local v5 = Prizes:FindFirstChild((("Item%*"):format(count)))
		local v6 = t3[count]

		if v6 then
			local v7 = t2[v6]

			v5.Visible = true

			if v5:FindFirstChild("ItemImage") and (v7 and v7.IMG) then
				v5.ItemImage.Image = v7.IMG
			end

			if v5:FindFirstChild("ItemName") then
				v5.ItemName.Text = v6
			end

			if v5:FindFirstChild("Odds") then
				v5.Odds.Visible = false
			end

			if v5:FindFirstChild("Inspect") then
				v11:Add(v5.Inspect.Activated:Connect(function() --[[ Line: 393 | Upvalues: v12 (ref), t (ref), v6 (copy) ]]
					t.Inspect({
						GearName = v6
					}, v12)
				end))
			end
		else
			v5.Visible = false
		end

		count = count + 1
	end
end

local function HideBars() --[[ HideBars | Line: 407 | Upvalues: TweenService (copy), BottomBar (copy), TopBar (copy), Prizes (copy) ]]
	TweenService:Create(BottomBar, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		AnchorPoint = Vector2.new(0, 0)
	}):Play()
	TweenService:Create(TopBar, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		AnchorPoint = Vector2.new(0, 1)
	}):Play()
	TweenService:Create(Prizes, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		AnchorPoint = Vector2.new(1, 0.5)
	}):Play()
end

local function ShowBars() --[[ ShowBars | Line: 414 | Upvalues: TweenService (copy), BottomBar (copy), TopBar (copy), Prizes (copy) ]]
	TweenService:Create(BottomBar, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		AnchorPoint = Vector2.new(0, 1)
	}):Play()
	TweenService:Create(TopBar, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		AnchorPoint = Vector2.new(0, 0)
	}):Play()
	TweenService:Create(Prizes, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		AnchorPoint = Vector2.new(0, 0.5)
	}):Play()
end

function t.Stop(p1) --[[ Stop | Line: 421 | Upvalues: v14 (ref), v11 (copy), HideBars (copy), v15 (ref), v12 (ref), v13 (ref) ]]
	if v14 then
		pcall(v14, true)
		v14 = nil
	end

	if v11 then
		v11:Clean()
	end

	if not p1 then
		return
	end

	HideBars()

	if v15 then
		local CurrentCamera = game.Workspace.CurrentCamera

		CurrentCamera.CameraType = v15.CameraType
		CurrentCamera.CameraSubject = v15.CameraSubject
		CurrentCamera.FieldOfView = v15.FieldOfView
		CurrentCamera.CFrame = v15.CFrame
		v15 = nil
	end

	v12 = nil
	v13 = nil
end
function t.Start(p1) --[[ Start | Line: 454 ]] end
function t.Init(p1) --[[ Init | Line: 458 ]] end
function t.Inspect(p1, p2, p3) --[[ Inspect | Line: 463 | Upvalues: v13 (ref), v15 (ref), t (copy), GetSceneCache (copy), v11 (copy), v1 (copy), GuiController (copy), v12 (ref), LocalPlayer (copy), StarterGui (copy), PopulateGearSidePanel (copy), WirePurchaseButtons (copy), ShowBars (copy), TopBar (copy), SceneApi (copy), v14 (ref) ]]
	local v16 = p1.GearName or p1.Name

	v13 = v16

	if not v15 then
		local CurrentCamera = game.Workspace.CurrentCamera

		v15 = {
			CameraType = CurrentCamera.CameraType,
			CameraSubject = CurrentCamera.CameraSubject,
			FieldOfView = CurrentCamera.FieldOfView,
			CFrame = CurrentCamera.CFrame
		}
	end

	t.Stop(false)

	local v2 = if p3 then p3 else {}
	local v3 = GetSceneCache()
	local default = v3.default
	local v4 = v3[string.lower(v16)] or default
	local v5, v6, v7

	if v4 then
		local FakePlot = v4.FakePlot

		if FakePlot then
			v5 = v2
		elseif default then
			FakePlot = default.FakePlot

			if FakePlot then
				v5 = v2
			else
				FakePlot = nil
				v5 = v2
			end
		else
			FakePlot = nil
			v5 = v2
		end

		local Module = require(v4.Module)

		v6 = Module
		v7 = FakePlot
	else
		v6 = nil
		v7 = nil
		v5 = v2
	end

	if not v6 then
		return
	end

	if not v7 then
		return
	end

	local v8 = v7:Clone()

	v8.Parent = game.Workspace
	v11:Add(v8)

	local v9 = v1:Clone()

	v9.Parent = v8

	local Humanoid = v9:WaitForChild("Humanoid")

	if v9.PrimaryPart then
		v9.PrimaryPart.Anchored = false

		local PlayerSpawn = v8:FindFirstChild("PlayerSpawn", true)

		if PlayerSpawn and PlayerSpawn:IsA("BasePart") then
			v9:PivotTo(PlayerSpawn.CFrame + Vector3.new(0, 3, 0))
		elseif v8.PrimaryPart then
			v9:PivotTo(v8.PrimaryPart.CFrame + Vector3.new(0, v8.PrimaryPart.Size.Y / 2 + 3, 0))
		end
	end

	GuiController:Close()

	if p2 then
		v12 = p2
	end

	local t2 = {}

	for v122, v132 in LocalPlayer.PlayerGui:GetChildren() do
		if v132:IsA("ScreenGui") and v132.Name ~= "GearCinematicBars" then
			t2[v132] = v132.Enabled
			v132.Enabled = false
		end
	end

	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
	v11:Add(function() --[[ Line: 539 | Upvalues: StarterGui (ref), t2 (copy) ]]
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

		for v1, v2 in t2 do
			if v1 then
				v1.Enabled = v2
			end
		end
	end)
	PopulateGearSidePanel(v16)
	WirePurchaseButtons(v16)
	ShowBars()
	TopBar.NameLabel.Text = ("%* GEAR"):format((string.upper(v16)))
	TopBar.NameLabel.TextLabel.Text = ("%* GEAR"):format((string.upper(v16)))
	v11:Add(TopBar.ExitButton.Activated:Connect(function() --[[ Line: 560 | Upvalues: v12 (ref), t (ref) ]]
		local v1 = v12

		t.Stop(true)

		if not v1 then
			return
		end

		v1()
	end))
	math.randomseed(os.clock() * 1000)
	v14 = v6.Run((SceneApi.new({
		Plot = v8,
		PlayerModel = v9,
		PlayerHumanoid = Humanoid,
		Camera = game.Workspace.CurrentCamera,
		Trove = v11,
		GearData = p1,
		Options = v5
	})))
end

return t