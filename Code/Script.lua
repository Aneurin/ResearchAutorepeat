function OnMsg.TechResearched(tech_id, city)
    if city:IsTechRepeatable(tech_id) then
        if #city:GetResearchQueue() == 0 then
            city:QueueResearch(tech_id)
        end
        local queue = city:GetResearchQueue()
        if #queue == 1 and queue[1] == tech_id then
            -- Either we just added one, or there was already one. Either way we want to add another
            -- so that there's always still one in the queue when it completes, to avoid the 'no
            -- active research' notification
            city:QueueResearch(tech_id)
        end
    else
        local queue = city:GetResearchQueue()
        if #queue == 1 and city:IsTechRepeatable(queue[1]) then
            -- We just completed some normal research, leaving only a single repeatable research in
            -- the queue. Add it again in order to avoid the 'no active research' notification when
            -- it ends the first time
            city:QueueResearch(queue[1])
        end
    end
end
