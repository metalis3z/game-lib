--if game.PlaceId == 0 then return end
local camera = workspace.Camera
--[[while not camera == nil do  
	wait()
	camera = workspace.CurrentCamera
end]]
--game.ReplicatedFirst:RemoveDefaultLoadingScreen()
--[[camera.CameraType = "Scriptable"
camera.CoordinateFrame = CFrame.new(47.434, 16.956, 217.24)
camera.Focus = CFrame.new(47.434, 16.956, 216.24)]]


local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local textLabel = Instance.new("TextLabel")
textLabel.Parent = PlayerGui
textLabel.Text = "Loading"
textLabel.Size = UDim2.new(1,0,1,0)
textLabel.FontSize = Enum.FontSize.Size14


game.ReplicatedFirst:RemoveDefaultLoadingScreen()

local screen = Instance.new("ScreenGui")
screen.Parent = PlayerGui

local loadingScreen = script.Parent:WaitForChild("LoadingScreen")
loadingScreen.Parent = screen
_G["LoadingScreen"] = loadingScreen


local Pizza = loadingScreen:WaitForChild("Pizza")
local Loading = loadingScreen:WaitForChild("Loading")
local rotation = 0
local ContentProvider = game:GetService("ContentProvider")
local index = 1
local maxQueSize = 1

local movePizza = game:GetService("RunService").RenderStepped:connect(function() 
	--print(ContentProvider.RequestQueueSize,"SIZE")
	for _,pizza in ipairs(all_pizzas) do
		pizza.Rotation = rotation 
	end
	rotation = rotation + 3
	if rotation >= 359 then
		rotation = 0
	end
end)
local queSize = ContentProvider.RequestQueueSize
_G["LoadingScreenFinished"] = false





while not game:IsLoaded() and textLabel.Text  do
	wait(.1)
end
loadingScreen:Destroy()

--[[
while true do
	wait(.05)
	queSize = ContentProvider.RequestQueueSize
	if queSize > maxQueSize then
		maxQueSize = queSize
	elseif queSize < (maxQueSize/5) * index or queSize == 0 then
		--print(queSize,"queSize")

		local size = 1
		local pizza = all_pizzas[index]
		game:GetService("RunService"):BindToRenderStep(pizza.Name,Enum.RenderPriority.First.Value,function()
			pizza.Size = UDim2.new(0,size,0,size)
			pizza.Position = UDim2.new(0,75-size/2,0,75-size/2)
			if size >= 150 then
				game:GetService("RunService"):UnbindFromRenderStep(pizza.Name)
				if index == 5 then
					wait(1)
					_G["LoadingScreenFinished"] = true
					movePizza:disconnect()
				end
			end
			size = size + 4
		end)
		if index == 5 then 
			break
		end
		index = index + 1

	end
end]]


--[[local str =  ""
local strs = {}

function search(obj)
	if (obj:IsA("ImageLabel") or obj:IsA("ImageButton")) and not strs[obj.Image] then

		str = str .. "'" .. obj.Image .. "',\n"
		strs[obj.Image] = true
	elseif obj:IsA("Decal")  and not strs[obj.Texture] then
		str = str .. "'" .. obj.Texture .. "',\n"
		strs[obj.Texture] = true
	elseif obj:IsA("SpecialMesh")   then
		if not strs[obj.TextureId] then
			str = str .. "'" .. obj.TextureId .. "',\n"
			strs[obj.TextureId] = true
		end
		if not strs[obj.MeshId] then
			str = str .. "'" .. obj.MeshId .. "',\n"
			strs[obj.MeshId] = true
		end

	end
	for _,object in ipairs(obj:GetChildren()) do
		search(object)
	end
end
search(workspace)
print(str)]]


--local moveGrowPizza = game:GetService("RunService").RenderStepped:connect(function() 




--[[while (ContentProvider.RequestQueueSize > 0) do
	wait(.1)
end]]

--PlayerGui:Destroy()


