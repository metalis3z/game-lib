local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local idleA = script.Parent:WaitForChild("Idle")

local idleAnim = humanoid:LoadAnimation(idleA)
--local scrubAnim = humanoid:LoadAnimation(script.Parent.Scrub)

local tool = script.Parent
local equipped = false

local proxy = {}
local tables = game.Workspace.DirtyTables:GetChildren()
local template = game.ReplicatedStorage.TableProx

local matches = {}

function showProx(val)
	
	if val == true then
		for i,v in pairs(tables) do
			print("copy")
			local prox = template:Clone()
			prox.Parent = v
			
			--[[
			v.Decal:GetPropertyChangedSignal("Transparency"):Connect(function()
				if v.Decal.Transparency == 0 then
					prox.Enabled = true
				else
					prox.Enabled = false
				end
			end)
			--]]
			
			prox.Triggered:Connect(function()
				game.ReplicatedStorage.SPONGE:FireServer(v)
			end)
			local insert = #proxy + 1
			proxy[insert] = prox
			matches[prox] = insert
		end
	end
	if val == false then
		for i,v in pairs(proxy) do
			v:Destroy()
			proxy[i] = nil
		end
	end
	
end

tool.Equipped:Connect(function()
	equipped = true
	idleAnim:Play()
	showProx(true)
end)

tool.Unequipped:Connect(function()
	equipped = false
	idleAnim:Stop()
	showProx(false)
end)

while wait(0.5) do
	if equipped then
		for i,v in pairs(proxy) do
			if v.Parent then
				if v.Parent.Decal.Transparency == 0 then
					v.Enabled = true
				else
					v.Enabled = false
				end
			end
		end
	end
end

--[[
game.ReplicatedStorage.SPONGE.OnClientEvent:Connect(function(to,lol)
	if equipped then
		if match[toHide] then
			
		end
	end
end)
--]]
--[[
for i,v in pairs(tables) do
	v:FindFirstChild("Decal"):GetPropertySignalChanged("Transparency"):Connect(function()
		--print("signal")
		local transparency = v:FindFirstChild("Decal").Transparency
		if transparency == 0 then
			if v:FindFirstChild("TableProx") then
				v:FindFirstChild("TableProx").Enabled = true
			end	
		else
			if v:FindFirstChild("TableProx") then
				v:FindFirstChild("TableProx").Enabled = false
			end	
		end
	end)
end
--]]