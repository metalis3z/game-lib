-- <- Init -> --
local Module = {}
Module.__index = Module

-- <- Services -> --
local Storage = game:GetService('ServerStorage');
local Client = game:GetService('ReplicatedStorage');
local RunService = game:GetService('RunService');
local Https = game:GetService('HttpService');

-- <- Private Variables -> --
local Commands = Client.Modules:FindFirstChild('ModeratorCommands');
local IsStudio = RunService:IsStudio();

local Webhook = 'https://discord.com/api/webhooks/REDACTED'

-- <- Modules -> --
local Initializer = require(Client.Initializer);
local Network = Initializer.Modules.Network;

-- <- Private Variable -> --
local LoadTestingGround = IsStudio

-- <- Functions -> --
function SendWebhook(Player: Player, Actions: {Action: string, Detail: string})
	local Message = Https:JSONEncode({
		["content"] = "",
		["embeds"] = {{
			["title"] = `Admin Panel Logs`,
			["description"] = `{Actions.Detail}`,
			["type"] = "rich",
			["color"] = tonumber(0xffffff),
			["fields"] = {
				{
					["name"] = 'User',
					["value"] = `{Player.Name}`,
					["inline"] = true
				},
				{
					["name"] = 'Profile Link',
					["value"] = `https://www.roblox.com/users/{Player.UserId}`,
					["inline"] = true
				},
				{
					["name"] = "Action",
					["value"] = `{Actions.Action}`,
					["inline"] = true
				}
			}
		}}
	})
	--
	pcall(function()
		Https:PostAsync(Webhook, Message)
	end)
end

-- <- Network -> --
function Module.Start()
	if LoadTestingGround then 
		local Cloned = Storage.Assets.DevMaps["Testing Place"]:Clone()
		Cloned.Parent = workspace
		--
		for Index, Value in Cloned.Survivors:GetChildren() do 
			Value.Parent = workspace.Players.Survivors
		end
		--
		task.delay(10, function()
			for Index, Value in game.Players:GetChildren() do 
				if Value.Character then 
					Value.Character.HumanoidRootPart.CFrame = Cloned.Spawnn.CFrame
				end
			end
		end)
	end
	--
	Network:SetConnection('ExecuteCommand', 'REMOTE_EVENT', function(Player: Player, ...)
		local Arguments = {...}
		local Name = Arguments[1]
		if Commands:FindFirstChild(Name) then
			require(Commands:FindFirstChild(Name)):Executed(...)
			--
			SendWebhook(Player, {
				Action = 'Command Used',
				Detail = Name
			})
		end
	end)
end

-- <- Return -> --
return Module