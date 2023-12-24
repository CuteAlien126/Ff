using HorizonSideRobots
r=Robot(animate=true)
inverse(Side::HorizonSide)=HorizonSide(mod(Int(Side)+2,4))

function mark_chess!(r)
    Side=Ost
    num_Sud=num_steps_along!(r,Sud)
    num_West=num_steps_along!(r,West)
    state=mod(num_Sud+num_West,2)
    if state==1
        move!(r,Ost)
    end
    while !isborder(r,Nord)
        mark_row!(r,Side)
        if state==1
            putmarker!(r)
        end
        move!(r,Nord)
        if state==1
            move!(r,inverse(Side))
        end
        Side=inverse(Side)
    end
    mark_row!(r,Side)
    if state==1
        putmarker!(r)
    end
    along!(r,Sud)
    along!(r,West)
    return!(r,Ost,num_West)
    return!(r,Nord,num_Sud)
end



function mark_row!(r,Side)
    while !isborder(r,Side)
        putmarker!(r)
        move!(r,Side)
        if !isborder(r,Side)
            move!(r,Side)
        end
    end
end

function along!(r,Side)
    while !isborder(r,Side)
        move!(r,Side)
    end
end

function num_steps_along!(r,Side)::Int
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

mark_chess!(r)
