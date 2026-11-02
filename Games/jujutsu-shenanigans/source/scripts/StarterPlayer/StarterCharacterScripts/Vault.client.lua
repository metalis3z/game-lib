local plr = game:GetService("Players").LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local HRP = char:WaitForChild("HumanoidRootPart")
local Hum = char:WaitForChild("Humanoid")
local animation1 = script:WaitForChild("ClimbAnim1")  
local animation2 = script:WaitForChild("ClimbAnim2") 
local animation3 = script:WaitForChild("ClimbAnim3")  
local animation4 = script:WaitForChild("ClimbAnim4")  

local ledgeavail = true


local anim1 = Hum:LoadAnimation(animation1)
local anim2 = Hum:LoadAnimation(animation2)
local anim3 = Hum:LoadAnimation(animation3)
local anim4 = Hum:LoadAnimation(animation4)

while game:GetService("RunService").RenderStepped:Wait() do
	local r = Ray.new(HRP.Position, HRP.CFrame.LookVector * 5 + HRP.CFrame.UpVector * -5)
	local part = workspace:FindPartOnRay(r, char)

	if part and ledgeavail then
		if part.Name == "Vault" then
			if Hum.FloorMaterial ~= Enum.Material.Air then
				ledgeavail = false

				
				local Vel = Instance.new("BodyVelocity")
				Vel.Parent = HRP
				Vel.Velocity = Vector3.new(0, 0, 0)
				Vel.MaxForce = Vector3.new(1, 1, 1) * math.huge
				Vel.Velocity = HRP.CFrame.LookVector * 15 + Vector3.new(0, 20, 0)

			
				local randomAnim = math.random(1, 4)
				local chosenAnim
				if randomAnim == 1 then
					chosenAnim = anim1
				elseif randomAnim == 2 then
					chosenAnim = anim2
				elseif randomAnim == 3 then
					chosenAnim = anim3
				else
					chosenAnim = anim4
				end

				
				chosenAnim:Play()

				
				game.Debris:AddItem(Vel, 0.20)

				
				wait(0.75)
				chosenAnim:Stop()
				ledgeavail = true
			end
		end
	end
end
