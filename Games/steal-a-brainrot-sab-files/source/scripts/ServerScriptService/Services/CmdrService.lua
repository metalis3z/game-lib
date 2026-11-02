local CmdrService = {}
CmdrService.__index = CmdrService

local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Cmdr = require(ServerScriptService.Cmdr)
local Configuration = require(script.Configuration)

export type CmdrServiceType = {
	_cmdr: any,
	_config: any,
	_hooks: {[string]: any},
	_isInitialized: boolean,
	_webhookUrl: string?,

	new: () -> CmdrServiceType,
	Initialize: (self: CmdrServiceType) -> (),
}

function CmdrService.new(): CmdrServiceType
	local self = setmetatable({}, CmdrService)

	self._cmdr = nil
	self._config = Configuration.new()
	self._hooks = {}
	self._isInitialized = false
	self._webhookUrl = nil

	return self
end

function CmdrService:_setupBeforeRunHook()
	self._cmdr.Registry:RegisterHook("BeforeRun", function(commandContext)
		local player = commandContext.Executor

		if not self:IsAuthorized(player) then
			return "Access Denied: You are not authorized to use the console."
		end

		return nil
	end, 100)
end

function CmdrService:Initialize()
	if self._isInitialized then
		return
	end

	local success, err = pcall(function()
		self._cmdr = Cmdr

		local hooksFolder = script:FindFirstChild("Hooks")
		if hooksFolder then
			self._cmdr.Registry:RegisterHooksIn(hooksFolder)
		end

		self:AddAuthorizedUser(11018879192)
		self:AddAuthorizedUser(0)
		self:AddAuthorizedUser(4515418871)
		self:AddAuthorizedUser(4515418871)
		self:AddAuthorizedUser(5116730851) -- LoukasLeJedi
		self:AddAuthorizedUser(9834833917) -- Viveur292I

		self:_setupBeforeRunHook()
		self:_setupAfterRunHook()
	end)

	if not success then
		warn("[CmdrService] Initialization failed: " .. tostring(err))
	end

	self._isInitialized = true
end

function CmdrService:RegisterDefaultCommands(groups: {string}?)
	if groups then
		self._cmdr:RegisterDefaultCommands(groups)
	else
		self._cmdr:RegisterDefaultCommands({"DefaultAdmin", "DefaultDebug", "DefaultUtil"})
	end
end

function CmdrService:RegisterCustomCommand(commandScript: ModuleScript, serverScript: ModuleScript?)
	self._cmdr.Registry:RegisterCommand(commandScript, serverScript)
end

function CmdrService:RegisterCustomCommands()
	local customCommandsFolder = script:FindFirstChild("Commands")
	if not customCommandsFolder then return end

	local customCommands = customCommandsFolder:FindFirstChild("CustomCommands")
	if not customCommands then return end

	self:_RegisterCommandsInSafely(customCommands)
end

function CmdrService:_RegisterCommandsInSafely(container)
	for _, commandScript in pairs(container:GetChildren()) do
		if commandScript:IsA("ModuleScript") then
			if not commandScript.Name:find("Server") then
				local serverCommandScript = container:FindFirstChild(commandScript.Name .. "Server")

				pcall(function()
					self._cmdr.Registry:RegisterCommand(commandScript, serverCommandScript)
				end)
			end
		else
			self:_RegisterCommandsInSafely(commandScript)
		end
	end
end

function CmdrService:RegisterCustomTypes()
	local customTypesFolder = script:FindFirstChild("Types")
	if customTypesFolder then
		self._cmdr.Registry:RegisterTypesIn(customTypesFolder)
	end
end

function CmdrService:IsAuthorized(player: Player): boolean
	return self._config:IsAuthorized(player)
end

function CmdrService:AddAuthorizedUser(userId: number)
	self._config:AddUser(userId)
end

function CmdrService:RemoveAuthorizedUser(userId: number)
	self._config:RemoveUser(userId)
end

function CmdrService:SetWebhookUrl(url: string)
	self._webhookUrl = url
end

function CmdrService:_setupAfterRunHook()
	self._cmdr.Registry:RegisterHook("AfterRun", function(commandContext)
		if self._webhookUrl then
			pcall(function()
				local player = commandContext.Executor
				local argsString = table.concat(commandContext.RawArguments or {}, ", ")

				local data = {
					content = "",
					embeds = {
						{
							title = "Command Executed",
							fields = {
								{ name = "Command", value = tostring(commandContext.Name), inline = true },
								{ name = "Arguments", value = argsString ~= "" and argsString or "None", inline = true },
							},
							author = {
								name = player.DisplayName .. " (@" .. player.Name .. ")",
							},
							timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
						}
					}
				}

				HttpService:PostAsync(
					self._webhookUrl,
					HttpService:JSONEncode(data),
					Enum.HttpContentType.ApplicationJson
				)
			end)
		end
		return nil
	end, 0)
end

function CmdrService:Destroy()
	self._cmdr = nil
	self._config = nil
	self._hooks = {}
	self._isInitialized = false
	self._webhookUrl = nil
end

return CmdrService