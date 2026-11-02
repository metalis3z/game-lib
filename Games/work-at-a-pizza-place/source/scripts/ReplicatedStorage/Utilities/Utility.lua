local Utility = {}

function Utility:WeldVehicle(object)
	local parts,last = {}
	local function scan(parent)
		for _,v in pairs(parent:GetChildren()) do
			--wait()
			if (v:IsA("BasePart") and v ~= workspace.Terrain and v.Name ~= "Wheel") then
				if (last ) then
					local w = Instance.new("Weld")
					w.Name = ("%s_Weld"):format(v.Name)
					w.Part0,w.Part1 = last,v
					w.C0 = last.CFrame:inverse()
					w.C1 = v.CFrame:inverse()
					w.Parent = last
				end
				last = v
				table.insert(parts,v)
			elseif v:IsA("BasePart") and v.Name == "Wheel" then
				table.insert(parts,v)
			end
			scan(v)
		end
	end
	scan(object)
	for _,v in pairs(parts) do
		v.Anchored = false
	end
end


function Utility:Preload(asset)   ---  accepts   123456  "rbsaset://1234"    {1234567,12345676}  {"rbsaset://1234","rbsaset://1234"}
	local Type = type(asset)
	
	local function preload(id)
		if type(id) == "number" then
			game:GetService("ContentProvider"):Preload("http://www.roblox.com/asset/?id=" .. id)
		elseif type(id) == "string" then
			game:GetService("ContentProvider"):Preload(id)
		end
	end
	
	if Type == "table" then
		for _,item in ipairs(asset) do
			preload(item)
		end
	else
		preload(asset)
	end
	
end

function Utility:Weld(x,y)
	local W = Instance.new("Weld")
	W.Name = "Weld"
	W.Part0 = x
	W.Part1 = y
	local CJ = CFrame.new(x.Position)
	local C0 = x.CFrame:inverse()*CJ
	local C1 = y.CFrame:inverse()*CJ
	W.C0 = C0
	W.C1 = C1
	W.Parent = x
end


function Utility:StringToUniqueNumber(str)
	local value = 0
	for i=1,string.len(str) do
		local char = string.sub(str,i,i)
		value = value + string.byte(char)
	end
	return value
end

function Utility:SetParentOfChildren(oldParent,newParent)
	for _,child in ipairs(oldParent:GetChildren()) do
		child.Parent = newParent
	end
end




function Utility:GetModelGlobalSizeAndPosition(model)
	local boundingBox = {Min = Vector3.new(0,0,0),Max = Vector3.new(0,0,0)}
	local initialized = false
	local function search(root)
		for _,obj in ipairs(root:GetChildren()) do
			if obj:IsA("BasePart") then
				local size = obj.Size
				for _,objectSpaceCornerPoint in ipairs({Vector3.new(size.X, size.Y, size.Z),Vector3.new(-size.X, -size.Y, -size.Z),Vector3.new(-size.X, size.Y, size.Z),Vector3.new(size.X, size.Y, -size.Z),Vector3.new(size.X, -size.Y, size.Z),Vector3.new(-size.X, -size.Y, size.Z),Vector3.new(size.X, -size.Y, -size.Z),Vector3.new(-size.X, size.Y, -size.Z)}) do 
					local worldCornerPoint = obj.CFrame:pointToWorldSpace(objectSpaceCornerPoint/2)
					if worldCornerPoint.X > boundingBox.Max.X or not initialized then boundingBox.Max = Vector3.new(worldCornerPoint.X,boundingBox.Max.Y,boundingBox.Max.Z) end
					if worldCornerPoint.Y > boundingBox.Max.Y or not initialized then boundingBox.Max = Vector3.new(boundingBox.Max.X,worldCornerPoint.Y,boundingBox.Max.Z) end
					if worldCornerPoint.Z > boundingBox.Max.Z or not initialized then boundingBox.Max = Vector3.new(boundingBox.Max.X,boundingBox.Max.Y,worldCornerPoint.Z) end
					if worldCornerPoint.X < boundingBox.Min.X or not initialized then boundingBox.Min = Vector3.new(worldCornerPoint.X,boundingBox.Min.Y,boundingBox.Min.Z) end
					if worldCornerPoint.Y < boundingBox.Min.Y or not initialized then boundingBox.Min = Vector3.new(boundingBox.Min.X,worldCornerPoint.Y,boundingBox.Min.Z) end
					if worldCornerPoint.Z < boundingBox.Min.Z or not initialized then boundingBox.Min = Vector3.new(boundingBox.Min.X,boundingBox.Min.Y,worldCornerPoint.Z) end
					initialized = true
				end
			else
				search(obj)
			end 
		end
	end
	search(model)
	local boxSize = Vector3.new(boundingBox.Max.X - boundingBox.Min.X, boundingBox.Max.Y - boundingBox.Min.Y, boundingBox.Max.Z - boundingBox.Min.Z)
	local modelPosition = Vector3.new(boundingBox.Max.X - boxSize.X/2, boundingBox.Max.Y - boxSize.Y/2, boundingBox.Max.Z - boxSize.Z/2)
	return boxSize,modelPosition
end

function Utility:BubbleSort(board)
	local flag = true
	local newBoard = {}
	for i=1,#board do
		flag = false
		for j=1,#board-1 do
			if board[j+1][1] > board[j][1] then
				local temp = board[j]
				board[j] = board[j+1]
				board[j+1] = temp
	
				flag = true
			end
		end
	end
end

--for debugging
function Utility:CreateMarker(vector3,timeout)	
	spawn(function()
		local marker = Instance.new("Part",workspace)
		marker.BrickColor = BrickColor.new("Bright red")
		marker.Size = Vector3.new(.2,.2,.2)
		marker.Material = Enum.Material.Neon
		marker.Anchored = true
		marker.CanCollide = false
		marker.CFrame = CFrame.new(vector3)
		wait(timeout)
		marker:Destroy()
	end)
end





--keeps value between min and max
function Utility:Clamp(val,min,max)
	return math.min(max,math.max(min,val))	
end


--Gets the horizontal (x,z) velocity magnitude of the given part
function Utility:HorizontalVelocityMagnitude(obj)
	local hVel = obj.Velocity + Vector3.new(0,-obj.Velocity.Y,0)
	return hVel.magnitude	
end;



function Utility:GetMinZIndex(guiObject)
	local minIndex = 0
	local function search(dir)
		for _,obj in ipairs(dir:GetChildren()) do
			if obj:IsA("GuiBase2d") and obj.ZIndex < minIndex then
				minIndex = obj.ZIndex
			end
			search(obj)
		end
	end
	search(guiObject)
	
	return (guiObject.ZIndex < minIndex and guiObject.ZIndex) or minIndex
end

function Utility:SetMinZIndex(guiObject,minIndex)
	local function search(dir)
		for _,obj in ipairs(dir:GetChildren()) do
			if obj:IsA("GuiBase2d") then
				obj.ZIndex =  obj.ZIndex + (obj.ZIndex-minIndex)
			end
			search(obj)
		end
	end
	search(guiObject)
	guiObject.ZIndex =  guiObject.ZIndex + (guiObject.ZIndex-minIndex)
end


local OVERLAP_PERCISION = 2

function Utility:GuiIsOverlapping(guiObject,guiObject2)
	local function Overlapping(obj1,obj2)
		local sizeX = (obj2.AbsoluteSize.X <= 0 and 1) or obj2.AbsoluteSize.X
		local sizeY = (obj2.AbsoluteSize.Y <= 0 and 1) or obj2.AbsoluteSize.Y
		
		for y=0, sizeY, sizeY / OVERLAP_PERCISION do
			for x=0, sizeX, sizeX / OVERLAP_PERCISION do
				if Utility:PointInsideGui(obj1,Vector2.new(obj2.AbsolutePosition.X + x,obj2.AbsolutePosition.Y +y)) then
					return true
				end
			end
		end
		return false
	end
	
	return Overlapping(guiObject,guiObject2) or Overlapping(guiObject2,guiObject)
	
end


local RunService = game:GetService("RunService")

function Utility:InterpolateCameraType2(camera,endPosition,focus,duration,finish)
	camera.CameraType = "Scriptable"
	
	local alpha = 0
	local originalPos = camera.CFrame.p
	
	RunService:BindToRenderStep("Interpolate", Enum.RenderPriority.Camera.Value, function()
		camera.CFrame = CFrame.new(originalPos:Lerp(endPosition,alpha),focus.Position)
		if alpha >= 1 then
			RunService:UnbindFromRenderStep("Interpolate")
			if finish then
				finish()
			end
		end
		alpha = alpha + (1/60) / duration
	end)

end


function Utility:AddCommas(value)
	local _,_,minusSign, int, fraction = tostring(value):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("%d%d%d", "%1,")
	return minusSign..int:reverse():gsub("^,", "")..fraction
end

function Utility:PointInsideGui(gui,point)  
	local positionX = gui.AbsolutePosition.X 
	local positionY = gui.AbsolutePosition.Y 
	local sizeX = gui.AbsoluteSize.X 
	local sizeY = gui.AbsoluteSize.Y 

	if point.X > positionX and point.Y > positionY  and 
       point.X < positionX + sizeX and point.Y < positionY + sizeY then
		
		return true
	end
	return false
end



function Utility:EnableScripts(root) 
	for i,v in ipairs(root:GetChildren()) do
		if v:IsA("Script") then
			local e = v:clone()
			e.Disabled  =false
			e.Parent = v.Parent
			v:Destroy()
		else
			Utility:EnableScripts(v)
		end
	end
end



function Utility:TweenAbsolutePosition(screenGui,gui,startAbsolutePos,endAbsolutePos,easingDirection,easingStyle,duration,callback)
	
	local endingPos = UDim2.new(0,endAbsolutePos.X,0,endAbsolutePos.Y)
	
	local guiClone = gui:clone()
	guiClone.Parent = screenGui
	guiClone.Position = UDim2.new(0,startAbsolutePos.X,0,startAbsolutePos.Y)
	guiClone.Size = UDim2.new(0,gui.AbsoluteSize.X,0,gui.AbsoluteSize.Y)
	
	
	guiClone:TweenPosition(endingPos,easingDirection,easingStyle,duration,false,function() 
		
		guiClone:Destroy()
		
		if callback then
			callback()
		end
			
	end)

end



--sets properties of all children with slimilar names (first 4 characters the same)
function Utility:SetGroupPropertiesByName(groupName,properties,parent)
	local subgroupName = string.sub(groupName,1,4)
	for _,obj in ipairs(parent:GetChildren()) do
		for propName,value in pairs(properties) do
			if string.sub(obj.Name,1,4) == subgroupName then
				obj[propName] = value
			end
		end
	end
end


function Utility:ConvertScale(input,inputRange,outputRange,noClamp)
	if input and inputRange and outputRange then
		local inputRangeMin = inputRange[1]
		local inputRangeMax = inputRange[2]
		local outputRangeMin  = outputRange[1]
		local outputRangeMax = outputRange[2]
		local scale = (input - inputRangeMin) / (inputRangeMax - inputRangeMin)
		local unclampedOutputValue = ((outputRangeMax - outputRangeMin) * scale) + outputRangeMin
		local clampedOutputValue = math.min(outputRangeMax,math.max(outputRangeMin,unclampedOutputValue))
		return (noClamp and unclampedOutputValue) or clampedOutputValue
	end
end



function Utility:TeleportPlayer(player,position)
	local torso = Utility:GetObjectInsideCharacter(player,"HumanoidRootPart")
	if torso then
		torso.CFrame = CFrame.new(position + Vector3.new(0,2.5,0))
	end
end

function Utility:TeleportHumanoid(humanoid,position)
	local torso = humanoid.Parent:FindFirstChild("HumanoidRootPart")
	if humanoid and torso then
		torso.CFrame = CFrame.new(position + Vector3.new(0,2.5,0))
	end
end

function Utility:Debounce(func)
    local isRunning = false    -- Create a local debounce variable
    return function(...)       -- Return a new function
        if not isRunning then
            isRunning = true
 
            func(...)          -- Call it with the original arguments
 
            isRunning = false
        end
    end
end



function Utility:BlockToScaledMesh(part,mesh)
	local scale = part.Size * 5
	part.FormFactor = "Custom"
	part.Size = Vector3.new(.2,.2,.2)
	mesh.Scale = scale
end

function Utility:ScaledMeshToBlock(part,mesh)
	local size = mesh.Scale / 5
	part.Size = size
	mesh.Scale = Vector3.new(1,1,1)
end

function Utility:Round(a,b)
	return math.floor((a/b)+0.5)*b
end 

function Utility:RoundUp(a,b)
	if a - math.floor(a) < .1 then
		return Utility:Round(a,b)
	end
	return math.ceil(a / b) * b
end

function Utility:RoundDown(a,b)
	return math.floor(a / b) * b
end



function Utility:PrintTable(t, tabs)

    local tabs = tabs and tabs + 1 or 0
    for i,v in next,t do
        if type(v) == "table" then
            if type(i) == "string" then
                print(string.rep("    ", tabs).."[\""..i.."\"] = {")
            elseif type(i) == "number" then
                print(string.rep("    ", tabs) .. "[" ..tostring(i) .. "] = {")
			
            end
            Utility:PrintTable(v, tabs)
            print(string.rep("    ", tabs).."};")
        else
            if type(i) == "string" then
                print(string.rep("    ", tabs).."[\""..i.."\"] =",v,";")
           elseif type(i) == "number" then
                print(string.rep("    ", tabs).. "[" ..tostring(i) .. "] =",v,";")
            end
        end
    end  
end


function roundDecimal(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end


function Utility:JSONEncode(value,Type)
	if value == nil then return end
	local newFormat = {}
	if Type == "CFrame" then
		for _,v in ipairs({value:components()}) do
			table.insert(newFormat,roundDecimal(v,3))
		end
	end
	return newFormat
end


function Utility:JSONDecode(encodedValue,Type)
	if encodedValue == nil then return end
	if Type == "CFrame" then
		return CFrame.new(encodedValue[1],encodedValue[2],encodedValue[3],encodedValue[4],encodedValue[5],encodedValue[6],encodedValue[7],encodedValue[8],encodedValue[9],encodedValue[10],encodedValue[11],encodedValue[12])
	end
end


function Utility:ClearChildrenByClassName(parent,...)
	local args = {...}
	for _,v in ipairs(parent:GetChildren()) do
		for _,arg in ipairs(args) do
			if v:IsA(arg) then
				v:Destroy()
			end
		end
	end
end



function Utility:MoveModel(model,position)
	local location = position
	model:MoveTo(location)
	local start = model:GetModelCFrame().p
	local target = location-start
	model:TranslateBy(target)
end



function Utility:RotateModel(model,degrees)
	local cframe = CFrame.fromEulerAnglesXYZ(0, math.rad(degrees), 0) 
	for _,object in ipairs(model:GetChildren()) do
		if object:IsA("BasePart") then
			object.CFrame = cframe * object.CFrame
		end
	end
end




function Utility.IsPointInsideBox(box,point)
	local objSpace = box.CFrame:pointToObjectSpace(point)
	local boxSize = box.Size
	return boxSize.X/2 >= math.abs(objSpace.X) and
		   boxSize.Y/2 >= math.abs(objSpace.Y) and
		   boxSize.Z/2 >= math.abs(objSpace.Z)
end


function Utility:IsBoxInsideBox(box,smallerBox,percision) --percision must be greater than one --might want to run twice if boxes are around the same size with the arguments switched
	local IsPointInsideBox = Utility.IsPointInsideBox --optomize
	local size = smallerBox.Size
	for y=-(size.Y/percision),(size.Y/percision),(size.Y/percision) do
		for x=-(size.X/percision),(size.X/percision),(size.X/percision) do
			for z=-(size.Z/percision),(size.Z/percision),(size.Z/percision) do
				local point = smallerBox.CFrame:pointToWorldSpace(Vector3.new(x,y,z))
				if IsPointInsideBox(box,point) then
					return true
				end
			end
		end
	end
	return false
end



function Utility:DeepCopy(tab)
	local copy = {}
	for k, v in pairs(tab) do
		if type(v) == 'table' then
			v = self:DeepCopy(v)
		end
		copy[k] = v
	end
	return copy
end


function Utility:GetObjectInsideCharacter(player,objName)
	if player and player.Parent == game.Players and player.Character and player.Character:FindFirstChild(objName) then
		return player.Character[objName]
	end
	return nil
end

function Utility:GetPlayerFromBodyPart(part)
	if part and part.Parent and part.Parent.Parent and (part.Parent:FindFirstChild("Humanoid") or part.Parent.Parent:FindFirstChild("Humanoid")) then
		local player = game.Players:GetPlayerFromCharacter(part.Parent) or game.Players:GetPlayerFromCharacter(part.Parent.Parent)
		if player then 
			return player
		end
	end
end


--collects all the properties of the object and its children
function Utility:UserDataToTable(root,properties)
	local currentParent = nil
	local function search(object,tree)
	
		for _,property in ipairs(properties) do
			pcall(function() tree[property] = object[property] end)

		end
	
		for _,child in ipairs(object:GetChildren()) do
			tree[child.Name] = {}
			tree[child.Name] = search(child,tree[child.Name])
		end
		
		return tree
	end
	return {[root.Name] = search(root,{})}
end


--keys cannont be objects when sent through remotes - need to replace keys with ids and then put them together again at client

function Utility:EncodeTableForRemotes(tab)
	local encodedTable = Utility:DeepCopy(tab)
	local idDictionary = {}
	local id = 10000 --start id count at 1000
	local function search(t)
		if type(t) == "table" then
			local newValues = {}
			for key,value in pairs(t) do
				if type(key) == "userdata" then
					newValues[tostring(id)] = value
					idDictionary[tostring(id)] = key
					t[key] = nil

					id = id + 1
				end
				search(value)
			end
			for key,value in pairs(newValues) do --cant remove items from table while its being looped through
				t[key] = value
			end
			
		end
		
	end
	search(encodedTable)
	return encodedTable,idDictionary
end




--[[local tab = {[workspace.Houses] = {[workspace.Houses] = 5,a = 5, b = {workspace.Houses}}}
local id
tabg,id = EncodeTableForRemotes(tab)
print(PrintTable(tabg))]]

function Utility:DecodeTableForRemotes(tab,idDictionary)
	local decodedTable = Utility:DeepCopy(tab)
	local function search(t)
		if type(t) == "table" then
			for key,value in pairs(t) do
				if idDictionary[key] then
					t[idDictionary[key]] = value
					t[key] = nil
				end
				search(value)
			end
		end
		
	end
	search(decodedTable)
	return decodedTable
end
--[[local bo = DecodeTableForRemotes(tabg,id)
print(PrintTable(bo))
print(bo[workspace.Houses])]]
--


--send data through a channel and wait for a response
function Utility:SendData(action,channelName,timeout,...)
	local channel = game.ReplicatedStorage.Channels[channelName]
	local eventClassName = (channel:IsA("RemoteEvent") and "RemoteEvent") or "BindableEvent"

	if timeout then --wait to hear back from the server
		
		local response = "no response"
		local response2, response3 --return up to 3 values
		local listener
		
		local function WaitForResponse(act,...)
			if action == act then
				response,response2,response3 = ...
			end
		end
		
		if eventClassName == "RemoteEvent" then
			listener = channel.OnClientEvent:connect(function(act,...) WaitForResponse(act,...) end)
			channel:FireServer(action,...)
		else
			listener = channel.Event:connect(function(act,...) WaitForResponse(act,...) end)
			channel:Fire(action,...)
		end
		
		
		
		local timeoutCount = timeout or 5 --seoncds
		while response == "no response" and timeoutCount > 0 do
			wait(.01)
			timeoutCount = timeoutCount - .01
		end
		
		listener:disconnect()
		
		if response == "no response" then
			return nil
		end

		return response,response2, response3
		
	else
		
		if eventClassName == "RemoteEvent" then
			channel:FireServer(action,...)
		else

			channel:Fire(action,...)
		end
	
		
	end
end


return Utility
