using HorizonSideRobots
r=Robot(animate=true)
inverse(Side::HorizonSide)=HorizonSide(mod(Int(Side)+2,4))

function along_one_mark!(r::Robot,Side::HorizonSide,num_steps::Int)
    if !isborder(r,Side)
        move!(r,Side)
        num_steps+=1
        num_steps+=along_one_mark!(r,Side,num_steps)
        return num_steps
    else 
        putmarker!(r)
        move!(r,inverse(Side),num_steps)
        return 0
    end
end

function HorizonSideRobots.move!(r::Robot,Side::HorizonSide,num::Int)
    for x in 1:num
        move!(r,Side)
    end
end

along_one_mark!(r,Nord,0)
