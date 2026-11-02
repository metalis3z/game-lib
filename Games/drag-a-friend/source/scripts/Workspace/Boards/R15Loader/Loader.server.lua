
-- Animations --->> 507771019 roblox dance , 3695333486 hype dance , 3333499508 monkey , 3303391864 around town , 4212455378 dorky , 4049037604 line dance , 3333136415 side to side , 4265725525 baby dance , 3338025566 robot dance , 3994127840 celebrate , 3576686446 wave , 4841405708
--copy and past the id into idle
local Model = script.Parent
local Config = Model.Configuration
local userId = Config.userId.Value

local Loader

if Config.AutoUpdateLoader.Value then
	Loader = require(6701993205) -- The auto updating module
else
	Loader = require(script.MainModule)
end

local Track = Model.Humanoid:LoadAnimation(script.Idle)
Track:Play()

-------------------------------------------------------------------------------------

Loader:updateModel(Model, Config.userId.Value)

if Config.AutoUpdateCharacter.Value then
	while wait(Config.AutoUpdateCharacter.Delay.Value) do
		Loader:updateModel(Model, Config.userId.Value)
	end
end