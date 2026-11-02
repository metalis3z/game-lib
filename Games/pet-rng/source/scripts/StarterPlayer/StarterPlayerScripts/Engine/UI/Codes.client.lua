local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RSEngine = ReplicatedStorage:WaitForChild("Engine")
local RemoteFunctions = RSEngine:WaitForChild("RemotesFunctions")
local getValue = RemoteFunctions:WaitForChild("GetValue")
local RemoteEvents = RSEngine:WaitForChild("RemotesEvents")
local claim = RemoteEvents:WaitForChild("Claim")
local changeValue = RemoteEvents:WaitForChild("ChangeValue")
local dataModules = ReplicatedStorage:WaitForChild("DataModules")
local CodesModule = require(dataModules:WaitForChild("Codes"))

local SoundService = game:GetService("SoundService")
local Main = SoundService:WaitForChild("Main")
local Interface = Main:WaitForChild("Interface")
local errorSFX = Interface:WaitForChild('Error')
local confirm = Interface:WaitForChild("Confirm")

local player = game.Players.LocalPlayer
local playerGui = player.PlayerGui
local gui = playerGui:WaitForChild("GUI")
local frames = gui:WaitForChild("Frames")
local codesFrame = frames:WaitForChild("Codes")
local redeemCode = codesFrame:WaitForChild("RedeemCode")

local codes = CodesModule.Codes
local expiredCodes = CodesModule.ExpiredCodes

redeemCode.FocusLost:Connect(function()
	local insertedCode = string.lower(redeemCode.Text)
	local redeemedCodes = getValue:InvokeServer("RedeemedCodes")
	
	redeemCode.Text = ""
	
	if not table.find(redeemedCodes, insertedCode) then
		if codes[insertedCode] then
			confirm:Play()
			
			claim:FireServer(codes[insertedCode])
			table.insert(redeemedCodes, insertedCode)
			changeValue:FireServer("RedeemedCodes", redeemedCodes)
			
			redeemCode.PlaceholderText = "Redeemed Code"
			wait(3)
			redeemCode.PlaceholderText = "Write Code Here"
		elseif expiredCodes[insertedCode] then
			errorSFX:Play()
			redeemCode.PlaceholderText = "Code Expired"
			wait(3)
			redeemCode.PlaceholderText = "Write Code Here"
		else
			errorSFX:Play()
			redeemCode.PlaceholderText = "Invalid Code"
			wait(3)
			redeemCode.PlaceholderText = "Write Code Here"
		end
	else
		errorSFX:Play()
		redeemCode.PlaceholderText = "Already Redeemed Code"
		wait(3)
		redeemCode.PlaceholderText = "Write Code Here"
	end
end)