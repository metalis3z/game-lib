-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Assets = game:GetService("ReplicatedStorage"):WaitForChild("Assets")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Save = require(ReplicatedStorage.Library.Client.Save)
local Message = require(ReplicatedStorage.Library.Client.Message)
local Functions = require(ReplicatedStorage.Library.Functions)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local TradingCmds = require(ReplicatedStorage.Library.Client.TradingCmds)
local Tooltip = require(ReplicatedStorage.Library.Client.GUIFX.Tooltip)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local LocalPlayer = Players.LocalPlayer
local Button = GUI.SideButtonTools().Trading.Button
local v2 = GUI.TradePlayerList()
local Frame = v2:WaitForChild("Frame")
local Players2 = Frame.Players
local Input = Frame.BottomBar.Search.Main.Input
local Friends = Frame.BottomBar.Container.Main.Friends
local v3 = Functions.Lock()
local GreenGradient = Assets.UI.Gradients.GreenGradient
local GreyGradient = Assets.UI.Gradients.GreyGradient
local t = {}

t.__index = t
t.__class = "TradingPlayerList"
function t._build() --[[ _build | Line: 49 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2._friendsToggle = false
	v2._cancelButtonCallbacks = {}
	v2:_init()

	return v2
end
function t._updateGradient(p1, p2, p3, p4) --[[ _updateGradient | Line: 63 | Upvalues: Functions (copy) ]]
	p2.ImageColor3 = if p4 then p4 else Color3.new(255/255, 255/255, 255/255)

	if p2:FindFirstChild(p3.Name) then
		return
	end

	Functions.GradientSwap(p2, p3)
end
function t._cancelButtonFx(p1, p2) --[[ _cancelButtonFx | Line: 70 ]]
	if p1._cancelButtonCallbacks[p2.UserId] then
		p1._cancelButtonCallbacks[p2.UserId]()
	end

	p1._cancelButtonCallbacks[p2.UserId] = nil
end
function t._listScrolling(p1) --[[ _listScrolling | Line: 77 | Upvalues: Players2 (copy) ]]
	local UIListLayout = Players2:FindFirstChildOfClass("UIListLayout")
	local UIPadding = Players2:FindFirstChildOfClass("UIPadding")

	Players2.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset)
end
function t._update(p1) --[[ _update | Line: 88 | Upvalues: Functions (copy), Input (copy), Players (copy), LocalPlayer (copy), Save (copy), TradingCmds (copy), Players2 (copy), Assets (copy), v3 (copy), v1 (copy), Message (copy), GreyGradient (copy), ButtonFX (copy), GreenGradient (copy), Frame (copy) ]]
	local RegexEscape = Functions.RegexEscape
	local v12 = RegexEscape(string.lower((tostring(Input.Text))))
	local v2 = if v12 == nil then false elseif v12 == "" then false else true
	local list = {}

	for k, v in pairs(Players:GetPlayers()) do
		local ok, result = pcall(function() --[[ Line: 96 | Upvalues: LocalPlayer (ref), v (copy) ]]
			return LocalPlayer:IsFriendsWith(v.UserId)
		end)

		table.insert(list, {
			Player = v,
			IsFriend = ok and result
		})
	end

	table.sort(list, function(p1, p2) --[[ Line: 102 ]]
		if p1.IsFriend and not p2.IsFriend then
			return true
		end

		if not p1.IsFriend and p2.IsFriend then
			return false
		end

		return p1.Player.DisplayName < p2.Player.DisplayName
	end)

	for i, v in ipairs(list) do
		local Player = v.Player
		local v32 = Save.Get(Player, true)

		if v32 then
			assert(v32, "luau")

			if Player ~= LocalPlayer then
				local IsFriend = v.IsFriend
				local v4 = false
				local v5 = if v32.Settings.Trading == false then false else true
				local v6 = TradingCmds.HasRequestFromPlayer(Player)
				local v7 = TradingCmds.HasOutgoingRequestToPlayer(Player)
				local v8 = Players2:FindFirstChild(Player.Name)

				if not v8 then
					local v9 = Player:GetAttribute("Partner") and Player.DisplayName .. " (\240\159\148\165 Partner)" or Player.DisplayName
					local v10 = Assets.UI.Trading.PlayerList.Player:Clone()

					v10.NameHolder.Username.Text = Player.Name
					v10.NameHolder.Display.Text = v9
					v10.Name = Player.Name
					v10:SetAttribute("Trader", true)
					task.spawn(function() --[[ Line: 138 | Upvalues: v10 (copy), Functions (ref), Player (copy) ]]
						v10.Icon.Image = ""
						v10.Icon.Image = Functions.GetThumbnailFromUserIdAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48) or ""
					end)
					v10.ButtonHolder.Trade.Activated:Connect(function() --[[ Line: 147 | Upvalues: v3 (ref), v5 (ref), v32 (copy), v4 (ref), v6 (ref), TradingCmds (ref), Player (copy), LocalPlayer (ref), v1 (ref), Message (ref) ]]
						v3(function() --[[ Line: 148 | Upvalues: v5 (ref), v32 (ref), v4 (ref), v6 (ref), TradingCmds (ref), Player (ref), LocalPlayer (ref), v1 (ref), Message (ref) ]]
							v5 = v32.Settings.Trading ~= false
							v4 = false
							v6 = TradingCmds.HasRequestFromPlayer(Player)

							if not v5 then
								return
							end

							local ok, result = pcall(function() --[[ Line: 154 | Upvalues: LocalPlayer (ref), Player (ref) ]]
								return LocalPlayer:IsFriendsWith(Player.UserId)
							end)

							if v4 and (ok and not result) then
								return
							end

							local v12, v2 = TradingCmds.Request(Player)

							v1:AtTrace():Log((("Trade request sent to %*, success: %*, message: %*"):format(Player.Name, v12, v2)))

							if v12 and not v6 then
								Message.New("\240\159\147\169 Trade request sent!", {
									sound = "rbxassetid://93248914376991"
								})

								return
							end

							if v12 then
								return
							end

							Message.New(v2 or "Failed to send trade request!")
						end)
					end)
					v10.Parent = Players2
					v8 = v10
				end

				if v5 then
					if v4 and not IsFriend then
						p1:_cancelButtonFX(Player)
						p1:_updateGradient(v8.ButtonHolder.Trade, GreyGradient)
						v8.ButtonHolder.Trade.TextLabel.Text = "Friends Only"
						v8.LayoutOrder = 998
					else
						if not p1._cancelButtonCallbacks[Player.UserId] then
							p1._cancelButtonCallbacks[Player.UserId] = ButtonFX(v8.ButtonHolder.Trade)
						end

						if v6 then
							p1:_updateGradient(v8.ButtonHolder.Trade, GreenGradient)
							v8.ButtonHolder.Trade.TextLabel.Text = "Accept!"
							v8.LayoutOrder = 1
						elseif v7 then
							p1:_updateGradient(v8.ButtonHolder.Trade, GreenGradient, Color3.new(0.5, 0.5, 0.5))
							v8.ButtonHolder.Trade.TextLabel.Text = "Pending"
							v8.LayoutOrder = 2
						else
							p1:_updateGradient(v8.ButtonHolder.Trade, GreenGradient)
							v8.ButtonHolder.Trade.TextLabel.Text = "Trade!"
							v8.LayoutOrder = i + 10
						end
					end
				else
					p1:_cancelButtonFX(Player)
					p1:_updateGradient(v8.ButtonHolder.Trade, GreyGradient)
					v8.ButtonHolder.Trade.TextLabel.Text = "Disabled"
					v8.LayoutOrder = 999
				end

				v8.Icon.Friend.Visible = IsFriend

				if v2 then
					v8.Visible = if string.find(string.lower(Player.Name), v12) == nil then if string.find(string.lower(Player.DisplayName), v12) == nil then false else true else true
				else
					v8.Visible = true
				end

				if p1._friendsToggle and not IsFriend then
					v8.Visible = false
				end
			end
		end
	end

	Frame.NoneAvailable.Visible = #Players:GetPlayers() <= 1

	for k, v in pairs(Players2:GetChildren()) do
		if v:GetAttribute("Trader") and not Players:FindFirstChild(v.Name) then
			v:Destroy()
		end
	end

	p1:_listScrolling()
end
function t._init(p1) --[[ _init | Line: 243 | Upvalues: Players2 (copy), ButtonFX (copy), Friends (copy), Tooltip (copy), Button (copy), TradingCmds (copy), Message (copy), TabController (copy), Players (copy), v2 (copy), RunService (copy) ]]
	for k, v in pairs(Players2:GetChildren()) do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end

	ButtonFX(Friends)
	Tooltip(Friends, "View Friends")
	ButtonFX(Button, nil, function() --[[ Line: 253 | Upvalues: TradingCmds (ref), Message (ref), TabController (ref) ]]
		local v1, v2 = TradingCmds.HasTradingUnlocked()

		if v1 then
			TabController.ToggleTab("TradePlayerList")
		else
			Message.New(v2 or "Trading is locked.")
		end
	end)
	Friends.Activated:Connect(function() --[[ Line: 263 | Upvalues: p1 (copy) ]]
		p1._friendsToggle = not p1._friendsToggle
	end)
	TabController.AddOpenListener(function(p12, p2) --[[ Line: 267 | Upvalues: p1 (copy) ]]
		if p12 ~= "TradePlayerList" then
			return
		end

		p1:_update()
	end)
	Players.PlayerRemoving:Connect(function(p12) --[[ Line: 273 | Upvalues: p1 (copy) ]]
		p1._cancelButtonCallbacks[p12.UserId] = nil
	end)
	task.spawn(function() --[[ Line: 277 | Upvalues: v2 (ref), p1 (copy), RunService (ref) ]]
		while true do
			if v2.Enabled then
				p1:_update()
			end

			RunService.Heartbeat:Wait()
		end
	end)
end

return t._build()