
---@param e ModUpdatePersonalFaction
function UpdatePersonalFaction(e)
    local multiplier = 1
    local boost_4x = e.self:GetBucket("boost_4x")
    if boost_4x == "ON" then
        multiplier = multiplier * 4
    end

    local boost_catchup = e.self:GetBucket("boost_catchup")
    if boost_catchup == "ON" then
        local level = e.self:GetLevel()
        multiplier = multiplier + 6
        if level >= 10 then
            multiplier = multiplier + 4
        end
        if level >= 20 then
            multiplier = multiplier + 4
        end
        if level >= 30 then
            multiplier = multiplier + 4
        end
        if level >= 40 then
            multiplier = multiplier + 6
        end
        if level >= 50 then
            multiplier = multiplier + 10
        end
    end
    if e.npc_value < 1 then
        multiplier = 1
    end
    e.return_value = e.npc_value * multiplier

    local is_debug = e.self:GetBucket("exp_debug")
    if is_debug == "ON" then
        e.self:Message(MT.Experience, string.format("Faction boost (%d * %0.1f) = %d", e.npc_value, multiplier, e.return_value))
    end
    if multiplier == 1 then
        return e
    end
    e.ignore_default = true
    return e
end
