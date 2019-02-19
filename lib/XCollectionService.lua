local CollectionService = game:GetService("CollectionService")

local Class = {}
Class.__index = function(inst, key)
    -- This will only be called when the method does not already exist in this class
    -- Since this is an extension wrapper for CollectionService, just return CollectionService's version
	if type(CollectionService[key]) == "function" then
		return function(inst, ...)
			return CollectionService[key](CollectionService, ...)
		end
	end
end

-- Singleton
local instance

function new()
    local self = setmetatable({}, Class)

    return self
end

return {
    GetInstance = function()
        if not instance then
            instance = new()
        end
        return instance
    end
}