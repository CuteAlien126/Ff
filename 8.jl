using HorizonSideRobots
r=Robot(animate=true)
left(Side::HorizonSide)=HorizonSide(mod(Int(Side)+1,4))

function find_marker!(r)
    max_num_steps=1
    Side=Nord
    while !ismarker(r)
        find_marker_along!(r,Side,max_num_steps)
        Side=left(Side)
        find_marker_along!(r,Side,max_num_steps)
        max_num_steps+=1
        Side=left(Side)
    end
end

function find_marker_along!(r,Side,max_num_steps)
    num_steps=0
    while num_steps<max_num_steps && !ismarker(r)
        move!(r,Side)
        num_steps+=1
    end
end
find_marker!(r)