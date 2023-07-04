using TypstGenerator
using Test

@testset "TypstGenerator.jl" begin
    include("../example/example.jl")
    
    println(typeof(gen_example())) 
    
    @test typeof(gen_example()) <: Vector{TypstGenerator.AbstractTypst}
    
    @test typeof(render_example(gen_example())) <: String
    
    #@test typeof(run_exmaple()) <: Base.Process
end