local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Remote = require(modules.Objects.Remote)
return Remote.new("OpenEmotes", "Event") 
