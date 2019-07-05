local CollectionService = game:GetService("CollectionService")

local Class = {}
Class.__index = function(inst, key)
    -- This will only be called when the index does not already exist in this class
    -- Since this is an extension wrapper for CollectionService, just return CollectionService's version

    if not CollectionService[key] then
        error("Attempt to index " .. tostring(key) .. ", a nil value", 2)
    end
    
	if type(CollectionService[key]) == "function" then
		return function(inst, ...)
			return CollectionService[key](CollectionService, ...)
		end
    end

    return CollectionService[key]
end

-- Singleton
local instance

function new()
    local self = setmetatable({}, Class)

    return self
end

--[[**
    Adds a tag to all elements in the array of instances

    @param [t:array<Instance>] instances The instances to tag
    @param [t:string] tag The tag to add
**--]]
function Class:AddTagToAll(instances, tag)
    Class:AddTagsToAll(instances, { tag })
end

--[[**
    Adds a list of tags to all elements in the array of instances

    @param [t:array<Instance>] instances The instances to tag
    @param [t:array<string>] tags The tags to add
**--]]
function Class:AddTagsToAll(instances, tags)
    if type("tags") == "string" then
        tags = { tags }
    end

    for i = 1, #instances do
        for j = 1, #tags do
            CollectionService:AddTag(instances[i], tags[i])
        end
    end
end

--[[**
    Removes a tag from all elements in the array of instances

    @param [t:array<Instance>] instances The instances to untag
    @param [t:string] tag The tag to remove
**--]]
function Class:RemoveTagFromAll(instances, tag)
    Class:RemoveTagsFromAll(instances, { tag })
end

--[[**
    Removes a list of tags to all elements in the array of instances

    @param [t:array<Instance>] instances The instances to untag
    @param [t:array<string>] tags The tags to remove
**--]]
function Class:RemoveTagsFromAll(instances, tags)
    if type("tags") == "string" then
        tags = { tags }
    end

    for i = 1, #instances do
        for j = 1, #tags do
            CollectionService:RemoveTag(instances[i], tags[i])
        end
    end
end

--[[**
    Checks whether a given instance has all the tags provided

    @param [t:Instance] instance The instance to check
    @param [t:array<string>] tags The tags to look for

    @returns [t:boolean] True if the instance has all the tags
**--]]
function Class:HasTags(instance, tags)
    if type("tags") == "string" then
        tags = { tags }
    end

    for i = 1, #tags do
        if not CollectionService:HasTag(instance, tag) then
            return false
        end
    end

    return true
end

--[[**
    Gets all instances that match the given set of tags

    @param [t:array<string>] tags The tags to match

    @returns [t:array<Instance>] The instances that match the set of tags
**--]]
function Class:GetMutliTagged(tags)
    if type("tags") == "string" then
        tags = { tags }
    end

    local instances = {}
    for i = 1, #tags do
        local taggedInstances = CollectionService:GetTagged(tags[i])
        for j = 1, #taggedInstances do
            local instance = taggedInstances[j]
            if not instances[instance] then
                instances[instance] = 0
            end
            instances[instance] = instances[instance] + 1
        end
    end

    local multiTaggedInstances = {}
    for instance, numTags in pairs(instances) do
        if numTags == #tags then
            table.insert(multiTaggedInstances, instance)
        end
    end

    return multiTaggedInstances
end

--[[**
    Gets all children of an instance with a tag

    @param [t:Instance] parent The parent to search the children of
    @param [t:string] tag The tag to search for

    @returns [t:array<Instance>] The children that have the tag
**--]]
function Class:GetTaggedChildren(parent, tag)
    local children = parent:GetChildren()
    local taggedChildren = {}

    for i = 1, #children do
        local child = children[i]
        if CollectionService:HasTag(child, tag) then
            table.insert(taggedChildren, child)
        end
    end

    return taggedChildren
end

--[[**
    Gets all descendants of an instance with a tag

    @param [t:Instance] ancestor The ancestor to search the descendants of
    @param [t:string] tag The tag to search for

    @returns [t:array<Instance>] The descendants that have the tag
**--]]
function Class:GetTaggedDescendants(ancestor, tag)
    local descendants = parent:GetDescendants()
    local taggedDescendants = {}

    for i = 1, #descendants do
        local descendant = descendants[i]
        if CollectionService:HasTag(descendant, tag) then
            table.insert(taggedDescendants, descendant)
        end
    end

    return taggedDescendants
end

--[[**
    Gets all children of an instance with all of the given tags

    @param [t:Instance] parent The parent to search the children of
    @param [t:array<string>] tags The tags to search for

    @returns [t:array<Instance>] The children that have all the tags
**--]]
function Class:GetMultiTaggedChildren(parent, tags)
    local children = parent:GetChildren()
    local multiTaggedChildren = {}

    for i = 1, #children do
        local child = children[i]

        if Class:HasTags(child, tags) then
            table.insert(multiTaggedChildren, child)
        end
    end

    return multiTaggedChildren
end

--[[**
    Gets all descendants of an instance with all of the given tags

    @param [t:Instance] ancestor The ancestor to search the descendants of
    @param [t:array<string>] tags The tags to search for

    @returns [t:array<Instance>] The descendants that have all the tags
**--]]
function Class:GetMultiTaggedDescendants(ancestor, tags)
    local descendants = parent:GetDescendants()
    local multiTaggedDescendants = {}

    for i = 1, #descendants do
        local descendant = descendants[i]

        if Class:HasTags(descendant, tags) then
            table.insert(multiTaggedDescendants, descendant)
        end
    end

    return multiTaggedDescendants
end

--[[**
    Gets all relatives, not including the top-most ancestor, that match the given set of tags

    @param [t:Instance] baseInstance The instance to get the relatives of
    @param [t:array<string>] tags The tags to check for
    @param [t:number] numLevels The number of levels to go up

    @returns [t:array<Instance>] The relatives that match, not including the baseInstance or the top-most ancestor
**--]]
function Class:GetRelativesWithTags(baseInstance, tags, numLevels)
    local currentAncestor = baseInstance

    while currentAncestor.Parent and numLevels > 0 do
        currentAncestor = currentAncestor.Parent
        numLevels = numLevels - 1
    end

    local matchingDescendants = Class:GetMultiTaggedDescendants(currentAncestor, tags)
    for i = 1, #matchingDescendants do
        if matchingDescendants[i] == baseInstance then
            table.remove(matchingDescendants, i)
            break
        end
    end

    return matchingDescendants
end

--[[**
    Gets a signal for when a child is added with the given tag to the given parent

    @param [t:Instance] parent The parent to listen for children of
    @param [t:string] tag The tag to listen for

    @returns [t:RBXScriptSignal] The signal, will provide the new child as an argument to any handlers connected to it
**--]]
function Class:GetChildAddedSignal(parent, tag)
    local event = Instance.new("BindableEvent")

    local instanceAddedSignal = CollectionService:GetInstanceAddedSignal(tag)
    local instanceAddedHandler = instanceAddedSignal:Connect(function(instance)
        if instance.Parent == parent then
            event:Fire(instance)
        end
    end)

    parent.AncestryChanged:Connect(function(_, newParent)
        if not newParent then
            instanceAddedHandler:Disconnect()
            instanceAddedHandler = nil
            event:Destroy()
        end
    end)

    return event.Event
end

--[[**
    Gets a signal for when a descendant is added with the given tag to the given ancestor

    @param [t:Instance] ancestor The ancestor to listen for descendants of
    @param [t:string] tag The tag to listen for

    @returns [t:RBXScriptSignal] The signal, will provide the new descendant as an argument to any handlers connected to it
**--]]
function Class:GetDescendantAddedSignal(ancestor, tag)
    local event = Instance.new("BindableEvent")

    local instanceAddedSignal = CollectionService:GetInstanceAddedSignal(tag)
    local instanceAddedHandler = instanceAddedSignal:Connect(function(instance)
        if instance:IsDescendantOf(ancestor) then
            event:Fire(instance)
        end
    end)

    ancestor.AncestryChanged:Connect(function(_, newParent)
        if not newParent then
            instanceAddedHandler:Disconnect()
            instanceAddedHandler = nil
            event:Destroy()
        end
    end)

    return event.Event
end

--[[**
    Gets a signal for when a child is removed with the given tag from the given parent

    @param [t:Instance] parent The parent to listen for children of
    @param [t:string] tag The tag to listen for

    @returns [t:RBXScriptSignal] The signal, will provide the former child as an argument to any handlers connected to it
**--]]
function Class:GetChildRemovedSignal(parent, tag)
    local event = Instance.new("BindableEvent")

    local instanceRemovedSignal = CollectionService:GetInstanceRemovedSignal(tag)
    local instanceRemovedHandler = instanceRemovedSignal:Connect(function(instance)
        if instance.Parent == parent then
            event:Fire(instance)
        end
    end)

    parent.AncestryChanged:Connect(function(_, newParent)
        if not newParent then
            instanceRemovedHandler:Disconnect()
            instanceRemovedHandler = nil
            event:Destroy()
        end
    end)

    return event.Event
end

--[[**
    Gets a signal for when a descendant is removed with the given tag from the given ancestor

    @param [t:Instance] ancestor The ancestor to listen for descendants of
    @param [t:string] tag The tag to listen for

    @returns [t:RBXScriptSignal] The signal, will provide the former descendant as an argument to any handlers connected to it
**--]]
function Class:GetDescendantRemovedSignal(ancestor, tag)
    local event = Instance.new("BindableEvent")

    local instanceRemovedSignal = CollectionService:GetInstanceRemovedSignal(tag)
    local instanceRemovedHandler = instanceRemovedSignal:Connect(function(instance)
        if instance:IsDescendantOf(ancestor) then
            event:Fire(instance)
        end
    end)

    ancestor.AncestryChanged:Connect(function(_, newParent)
        if not newParent then
            instanceRemovedHandler:Disconnect()
            instanceRemovedHandler = nil
            event:Destroy()
        end
    end)

    return event.Event
end

return {
    GetInstance = function()
        if not instance then
            instance = new()
        end
        return instance
    end
}
