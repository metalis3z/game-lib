--[[
     Made by arxx fully plszzz zay fuck urself 
]]

local _datastoreservice = game:GetService("DataStoreService")
local _RemotesRedeem = game:GetService("ReplicatedStorage").Events.Codes.Redeeem
local _MyData = _datastoreservice:GetDataStore("AlreadyRedeemed")

local ValidCodes = {"release", "justdonate"}

_RemotesRedeem.OnServerEvent:Connect(function(player, code)
	local msg = string.lower(code)
	if table.find(ValidCodes, msg) then
		if msg == "release" then
			if not _MyData:GetAsync(player.UserId .. "-CODES, Redeem") then
				local s, e = pcall(function()
					player:FindFirstChild("Cashbux").Value += 100
					_MyData:SetAsync(player.UserId .. "-CODES, Redeem", "Claimed")
				end)

				if e then
					_RemotesRedeem.Parent.error:FireClient(player)
					warn(e)
				else
					_RemotesRedeem.Parent.success:FireClient(player)
				end
			else
				_RemotesRedeem.Parent.AlreadyClaimed:FireClient(player)
			end
		end
		
		if msg == "justdonate" then
			if not _MyData:GetAsync(player.UserId .. "-CODES, justdonate") then
				local s, e = pcall(function()
					player:FindFirstChild("Cashbux").Value += 50
					_MyData:SetAsync(player.UserId .. "-CODES, justdonate", "Claimed")
				end)

				if e then
					_RemotesRedeem.Parent.error:FireClient(player)
					warn(e)
				else
					_RemotesRedeem.Parent.success:FireClient(player)
				end
			else
				_RemotesRedeem.Parent.AlreadyClaimed:FireClient(player)
			end
		end
	else
		_RemotesRedeem.Parent.wrong:FireClient(player)
	end
end)