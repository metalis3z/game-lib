local scriptContext = game:GetService("ScriptContext")
local LogService = game:GetService("LogService")

scriptContext.Error:connect(function(msg, stackTrace, scr)
	game.ReplicatedStorage.Remote.SendError:FireServer(msg, stackTrace, scr)
end)