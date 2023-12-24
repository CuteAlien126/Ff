using HorizonSideRobots
r=Robot("pr.sit",animate=true)

function per(r)
    num_Sud=along!(r,Sud)
    num_West=along!(r,West)
    for Side in (Nord,Ost,Sud,West)
        along_per!(r,Side)
    end
    return!(r,Ost,num_West)
    return!(r,Nord,num_Sud)
end

function along!(r,Side)::Int
    num_steps=0
    while !isborder(r,Side)
        move!(r,Side)
        num_steps+=1
    end
    return num_steps
end

function along_per!(r,Side)::Nothing
    while !isborder(r,Side)
        putmarker!(r)
        move!(r,Side)
    end
end

function return!(r,Side,num_steps)
    for x in 1:num_steps
        move!(r,Side)
    end
end

per(r)