--[[
	Tween function for tweening any property.  Automatically tweens the property from startValue to endValue over time seconds.
	
	s.tween(
		Object object OR Table object OR Void Function receiver(String propertyName, Variant value),
		String propertyName,
		String valueType,
		Variant startValue = currentValue,
		Variant endValue = nil,
		Number time = 1,
		String easingStyleName = Linear,
		String easingDirectionName = In,
		Variant Tuple easingStyleArgs = nil
	)
	RETURNS:
		RBXScriptSignal onFinished(Bool completed, Object object OR Table object, String propertyName),
		RBXScriptSignal onStepped(Number rawAlpha, Number styledAlpha) Function getOnStepped()
	
	NOTES
		If startValue is not provided it will tween from the existing state of that's object's property.
		If endValue is not provided it will cancel existing tweens, not start a new one, and not return anything.
		Any existing tween on the named property of the defined object will be cancelled automatically.
		easing styles are defined under script.styles.
			Easing style modules should return a function which accepts
			an alpha 0-1 argument and returns a modified alpha value.
		value type interpolators are defined under script.types.
			Value type modules should reutrn a function which accepts a start value,
			an end value, and an alpha value, and returns an interpolated value.
		easingStyleArgs is used to give extra functionality to easing styles.
			If provided, these args will be passed to the easing style function so
			that it can have extra functionality
		The first value returned by the function is a signal that will fire when
			the tween stops (either it completes or it is cancelled).
		The second value returned by the function is a function that when called
			will return a signal that fires every time a new value is calculated
		Functions steps on RenderStepped on clients, runs at 20 Hz on the server.
	
	USAGE:
		-- Start a new tween and connect onFinished and onStepped
		local onFinished, getOnStepped = tween(part, 'Transparency', 'Number', 0, 1, 0.5, 'Sine', 'In')
		local onStepped = getOnStepped()
		onFinished:connect(function(completed, object, propertyName) end)
		onStepped:connect(function(alpha, styledAlpha) end)
		
		-- Cancel an existing tween
		tween(part, 'Transparency')
		
		-- In one line, start a tween and connect onFinished
		tween(part, 'Transparency', 'Number', nil, 1, 0.5, 'Sine'):connect(function(completed, object, propertyName)
			print'done'
		end)
--]]

local private, public = {}, {}
local runService = game:GetService'RunService'

--
--
private.types = {}
private.styles = {}
private.activeTweens = {}

function private.loadTypes()
	for i, module in next, script.types:GetChildren() do
		private.types[module.Name] = require(module)
	end
end

function private.loadStyles()
	for i, module in next, script.styles:GetChildren() do
		private.styles[module.Name] = require(module)
	end
end

function private.stopTween(object, property, completed)
	if private.activeTweens[object] ~= nil then
		if private.activeTweens[object][property] ~= nil then
			local info = private.activeTweens[object][property]
			if info then
				private.activeTweens[object][property] = nil
				info.finishedEvent:Fire(completed, type(object)=='userdata' and object or nil, property)
				info.finishedEvent:Destroy()
				
				if next(private.activeTweens[object]) == nil then
					private.activeTweens[object] = nil
				end
			end
		end
	end
end

function private.tween(object, property, vtype, start, finish, time, style, ...)
	private.updateSpecificTween(object, property)
	private.stopTween(object, property, false)
	
	if finish ~= nil then
		local info = {
			object = object,
			property = property,
			type = vtype,
			start = start,
			finish = finish,
			time = time,
			style = style or 'Linear',
			extra = ... and {...} or nil,
			hasExtra = #{...}>0,
			finishedEvent = Instance.new'BindableEvent',
			started = tick(),
			objectType = type(object)=='function' and 'Function' or 'Object'
		}
		
		if info.start == nil then
			if info.objectType == 'Function' then
				info.start = object('Get', property)
			elseif info.objectType == 'Object' then
				info.start = object[property]
			end
		end
		
		if not private.activeTweens[object] then
			private.activeTweens[object] = {}
		end
		private.activeTweens[object][property] = info
		
		return info.finishedEvent.Event, object.Changed
	end
end

function private.updateTween(info)
	local rawAlpha = math.min(1, (tick()-info.started)/info.time)
	local alpha = info.style == 'Linear' and rawAlpha or private.styles[info.style](rawAlpha, info.hasExtra and unpack(info.extra))
	local newValue = private.types[info.type](info.start, info.finish, alpha)
	
	local cf
	if info.property == 'Size' and info.type == 'Vector3' then
		cf = info.object.CFrame
	end
	
	if info.objectType == 'Object' then
		info.object[info.property] =  newValue
	elseif info.objectType == 'Function' then
		info.object(info.property, newValue)
	end
	
	if cf then
		info.object.CFrame = cf
	end
	
	return rawAlpha >= 1
end

function private.updateSpecificTween(object, property)
	if private.activeTweens[object] and private.activeTweens[object][property] then
		private.updateTween(private.activeTweens[object][property])
	end
end

function private.update()
	for object, props in next, private.activeTweens do
		for property, info in next, props do
			local finished = private.updateTween(info)
			if finished then
				private.activeTweens[info] = nil
				private.stopTween(object, property, true)
			end
		end
	end
end

function private.startLoop()
	local isServer = game:FindService'NetworkServer' ~= nil
	
	if isServer then
		spawn(function()
			while true do
				private.update()
				wait(1/20)
			end
		end)
	else
		runService:BindToRenderStep('AutoTweenUpdate', 0, private.update)
	end
end

--
--
private.loadTypes()
private.loadStyles()
private.startLoop()

--
--
return private.tween