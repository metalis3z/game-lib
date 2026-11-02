local Event = {}

function Event.New(eventtable)
	local self = {}
	self = eventtable or self
	local removelist = {}
	local functions = {}
	local pendingdeletion = false
	function self:Connect(func)
		functions[#functions + 1] = func
		return function()
			removelist[func] = true
			pendingdeletion = true
		end
	end
	return function(...)
		if pendingdeletion then
			pendingdeletion = false
			local j = 1
			for i = 1, #functions do
				local f = functions[i]
				functions[i] = nil
				if removelist[f] then
					removelist[f] = nil
				else
					f(...)
					functions[j] = f
					j = j + 1
				end
			end
		else
			for i = 1, #functions do
				if functions[i] then
					functions[i](...)
				else
					
				end
			end
		end
	end, self
end

return Event
