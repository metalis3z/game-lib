wait(3)
--// Player
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
--// UI
local UI = script.Parent.Parent.Parent.Parent
--// Services 
local SocialService = game:GetService("SocialService")
local UserInputService = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Remotes = game.ReplicatedStorage.Remotes
local bees = game.ReplicatedStorage.Bees

--// Modules
local Utils = require(game.ReplicatedStorage.Modules.Utils)
local Hovers = require(game.ReplicatedStorage.Modules.InfoHover)
local Eggs = require(game.ReplicatedStorage.Modules.Items).Eggs
local Alerts = require(game.ReplicatedStorage.Modules.Alerts)
local Shops = require(game.ReplicatedStorage.Modules.UI.Shops)
local BeeLevels = require(game.ReplicatedStorage.Modules.BeeLevels)

--// Vars
local Camera = game:GetService("Workspace").CurrentCamera
local Mouse = Player:GetMouse()
local Humanoid = Player.Character:WaitForChild("Humanoid")

local codeExample = script.Parent.CodeExample;
local codes: {} = {};

local function openQuestionBox(question: string)
	local questionBox: ImageLabel = script.Parent.QuestionBox;
	questionBox.Box.TextBox.Text = question;
	questionBox.Visible = true;
	game.Lighting.Blur.Enabled = true;
end

local function load() 
	print(codes);
	for uses,code in pairs(codes) do
		local Ex: ImageLabel = script.Parent.CodeExample:Clone();
		Ex.Parent = script.Parent.Icon.List;
		Ex.Name = code["name"];
		Ex.CodeName.Text = code["name"];
		Ex.CodeUses.Text = uses;
		Ex.Visible = true;
		
		local deleteButton: TextButton = Ex.DeleteButton;
		deleteButton.MouseButton1Click:Connect(function()
			script.Parent.QuestionBox.Code.Value = code["name"];
			openQuestionBox("Confirm deleting the <"..code["name"].."> code?");
		end)
	end
end

script.Parent.QuestionBox.Box.YesButton.MouseButton1Click:Connect(function()
	Remotes.RemoveCode:FireServer(script.Parent.QuestionBox.Code.Value)
	script.Parent.Icon.List[script.Parent.QuestionBox.Code.Value]:Remove()
end)

Remotes.GetAllCodes:FireServer();
Remotes.GetAllCodes.OnClientEvent:Connect(function(codes2: {})
	codes = codes2;
	load()
end)
