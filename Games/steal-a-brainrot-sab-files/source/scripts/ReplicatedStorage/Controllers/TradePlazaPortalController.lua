--recodded by fayple studios
--removed functions that are hiding the model
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Observers = require(ReplicatedStorage.Packages.Observers)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local ConfirmationController = require(ReplicatedStorage.Controllers.ConfirmationController)
local Updates = require(ReplicatedStorage.Shared.Updates)
local v1 = Net:RemoteEvent("TradePlazaPortalService/Teleport")
local LocalPlayer = Players.LocalPlayer
local t = {}
local t2 = {}
local v3 = CFrame.new(0, -100000, 0)
local function canUsePortal()
	return not ServerData.IsTradePlaza() and not ServerData.IsDuelsServer() and not ServerData.IsTsunamiServer()
end

local function refreshAll()
	for v1 in t2 do
		v1()
	end
end

function t.Start(p1)

	Observers.observeTag("TradePlazaPortal", function(p1)
		if not p1:IsA("Model") then
			return
		end

		local v1 = Trove.new()
		local v22 = p1:GetPivot()

		local function apply()
			if not ServerData.IsTradePlaza() and not ServerData.IsDuelsServer() and not ServerData.IsTsunamiServer() then
				p1:PivotTo(v22)
			else
				p1:PivotTo(v22 * v3)
			end
		end

		t2[apply] = true
		v1:Add(function()
			t2[apply] = nil
			if not p1.Parent then
				return
			end
			pcall(function()
				p1:PivotTo(v22)
			end)
		end)

		if not ServerData.IsTradePlaza() and not ServerData.IsDuelsServer() and not ServerData.IsTsunamiServer() then
			p1:PivotTo(v22)
		else
			p1:PivotTo(v22 * v3)
		end

		return function()
			v1:Destroy()
		end
	end)

	Observers.observeTag("TradePlazaPortalPrompt", function(p1)
		if not p1:IsA("ProximityPrompt") then
			return
		end

		local v12 = Trove.new()
		p1.Style = Enum.ProximityPromptStyle.Custom

		local function apply()
			p1.Enabled = not ServerData.IsTradePlaza() and not ServerData.IsDuelsServer() and not ServerData.IsTsunamiServer()
		end

		v12:Add(p1.Triggered:Connect(function()
			if ServerData.IsTradePlaza() or ServerData.IsDuelsServer() or ServerData.IsTsunamiServer() then
				return
			end

			if ConfirmationController:IsInPrompt() then
				return
			end

			if ConfirmationController:Show("Are you sure you want to join the <font color=\"rgb(64, 156, 255)\">Trade Plaza</font>?", 300, "JoinCancel") then
				v1:FireServer()
			end
		end))

		t2[apply] = true
		v12:Add(function()
			t2[apply] = nil
		end)

		p1.Enabled = not ServerData.IsTradePlaza() and not ServerData.IsDuelsServer() and not ServerData.IsTsunamiServer()

		return function()
			v12:Destroy()
		end
	end)
end
return 