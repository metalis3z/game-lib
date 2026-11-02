if not game:IsLoaded() then game.Loaded:Wait() end

local tool= script.Parent
local plr= game.Players.LocalPlayer
local char= plr.Character or plr.CharacterAdded:Wait()
local hum= char:WaitForChild("Humanoid")
local hrp = char:WaitForChild('HumanoidRootPart')
char:WaitForChild('Head')

local pE= script:WaitForChild('punched')
local FIRSTTIME = false

local UserInputService = game:GetService("UserInputService")

local on= false
local deb= false
local b1d
local b2d
local mouse= plr:GetMouse()
local cooldown= .5

local rh= char:WaitForChild("RightHand")
local lh= char:WaitForChild("LeftHand")
local lf= char:WaitForChild("LeftFoot")
local rf = char:WaitForChild("RightFoot")
local rht
local lht
local dmg = 10
local durab

local throw= Instance.new("Sound",plr.Character:WaitForChild('UpperTorso'))
throw.SoundId = "rbxassetid://9076453292"

local Animator = hum:WaitForChild("Animator")

local anim1
local anim2
local idle
local kickAnim
local pushAnim
local stompAnim 

local rand = 0

local cooldowns = {
	["punch"] = .5,
	["stomp"] = .75,
	["kick"] = .4,
	["push"] = .4
}

function punch()
	if hum.Health <= 0 then return end
	if deb == false then deb= true
		if on == false then on = true
			anim1:Play()
			throw.Pitch= math.random(1,1)
			throw:Play()
			local mydeb= false
			rht = rh.Touched:Connect(function(hit)
				if hum.Health <= 0 then return end
				if mydeb == false then mydeb=true
					if hit and hit.Parent then
						if hit.Parent:FindFirstChild("Humanoid") then
							pE:InvokeServer(hit.Parent:FindFirstChild("Humanoid"), 'Punch')
						end
						if hit.Parent.Parent:FindFirstChild("Humanoid") then
							pE:InvokeServer(hit.Parent.Parent:FindFirstChild("Humanoid"), 'Punch')
						end
						if hit.Parent.Parent.Parent:FindFirstChild("Humanoid") then
							pE:InvokeServer(hit.Parent.Parent.Parent:FindFirstChild("Humanoid"), 'Punch')
						end
					end
				end
			end)
		elseif on == true then on = false
			anim2:Play()
			throw.Pitch= math.random(1,2)
			throw:Play()
			local mydeb= false
			lht= lh.Touched:Connect(function(hit)
				if hum.Health <= 0 then return end
				if mydeb == false then mydeb=true
					if hit and hit.Parent then
						if hit.Parent:FindFirstChild("Humanoid") then
							pE:InvokeServer(hit.Parent:FindFirstChild("Humanoid"), 'Punch')
						end
						if hit.Parent.Parent:FindFirstChild("Humanoid") then
							pE:InvokeServer(hit.Parent.Parent:FindFirstChild("Humanoid"), 'Punch')
						end
						if hit.Parent.Parent.Parent:FindFirstChild("Humanoid") then
							pE:InvokeServer(hit.Parent.Parent.Parent:FindFirstChild("Humanoid"), 'Punch')
						end
					end
				end
			end)		
		end
		wait(cooldowns["punch"])
		if lht then lht:disconnect() end
		if rht then rht:disconnect() end
		anim1:Stop()
		anim2:Stop()
		deb=false
	end
end

function stomp()
	if hum.Health <= 0 then return end
	if deb == true then return end
	deb = true
	stompAnim:Play()
	throw.Pitch= math.random(1, 2)
	throw:Play()
	local mydeb= false
	local rft = rf.Touched:Connect(function(hit)
		if hum.Health <= 0 then return end
		if mydeb == false then mydeb=true
			if hit and hit.Parent then
				task.wait(.2)
				if hit.Parent:FindFirstChild("Humanoid") then
					pE:InvokeServer(hit.Parent:FindFirstChild("Humanoid"), 'Stomp')
				end
				if hit.Parent.Parent:FindFirstChild("Humanoid") then
					pE:InvokeServer(hit.Parent.Parent:FindFirstChild("Humanoid"), 'Stomp')
				end
				if hit.Parent.Parent.Parent:FindFirstChild("Humanoid") then
					pE:InvokeServer(hit.Parent.Parent.Parent:FindFirstChild("Humanoid"), 'Stomp')
				end
			end
		end
	end)
	wait(cooldowns["stomp"])
	if lht then lht:disconnect() end
	if rht then rht:disconnect() end
	stompAnim:Stop()
	deb = false
end

local toDestroy = nil

function createGuiButtons()
	local gui = script.Parent.MobilePunchGui:Clone()
	gui.Parent = game.Players.LocalPlayer.PlayerGui

	gui.MobileButtons.Stomp.MouseButton1Click:Connect(function()
		stomp()
	end)

	toDestroy = gui
end

task.wait(1)

tool.Equipped:Connect(function()
	local Character = plr.Character or plr.CharacterAdded:Wait()
	local hum = Character:WaitForChild('Humanoid')
	local Animatior = hum:WaitForChild('Animator')
	if hum.Health <= 0 then return end
	if FIRSTTIME == true then task.wait(2) FIRSTTIME = false end
	anim1 = Animator:LoadAnimation(script:WaitForChild('Punch1'))
	anim2 = Animator:LoadAnimation(script:WaitForChild('Punch2'))
	idle= Animator:LoadAnimation(script:WaitForChild('Idle'))
	kickAnim = Animator:LoadAnimation(script:WaitForChild('Kick'))
	pushAnim = Animator:LoadAnimation(script:WaitForChild('Push'))
	stompAnim = Animator:LoadAnimation(script:WaitForChild('Stomp'))
	idle:Play()
	local LastInput = UserInputService:GetLastInputType()
	if LastInput == Enum.UserInputType.Touch and UserInputService.TouchEnabled then
		createGuiButtons() 
	elseif (LastInput == Enum.UserInputType.Keyboard or LastInput == Enum.UserInputType.MouseButton1) and UserInputService.KeyboardEnabled then
		local gui = script.Parent.KeyboardButtons:Clone()
		gui.Parent = game.Players.LocalPlayer.PlayerGui
		toDestroy = gui
	elseif UserInputService.GamepadEnabled then
		local gui = script.Parent.KeyboardButtons:Clone()
		gui.Parent = game.Players.LocalPlayer.PlayerGui
		toDestroy = gui
		gui.Frame.STOMP.Text = 'X / SQUARE - STOMP'
	end
	b1d	= mouse.Button1Down:Connect(punch)
	if UserInputService.KeyboardEnabled or UserInputService.GamepadEnabled then
		b2d = UserInputService.InputBegan:Connect(function(input)
			if input.KeyCode == Enum.KeyCode.F or input.KeyCode == Enum.KeyCode.ButtonX then
				stomp()
			end
		end)
	end	
end)

tool.Unequipped:Connect(function()
	b1d:disconnect()
	if b2d then
		b2d:disconnect()
	end
	if rht then rht:disconnect() end
	if lht then lht:disconnect() end
	if rht then rht:disconnect() end
	idle:Stop()

	if toDestroy then toDestroy:Destroy() toDestroy = nil end
end)