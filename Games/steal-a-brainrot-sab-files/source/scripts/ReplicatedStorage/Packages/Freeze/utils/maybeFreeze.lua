

return function(p1)
	if table.isfrozen(p1) then
		return p1
	end

	return table.freeze(p1)
end
