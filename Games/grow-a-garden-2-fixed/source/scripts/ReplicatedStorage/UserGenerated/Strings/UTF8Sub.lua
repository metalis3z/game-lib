--credit to leon games studio
return function(p1, p2, p3) --[[ UTF8Sub | Line: 20 ]]
	local v1 = p3 or -1
	local v2 = utf8.offset(p1, p2)
	local v3

	if v2 then
		v3 = v2
	else
		if p2 > 0 then
			return ""
		end

		v3 = 1
	end

	local v4

	if v1 == -1 then
		v4 = #p1
	else
		local v5 = utf8.offset(p1, v1 + 1)

		v4 = if v5 then v5 - 1 elseif v1 < 0 then 0 else #p1
	end

	return string.sub(p1, v3, v4)
end