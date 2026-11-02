local parent = script.Parent
local mouse = game.Players.LocalPlayer:GetMouse()
local christmasEvents = game.ReplicatedStorage.Summer2023Events
local chatGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("MainGUI"):FindFirstChild("Chat")
if chatGui then
	local GiftTip = chatGui:FindFirstChild("Gift")
	if GiftTip then
		GiftTip.Visible = true
	end
end
local gifterGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("Gifter")
local giftsLeft = _G.PlayerData.SummerGiftInventory
local selectedPlayer = nil
function update()
	gifterGui.Container.GiftCount.Text = "You have " .. giftsLeft .. " gifts"
end
gifterGui.Container.Instructions.Visible = selectedPlayer == nil
gifterGui.Container.Confirm.Player.Text = "Send Gift to " .. tostring(selectedPlayer)
gifterGui.Container.Confirm.Visible = selectedPlayer ~= nil
parent.Equipped:connect(function()
	gifterGui.Enabled = true
	update()
	gifterGui.Container.Instructions.Visible = selectedPlayer == nil
	gifterGui.Container.Confirm.Player.Text = "Send Gift to " .. tostring(selectedPlayer)
	gifterGui.Container.Confirm.Visible = selectedPlayer ~= nil
end)
parent.Unequipped:Connect(function()
	gifterGui.Enabled = false
	selectedPlayer = nil
end)
parent.Deactivated:Connect(function()
	selectedPlayer = nil
	local target = mouse.Target
	local player = nil
	if target ~= nil then
		player = game.Players:GetPlayerFromCharacter(target.Parent) or game.Players:GetPlayerFromCharacter(target.Parent.Parent)
	end
	selectedPlayer = player
	gifterGui.Container.Instructions.Visible = selectedPlayer == nil
	gifterGui.Container.Confirm.Player.Text = "Send Gift to " .. tostring(selectedPlayer)
	gifterGui.Container.Confirm.Visible = selectedPlayer ~= nil
end)
local lastActivatedTime = 0
gifterGui.Container.Confirm.Activated:Connect(function()
	if selectedPlayer and time() - lastActivatedTime >= 1 then
		lastActivatedTime = time()
		christmasEvents.GiveGiftToPlayer:FireServer(selectedPlayer)
		parent.Parent = game.Players.LocalPlayer.Backpack
		gifterGui.Container.Instructions.Visible = selectedPlayer == nil
		gifterGui.Container.Confirm.Player.Text = "Send Gift to " .. tostring(selectedPlayer)
		gifterGui.Container.Confirm.Visible = selectedPlayer ~= nil
	end
	gifterGui.Container.Instructions.Visible = selectedPlayer == nil
	gifterGui.Container.Confirm.Player.Text = "Send Gift to " .. tostring(selectedPlayer)
	gifterGui.Container.Confirm.Visible = selectedPlayer ~= nil
end)
christmasEvents.UpdateGiftTool.OnClientEvent:connect(function(giftsLeftUpdate)
	giftsLeft = giftsLeftUpdate
	gifterGui.Container.Instructions.Visible = selectedPlayer == nil
	gifterGui.Container.Confirm.Player.Text = "Send Gift to " .. tostring(selectedPlayer)
	gifterGui.Container.Confirm.Visible = selectedPlayer ~= nil
end)
spawn(function()
	while true do
		gifterGui.Container.GiftCount.Text = "You have ".._G.PlayerData.SummerGiftInventory.." gifts"
		wait()
	end
end)