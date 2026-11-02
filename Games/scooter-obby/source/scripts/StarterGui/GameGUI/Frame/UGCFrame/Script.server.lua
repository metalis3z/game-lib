local rs = game:GetService("ReplicatedStorage")
local ms = game:GetService("MarketplaceService")
wait(1)
local function update()
	local ugcs = rs.RemoteFunctions.fetchUGC:InvokeServer()
	for i,v in pairs(script.Parent.Main.Inside.Content.Holder.ScrollingFrame:GetChildren()) do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end
	for i,v in pairs(ugcs) do
		local info = ms:GetProductInfo(v, Enum.InfoType.Asset)
		local ui = script.Parent.Main.Inside.Content.Holder.UGCBase:Clone()
		ui.Parent = script.Parent.Main.Inside.Content.Holder.ScrollingFrame
		ui.Label.Text = info.Name
		if info.Remaining >= 1 then
			ui.Remaining.Text = info.Remaining .. " remaining :O"
		else
			ui.Remaining.Text = info.Remaining .. " remaining :("
		end
		ui.Switch.Inside.Button.MouseButton1Up:Connect(function(v)
			rs.RemoteEvents.buyUGC:FireServer(info.AssetId)
		end)
		wait(0.05)
	end
end

while true do
	pcall(update)
	wait(10)
end