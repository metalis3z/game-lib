if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Stored = Player:WaitForChild('stored')
local Money = Stored:WaitForChild('Money')
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid')
local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')

local Buy = game:FindService('ReplicatedStorage'):FindFirstChild('Buy')
local Kaching, Error, Press = script:FindFirstChild('Kaching'), script:FindFirstChild('Error'), script:FindFirstChild('Press')
local NotifyRemote = game:FindService('ReplicatedStorage'):FindFirstChild('Notify')

local PaintFrame, UnderglowFrame, TintFrame = script.Parent.Frame:FindFirstChild('PaintFrame'), script.Parent.Frame:FindFirstChild('UnderglowFrame'), script.Parent.Frame:FindFirstChild('TintFrame')

function TweenCamera(CFrame1)
	local Tween = game:GetService('TweenService'):Create(workspace.CurrentCamera, TweenInfo.new(.2,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0), {CFrame = CFrame1})
	Tween:Play()
end

local WasOn = false
if Player.PlayerGui:FindFirstChild('ShiftLockButton').Enabled then
	Player.PlayerGui:FindFirstChild('ShiftLockButton').Enabled = false
	WasOn = true
end

local Colors = {
	"Bright red",
	"Bright orange",
	"Bright yellow",
	"Bright green",
	"Bright blue",
	"Dark indigo",
	"Royal purple",
	"Black",
	"White",
	"Dark stone grey",
	"Cool yellow",
	"Really black",
	"Teal",
	"Earth green",
	"Hot pink"
}

local Tints = {
	"None",
	"Light Smoke",
	"Medium Smoke",
	"Dark Smoke",
	"Limo"
}

local Current = nil
local Current_U = nil
local Current_T = nil

if workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car").CarType.Value ~= 'DirtBike' then
	if not workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car") then return end
	for _,v in next, workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('CHANGE'):GetChildren() do
		if v:IsA('MeshPart') then
			Current = v.BrickColor
		end
	end
	if not workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('Underglow'):FindFirstChild('Neon'):FindFirstChildOfClass('PointLight').Enabled then
		Current_U = 'nil'
	else
		Current_U = workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('Underglow'):FindFirstChild('Neon'):FindFirstChildOfClass('PointLight').Color
	end
	if workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('Windows') then
		Current_T = workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('Windows'):FindFirstChildOfClass('BasePart')
	end
else
	for _,v in next, workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('CHANGE'):GetChildren() do
		if v:IsA('Part') then
			print(v.Name)
			Current = v.BrickColor
		end
	end
end

if Current_T then
	if Current_T == .9 then
		Current_T = 'None'
	elseif Current_T == .7 then
		Current_Ty = 'Light Smoke'
	elseif Current_T == .5 then
		Current_T = 'Medium Smoke' 
	elseif Current_T == .3 then
		Current_T= 'Dark Smoke'
	elseif Current_T == 0 then
		Current_T = 'Limo'
	end
end

task.wait(.1) 

Player.PlayerGui:FindFirstChild('RStore').Enabled = false
Player.PlayerGui:FindFirstChild('Gang').Enabled = false

workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
TweenCamera(script.Parent:WaitForChild('Object').Value.Parent:FindFirstChild('Camera').CFrame)

for _,v in next, script.Parent.Frame:GetChildren() do
	if v.Name ~= 'Close' then
		if v.Name == 'Paint' then
			v.MouseButton1Click:Connect(function()
				if not Press.IsPlaying then Press:Play() end
				if PaintFrame.Visible then return end
				for _,v in next, PaintFrame:FindFirstChild('ScrollingFrame'):GetChildren() do
					if v:IsA('TextButton') then
						v:Destroy()
					end
				end
				for _,v in next, UnderglowFrame:FindFirstChild('ScrollingFrame'):GetChildren() do
					if v:IsA('TextButton') then
						v:Destroy()
					end
				end
				PaintFrame.Visible = true
				UnderglowFrame.Visible = false
				TintFrame.Visible = false
				for _,v in next, Colors do
					local Clone = PaintFrame:FindFirstChild('Color'):Clone()
					Clone.Parent = PaintFrame:FindFirstChild('ScrollingFrame')
					Clone.BackgroundColor3 = BrickColor.new(v).Color
					Clone.Name = v
					Clone.Interactable = true
					Clone.Visible = true
					Clone.MouseButton1Click:Connect(function()
						if workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car") then
							if workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body') then
								if workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('CHANGE') then
									for _,vv in next, workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('CHANGE'):GetChildren() do
										if vv:IsA('MeshPart') or vv:IsA('Part') then
											vv.BrickColor = BrickColor.new(v)
										end
									end
									for _,v in next, PaintFrame:FindFirstChild('ScrollingFrame'):GetChildren() do
										if v:IsA('TextButton') then
											v:FindFirstChild('Purchase').Visible = false
											v:FindFirstChild('Purchase').Interactable = false
											v:FindFirstChild('TextLabel').Visible = true
										end
									end
									Clone:FindFirstChild('Purchase').Visible = true
									Clone:FindFirstChild('Purchase').Interactable = true
									Clone:FindFirstChild('TextLabel').Visible = false
								end
							end
						end
					end)
					Clone:FindFirstChild('Purchase').MouseButton1Click:Connect(function()
						if Money.Value >= 2000 then
							game:FindService('ReplicatedStorage').CarHandler:FireServer('BuyExtra', workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('CarType').Value, v)
							Current = BrickColor.new(v)
							if not Kaching.IsPlaying then Kaching:Play() end
						else
							if not Error.IsPlaying then Error:Play() end
						end
					end)
					task.wait(.1)
				end
			end)
		elseif v.Name == 'Underglow' and workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car").CarType.Value ~= 'DirtBike' then
			v.MouseButton1Click:Connect(function()
				if not Press.IsPlaying then Press:Play() end
				if UnderglowFrame.Visible then return end
				for _,v in next, PaintFrame:FindFirstChild('ScrollingFrame'):GetChildren() do
					if v:IsA('TextButton') then
						v:Destroy()
					end
				end
				for _,v in next, UnderglowFrame:FindFirstChild('ScrollingFrame'):GetChildren() do
					if v:IsA('TextButton') then
						v:Destroy()
					end
				end
				UnderglowFrame.Visible = true
				PaintFrame.Visible = false
				TintFrame.Visible = false
				for _,v in next, Colors do
					local Clone = UnderglowFrame:FindFirstChild('Color'):Clone()
					Clone.Parent = UnderglowFrame:FindFirstChild('ScrollingFrame')
					Clone.BackgroundColor3 = BrickColor.new(v).Color
					Clone.Name = v
					Clone.Interactable = true
					Clone.Visible = true
					Clone.MouseButton1Click:Connect(function()
						if workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car") then
							if workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body') then
								if workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('Underglow') then
									for _,vv in next, workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('Underglow'):GetChildren() do
										if vv.Name == 'Neon' then
											vv:FindFirstChild('PointLight').Color = BrickColor.new(v).Color
											vv:FindFirstChild('PointLight').Enabled = true
										end
									end
									for _,v in next, UnderglowFrame:FindFirstChild('ScrollingFrame'):GetChildren() do
										if v:IsA('TextButton') then
											v:FindFirstChild('Purchase').Visible = false
											v:FindFirstChild('Purchase').Interactable = false
											v:FindFirstChild('TextLabel').Visible = true
										end
									end
									Clone:FindFirstChild('Purchase').Visible = true
									Clone:FindFirstChild('Purchase').Interactable = true
									Clone:FindFirstChild('TextLabel').Visible = false
								end
							end
						end
					end)
					Clone:FindFirstChild('Purchase').MouseButton1Click:Connect(function()
						if Money.Value >= 1000 then
							game:FindService('ReplicatedStorage').CarHandler:FireServer('BuyExtra2', workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('CarType').Value, v)
							Current_U = BrickColor.new(v)
							if not Kaching.IsPlaying then Kaching:Play() end
						else
							if not Error.IsPlaying then Error:Play() end
						end
					end)
					task.wait(.1)
				end
			end)
		elseif v.Name == 'Tint' and workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car").CarType.Value ~= 'DirtBike' then
			v.MouseButton1Click:Connect(function()
				if not Press.IsPlaying then Press:Play() end
				if TintFrame.Visible then return end
				for _,v in next, PaintFrame:FindFirstChild('ScrollingFrame'):GetChildren() do
					if v:IsA('TextButton') then
						v:Destroy()
					end
				end
				for _,v in next, UnderglowFrame:FindFirstChild('ScrollingFrame'):GetChildren() do
					if v:IsA('TextButton') then
						v:Destroy()
					end
				end
				UnderglowFrame.Visible = false
				PaintFrame.Visible = false
				TintFrame.Visible = true
				for _,v in next, Tints do
					local Clone 
					if TintFrame.ScrollingFrame:FindFirstChild(v) then
						Clone = TintFrame.ScrollingFrame:FindFirstChild(v) 
					end
					Clone.MouseButton1Click:Connect(function()
						if workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car") then
							if workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body') then
								if workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('Windows') then
									for _,vv in next, workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('Windows'):GetChildren() do
										if Clone.Name == 'None' then
											vv.Transparency = .9
										elseif Clone.Name == 'Light Smoke' then
											vv.Transparency = .7
										elseif Clone.Name == 'Medium Smoke' then
											vv.Transparency = .5
										elseif Clone.Name == 'Dark Smoke' then
											vv.Transparency = .3
										elseif Clone.Name == 'Limo' then
											vv.Transparency = 0
										end
									end
									for _,v in next, TintFrame:FindFirstChild('ScrollingFrame'):GetChildren() do
										if v:IsA('TextButton') then
											v:FindFirstChild('Purchase').Visible = false
											v:FindFirstChild('Purchase').Interactable = false
											v:FindFirstChild('TextLabel').Visible = true
										end
									end
									Clone:FindFirstChild('Purchase').Visible = true
									Clone:FindFirstChild('Purchase').Interactable = true
									Clone:FindFirstChild('TextLabel').Visible = false
								end
							end
						end
					end)
					Clone:FindFirstChild('Purchase').MouseButton1Click:Connect(function()
						if Money.Value >= 1000 then
							game:FindService('ReplicatedStorage').CarHandler:FireServer('BuyExtra3', workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('CarType').Value, v)
							Current_T = v
							if not Kaching.IsPlaying then Kaching:Play() end
						else
							if not Error.IsPlaying then Error:Play() end
						end
					end)
					task.wait(.1)
				end
			end)
		end
	end
end

if workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car").CarType.Value == 'DirtBike' then
	script.Parent.Frame.Future.Visible = false
	script.Parent.Frame.Tint.Visible = false
	script.Parent.Frame.Underglow.Visible = false
end

UnderglowFrame:FindFirstChild('Remove').MouseButton1Click:Connect(function()
	game:FindService('ReplicatedStorage').CarHandler:FireServer('BuyExtra2', workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('CarType').Value, 'nil')
	Current_U = 'nil'
	for _,vv in next, workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('Underglow'):GetChildren() do
		if vv.Name == 'Neon' then
			vv:FindFirstChild('PointLight').Enabled = false
		end
	end
	if not Press.IsPlaying then Press:Play() end
end)

script.Parent:FindFirstChild('Frame').Close.MouseButton1Click:Connect(function()
	if not Press.IsPlaying then Press:Play() end
	script.Parent:WaitForChild('Object').Value.Enabled = true
	if WasOn == true then Player.PlayerGui:FindFirstChild('ShiftLockButton').Enabled = true end
	Player.PlayerGui:FindFirstChild('RStore').Enabled = true
	Player.PlayerGui:FindFirstChild('Gang').Enabled = true
	game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	workspace.CurrentCamera.CameraType = Enum.CameraType.Track
	task.spawn(function()
		if workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car").CarType.Value ~= 'DirtBike' then
			for _,vv in next, workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('CHANGE'):GetChildren() do
				if vv:IsA('MeshPart') then
					vv.BrickColor = Current
				end
			end
			for _,vv in next, workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('Underglow'):GetChildren() do
				if vv.Name == 'Neon' then
					if Current_U == 'nil' then
						vv:FindFirstChild('PointLight').Enabled = false
					else
						vv:FindFirstChild('PointLight').Color = Current_U.Color
					end
				end
			end

			for _,vv in next, workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('Windows'):GetChildren() do
				if Current_T then
					if Current_T == 'None' then
						vv.Transparency = .9
					elseif Current_T == 'Light Smoke' then
						vv.Transparency = .7
					elseif Current_T == 'Medium Smoke' then
						vv.Transparency = .5
					elseif Current_T == 'Dark Smoke' then
						vv.Transparency = .3
					elseif Current_T == 'Limo' then
						vv.Transparency = 0
					end
				else
					vv.Transparency = .9
				end
			end
		else
			for _,v in next, workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('Body'):FindFirstChild('CHANGE'):GetChildren() do
				if v:IsA('Part') then
					Current = v.BrickColor
				end
			end
		end
	end)
	script.Parent:Destroy()
end)