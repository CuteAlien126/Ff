using HorizonSideRobots
include("edge_robot.jl")
HSR=HorizonSideRobots

r=Robot("pr.sit",animate=true)
r=EdgeRobot{Robot}(r, Nord)

function shuttle!(stop::Function, r::EdgeRobot)
    n=2
    while !stop()
        move!(stop,r,n)
        n+=10
        inverse!(r)
    end
end

function HSR.move!(stop_cond::Function, r::EdgeRobot, num_steps::Integer)
    for x in 1:num_steps
        if !stop_cond() 
        move!(r)
        end
    end
end

shuttle!(()->ismarker(r), r)
