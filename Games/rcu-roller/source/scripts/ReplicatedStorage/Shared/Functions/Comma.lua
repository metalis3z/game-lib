local tbl = {'k', 'm', 'b', 't', "qd", "aa", "ab", "ac", "ad", "ae", "af", "ag", "ah"}
return function(arg1)
	local var3 = tostring(arg1)
	repeat
		local string_gsub_result1, string_gsub_result2 = string.gsub(var3, "^(-?%d+)(%d%d%d)", "%1,%2")
		var3 = string_gsub_result1
	until string_gsub_result2 == 0
	return var3
end