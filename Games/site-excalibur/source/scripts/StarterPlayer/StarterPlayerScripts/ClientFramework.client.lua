local ClientFramework = {}
local Modules = {}

local function RecursiveGetModules(Directory)
	for _, Module in next, Directory:GetChildren() do
		if Module:IsA("ModuleScript") then
			Modules[Module.Name] = Module
		end
		RecursiveGetModules(Module)
	end
end

local Chat = game:GetService("Chat")

Chat:RegisterChatCallback(Enum.ChatCallbackType.OnCreatingChatWindow, function()
    return {
        ClassicChatEnabled = false,
        BubbleChatEnabled = true,
    }
end)

function ClientFramework.Require(Name)
	if Modules[Name] then
		return require(Modules[Name])
	else
		warn("ClientFramework | Requested Module " .. Name .. " does not exist")
	end
	return nil
end

shared.ClientFramework = ClientFramework
RecursiveGetModules(script)
ClientFramework.Require("ClientMain")

