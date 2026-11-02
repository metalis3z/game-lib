--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)
local Debounce = require(Packages.Debounce)

local Tool = script.Parent
local Player = Tool.Parent.Parent :: Player

local function getCharacter()
	return Player.Character or Player.CharacterAdded:Wait()
end

local function getHumanoid()
	local character = getCharacter()
	return character and character:FindFirstChildOfClass("Humanoid")
end

local function getAnimator()
	local humanoid = getHumanoid()
	return humanoid and humanoid:FindFirstChildWhichIsA("Animator")
end

local function playHitAnimation()
	local animator = getAnimator()
	if not animator then return end
	
	local hitAnim = Tool:FindFirstChild("HitAnim")
	if not hitAnim then return end
	
	local animationTrack = animator:LoadAnimation(hitAnim)
	animationTrack:Play()
	
	-- Очищаем трек после окончания анимации
	animationTrack.Ended:Connect(function()
		animationTrack:Destroy()
	end)
end

Tool.Activated:Connect(function()
	if Debounce("ItemUse/Bat/", 1) then
		return
	end
	
	-- Воспроизводим анимацию на клиенте
	playHitAnimation()
	
	-- Отправляем на сервер
	Net:RemoteEvent("UseItem"):FireServer()
end)