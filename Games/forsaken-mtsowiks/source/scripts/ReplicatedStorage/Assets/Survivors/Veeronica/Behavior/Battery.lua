--!native
--[[
▄• ▄▌ ▐ ▄  ▄▄·        ▐ ▄  ▐ ▄ ▄▄▄ . ▄▄· ▄▄▄▄▄▄▄▄ .·▄▄▄▄  
█▪██▌•█▌▐█▐█ ▌▪▪     •█▌▐█•█▌▐█▀▄.▀·▐█ ▌▪•██  ▀▄.▀·██▪ ██ 
█▌▐█▌▐█▐▐▌██ ▄▄ ▄█▀▄ ▐█▐▐▌▐█▐▐▌▐▀▀▪▄██ ▄▄ ▐█.▪▐▀▀▪▄▐█· ▐█▌
▐█▄█▌██▐█▌▐███▌▐█▌.▐▌██▐█▌██▐█▌▐█▄▄▌▐███▌ ▐█▌·▐█▄▄▌██. ██ 
 ▀▀▀ ▀▀ █▪·▀▀▀  ▀█▄▀▪▀▀ █▪▀▀ █▪ ▀▀▀ ·▀▀▀  ▀▀▀  ▀▀▀ ▀▀▀▀▀• 
 
]]--
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Sounds = require(ReplicatedStorage.Modules.Sounds)
local Utils = require(ReplicatedStorage.Modules.Util)
local Config = require(script.Parent.Parent.Config) -- Bro
local IS_SERVER = RunService:IsServer()

local Battery = {}
Battery.__index = Battery
Battery.BatteryLoopSound = nil

function Battery.new(character)
	assert(IS_SERVER, "Battery is intended for server")
	assert(character, "Bad Rig")

	local self = setmetatable({}, Battery)

	self.Charge = 15
	self.MaxCharge = 50
	self.Callbacks = {}
	self._isChargable = true
	self._isHealing = false
	self._character = character

	self:_updateCharge()

	return self
end

function Battery:Destroy()
	self:StopHealing()
end

function Battery:_callback(eventName, ...)
	local callback = self.Callbacks[eventName]
	if not callback then return false end

	local success, result = pcall(callback, ...)
	if not success then
		warn(`[Veeronica's Battery] Battery callback failed for {eventName}:\n{result}`)
		return false
	end

	return true, result
end

function Battery:_updateCharge()
	local percent = math.floor(self.Charge / self.MaxCharge * 100)
	self._character:SetAttribute("BatteryPercent", percent)
end

function Battery:IsHealable(targetHumanoid)
	if self.Charge <= 0 then return false end
	if not targetHumanoid then return false end
	if targetHumanoid.Health <= 0 then return false end

	return targetHumanoid.Health < targetHumanoid.MaxHealth
end

function Battery:DecrementCharge()
	self.Charge = math.clamp(self.Charge - 1, 0, self.MaxCharge)
	self:_updateCharge()
	return self.Charge
end

function Battery:IncrementCharge(amount)
	amount = tonumber(amount) or 1
	self.Charge = math.clamp(self.Charge + amount, 0, self.MaxCharge)
	self:_updateCharge()
	self:_callback("Charged", amount)
	return self.Charge
end

function Battery:StopHealing()
	if self._healingRoutine and coroutine.status(self._healingRoutine) ~= "dead" then
		task.cancel(self._healingRoutine)
	end
	if Battery.BatteryLoopSound then
		Sounds:Stop(Config.Sounds.BatteryLoop)
		Battery.BatteryLoopSound = nil
	end
	
	self._healingRoutine = nil

	self._isHealing = false
	self._isChargable = true
	self:_callback("Ended")
end

function Battery:StartHealing(onHealCallback)
	local humanoid = self._character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		warn("[Veeronica's Battery] No humanoid found")
		return false
	end

	if self._isHealing then
		warn("[Veeronica's Battery] Already healing")
		return false
	end

	if not self:IsHealable(humanoid) then
		warn("[Veeronica's Battery] Not healable")
		return false
	end
	
	Sounds:Play(Config.Sounds.BatteryStart, {
		Parent = self._character.PrimaryPart, 
		Looped = false, 
		Volume = 0.5
	})
	
	--[[Battery.BatteryLoopSound = Sounds:Play(Config.Sounds.BatteryLoop, { -- gaaayyyy
		Parent = self._character.PrimaryPart, 
		Looped = false, 
		Volume = 0.5,
		PlaybackSpeed = 1
	})]]--

	self._isHealing = true
	self._isChargable = false

	self._healingRoutine = task.spawn(function()
		local lastHealth = humanoid.Health

		local healthConnection
		local diedConnection

		local success, err = pcall(function()
			healthConnection = humanoid.HealthChanged:Connect(function(newHealth)
				if not self._isHealing then return end
				if newHealth < lastHealth then
					self:StopHealing()
					self:_callback("Interrupted")
					Sounds:Play(Config.Sounds.BatteryInterrupted, {
						Parent = self._character.PrimaryPart, 
						Looped = false, 
						Volume = 0.5
					})
				end
				lastHealth = newHealth
			end)

			diedConnection = humanoid.Died:Connect(function()
				if not self._isHealing then return end
				self:StopHealing()
				self:_callback("Interrupted")
				Sounds:Play(Config.Sounds.BatteryInterrupted, {
					Parent = self._character.PrimaryPart, 
					Looped = false, 
					Volume = 0.5
				})
			end)
		end)

		if not success then
			warn("[Veeronica's Battery] Failed to create health monitoring connections: " .. tostring(err))
		end

		self:_callback("Start")

		while self._isHealing and self:IsHealable(humanoid) and self.Charge > 0 do
			local oldHealth = humanoid.Health

			if oldHealth < humanoid.MaxHealth then
				humanoid.Health = math.min(oldHealth + 1, humanoid.MaxHealth)
				local newHealth = humanoid.Health

				if newHealth > oldHealth then
					self:DecrementCharge()

					if onHealCallback then
						onHealCallback(newHealth, oldHealth)
					end

					lastHealth = newHealth
				else
					break
				end
			else
				break
			end

			task.wait(0.25)
		end

		if healthConnection then
			healthConnection:Disconnect()
		end
		if diedConnection then
			diedConnection:Disconnect()
		end

		if self._isHealing then
			self._isHealing = false
			self._isChargable = true
			local event = self.Charge <= 0 and "Discharged" or "Finished"
			if Battery.BatteryLoopSound then
				Sounds:Stop(Config.Sounds.BatteryLoop)
				Battery.BatteryLoopSound = nil
			end
			if event == "Finished" then
				Sounds:Play(Config.Sounds.BatteryFinished, {
					Parent = self._character.PrimaryPart, 
					Looped = false, 
					Volume = 0.5
				})
			elseif event == "Discharged" then
				Sounds:Play(Config.Sounds.BatteryDischarged, {
					Parent = self._character.PrimaryPart, 
					Looped = false, 
					Volume = 0.5
				})
			else
				warn("[Veeronica's Battery] Don't even trip, dawg!")
			end
			self:_callback(event)
		end

		self._healingRoutine = nil
	end)

	return true
end

function Battery:IsHealing()
	return self._isHealing
end

function Battery:GetChargePercent()
	return math.floor(self.Charge / self.MaxCharge * 100)
end

return Battery