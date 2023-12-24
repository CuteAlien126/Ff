using HorizonSideRobots
r=Robot("pr.sit",animate=true)
inverse(Side::HorizonSide)::HorizonSide=HorizonSide(mod(Int(Side)+2,4))

function mark_all!(r)
    num_Sud=along!(r,Sud)
    num_West=along!(r,West)
    Side=Ost
    while !isborder(r,Nord)
        mark_row!(r,Side)
        move!(r,Nord)
        Side=inverse(Side)
    end
    mark_row!(r,Ost)
    mark_row!(r,Sud)
    mark_row!(r,West)
    return!(r,Ost,num_West)
    return!(r,Nord,num_Sud)
end

function mark_row!(r,Side)
    while !isborder(r,Side)
        putmarker!(r)
        move!(r,Side)
    end
    putmarker!(r)
end

function along!(r,Side)::Int
    num_steps=0
    while !isborder(r,Side)
        move!(r,Side)
        num_steps+=1
    end
    return num_steps
end

function return!(r,Side,num_steps)
    for x in 1:num_steps
        move!(r,Side)
    end
end


mark_all!(r)