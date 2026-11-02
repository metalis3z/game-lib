local ContentProvider = game:GetService("ContentProvider")
local v1 = script:GetChildren()

task.spawn(function() --[[ Line: 6 | Upvalues: ContentProvider (copy), v1 (copy) ]]
	ContentProvider:PreloadAsync(v1)
end)