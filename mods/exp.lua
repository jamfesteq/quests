---@param e ModSetEXP
function SetEXP(e)
    if not e.self:IsClient() then
        return e
    end
    local client = e.self:CastToClient()

    eq.debug(string.format("exp source: %d, cur: %d, set: %d, diff: %d", e.exp_source, e.current_exp, e.set_exp, e.set_exp - e.current_exp))
    return_check(e)
    if e.exp_source ~= ExpSource.Quest and
        e.exp_source ~= ExpSource.Kill and
        e.exp_source ~= ExpSource.LDoNChest and
        e.exp_source ~= ExpSource.Task then
            eq.debug("ignoring exp source")
        return e
    end

    local multiplier = 1
    local boost_4x = e.self:GetBucket("boost_4x")
    if boost_4x == "ON" then
        multiplier = multiplier * 4
    end

    local boost_catchup = e.self:GetBucket("boost_catchup")
    if boost_catchup == "ON" and e.self:GetLevel() <= 65 and e.exp_source == ExpSource.Kill then
        local level = client:GetLevel()
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

    local base_gain = e.set_exp - e.current_exp
    local new_gain = base_gain*multiplier
    e.return_value = e.current_exp + new_gain

    local is_debug = e.self:GetBucket("exp_debug")

    if is_debug == "ON" then
        e.self:Message(MT.Experience, string.format("Exp Mod (%d * %0.0f) = %d", base_gain, multiplier, new_gain))
    end

    e.ignore_default = true
    return e
end

---@param e ModSetAAEXP
function SetAAEXP(e)

    if not e.self:IsClient() then
        return e
    end
    local client = e.self:CastToClient()
    local total_aa = client:GetSpentAA() + client:GetAAPoints()

    eq.debug(string.format("aa exp source: %d, cur: %d, set: %d, diff: %d", e.exp_source, e.current_aa_exp, e.set_aa_exp, e.set_aa_exp - e.current_aa_exp))
    if e.exp_source ~= ExpSource.Quest and
        e.exp_source ~= ExpSource.Kill and
        e.exp_source ~= ExpSource.LDoNChest and
        e.exp_source ~= ExpSource.Task then
            eq.debug("ignoring exp source")
        return e
    end

    local multiplier = 1
    local boost_4x = e.self:GetBucket("boost_4x")
    if boost_4x == "ON" then
        multiplier = multiplier * 4
    end

    local boost_catchup = e.self:GetBucket("boost_catchup")
    if boost_catchup == "ON" and total_aa <= 1000 and e.exp_source == ExpSource.Kill then
        local level = client:GetLevel()
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
        if total_aa < 900 then
            multiplier = multiplier + 100
        end
    end

    local base_gain = e.set_aa_exp - e.current_aa_exp
    local new_gain = base_gain*multiplier
    e.return_value = e.current_aa_exp + new_gain

    local is_debug = e.self:GetBucket("exp_debug")

    if is_debug == "ON" then
        e.self:Message(MT.Experience, string.format("AA Exp Mod (%d * %0.0f) = %d", base_gain, multiplier, new_gain))
    end

    e.ignore_default = true
    return e
end

---@param e ModSetEXP
function return_check(e)
    if e.exp_source ~= ExpSource.Death then
        return
    end
    local base_gain = e.set_exp - e.current_exp

    if base_gain >= 0 then
        e.self:Message(MT.Say, "No exp loss detected, so return is not set.")
        return
    end
    e.self:SetBucket("return_zone_id", tostring(eq.get_zone_id()))
    e.self:SetBucket("return_instance_id", tostring(eq.get_zone_instance_id))
    e.self:SetBucket("return_version_id", tostring(eq.get_zone_instance_version()))
    e.self:SetBucket("return_x", tostring(e.self:GetX()))
    e.self:SetBucket("return_y", tostring(e.self:GetY()))
    e.self:SetBucket("return_z", tostring(e.self:GetZ()))
    e.self:SetBucket("return_h", tostring(e.self:GetHeading()))
    e.self:Message(MT.Say, "You can [" .. eq.say_link("#opt return", true, "return") .. "] to your death location.")
end
