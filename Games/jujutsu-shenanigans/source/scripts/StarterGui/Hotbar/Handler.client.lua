--// Services \\--

local UIS = game:GetService('UserInputService')
local RS = game:GetService('ReplicatedStorage')
local TS = game:GetService('TweenService')
local Players = game:GetService('Players')
local StarterGUI = game:GetService('StarterGui')

StarterGUI:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)



--// Player \\--

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Backpack = Player:WaitForChild('Moveset')



--// Remotes \\--

local Remotes = RS.Remotes

local MovesetHandler = Remotes.MovesetHandler


local AbilitiesHandlerFolder = Remotes.AbilitiesHandler

local AbilitieRemote_Set = AbilitiesHandlerFolder.Set
local AbilitieRemote_Get = AbilitiesHandlerFolder.Get



--// GUI \\--

local GUI = script.Parent
local HotbarFrame = GUI.Hotbar
local CooldownFrame = script.Cooldown
local CurrentTween: Tween



--// Keys \\--

local Keys = {
	['One']   = '1',
	['Two']   = '2',
	['Three'] = '3',
	['Four']  = '4',
	['Five']  = '5',
	['Six']   = '6',
	['Seven'] = '7',
	['Eight'] = '8',
	['Nine']  = '9',
	['Zero']  = '0',

	['ButtonL1'] = '1',
	['ButtonL2'] = '2',
	['ButtonR2'] = '3',
	['ButtonR1'] = '4'
}



--// Variables \\--

local MoveSelected = nil



--// Functions \\--

local function whiteGradientTween(Parent)
	local moveUsed = script.Cooldown:Clone()
	moveUsed.BackgroundColor3 = Color3.new(1,1,1)
	moveUsed.Size = UDim2.fromScale(1,-1)
	moveUsed.Parent = Parent
	TS:Create(moveUsed, TweenInfo.new(.5, Enum.EasingStyle.Linear), { BackgroundTransparency = 1 }):Play()
	game.Debris:AddItem(moveUsed, .5)
end

local function Equip(HotbarSlot: TextButton, addVisualizer)
	local Tool: Tool = AbilitieRemote_Get:InvokeServer(HotbarSlot.ToolName.Text)
	if Tool then
		RS.Bindables.MoveUsed:Fire(HotbarSlot.ToolName.Text)
		Character:RemoveTag('Move Selected')

		if Player.Commands.NoCooldown.Value == false then
			if addVisualizer ~= false then
				local Cooldown: Frame = CooldownFrame:Clone()

				if not Tool:HasTag('onCDS') then
					repeat task.wait() until Tool:HasTag('onCDS')
				end

				Cooldown.Parent = HotbarSlot
				game.Debris:AddItem(Cooldown, Tool:GetAttribute('CDS'))

				local Tween = TS:Create(Cooldown,TweenInfo.new(Tool:GetAttribute('CDS'), Enum.EasingStyle.Linear), { Size = UDim2.fromScale(1,0) })
				Tween.Completed:Once(function()
					whiteGradientTween(HotbarSlot)
				end)

				Tween:Play()
			end
		else
			whiteGradientTween(HotbarSlot)
		end
	end
end

local function updateTools()
	for _,Frame in pairs(HotbarFrame:GetChildren()) do
		if Frame:IsA('Frame') and Frame:FindFirstChild('Base') then
			local TextButton = Frame.Base
			local Cooldown = TextButton:FindFirstChild('Cooldown')
			if Cooldown then
				Cooldown:Destroy()
				
				whiteGradientTween(TextButton)
			end


			local Found = false
			for _,Tool: Tool in Backpack:GetChildren() do
				if Tool:GetAttribute('Index') == Frame.LayoutOrder then
					Found = true
					
					local Description = Tool:GetAttribute('Description')
					
					TextButton.ToolName.Text = Tool.Name
					if Description ~= 'nil' then
						TextButton.Description.Text = Description
						TextButton.Description.Description.Text = Description
						
						TextButton.Description.Visible = true
						TextButton.Description.Description.Visible = true
					else
						TextButton.Description.Visible = false
						TextButton.Description.Description.Visible = false
					end
					
					break
				end
			end

			Frame.Visible = Found
		end
	end
end



--// Events \\--

local IB = UIS.InputBegan
local MHE = MovesetHandler.OnClientEvent



--// Connections \\--

IB:Connect(function(input, gameProccessedEvent)
	if gameProccessedEvent then return end
	
	if Keys[input.KeyCode.Name] and not Character:HasTag('ThrowableGrabbed') then
		local HotbarSlot = HotbarFrame[Keys[input.KeyCode.Name]]
		
		if HotbarSlot then
			HotbarSlot = HotbarSlot.Base
			
			if Player.Configuration['Auto Use'].Value == true then
				Equip(HotbarSlot)
			else
				if HotbarSlot.SelectionObjectClipper.Visible == true then
					HotbarSlot.SelectionObjectClipper.Visible = false
					MoveSelected = nil
					
					Character:RemoveTag('Move Selected')
				else
					for _, Slot in HotbarFrame:GetChildren() do
						if Slot:IsA('Frame') and Slot:FindFirstChild('Base') then
							Slot = Slot.Base
							
							if Slot ~= HotbarSlot and Slot.SelectionObjectClipper.Visible == true then
								Slot.SelectionObjectClipper.Visible = false

								Character:RemoveTag('Move Selected')
							end
						end
					end
					
					HotbarSlot.SelectionObjectClipper.Visible = true
					MoveSelected = HotbarSlot

					Character:AddTag('Move Selected')
				end
			end
		end
	else
		if Player.Configuration['Auto Use'].Value == false and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch or input.KeyCode == Enum.KeyCode.ButtonB) then
			if MoveSelected and not MoveSelected:FindFirstChild('Cooldown') then
				Equip(MoveSelected)
				
				MoveSelected.SelectionObjectClipper.Visible = false
				MoveSelected = nil
				
				Character:RemoveTag('Move Selected')
			end
		end
	end
end)


for _, HotbarSlot: Frame in HotbarFrame:GetChildren() do
	if HotbarSlot:IsA('Frame') and HotbarSlot:FindFirstChild('Base') then
		HotbarSlot = HotbarSlot.Base
		HotbarSlot.Activated:Connect(function()
			if Player.Configuration['Auto Use'].Value == true then
				Equip(HotbarSlot)
			else
				if HotbarSlot.SelectionObjectClipper.Visible == true then
					MoveSelected.SelectionObjectClipper.Visible = false
					MoveSelected = nil

					Character:RemoveTag('Move Selected')
				else
					for _, Slot in HotbarFrame:GetChildren() do
						if Slot:IsA('Frame') and Slot:FindFirstChild('Base') then
							Slot = Slot.Base
							
							if Slot ~= HotbarSlot and Slot.SelectionObjectClipper.Visible == true then
								Slot.SelectionObjectClipper.Visible = false

								Character:RemoveTag('Move Selected')
							end
						end
					end

					HotbarSlot.SelectionObjectClipper.Visible = true
					MoveSelected = HotbarSlot

					Character:AddTag('Move Selected')
				end
			end
		end)
	end
end


MHE:Connect(updateTools)

shared.triggerHotbar = function(State)
	if State == true then
		HotbarFrame:TweenPosition(UDim2.new(0.5, -327, 1, -70), nil, nil, .4)
	else
		HotbarFrame:TweenPosition(UDim2.new(0.5, -327, 1, 55), nil, nil, .4)
	end
end