# Extended Roblox CollectionService
Added functionality to layer on top of Roblox's CollectionService

Documentation
---

<details>
<summary><code>function Class:AddTagToAll(instances, tag)</code></summary>

Adds a tag to all elements in the array of instances

**Parameters:**
- `instances` (`array<Instance>`)  
The instances to tag
- `tag` (`string`)  
The tag to add

</details>

<details>
<summary><code>function Class:AddTagsToAll(instances, tags)</code></summary>

Adds a list of tags to all elements in the array of instances

**Parameters:**
- `instances` (`array<Instance>`)  
The instances to tag
- `tags` (`array<string>`)  
The tags to add

</details>

<details>
<summary><code>function Class:RemoveTagFromAll(instances, tag)</code></summary>

Removes a tag from all elements in the array of instances

**Parameters:**
- `instances` (`array<Instance>`)  
The instances to untag
- `tag` (`string`)  
The tag to remove

</details>

<details>
<summary><code>function Class:RemoveTagsFromAll(instances, tags)</code></summary>

Removes a list of tags to all elements in the array of instances

**Parameters:**
- `instances` (`array<Instance>`)  
The instances to untag
- `tags` (`array<string>`)  
The tags to remove

</details>

<details>
<summary><code>function Class:HasTags(instance, tags)</code></summary>

Checks whether a given instance has all the tags provided

**Parameters:**
- `instance` (`Instance`)  
The instance to check
- `tags` (`array<string>`)  
The tags to look for

**Returns:**  
`boolean`  
True if the instance has all the tags

</details>

<details>
<summary><code>function Class:GetMutliTagged(tags)</code></summary>

Gets all instances that match the given set of tags

**Parameters:**
- `The` (`array<string>`)  
tags to match

**Returns:**  
`array<Instance>`  
The instances that match the set of tags

</details>

<details>
<summary><code>function Class:GetTaggedChildren(parent, tag)</code></summary>

Gets all children of an instance with a tag

**Parameters:**
- `parent` (`Instance`)  
The parent to search the children of
- `tag` (`string`)  
The tag to search for

**Returns:**  
`array<Instance>`  
The children that have the tag

</details>

<details>
<summary><code>function Class:GetTaggedDescendants(ancestor, tag)</code></summary>

Gets all descendants of an instance with a tag

**Parameters:**
- `ancestor` (`Instance`)  
The ancestor to search the descendants of
- `tag` (`string`)  
The tag to search for

**Returns:**  
`array<Instance>`  
The descendants that have the tag

</details>

<details>
<summary><code>function Class:GetMultiTaggedChildren(parent, tags)</code></summary>

Gets all children of an instance with all of the given tags

**Parameters:**
- `parent` (`Instance`)  
The parent to search the children of
- `tags` (`array<string>`)  
The tags to search for

**Returns:**  
`array<Instance>`  
The children that have all the tags

</details>

<details>
<summary><code>function Class:GetMultiTaggedDescendants(ancestor, tags)</code></summary>

Gets all descendants of an instance with all of the given tags

**Parameters:**
- `ancestor` (`Instance`)  
The ancestor to search the descendants of
- `tags` (`array<string>`)  
The tags to search for

**Returns:**  
`array<Instance>`  
The descendants that have all the tags

</details>

<details>
<summary><code>function Class:GetRelativesWithTags(baseInstance, tags, numLevels)</code></summary>

Gets all relatives, not including the top-most ancestor, that match the given set of tags

**Parameters:**
- `baseInstance` (`Instance`)  
The instance to get the relatives of
- `tags` (`array<string>`)  
The tags to check for
- `numLevels` (`number`)  
The number of levels to go up

**Returns:**  
`array<Instance>`  
The relatives that match, not including the baseInstance or the top-most ancestor

</details>

<details>
<summary><code>function Class:GetChildAddedSignal(parent, tag)</code></summary>

Gets a signal for when a child is added with the given tag to the given parent

**Parameters:**
- `parent` (`Instance`)  
The parent to listen for children of
- `tag` (`string`)  
The tag to listen for

**Returns:**  
`RBXScriptSignal`  
The signal, will provide the new child as an argument to any handlers connected to it

</details>

<details>
<summary><code>function Class:GetDescendantAddedSignal(ancestor, tag)</code></summary>

Gets a signal for when a descendant is added with the given tag to the given ancestor

**Parameters:**
- `ancestor` (`Instance`)  
The ancestor to listen for descendants of
- `tag` (`string`)  
The tag to listen for

**Returns:**  
`RBXScriptSignal`  
The signal, will provide the new descendant as an argument to any handlers connected to it

</details>

<details>
<summary><code>function Class:GetChildRemovedSignal(parent, tag)</code></summary>

Gets a signal for when a child is removed with the given tag from the given parent

**Parameters:**
- `parent` (`Instance`)  
The parent to listen for children of
- `tag` (`string`)  
The tag to listen for

**Returns:**  
`RBXScriptSignal`  
The signal, will provide the former child as an argument to any handlers connected to it

</details>

<details>
<summary><code>function Class:GetDescendantRemovedSignal(ancestor, tag)</code></summary>

Gets a signal for when a descendant is removed with the given tag from the given ancestor

**Parameters:**
- `ancestor` (`Instance`)  
The ancestor to listen for descendants of
- `tag` (`string`)  
The tag to listen for

**Returns:**  
`RBXScriptSignal`  
The signal, will provide the former descendant as an argument to any handlers connected to it

</details>

