using HorizonSideRobots
r=Robot(animate=true)
function mark_kross!(r)
    for Side in (Nord,West,Sud,Ost)
        num_steps=numsteps_mark_along!(r,Side)
        along!(r,inverse(Side),num_steps)
    end
    putmarker!(r)
end

function numsteps_mark_along!(r,Side)
    num_steps=0
    while !isborder(r,Side)
        move!(r,Side)
        putmarker!(r)
        num_steps+=1
    end
    return num_steps
end

function along!(r,Side,num_steps)::Nothing
    for x in 1:num_steps
        move!(r,Side)
    end
end
inverse(Side::HorizonSide)::HorizonSide=HorizonSide(mod(Int(Side)+2,4))

mark_kross!(r)