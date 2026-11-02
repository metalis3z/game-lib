--[[
	Gear Library by ArceusInator.
	
	Using this to make it easy to make and edit gear.
--]]

local Lib = {
	CFrameModel = function(model, target, primary)
		local GLib = require(script.Parent)
		local descendants = GLib.GetDescendants(model)
		
		local primary = primary or target.CFrame
		
		--
		local localCFrames = {}
		for i, object in next, descendants do
			if object:IsA'BasePart' then
				localCFrames[object] = primary.CFrame:toObjectSpace(object.CFrame)
			end
		end
		
		primary.CFrame = target
		
		for part, localCFrame in next, localCFrames do
			part.CFrame = target:toWorldSpace(localCFrame)
		end
	end,
	
	Create = function(className, defaultParent)
		return function(propList)
			local new = Instance.new(className)
			local parent = defaultParent
			
			for index, value in next, propList do
				if type(index)=='string' then
					if index == 'Parent' then
						parent = value
					else
						new[index] = value
					end
				elseif type(index)=='number' then
					value.Parent = new
				end
			end
			
			new.Parent = parent
			
			return new
		end
	end
}

--
-- Populate library
for i, obj in next, script:GetChildren() do
	if obj:IsA'ModuleScript' then
		Lib[obj.Name] = require(obj)
	end
end

setmetatable(Lib, {
	__index = function(t, index)
		if index == 'Script' then
			local sc = script:Clone()
			sc.Name = 'GLib'
			return sc
		end
		
		if type(index) == 'string' then
			local module = script:FindFirstChild(index)
			if module then
				Lib[module.Name] = require(module)
			end
		end
		
		return rawget(Lib, index)
	end,
	__call = function(t)
		return t.Script
	end
})

--
-- Return
return Lib