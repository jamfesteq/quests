---@diagnostic disable: param-type-mismatch
--- @param e PlayerEventCommand
local function return_command(e)
    local zone_id = tonumber(e.self:GetBucket("return_zone_id"))
    if zone_id == 0 then
        e.self:Message(MT.Say, "No recent deaths.")
        return
    end
    local zone_name = eq.get_zone_long_name_by_id(zone_id)
    local zone_instance_id = tonumber(e.self:GetBucket("return_instance_id"))
    local zone_version_id = tonumber(e.self:GetBucket("return_version_id"))
    local return_x = tonumber(e.self:GetBucket("return_x"))
    local return_y = tonumber(e.self:GetBucket("return_y"))
    local return_z = tonumber(e.self:GetBucket("return_z"))
    local return_h = tonumber(e.self:GetBucket("return_h"))


    if zone_version_id and zone_version_id > 0 then
        e.self:Message(MT.Say, "Returning to " .. zone_name .. " version " .. zone_version_id.. ".")
        e.self:MovePCDynamicZone(zone_id, zone_version_id, true)
        reset_return(e)
        return
    end

    if zone_instance_id and zone_instance_id > 0 then
        e.self:Message(MT.Say, "Returning to " .. zone_name .. " instance " .. zone_instance_id .. " version " .. zone_version_id .. ".")
        e.self:MovePCInstance(zone_id, zone_instance_id, return_x, return_y, return_z, return_h)
        reset_return(e)
        return
    end

    e.self:Message(MT.Say, "Returning to " .. zone_name .. ".")
    e.self:MovePC(tonumber(zone_id), tonumber(return_x), tonumber(return_y), tonumber(return_z), tonumber(return_h))
    reset_return(e)
end

---@param e PlayerEventCommand
function reset_return(e)
    e.self:SetBucket("return_zone_id", "0")
    e.self:SetBucket("return_instance_id", "0")
    e.self:SetBucket("return_version_id", "0")
    e.self:SetBucket("return_x", "0")
    e.self:SetBucket("return_y", "0")
    e.self:SetBucket("return_z", "0")
    e.self:SetBucket("return_h", "0")
end

return return_command;
